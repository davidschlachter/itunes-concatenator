FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     �� 	 
��   	 "   DASAppDelegate.applescript    
 �   8     D A S A p p D e l e g a t e . a p p l e s c r i p t      l     ��  ��       itunes-concatenator     �   *     i t u n e s - c o n c a t e n a t o r      l     ��������  ��  ��        l     ��  ��    2 ,  Created by David Schlachter on 2014-08-26.     �   X     C r e a t e d   b y   D a v i d   S c h l a c h t e r   o n   2 0 1 4 - 0 8 - 2 6 .      l     ��  ��    A ;  Copyright (c) 2014 Red Eft Software. All rights reserved.     �   v     C o p y r i g h t   ( c )   2 0 1 4   R e d   E f t   S o f t w a r e .   A l l   r i g h t s   r e s e r v e d .      l     ��������  ��  ��         l     ��������  ��  ��      ! " ! l     �� # $��   # _ Y via http://macscripter.net/viewtopic.php?pid=173787 ; apparently needed for using arrays    $ � % % �   v i a   h t t p : / / m a c s c r i p t e r . n e t / v i e w t o p i c . p h p ? p i d = 1 7 3 7 8 7   ;   a p p a r e n t l y   n e e d e d   f o r   u s i n g   a r r a y s "  & ' & l     ��������  ��  ��   '  (�� ( h     �� )��  0 dasappdelegate DASAppDelegate ) k       * *  + , + j     �� -
�� 
pare - 4     �� .
�� 
pcls . m     / / � 0 0  N S O b j e c t ,  1 2 1 l     ��������  ��  ��   2  3 4 3 p   	 	 5 5 �� 6�� 0 these_files   6 �� 7�� 0 these_times   7 �� 8�� 0 these_titles   8 �� 9�� 0 	the_index   9 �� :�� 0 	the_pipes   : �� ;�� 0 
thecounter 
theCounter ; ������ 0 	cmdprefix 	cmdPrefix��   4  < = < l     ��������  ��  ��   =  > ? > l     �� @ A��   @  
 IBOutlets    A � B B    I B O u t l e t s ?  C D C j   	 �� E
�� 
cwin E m   	 
��
�� 
msng D  F G F j    �� H�� 0 
tracktable 
trackTable H m    ��
�� 
msng G  I J I j    �� K�� 0 catname catName K m    ��
�� 
msng J  L M L j    �� N�� 0 	catartist 	catArtist N m    ��
�� 
msng M  O P O j    �� Q�� 0 catalbum catAlbum Q m    ��
�� 
msng P  R S R j    �� T�� 0 catcomposer catComposer T m    ��
�� 
msng S  U V U j    �� W�� 0 catgenre catGenre W m    ��
�� 
msng V  X Y X j     �� Z�� 0 cattrack catTrack Z m    ��
�� 
msng Y  [ \ [ j   ! #�� ]�� 0 	cattracks 	catTracks ] m   ! "��
�� 
msng \  ^ _ ^ j   $ &�� `�� 0 catdisc catDisc ` m   $ %��
�� 
msng _  a b a j   ' )�� c�� 0 catdiscs catDiscs c m   ' (��
�� 
msng b  d e d j   * ,�� f��  0 catalbumartist catAlbumArtist f m   * +��
�� 
msng e  g h g j   - /�� i�� 0 catyear catYear i m   - .��
�� 
msng h  j k j j   0 2�� l�� 0 	radiotype 	radioType l m   0 1��
�� 
msng k  m n m j   3 5�� o�� 0 progressfield progressField o m   3 4��
�� 
msng n  p q p l     ��������  ��  ��   q  r s r l     �� t u��   t D > Again, per macscripter, we'll set up bindings for the options    u � v v |   A g a i n ,   p e r   m a c s c r i p t e r ,   w e ' l l   s e t   u p   b i n d i n g s   f o r   t h e   o p t i o n s s  w x w j   6 <�� y�� 0 pcatname pcatName y m   6 9 z z � { {   x  | } | j   = C�� ~�� 0 
pcatartist 
pcatArtist ~ m   = @   � � �   }  � � � j   D J�� ��� 0 	pcatalbum 	pcatAlbum � m   D G � � � � �   �  � � � j   K Q�� ��� 0 pcatcomposer pcatComposer � m   K N � � � � �   �  � � � j   R X�� ��� 0 	pcatgenre 	pcatGenre � m   R U � � � � �   �  � � � j   Y _�� ��� 0 	pcattrack 	pcatTrack � m   Y \ � � � � �   �  � � � j   ` f�� ��� 0 
pcattracks 
pcatTracks � m   ` c � � � � �   �  � � � j   g m�� ��� 0 pcatdisc pcatDisc � m   g j � � � � �   �  � � � j   n t�� ��� 0 	pcatdiscs 	pcatDiscs � m   n q � � � � �   �  � � � j   u {�� ��� "0 pcatalbumartist pcatAlbumArtist � m   u x � � � � �   �  � � � j   | ��� ��� 0 pcatyear pcatYear � m   |  � � � � �   �  � � � j   � ��� ��� "0 missingpackages missingPackages � m   � � � � � � �   �  � � � j   � ��� ��� 0 mediatypetext mediaTypeText � m   � � � � � � �   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � 4 . Empty strings for each file name and location    � � � � \   E m p t y   s t r i n g s   f o r   e a c h   f i l e   n a m e   a n d   l o c a t i o n �  � � � j   � ��� ��� 0 	peachname 	pEachName � m   � � � � � � �   �  � � � j   � ��� ��� 0 peachlocation pEachLocation � m   � � � � � � �   �  � � � l     ��������  ��  ��   �  � � � j   � ��� ��� 0 these_titles   � J   � �����   �  � � � j   � ��� ��� 0 these_files   � J   � �����   �  � � � j   � ��� ��� 0 these_times   � J   � �����   �  � � � j   � ��� ��� 0 	the_index   � J   � �����   �  � � � j   � ��� ��� 0 	the_pipes   � J   � �����   �  � � � l     ��������  ��  ��   �  � � � j   � ��� ��� 0 
thecounter 
theCounter � m   � � � � � � �   �  � � � j   � ��� ��� 0 	cmdprefix 	cmdPrefix � m   � � � � � � �  i f   [ [   - r   / e t c / p r o f i l e   ] ] ; t h e n   .   / e t c / p r o f i l e ; f i ; i f   [ [   - r   ~ / . b a s h r c   ] ] ; t h e n   .   ~ / . b a s h r c ; f i ; i f   [ [   - r   ~ / . b a s h _ p r o f i l e   ] ] ; t h e n   .   ~ / . b a s h _ p r o f i l e ; f i ; �  � � � l     ��������  ��  ��   �  � � � i   � � � � � I      �������� 0 awakefromnib awakeFromNib��  ��   � k    A � �  � � � l     �� � ���   � #  Check for FFMPEG in the path    � � � � :   C h e c k   f o r   F F M P E G   i n   t h e   p a t h �  � � � Q      � � � � I   �� ���
�� .sysoexecTEXT���     TEXT � b    
 � � � o    ���� 0 	cmdprefix 	cmdPrefix � m    	 � � � � � ~   i f   [   - x   " ` / u s r / b i n / w h i c h   f f m p e g ` "   ] ; t h e n   e x i t   0 ; e l s e   e x i t   1 ; f i��   � R      ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � o      ���� 0 error_number  ��   � r     � � � m       �  F F M P E G   � o      ���� "0 missingpackages missingPackages �  l   ����~��  �  �~    l   �}�}   "  Check for MP4v2 in the path    � 8   C h e c k   f o r   M P 4 v 2   i n   t h e   p a t h 	
	 Q    P I  ! ,�|�{
�| .sysoexecTEXT���     TEXT b   ! ( o   ! &�z�z 0 	cmdprefix 	cmdPrefix m   & ' � �   i f   [   - x   " ` / u s r / b i n / w h i c h   m p 4 c h a p s ` "   ] ; t h e n   e x i t   0 ; e l s e   e x i t   1 ; f i�{   R      �y�x
�y .ascrerr ****      � ****�x   �w�v
�w 
errn o      �u�u 0 error_number  �v   Z   4 P�t =  4 ; o   4 9�s�s "0 missingpackages missingPackages m   9 : �  F F M P E G r   > F m   > ? �  M P 4 v 2   l      �r�q  n      !"!  ;   D E" o   ? D�p�p "0 missingpackages missingPackages�r  �q  �t   r   I P#$# m   I J%% �&&  M P 4 v 2  $ o      �o�o "0 missingpackages missingPackages
 '(' l  Q Q�n�m�l�n  �m  �l  ( )�k) Z   QA*+�j�i* >  Q X,-, o   Q V�h�h "0 missingpackages missingPackages- m   V W.. �//  + k   [=00 121 I  [ q�g34
�g .sysodlogaskr        TEXT3 b   [ d565 b   [ b787 m   [ \99 �:: n Y o u   m u s t   i n s t a l l   t h e   f o l l o w i n g   p r o g r a m s   t o   c o n t i n u e :   
 	8 o   \ a�f�f "0 missingpackages missingPackages6 m   b c;; �<<�   
 
 Y o u   m a y   h a v e   t o   i n s t a l l   X c o d e   C o m m a n d   L i n e   T o o l s   a n d   H o m e b r e w   f i r s t .   I f   y o u   c o n t i n u e ,   w e ' l l   a t t e m p t   t o   i n s t a l l   t h e m   f o r   y o u   i f   t h e y   a r e   n o t   a l r e a d y   p r e s e n t .   
 
 I f   y o u   h a v e   a l r e a d y   i n s t a l l e d   F F M P E G   a n d   M P 4 v 2 ,   e n s u r e   t h a t   t h e y   a r e   i n   y o u r   b a s h   p a t h .4 �e=>
�e 
btns= J   e i?? @A@ m   e fBB �CC  Q u i tA D�dD m   f gEE �FF  I n s t a l l�d  > �cG�b
�c 
dfltG m   j k�a�a �b  2 H�`H Z   r=IJK�_I =   r ~LML 1   r u�^
�^ 
rsltM K   u }NN �]O�\
�] 
bhitO m   x {PP �QQ  I n s t a l l�\  J k   �RR STS O   � �UVU k   � �WW XYX r   � �Z[Z I  � ��[\�Z
�[ .coredoscnull��� ��� ctxt\ b   � �]^] o   � ��Y�Y 0 	cmdprefix 	cmdPrefix^ m   � �__ �``� i f   [ [   - x   ` w h i c h   b r e w `   ] ] ; t h e n   b r e w   i n s t a l l   f f m p e g   m p 4 v 2   & &   e x i t   0 ; e l s e   / u s r / b i n / r u b y   - e   " $ ( / u s r / b i n / c u r l   - f s S L   h t t p s : / / r a w . g i t h u b . c o m / H o m e b r e w / h o m e b r e w / g o / i n s t a l l ) " ;   b r e w   i n s t a l l   f f m p e g   m p 4 v 2   & &   e x i t   0 ; f i�Z  [ o      �X�X 0 newtab newTabY aba I  � ��Wc�V
�W .sysodelanull��� ��� nmbrc m   � ��U�U �V  b ded I  � ��T�S�R
�T .miscactvnull��� ��� null�S  �R  e fgf l  � ��Qhi�Q  h * $ Check for when the Terminal is done   i �jj H   C h e c k   f o r   w h e n   t h e   T e r m i n a l   i s   d o n eg k�Pk Q   � �lm�Ol T   � �nn k   � �oo pqp I  � ��Nr�M
�N .sysodelanull��� ��� nmbrr m   � �ss ?ə������M  q t�Lt Z  � �uv�K�Ju H   � �ww n   � �xyx 1   � ��I
�I 
busyy o   � ��H�H 0 newtab newTabv  S   � ��K  �J  �L  m R      �G�F�E
�G .ascrerr ****      � ****�F  �E  �O  �P  V m   � �zz�                                                                                      @ alis    l  Macintosh HD               �(\HH+   QE�Terminal.app                                                    QoW�4�(        ����  	                	Utilities     �(��      �5&h     QE� QE�  2Macintosh HD:Applications: Utilities: Terminal.app    T e r m i n a l . a p p    M a c i n t o s h   H D  #Applications/Utilities/Terminal.app   / ��  T {|{ l  � ��D}~�D  } + % Check if installation was successful   ~ � J   C h e c k   i f   i n s t a l l a t i o n   w a s   s u c c e s s f u l| ��C� Q   ����� k   ��� ��� I  � ��B��A
�B .sysoexecTEXT���     TEXT� b   � ���� o   � ��@�@ 0 	cmdprefix 	cmdPrefix� m   � ��� ��� �   i f   [   - x   " ` / u s r / b i n / w h i c h   f f m p e g ` "   - a   - x   " ` / u s r / b i n / w h i c h   m p 4 c h a p s ` "   ] ; t h e n   e x i t   0 ; e l s e   e x i t   1 ; f i�A  � ��� O  � ���� I  � ��?�>�=
�? .aevtquitnull��� ��� null�>  �=  � m   � ����                                                                                      @ alis    l  Macintosh HD               �(\HH+   QE�Terminal.app                                                    QoW�4�(        ����  	                	Utilities     �(��      �5&h     QE� QE�  2Macintosh HD:Applications: Utilities: Terminal.app    T e r m i n a l . a p p    M a c i n t o s h   H D  #Applications/Utilities/Terminal.app   / ��  � ��� I  � ��<�;�:
�< .miscactvnull��� ��� null�;  �:  � ��9� I  ��8��
�8 .sysodlogaskr        TEXT� m   � ��� ��� 8 I n s t a l l a t i o n   w a s   s u c c e s s f u l !� �7��
�7 
btns� J   � ��� ��6� m   � ��� ���  O K�6  � �5��4
�5 
dflt� m   ��� ���  O K�4  �9  � R      �3��2
�3 .ascrerr ****      � ****� o      �1�1 0 error_number  �2  � k  �� ��� I �0�/�.
�0 .miscactvnull��� ��� null�/  �.  � ��-� I �,��+
�, .sysodlogaskr        TEXT� m  �� ��� j H o m e b r e w ,   F F M P E G   a n d / o r   M P 4 v 2   c o u l d   n o t   b e   i n s t a l l e d .�+  �-  �C  K ��� =   ,��� 1   #�*
�* 
rslt� K  #+�� �)��(
�) 
bhit� m  &)�� ���  Q u i t�(  � ��'� O /9��� I 38�&�%�$
�& .aevtquitnull��� ��� null�%  �$  �  f  /0�'  �_  �`  �j  �i  �k   � ��� l     �#�"�!�#  �"  �!  � ��� l     � ���   �  �  � ��� i   � ���� I      ���� 0 btngettracks_ btnGetTracks_� ��� o      �� 
0 sender  �  �  � k    ��� ��� l     ����  � , & Code to add iTunes tracks to our list   � ��� L   C o d e   t o   a d d   i T u n e s   t r a c k s   t o   o u r   l i s t� ��� l     ����  � � � via http://dougscripts.com/itunes/itinfo/info02.php and http://www.randomsequence.com/articles/applescript-to-send-selected-itunes-tracks-using-mail/   � ���,   v i a   h t t p : / / d o u g s c r i p t s . c o m / i t u n e s / i t i n f o / i n f o 0 2 . p h p   a n d   h t t p : / / w w w . r a n d o m s e q u e n c e . c o m / a r t i c l e s / a p p l e s c r i p t - t o - s e n d - s e l e c t e d - i t u n e s - t r a c k s - u s i n g - m a i l /� ��� O    ��� k   �� ��� r    ��� J    ��  � o      �� 0 these_titles  � ��� r    ��� J    ��  � o      �� 0 these_times  � ��� r    ��� J    ��  � o      �� 0 these_files  � ��� r    '��� J    !��  � o      �� 0 	the_index  � ��� Z   (����� >  ( .��� 1   ( +�
� 
sele� J   + -��  � l  1���� k   1�� ��� r   1 6��� 1   1 4�

�
 
sele� o      �	�	 0 myselection mySelection� ��� r   7 :��� m   7 8�� � o      �� 0 i  � ��� X   ;���� Z   K����� =  K P��� n   K N��� m   L N�
� 
pcls� o   K L�� 0 atrack aTrack� m   N O� 
�  
cFlT� k   S�� ��� r   S _��� l  S X������ c   S X��� l  S V ����  n   S V 1   T V��
�� 
pnam o   S T���� 0 atrack aTrack��  ��  � m   V W��
�� 
TEXT��  ��  � n        ;   ] ^ o   X ]���� 0 these_titles  �  r   ` l l  ` e	����	 c   ` e

 l  ` c���� n   ` c 1   a c��
�� 
pTim o   ` a���� 0 atrack aTrack��  ��   m   c d��
�� 
TEXT��  ��   n        ;   j k o   e j���� 0 these_times    r   m z l  m s���� n   m s 1   q s��
�� 
psxp l  m q���� e   m q n   m q 1   n p��
�� 
pLoc o   m n���� 0 atrack aTrack��  ��  ��  ��   n        ;   x y o   s x���� 0 these_files    r   { � !  l  { �"����" I  { ���#��
�� .corecnte****       ****# o   { ����� 0 these_titles  ��  ��  ��  ! n      $%$  ;   � �% o   � ����� 0 	the_index   &'& l  � ���()��  ( ( " Get metadata from the first track   ) �** D   G e t   m e t a d a t a   f r o m   t h e   f i r s t   t r a c k' +,+ Z   � �-.����- =  � �/0/ o   � ����� 0 i  0 m   � ����� . k   � �11 232 r   � �454 l  � �6����6 c   � �787 l  � �9����9 n   � �:;: 1   � ���
�� 
pArt; o   � ����� 0 atrack aTrack��  ��  8 m   � ���
�� 
TEXT��  ��  5 o      ���� 0 
pcatartist 
pcatArtist3 <=< r   � �>?> l  � �@����@ c   � �ABA l  � �C����C n   � �DED 1   � ���
�� 
pAlbE o   � ����� 0 atrack aTrack��  ��  B m   � ���
�� 
TEXT��  ��  ? o      ���� 0 	pcatalbum 	pcatAlbum= FGF r   � �HIH l  � �J����J c   � �KLK l  � �M����M n   � �NON 1   � ���
�� 
pCmpO o   � ����� 0 atrack aTrack��  ��  L m   � ���
�� 
TEXT��  ��  I o      ���� 0 pcatcomposer pcatComposerG PQP r   � �RSR l  � �T����T c   � �UVU l  � �W����W n   � �XYX 1   � ���
�� 
pGenY o   � ����� 0 atrack aTrack��  ��  V m   � ���
�� 
TEXT��  ��  S o      ���� 0 	pcatgenre 	pcatGenreQ Z[Z r   � �\]\ l  � �^����^ c   � �_`_ l  � �a����a n   � �bcb 1   � ���
�� 
pDsNc o   � ����� 0 atrack aTrack��  ��  ` m   � ���
�� 
TEXT��  ��  ] o      ���� 0 pcatdisc pcatDisc[ ded r   � �fgf l  � �h����h c   � �iji l  � �k����k n   � �lml 1   � ���
�� 
pDsCm o   � ����� 0 atrack aTrack��  ��  j m   � ���
�� 
TEXT��  ��  g o      ���� 0 	pcatdiscs 	pcatDiscse non r   � �pqp l  � �r����r c   � �sts l  � �u����u n   � �vwv 1   � ���
�� 
pAlAw o   � ����� 0 atrack aTrack��  ��  t m   � ���
�� 
TEXT��  ��  q o      ���� "0 pcatalbumartist pcatAlbumArtisto x��x r   � �yzy l  � �{����{ c   � �|}| l  � �~����~ n   � �� 1   � ���
�� 
pYr � o   � ����� 0 atrack aTrack��  ��  } m   � ���
�� 
TEXT��  ��  z o      ���� 0 pcatyear pcatYear��  ��  ��  , ���� r   ���� l  ������� [   ���� o   � ����� 0 i  � m   � ���� ��  ��  � o      ���� 0 i  ��  �  �  � 0 atrack aTrack� o   > ?���� 0 myselection mySelection�  � #  there ARE tracks selected...   � ��� :   t h e r e   A R E   t r a c k s   s e l e c t e d . . .�  �  �  � m     ���                                                                                  hook  alis    N  Macintosh HD               �(\HH+   QE�
iTunes.app                                                      C�����        ����  	                Applications    �(��      ���     QE�  %Macintosh HD:Applications: iTunes.app    
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  � ��� l ������  � + % Display the songs to be concatenated   � ��� J   D i s p l a y   t h e   s o n g s   t o   b e   c o n c a t e n a t e d� ��� l ������  � [ U via http://stackoverflow.com/questions/25537750/setstringvalue-with-applescript-list   � ��� �   v i a   h t t p : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 2 5 5 3 7 7 5 0 / s e t s t r i n g v a l u e - w i t h - a p p l e s c r i p t - l i s t� ��� r  ��� n ��� 1  ��
�� 
txdl� 1  ��
�� 
ascr� o      ���� 0 olddelimeters  � ��� r  '��� m  �� ���  
� n     ��� 1  "&��
�� 
txdl� 1  "��
�� 
ascr� ��� r  (1��� c  (/��� o  (-���� 0 these_titles  � m  -.��
�� 
TEXT� o      ���� 0 disp_titles  � ��� n 2<��� I  7<������� "0 setstringvalue_ setStringValue_� ���� o  78���� 0 disp_titles  ��  ��  � o  27���� 0 
tracktable 
trackTable� ��� r  =F��� o  =>���� 0 olddelimeters  � n     ��� 1  AE��
�� 
txdl� 1  >A��
�� 
ascr� ��� l GG������  � "  Update the default metadata   � ��� 8   U p d a t e   t h e   d e f a u l t   m e t a d a t a� ��� n GU��� I  LU������� "0 setstringvalue_ setStringValue_� ��� o  LQ�~�~ 0 
pcatartist 
pcatArtist�  ��  � o  GL�}�} 0 	catartist 	catArtist� ��� n Vd��� I  [d�|��{�| "0 setstringvalue_ setStringValue_� ��z� o  [`�y�y 0 	pcatalbum 	pcatAlbum�z  �{  � o  V[�x�x 0 catalbum catAlbum� ��� n es��� I  js�w��v�w "0 setstringvalue_ setStringValue_� ��u� o  jo�t�t 0 pcatcomposer pcatComposer�u  �v  � o  ej�s�s 0 catcomposer catComposer� ��� n t���� I  y��r��q�r "0 setstringvalue_ setStringValue_� ��p� o  y~�o�o 0 	pcatgenre 	pcatGenre�p  �q  � o  ty�n�n 0 catgenre catGenre� ��� n ����� I  ���m��l�m "0 setstringvalue_ setStringValue_� ��k� o  ���j�j 0 pcatdisc pcatDisc�k  �l  � o  ���i�i 0 catdisc catDisc� ��� n ����� I  ���h��g�h "0 setstringvalue_ setStringValue_� ��f� o  ���e�e 0 	pcatdiscs 	pcatDiscs�f  �g  � o  ���d�d 0 catdiscs catDiscs� ��� n ����� I  ���c��b�c "0 setstringvalue_ setStringValue_� ��a� o  ���`�` "0 pcatalbumartist pcatAlbumArtist�a  �b  � o  ���_�_  0 catalbumartist catAlbumArtist� ��� n ����� I  ���^��]�^ "0 setstringvalue_ setStringValue_� ��\� o  ���[�[ 0 pcatyear pcatYear�\  �]  � o  ���Z�Z 0 catyear catYear� ��� l ���Y���Y  � &   Reset the name and track fields   � ��� @   R e s e t   t h e   n a m e   a n d   t r a c k   f i e l d s� ��� n ����� I  ���X��W�X "0 setstringvalue_ setStringValue_� ��V� m  ���� ���  �V  �W  � o  ���U�U 0 catname catName� ��� n ����� I  ���T��S�T "0 setstringvalue_ setStringValue_� ��R� m  ���� ���  �R  �S  � o  ���Q�Q 0 cattrack catTrack� ��P� n ����� I  ���O �N�O "0 setstringvalue_ setStringValue_  �M m  �� �  �M  �N  � o  ���L�L 0 	cattracks 	catTracks�P  �  l     �K�J�I�K  �J  �I    i   � �	 I      �H
�G�H "0 btnconcatenate_ btnConcatenate_
 �F o      �E�E 
0 sender  �F  �G  	 k      l     �D�D   : 4 Update the metadata variables with the user's input    � h   U p d a t e   t h e   m e t a d a t a   v a r i a b l e s   w i t h   t h e   u s e r ' s   i n p u t  r      n    	 I    	�C�B�A�C 0 stringvalue stringValue�B  �A   o     �@�@ 0 catname catName o      �?�? 0 pcatname pcatName  r     n    I    �>�=�<�> 0 stringvalue stringValue�=  �<   o    �;�; 0 	catartist 	catArtist o      �:�: 0 
pcatartist 
pcatArtist  r     / !  n    )"#" I   % )�9�8�7�9 0 stringvalue stringValue�8  �7  # o     %�6�6 0 catalbum catAlbum! o      �5�5 0 	pcatalbum 	pcatAlbum $%$ r   0 ?&'& n  0 9()( I   5 9�4�3�2�4 0 stringvalue stringValue�3  �2  ) o   0 5�1�1 0 catcomposer catComposer' o      �0�0 0 pcatcomposer pcatComposer% *+* r   @ O,-, n  @ I./. I   E I�/�.�-�/ 0 stringvalue stringValue�.  �-  / o   @ E�,�, 0 catgenre catGenre- o      �+�+ 0 	pcatgenre 	pcatGenre+ 010 r   P _232 n  P Y454 I   U Y�*�)�(�* 0 stringvalue stringValue�)  �(  5 o   P U�'�' 0 cattrack catTrack3 o      �&�& 0 	pcattrack 	pcatTrack1 676 r   ` o898 n  ` i:;: I   e i�%�$�#�% 0 stringvalue stringValue�$  �#  ; o   ` e�"�" 0 	cattracks 	catTracks9 o      �!�! 0 
pcattracks 
pcatTracks7 <=< r   p >?> n  p y@A@ I   u y� ���  0 stringvalue stringValue�  �  A o   p u�� 0 catdisc catDisc? o      �� 0 pcatdisc pcatDisc= BCB r   � �DED n  � �FGF I   � ����� 0 stringvalue stringValue�  �  G o   � ��� 0 catdiscs catDiscsE o      �� 0 	pcatdiscs 	pcatDiscsC HIH r   � �JKJ n  � �LML I   � ����� 0 stringvalue stringValue�  �  M o   � ���  0 catalbumartist catAlbumArtistK o      �� "0 pcatalbumartist pcatAlbumArtistI NON r   � �PQP n  � �RSR I   � ����� 0 stringvalue stringValue�  �  S o   � ��� 0 catyear catYearQ o      �� 0 pcatyear pcatYearO TUT r   � �VWV J   � ���  W o      �� 0 	the_pipes  U XYX r   � �Z[Z c   � �\]\ l  � �^�
�	^ n  � �_`_ I   � ����� *0 titleofselecteditem titleOfSelectedItem�  �  ` o   � ��� 0 	radiotype 	radioType�
  �	  ] m   � ��
� 
TEXT[ o      �� 0 mediatypetext mediaTypeTextY aba l  � ���� �  �  �   b cdc Q   � �ef��e I  � ���g��
�� .sysoexecTEXT���     TEXTg m   � �hh �ii � / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t   / p r i v a t e / t m p / c a t . m 4 *   / p r i v a t e / t m p / c a t . m p 4��  f R      ������
�� .ascrerr ****      � ****��  ��  ��  d jkj r   � �lml m   � ���
�� boovfalsm o      ���� 0 errorhappened errorHappenedk non l  � ���pq��  p $  Create the intermediate files   q �rr <   C r e a t e   t h e   i n t e r m e d i a t e   f i l e so sts Q   �uuvwu X   �Mx��yx k   �Hzz {|{ n  �
}~} I   �
������ "0 setstringvalue_ setStringValue_ ���� c   ���� b   ���� b   ���� m   � ��� ���   P r e p a r i n g   t r a c k  � l  ������� c   ���� o   � ����� 0 theindex theIndex� m   � ��
�� 
ctxt��  ��  � m  �� ���  . . .� m  ��
�� 
ctxt��  ��  ~ o   � ����� 0 progressfield progressField| ��� I �����
�� .sysodelanull��� ��� nmbr� m  �� ?ə�������  � ��� I 5�����
�� .sysoexecTEXT���     TEXT� l 1������ c  1��� b  /��� b  +��� b  )��� b  %��� b  ��� o  ���� 0 	cmdprefix 	cmdPrefix� m  �� ���  f f m p e g   - i   "� l $������ c  $��� n  "��� 4  "���
�� 
cobj� o   !���� 0 theindex theIndex� o  ���� 0 these_files  � m  "#��
�� 
ctxt��  ��  � m  %(�� ��� v "   - c   c o p y   - f   m p e g t s   - l o g l e v e l   f a t a l   - v n   / p r i v a t e / t m p / c o n c a t� o  )*���� 0 theindex theIndex� m  +.�� ���  . t s� m  /0��
�� 
ctxt��  ��  ��  � ���� r  6H��� l 6A������ c  6A��� b  6?��� b  6;��� m  69�� ��� & / p r i v a t e / t m p / c o n c a t� o  9:���� 0 theindex theIndex� m  ;>�� ���  . t s� m  ?@��
�� 
ctxt��  ��  � n      ���  ;  FG� o  AF���� 0 	the_pipes  ��  �� 0 theindex theIndexy o   � ����� 0 	the_index  v R      �����
�� .ascrerr ****      � ****� o      ���� 0 error_number  ��  w k  Uu�� ��� r  UX��� m  UV��
�� boovtrue� o      ���� 0 errorhappened errorHappened� ��� I Y`�����
�� .sysoexecTEXT���     TEXT� m  Y\�� ��� > / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *��  � ��� n am��� I  fm������� "0 setstringvalue_ setStringValue_� ���� m  fi�� ���  ��  ��  � o  af���� 0 progressfield progressField� ���� I nu�����
�� .sysodlogaskr        TEXT� m  nq�� ��� � T h e   t r a c k s   y o u   s e l e c t e d   c o u l d   n o t   b e   j o i n e d .   O n l y   m p 4   f i l e s   e n c o d e d   a s   A A C   c a n   b e   j o i n e d   p r e s e n t l y .��  ��  t ��� l vv������  � O I Run the actual concatenation command in ffmpeg (for mp4/AAC files only!)   � ��� �   R u n   t h e   a c t u a l   c o n c a t e n a t i o n   c o m m a n d   i n   f f m p e g   ( f o r   m p 4 / A A C   f i l e s   o n l y ! )� ��� l vv������  � ` Z via https://trac.ffmpeg.org/wiki/How%20to%20concatenate%20(join,%20merge)%20media%20files   � ��� �   v i a   h t t p s : / / t r a c . f f m p e g . o r g / w i k i / H o w % 2 0 t o % 2 0 c o n c a t e n a t e % 2 0 ( j o i n , % 2 0 m e r g e ) % 2 0 m e d i a % 2 0 f i l e s� ��� Z  v�������� H  vx�� o  vw���� 0 errorhappened errorHappened� Q  {����� k  ~��� ��� r  ~���� n ~���� 1  ����
�� 
txdl� 1  ~���
�� 
ascr� o      ���� 0 olddelimeters  � ��� r  ����� m  ���� ���  |� n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr� ��� r  ����� c  ����� o  ������ 0 	the_pipes  � m  ����
�� 
TEXT� o      ���� 0 disp_thepipes  � ��� n ����� I  ���� ���� "0 setstringvalue_ setStringValue_  �� m  �� � . C o n c a t e n a t i n g   t r a c k s . . .��  ��  � o  ������ 0 progressfield progressField�  I ������
�� .sysodelanull��� ��� nmbr m  �� ?ə�������   	 I ����
��
�� .sysoexecTEXT���     TEXT
 l ������ c  �� b  �� b  �� b  �� o  ������ 0 	cmdprefix 	cmdPrefix m  �� � 8 f f m p e g   - f   m p e g t s   - i   " c o n c a t : l ������ c  �� o  ������ 0 disp_thepipes   m  ����
�� 
ctxt��  ��   m  �� � � "   - c   c o p y   - b s f : a   a a c _ a d t s t o a s c   - l o g l e v e l   f a t a l   / p r i v a t e / t m p / c a t . m p 4 m  ����
�� 
ctxt��  ��  ��  	 �� r  �� o  ������ 0 olddelimeters   n      1  ����
�� 
txdl 1  ����
�� 
ascr��  � R      �� ��
�� .ascrerr ****      � ****  o      ���� 0 error_number  ��  � k  ��!! "#" r  ��$%$ m  ����
�� boovtrue% o      ���� 0 errorhappened errorHappened# &'& I ����(��
�� .sysoexecTEXT���     TEXT( m  ��)) �** h / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . m p 4��  ' +,+ n ��-.- I  ����/���� "0 setstringvalue_ setStringValue_/ 0��0 m  ��11 �22  ��  ��  . o  ������ 0 progressfield progressField, 3��3 I ����4��
�� .sysodlogaskr        TEXT4 m  ��55 �66 > T h e   t r a c k s   c o u l d   n o t   b e   j o i n e d .��  ��  ��  ��  � 787 l ����9:��  9 ( " Now let's create the chapter file   : �;; D   N o w   l e t ' s   c r e a t e   t h e   c h a p t e r   f i l e8 <=< Z  �:>?����> H  �@@ o  � ���� 0 errorhappened errorHappened? k  6AA BCB n DED I  	��F���� "0 setstringvalue_ setStringValue_F G��G m  	HH �II * P r e p a r i n g   c h a p t e r s . . .��  ��  E o  	���� 0 progressfield progressFieldC JKJ I ��L��
�� .sysodelanull��� ��� nmbrL m  MM ?ə�������  K N��N Q  6OPQO X  R��SR Z  .	TU��VT A  .1WXW o  ./���� 0 theindex theIndexX m  /0���� U k  4�YY Z[Z I 4L��\��
�� .sysoexecTEXT���     TEXT\ l 4H]����] c  4H^_^ b  4F`a` b  4Bbcb m  47dd �ee 0 / b i n / e c h o   " 0 0 : 0 0 : 0 0 . 0 0 0  c l 7Af����f c  7Aghg n  7?iji 4  <?��k
�� 
cobjk o  =>���� 0 theindex theIndexj o  7<���� 0 these_titles  h m  ?@��
�� 
ctxt��  ��  a m  BEll �mm B "   >   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t_ m  FG��
�� 
ctxt��  ��  ��  [ non r  Mnpqp l Mhr��~r I Mh�}st
�} .sysoexecTEXT���     TEXTs l M`u�|�{u c  M`vwv b  M^xyx b  MZz{z b  MV|}| o  MR�z�z 0 	cmdprefix 	cmdPrefix} m  RU~~ � r f f p r o b e   - l o g l e v e l   p a n i c   - s h o w _ s t r e a m s   / p r i v a t e / t m p / c o n c a t{ l VY��y�x� c  VY��� o  VW�w�w 0 theindex theIndex� m  WX�v
�v 
ctxt�y  �x  y m  Z]�� ��� � . t s   |   e g r e p   - m   1   ' d u r a t i o n = [ 0 - 9 ] + \ . '   |   s e d   ' s / d u r a t i o n = \ ( [ 0 - 9 ] * [ 0 - 9 ] \ . [ 0 - 9 ] * \ ) / \ 1 / 'w m  ^_�u
�u 
ctxt�|  �{  t �t��s
�t 
rtyp� m  cd�r
�r 
TEXT�s  �  �~  q o      �q�q 0 
thecounter 
theCountero ��p� r  o���� l o���o�n� I o��m��
�m .sysoexecTEXT���     TEXT� l o|��l�k� b  o|��� b  ox��� m  or�� ��� � / b i n / e c h o   $ ( / u s r / b i n / p r i n t f   % . $ 2 f   $ ( / b i n / e c h o   " ` / u s r / b i n / p r i n t f   % . 3 f  � o  rw�j�j 0 
thecounter 
theCounter� m  x{�� ��� 2 `   *   1 0 0 0 "   |   / u s r / b i n / b c ) )�l  �k  � �i��h
�i 
rtyp� m  ��g
�g 
TEXT�h  �o  �n  � o      �f�f 0 
thecounter 
theCounter�p  ��  V k  �	�� ��� r  ����� I ���e��d
�e .sysoexecTEXT���     TEXT� l ����c�b� c  ����� b  ����� b  ����� b  ����� o  ���a�a 0 	cmdprefix 	cmdPrefix� m  ���� ���  t =� l ����`�_� c  ����� o  ���^�^ 0 
thecounter 
theCounter� m  ���]
�] 
ctxt�`  �_  � m  ���� ���$ ; ( ( m s e c = t % 1 0 0 0 ,   t / = 1 0 0 0 ,   s e c = t % 6 0 ,   t / = 6 0 ,   m i n = t % 6 0 ,   h r s = t / 6 0 ) ) ; t i m e s t a m p = $ ( p r i n t f   " % 0 2 d : % 0 2 d : % 0 2 d . % 0 3 d "   $ h r s   $ m i n   $ s e c   $ m s e c ) ; / b i n / e c h o   $ t i m e s t a m p� m  ���\
�\ 
ctxt�c  �b  �d  � o      �[�[ 0 thedatestamp theDateStamp� ��� I ���Z��Y
�Z .sysoexecTEXT���     TEXT� l ����X�W� c  ����� b  ����� b  ����� b  ����� b  ����� m  ���� ���  / b i n / e c h o   "� l ����V�U� c  ����� o  ���T�T 0 thedatestamp theDateStamp� m  ���S
�S 
ctxt�V  �U  � m  ���� ���   � l ����R�Q� c  ����� n  ����� 4  ���P�
�P 
cobj� o  ���O�O 0 theindex theIndex� o  ���N�N 0 these_titles  � m  ���M
�M 
ctxt�R  �Q  � m  ���� ��� D "   > >   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t� m  ���L
�L 
ctxt�X  �W  �Y  � ��� r  ����� I ���K��J
�K .sysoexecTEXT���     TEXT� l ����I�H� c  ����� l ����G�F� c  ����� b  ����� b  ����� b  ����� o  ���E�E 0 	cmdprefix 	cmdPrefix� m  ���� ��� r f f p r o b e   - l o g l e v e l   p a n i c   - s h o w _ s t r e a m s   / p r i v a t e / t m p / c o n c a t� l ����D�C� c  ����� o  ���B�B 0 theindex theIndex� m  ���A
�A 
ctxt�D  �C  � m  ���� ��� � . t s   |   e g r e p   - m   1   ' d u r a t i o n = [ 0 - 9 ] + \ . '   |   s e d   ' s / d u r a t i o n = \ ( [ 0 - 9 ] * [ 0 - 9 ] \ . [ 0 - 9 ] * \ ) / \ 1 / '� m  ���@
�@ 
ctxt�G  �F  � m  ���?
�? 
TEXT�I  �H  �J  � o      �>�> 0 thenewcounter theNewCounter� ��� r  ����� I ���=��
�= .sysoexecTEXT���     TEXT� l ����<�;� b  ����� b  ����� m  ���� ��� � / b i n / e c h o   $ ( / u s r / b i n / p r i n t f   % . $ 2 f   $ ( / b i n / e c h o   " ` / u s r / b i n / p r i n t f   % . 3 f  � o  ���:�: 0 thenewcounter theNewCounter� m  ���� ��� 2 `   *   1 0 0 0 "   |   / u s r / b i n / b c ) )�<  �;  � �9��8
�9 
rtyp� m  ���7
�7 
TEXT�8  � o      �6�6 0 thenewcounter theNewCounter� ��5� r  �	��� l ���4�3� [  ���� o  ��2�2 0 
thecounter 
theCounter� o  �1�1 0 thenewcounter theNewCounter�4  �3  � o      �0�0 0 
thecounter 
theCounter�5  �� 0 theindex theIndexS o  "�/�/ 0 	the_index  P R      �.��-
�. .ascrerr ****      � ****� o      �,�, 0 error_number  �-  Q k  6�� ��� r  ��� m  �+
�+ boovtrue� o      �*�* 0 errorhappened errorHappened� ��� I !�)��(
�) .sysoexecTEXT���     TEXT� m     � � / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . m p 4   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t�(  �  n ". I  '.�'�&�' "0 setstringvalue_ setStringValue_ �% m  '* �		  �%  �&   o  "'�$�$ 0 progressfield progressField 
�#
 I /6�"�!
�" .sysodlogaskr        TEXT m  /2 � � T h e   c h a p t e r s   c o u l d   n o t   b e   r e a d   f r o m   t h e   t r a c k s   y o u   h a d   s e l e c t e d .�!  �#  ��  ��  ��  =  l ;;� �      Chapterize cat.mp4    � &   C h a p t e r i z e   c a t . m p 4  Z  ;��� H  ;= o  ;<�� 0 errorhappened errorHappened Q  @� k  Ce  n CO I  HO� �� "0 setstringvalue_ setStringValue_  !�! m  HK"" �##  C h a p t e r i z i n g . . .�  �   o  CH�� 0 progressfield progressField $%$ I PU�&�
� .sysodelanull��� ��� nmbr& m  PQ'' ?ə������  % (�( I Ve�)�
� .sysoexecTEXT���     TEXT) l Va*��* c  Va+,+ b  V_-.- o  V[�� 0 	cmdprefix 	cmdPrefix. m  [^// �00 @ m p 4 c h a p s   - i   / p r i v a t e / t m p / c a t . m p 4, m  _`�
� 
ctxt�  �  �  �   R      �1�
� .ascrerr ****      � ****1 o      �� 0 error_number  �   k  m�22 343 r  mp565 m  mn�
� boovtrue6 o      �� 0 errorhappened errorHappened4 787 I qx�
9�	
�
 .sysoexecTEXT���     TEXT9 m  qt:: �;; � / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . m p 4   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t�	  8 <=< n y�>?> I  ~��@�� "0 setstringvalue_ setStringValue_@ A�A m  ~�BB �CC  �  �  ? o  y~�� 0 progressfield progressField= D�D I ���E�
� .sysodlogaskr        TEXTE m  ��FF �GG j T h e   c h a p t e r s   c o u l d   n o t   b e   a d d e d   t o   c o n c a t e n a t e d   f i l e .�  �  �  �   HIH l ���JK�  J  	 Add tags   K �LL    A d d   t a g sI MNM Z  �VOP� ��O H  ��QQ o  ������ 0 errorhappened errorHappenedP Q  �RRSTR k  �*UU VWV n ��XYX I  ����Z���� "0 setstringvalue_ setStringValue_Z [��[ m  ��\\ �]]  A d d i n g   t a g s . . .��  ��  Y o  ������ 0 progressfield progressFieldW ^_^ I ����`��
�� .sysodelanull��� ��� nmbr` m  ��aa ?ə�������  _ b��b I �*��c��
�� .sysoexecTEXT���     TEXTc l �&d����d c  �&efe b  �$ghg b  � iji b  �klk b  �mnm b  �opo b  �qrq b  �sts b  �uvu b  ��wxw b  ��yzy b  ��{|{ b  ��}~} b  ��� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� b  ����� o  ������ 0 	cmdprefix 	cmdPrefix� m  ���� ���  m p 4 t a g s   - s o n g   "� o  ������ 0 pcatname pcatName� m  ���� ���  "   - a l b u m   "� o  ������ 0 	pcatalbum 	pcatAlbum� m  ���� ���  "   - a r t i s t   "� o  ������ 0 
pcatartist 
pcatArtist� m  ���� ���  "   - w r i t e r   "� o  ������ 0 pcatcomposer pcatComposer� m  ���� ���  "   - g e n r e   "� o  ������ 0 	pcatgenre 	pcatGenre� m  ���� ���  "   - t r a c k   "~ o  ������ 0 	pcattrack 	pcatTrack| m  ���� ���  "   - t r a c k s   "z o  ������ 0 
pcattracks 
pcatTracksx m  ���� ���  "   - d i s k   "v o  ����� 0 pcatdisc pcatDisct m  �� ���  "   - d i s k s   "r o  ���� 0 	pcatdiscs 	pcatDiscsp m  �� ���   "   - a l b u m a r t i s t   "n o  ���� "0 pcatalbumartist pcatAlbumArtistl m  �� ���  "   - y e a r   "j o  ���� 0 pcatyear pcatYearh m   #�� ��� , "   / p r i v a t e / t m p / c a t . m p 4f m  $%��
�� 
ctxt��  ��  ��  ��  S R      �����
�� .ascrerr ****      � ****� o      ���� 0 error_number  ��  T k  2R�� ��� r  25��� m  23��
�� boovtrue� o      ���� 0 errorhappened errorHappened� ��� I 6=�����
�� .sysoexecTEXT���     TEXT� m  69�� ��� � / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . m p 4   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t��  � ��� n >J��� I  CJ������� "0 setstringvalue_ setStringValue_� ���� m  CF�� ���  ��  ��  � o  >C���� 0 progressfield progressField� ���� I KR�����
�� .sysodlogaskr        TEXT� m  KN�� ��� v T h e   t a g s   c o u l d   n o t   b e   a d d e d   t o   t h e   c o n c a t e n a t e d   a u d i o   f i l e .��  ��  �   ��  N ��� l WW������  � ' ! Add the finished track to iTunes   � ��� B   A d d   t h e   f i n i s h e d   t r a c k   t o   i T u n e s� ��� Z  W�������� H  WY�� o  WX���� 0 errorhappened errorHappened� k  \��� ��� n \h��� I  ah������� "0 setstringvalue_ setStringValue_� ���� m  ad�� ��� & A d d i n g   t o   i T u n e s . . .��  ��  � o  \a���� 0 progressfield progressField� ��� I in�����
�� .sysodelanull��� ��� nmbr� m  ij�� ?ə�������  � ���� Q  o����� k  r��� ��� Z  r������� = r{��� o  rw���� 0 mediatypetext mediaTypeText� m  wz�� ���  M u s i c   t r a c k� r  ~���� m  ~��� ���  m 4 a� o      ���� 0 	mediatype 	mediaType� ��� = ����� o  ������ 0 mediatypetext mediaTypeText� m  ���� ���  A u d i o b o o k   t r a c k� ���� r  ����� m  ���� ���  m 4 b� o      ���� 0 	mediatype 	mediaType��  ��  � ��� I �������
�� .sysoexecTEXT���     TEXT� l �������� c  ����� b  ����� m  ��   � \ / b i n / m v   / p r i v a t e / t m p / c a t . m p 4   / p r i v a t e / t m p / c a t .� o  ������ 0 	mediatype 	mediaType� m  ����
�� 
ctxt��  ��  ��  � �� O  �� I ������
�� .hookAdd cTrk      @ alis 4  ����
�� 
file l ������ c  ��	 b  ��

 m  �� � " : p r i v a t e : t m p : c a t . o  ������ 0 	mediatype 	mediaType	 m  ����
�� 
ctxt��  ��  ��   m  ���                                                                                  hook  alis    N  Macintosh HD               �(\HH+   QE�
iTunes.app                                                      C�����        ����  	                Applications    �(��      ���     QE�  %Macintosh HD:Applications: iTunes.app    
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  ��  � R      ����
�� .ascrerr ****      � **** o      ���� 0 error_number  ��  � k  ��  r  �� m  ����
�� boovtrue o      ���� 0 errorhappened errorHappened  I ������
�� .sysoexecTEXT���     TEXT b  �� m  �� � � / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . m p 4   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t   / p r i v a t e / t m p / c a t . o  ������ 0 	mediatype 	mediaType��    n �� I  ���� ���� "0 setstringvalue_ setStringValue_  !��! m  ��"" �##  ��  ��   o  ������ 0 progressfield progressField $��$ I ����%��
�� .sysodlogaskr        TEXT% m  ��&& �'' f T h e   c o n c a t e n a t e d   f i l e   c o u l d   n o t   b e   a d d e d   t o   i T u n e s .��  ��  ��  ��  ��  � ()( l ����*+��  *  	 Clean up   + �,,    C l e a n   u p) -.- I ����/��
�� .sysoexecTEXT���     TEXT/ m  ��00 �11 � / b i n / r m   - f   / p r i v a t e / t m p / c o n c a t *   / p r i v a t e / t m p / c a t . c h a p t e r s . t x t   / p r i v a t e / t m p / c a t . m 4 *��  . 232 r  ��454 m  ��66 �77  5 o      ���� 0 
thecounter 
theCounter3 8��8 n  9:9 I  ��;���� "0 setstringvalue_ setStringValue_; <��< m  == �>>  ��  ��  : o   ���� 0 progressfield progressField��   ?@? l     ��������  ��  ��  @ ABA l     ��������  ��  ��  B CDC i   � �EFE I      ��G���� B0 applicationwillfinishlaunching_ applicationWillFinishLaunching_G H��H o      ���� 0 anotification aNotification��  ��  F l     ��IJ��  I R L Insert code here to initialize your application before any files are opened   J �KK �   I n s e r t   c o d e   h e r e   t o   i n i t i a l i z e   y o u r   a p p l i c a t i o n   b e f o r e   a n y   f i l e s   a r e   o p e n e dD LML l     ��������  ��  ��  M NON i   � �PQP I      ��R���� :0 applicationshouldterminate_ applicationShouldTerminate_R S��S o      ���� 
0 sender  ��  ��  Q k     TT UVU l     ��WX��  W L F Insert code here to do any housekeeping before your application quits   X �YY �   I n s e r t   c o d e   h e r e   t o   d o   a n y   h o u s e k e e p i n g   b e f o r e   y o u r   a p p l i c a t i o n   q u i t sV Z��Z L     [[ n    \]\ o    ����  0 nsterminatenow NSTerminateNow] m     ��
�� misccura��  O ^��^ l     ��������  ��  ��  ��  ��       ��_`��  _ ����  0 dasappdelegate DASAppDelegate` �� )ab��  0 dasappdelegate DASAppDelegatea cc ����d
�� misccura
�� 
pclsd �ee  N S O b j e c tb -��f����~�}�|�{�z�y�x�w�v�u�t�s�r�q z  � � � � � � � � � � � � �ghijk � �lmnop��  f +�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�K�J�I�H�G�F
�p 
pare
�o 
cwin�n 0 
tracktable 
trackTable�m 0 catname catName�l 0 	catartist 	catArtist�k 0 catalbum catAlbum�j 0 catcomposer catComposer�i 0 catgenre catGenre�h 0 cattrack catTrack�g 0 	cattracks 	catTracks�f 0 catdisc catDisc�e 0 catdiscs catDiscs�d  0 catalbumartist catAlbumArtist�c 0 catyear catYear�b 0 	radiotype 	radioType�a 0 progressfield progressField�` 0 pcatname pcatName�_ 0 
pcatartist 
pcatArtist�^ 0 	pcatalbum 	pcatAlbum�] 0 pcatcomposer pcatComposer�\ 0 	pcatgenre 	pcatGenre�[ 0 	pcattrack 	pcatTrack�Z 0 
pcattracks 
pcatTracks�Y 0 pcatdisc pcatDisc�X 0 	pcatdiscs 	pcatDiscs�W "0 pcatalbumartist pcatAlbumArtist�V 0 pcatyear pcatYear�U "0 missingpackages missingPackages�T 0 mediatypetext mediaTypeText�S 0 	peachname 	pEachName�R 0 peachlocation pEachLocation�Q 0 these_titles  �P 0 these_files  �O 0 these_times  �N 0 	the_index  �M 0 	the_pipes  �L 0 
thecounter 
theCounter�K 0 	cmdprefix 	cmdPrefix�J 0 awakefromnib awakeFromNib�I 0 btngettracks_ btnGetTracks_�H "0 btnconcatenate_ btnConcatenate_�G B0 applicationwillfinishlaunching_ applicationWillFinishLaunching_�F :0 applicationshouldterminate_ applicationShouldTerminate_��  
� 
msng
�~ 
msng
�} 
msng
�| 
msng
�{ 
msng
�z 
msng
�y 
msng
�x 
msng
�w 
msng
�v 
msng
�u 
msng
�t 
msng
�s 
msng
�r 
msng
�q 
msngg �E�D�E  �D  h �C�B�C  �B  i �A�@�A  �@  j �?�>�?  �>  k �=�<�=  �<  l �; ��:�9qr�8�; 0 awakefromnib awakeFromNib�:  �9  q �7�6�7 0 error_number  �6 0 newtab newTabr % ��5�4s %.9;�3BE�2�1�0�/�.Pz_�-�,�+s�*�)��(����'��
�5 .sysoexecTEXT���     TEXT�4  s �&�%�$
�& 
errn�% 0 error_number  �$  
�3 
btns
�2 
dflt�1 
�0 .sysodlogaskr        TEXT
�/ 
rslt
�. 
bhit
�- .coredoscnull��� ��� ctxt
�, .sysodelanull��� ��� nmbr
�+ .miscactvnull��� ��� null
�* 
busy�)  
�( .aevtquitnull��� ��� null�' 0 error_number  �8B b  %�%j W X  �Ec  O b  %�%j W #X  b  �  �b  6FY 	�Ec  Ob  � ��b  %�%���lv�la  O_ a a l  �a  Jb  %a %j E�Okj O*j O % hZa j O�a , Y h[OY��W X  hUO 9b  %a %j Oa  *j UO*j Oa �a  kv�a !a  W X " *j Oa #j Y _ a a $l  ) *j UY hY hm �#��"�!tu� �# 0 btngettracks_ btnGetTracks_�" �v� v  �� 
0 sender  �!  t ������� 
0 sender  � 0 myselection mySelection� 0 i  � 0 atrack aTrack� 0 olddelimeters  � 0 disp_titles  u ���������������
�	����������
� 
sele
� 
kocl
� 
cobj
� .corecnte****       ****
� 
pcls
� 
cFlT
� 
pnam
� 
TEXT
� 
pTim
� 
pLoc
� 
psxp
� 
pArt
� 
pAlb
�
 
pCmp
�	 
pGen
� 
pDsN
� 
pDsC
� 
pAlA
� 
pYr 
� 
ascr
� 
txdl� "0 setstringvalue_ setStringValue_� ��jvEc  OjvEc  !OjvEc   OjvEc  "O*�,jv �*�,E�OkE�O С[��l kh ��,�  ���,�&b  6FO��,�&b  !6FO��,E�,b   6FOb  j b  "6FO�k  l��,�&Ec  O��,�&Ec  O��,�&Ec  O��,�&Ec  O�a ,�&Ec  O�a ,�&Ec  O�a ,�&Ec  O�a ,�&Ec  Y hO�kE�Y h[OY�>Y hUO_ a ,E�Oa _ a ,FOb  �&E�Ob  �k+ O�_ a ,FOb  b  k+ Ob  b  k+ Ob  b  k+ Ob  b  k+ Ob  
b  k+ Ob  b  k+ Ob  b  k+ Ob  b  k+ Ob  a k+ Ob  a k+ Ob  	a k+ n �	� ��wx��� "0 btnconcatenate_ btnConcatenate_�  ��y�� y  ���� 
0 sender  ��  w 	�������������������� 
0 sender  �� 0 errorhappened errorHappened�� 0 theindex theIndex�� 0 error_number  �� 0 olddelimeters  �� 0 disp_thepipes  �� 0 thedatestamp theDateStamp�� 0 thenewcounter theNewCounter�� 0 	mediatype 	mediaTypex \������h��������������������������������������)15Hdl~�������������� "/:BF\�������������������� ����"&06=�� 0 stringvalue stringValue�� *0 titleofselecteditem titleOfSelectedItem
�� 
TEXT
�� .sysoexecTEXT���     TEXT��  ��  
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
ctxt�� "0 setstringvalue_ setStringValue_
�� .sysodelanull��� ��� nmbr�� 0 error_number  
�� .sysodlogaskr        TEXT
�� 
ascr
�� 
txdl
�� 
rtyp
�� 
file
�� .hookAdd cTrk      @ alis��b  j+  Ec  Ob  j+  Ec  Ob  j+  Ec  Ob  j+  Ec  Ob  j+  Ec  Ob  j+  Ec  Ob  	j+  Ec  Ob  
j+  Ec  Ob  j+  Ec  Ob  j+  Ec  Ob  j+  Ec  OjvEc  #Ob  j+ �&Ec  O 
�j W X  hOfE�O n hb  "[��l 	kh b  ��&%�%�&k+ O�j Ob  %a %b   �/�&%a %�%a %�&j Oa �%a %�&b  #6F[OY��W 'X  eE�Oa j Ob  a k+ Oa j O� � Y_ a ,E�Oa _ a ,FOb  #�&E�Ob  a k+ O�j Ob  %a %��&%a %�&j O�_ a ,FW 'X  eE�Oa  j Ob  a !k+ Oa "j Y hO�7b  a #k+ O�j O � �b  "[��l 	kh �l [a $b  �/�&%a %%�&j Ob  %a &%��&%a '%�&a (�l Ec  $Oa )b  $%a *%a (�l Ec  $Y ~b  %a +%b  $�&%a ,%�&j E�Oa -��&%a .%b  �/�&%a /%�&j Ob  %a 0%��&%a 1%�&�&j E�Oa 2�%a 3%a (�l E�Ob  $�Ec  $[OY�W 'X  eE�Oa 4j Ob  a 5k+ Oa 6j Y hO� R 'b  a 7k+ O�j Ob  %a 8%�&j W 'X  eE�Oa 9j Ob  a :k+ Oa ;j Y hO� � �b  a <k+ O�j Ob  %a =%b  %a >%b  %a ?%b  %a @%b  %a A%b  %a B%b  %a C%b  %a D%b  %a E%b  %a F%b  %a G%b  %a H%�&j W 'X  eE�Oa Ij Ob  a Jk+ Oa Kj Y hO� �b  a Lk+ O�j O Rb  a M  
a NE�Y b  a O  
a PE�Y hOa Q�%�&j Oa R *a Sa T�%�&/j UUW )X  eE�Oa V�%j Ob  a Wk+ Oa Xj Y hOa Yj Oa ZEc  $Ob  a [k+ o ��F����z{���� B0 applicationwillfinishlaunching_ applicationWillFinishLaunching_�� ��|�� |  ���� 0 anotification aNotification��  z ���� 0 anotification aNotification{  �� hp ��Q����}~���� :0 applicationshouldterminate_ applicationShouldTerminate_�� ����   ���� 
0 sender  ��  } ���� 
0 sender  ~ ����
�� misccura��  0 nsterminatenow NSTerminateNow�� ��,E ascr  ��ޭ