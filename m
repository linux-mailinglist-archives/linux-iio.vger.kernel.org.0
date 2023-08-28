Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0110E78B617
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjH1RKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjH1RJr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 13:09:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4513CE55
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 10:09:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-500bb392ab7so1582963e87.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693242524; x=1693847324;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KhVqJrkrqBNlqi6IpxkR/5t9D7hckFnElj07vbxrqSE=;
        b=N3vG2Ms4M5lVgCJM13o+7/wWbEdJumaoTsFbfkE3GOw0ED+VdMt6u86ehfQD+aePUv
         aqSpPGNomdayf/OAxXe2gwEuJkQ5G1TE+AAobeFTrQWfuVNbOEWOTDszEPWey00XE5Sy
         WDK1qLRpmzqRn1H6D8qJX7IyZuPkADx9h15q0Z97gZxgUUdun51w6yGnjJKSkeHPDaxb
         AaMsl3wdFU3g/S6LnplHo3grlNSGlZPNXc90JwZTLu/MDj1g1RiWG1j9Z7QAMRUH2D8M
         3zF4yi6jgB1GVXD1KjfuHkAQ9q5a/icdbZjiEK5rtYjcCrrUwMOzXkSpW+nJz/f2/JSM
         Uhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242524; x=1693847324;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhVqJrkrqBNlqi6IpxkR/5t9D7hckFnElj07vbxrqSE=;
        b=OJ1Yy8ICaRDQ4GEGCqglRrBGZksziJBqPObmKR/CYwAYyg4igKJAopTnpbZZs+OjxY
         NOtgrQhGFFe7nuZv+1R6GZ4LElgwV2fG+NOJqr+4Cuau6gZcNebAbyucRvPE1KNGy8+A
         svTNIsm47iJIo6GJcjJ3yC+x6oBmyPLAoeVSbdSpenTj2s7g8zswqVOrcOXeTYYANrPs
         ZcE1bRwlnkfHYZcNGMJM9Jh62Ys/yZKBfaj9KE1pZh+NQYvv7Yu3RnijcnfiVMMfK9tN
         6+XS+wX8dDAqLQW9pYmgr4e4wZEnC4Am8Wq7E18mEtnQJhH6XhMAzQzqQ132KWDjvAAG
         s5JA==
X-Gm-Message-State: AOJu0YyvvctT/7vdSkaFblYwE/PNIwMCCpLw0skxPemWUJ/LdvLBr3ST
        J+ZEVkREPo3BDI6qYyD4+JNRrCqIGqFJbSgre7A=
X-Google-Smtp-Source: AGHT+IFD0gG+jYJSP/rRuCk01Uj8R4Ezh+YmdiwCRL7f/MwcmY8VdosHR5AyiNUUocFgMvtQWxw4ouJj430FQrlb0PE=
X-Received: by 2002:a05:6512:114d:b0:4fd:d08c:fa3e with SMTP id
 m13-20020a056512114d00b004fdd08cfa3emr26710295lfg.42.1693242523503; Mon, 28
 Aug 2023 10:08:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:42c9:b0:272:44f7:a1d4 with HTTP; Mon, 28 Aug 2023
 10:08:43 -0700 (PDT)
Reply-To: candypayne48@gmail.com
From:   payne candy <mousandiaye411@gmail.com>
Date:   Mon, 28 Aug 2023 10:08:43 -0700
Message-ID: <CAK_EP0Qh888P8peA0YUDqCwCNBa=xBeg6Ok7VxO37-roLLzJqQ@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

5oiR5biM5pyb5oKo6IO955CG6Kej5oiR55qE5L+h5oGv77yM5Zug5Li65oiR5q2j5Zyo5L2/55So
57+76K+R5Zmo44CCDQoNCuaIkeaYr+S9qeaBqeWdjui/quS4reWjq+Wkq+S6uuOAgg0KDQrlnKjn
vo7lm73pmYblhpvnmoTlhpvkuovpg6jpl6jjgIIg576O5Zu977yM5LiA5ZCN5Lit5aOr77yMMzIg
5bKB77yM5oiR5p2l6Ieq576O5Zu95L+E5Lql5L+E5bee5YWL5Yip5aSr5YWw77yM5Y2V6Lqr77yM
55uu5YmN5LiO5ZCM5LqL5LiA6LW35Zyo5Yip5q+U5Lqa54+t5Yqg6KW/5omn6KGM5LiA6aG554m5
5q6K5Lu75Yqh44CCDQoNCuaIkeaYr+S4gOS4quWFhea7oeeIseW/g+OAgeivmuWunuOAgea3seaD
heeahOS6uu+8jOWFt+acieiJr+WlveeahOW5vem7mOaEn++8jOaIkeWWnOasoue7k+ivhuaWsOac
i+WPi+W5tuS6huino+S7luS7rOeahOeUn+a0u+aWueW8j++8jOaIkeWWnOasoueci+WIsOWkp+a1
t+eahOazoua1quOAgeWxseiEieeahOe+juS4veS7peWPiuWkp+iHqueEtueahOS4gOWIhw0K5o+Q
5L6b44CCIOW+iOmrmOWFtOabtOWkmuWcsOS6huino+aCqO+8jOaIkeiupOS4uuaIkeS7rOWPr+S7
peW7uueri+iJr+WlveeahOWVhuS4muWPi+iwiuOAgg0KDQrmiJHkuIDnm7TlvojkuI3lvIDlv4Pv
vIzlm6DkuLrlpJrlubTmnaXnlJ/mtLvlr7nmiJHkuI3lhazlubPvvJsg5oiRMjHlsoHml7blsLHl
pLHljrvkuobniLbmr43jgIIg5oiR54i25Lqy55qE5ZCN5a2X5piv5biV54m56YeM5YWLwrfkvanm
ganvvIzmiJHnmoTmr43kurLmmK/njpvkuL3Ct+S9qeaBqeOAgg0K5rKh5pyJ5Lq65biu5Yqp5oiR
77yM5L2G5oiR5b6I6auY5YW05oiR57uI5LqO5Zyo576O5Zu95Yab6Zif5Lit5om+5Yiw5LqG6Ieq
5bex44CCDQoNCuaIkee7k+WpmuS6hu+8jOacieS6huWtqeWtkO+8jOS9huS7luWOu+S4luS6hu+8
jOS4jeS5heaIkeS4iOWkq+WwseW8gOWni+asuumql+aIke+8jOaJgOS7peaIkeS4jeW+l+S4jeaU
vuW8g+WpmuWnu+OAgg0KDQrmiJHkuZ/lvojlubjov5DvvIzlnKjmiJHnmoTlm73lrrbnvo7lm73l
kozliKnmr5Tkuprnj63liqDopb/ov5nph4zvvIzmiJHmi6XmnInnlJ/mtLvkuK3miYDpnIDnmoTk
uIDliIfvvIzkvYbmsqHmnInkurrnu5nmiJHlu7rorq7jgIINCuaIkemcgOimgeS4gOS4quivmuWu
nueahOS6uuadpeS/oeS7u++8jOW5tuS4lOS7luS5n+S8muWwseWmguS9leaKlei1hOaIkeeahOmS
seaPkOS+m+W7uuiuruOAgiDlm6DkuLrmiJHmmK/miJHniLbmr43ljrvkuJbliY3nlJ/kuIvnmoTl
lK/kuIDnmoTlpbPlranjgIINCg0K5oiR5LiN6K6k6K+G5L2g5pys5Lq677yM5L2G5oiR6K6k5Li6
5pyJ5LiA5Liq5YC85b6X5L+h5Lu755qE5aW95Lq677yM5Y+v5Lul5bu656uL55yf5q2j55qE5L+h
5Lu75ZKM6Imv5aW955qE5ZWG5Lia5Y+L6LCK77yM5aaC5p6c5L2g56Gu5a6e5pyJ6K+a5a6e5ZKM
6K+a5a6e55qE5ZCN5aOw77yM5oiR5Lmf5pyJ5LiA5Lqb5Lic6KW/5Y+v5Lul5LiO5L2g5YiG5Lqr
44CCDQrnm7jkv6HjgIIg5a+55L2g5p2l6K+077yM5Zug5Li65oiR6ZyA6KaB5L2g55qE5biu5Yqp
44CCDQoNCuaIkeaJi+mHjOacieaIkeS7rOWcqOaRqea0m+WTpeaJp+ihjOS7u+WKoeaXtuaJgOaL
peacieeahOaAu+mHkemine+8iDcuMjAwLjAwMC4wMCDnvo7lhYPvvInjgIINCuaIkeWwhuWcqOS4
i+S4gOWwgeeUteWtkOmCruS7tuS4reWRiuivieaCqOaIkeWmguS9leiOt+W+l+i/meeslOi1hOmH
ke+8jOS4jeimgeaDiuaFjO+8jOWug+S7rOaYr+aXoOmjjumZqeeahO+8jOaIkei/mOWcqOS4jue6
ouiJsuacieWFs+eahOS6uumBk+S4u+S5ieWMu+eUn+eahOW4ruWKqeS4i+Wwhui/meeslOi1hOmH
keWtmOWFpeaRqea0m+WTpeeahOS4gOWutumTtuihjOOAgg0K5oiR5biM5pyb5oKo5Lul5oiR55qE
5Y+X55uK5Lq66Lqr5Lu95o6l5Y+X6K+l5Z+66YeR77yM5bm25Zyo5oiR5Zyo5Yip5q+U5Lqa57uT
5p2f5bel5L2c5ZCO5aal5ZaE5L+d566h6K+l5Z+66YeR77yM5bm26I635b6X5oiR55qE5Yab5LqL
6YCa6KGM6K+B77yM5Lul5L6/5Zyo5oKo55qE5Zu95a625LiO5oKo5Lya6Z2i77ybDQrkuI3opoHm
i4Xlv4Ppk7booYzkvJrpgJrov4fpk7booYzpl7TovazotKblsIbotYTph5Hovaznu5nmgqjvvIzo
v5nlr7nmiJHku6zmnaXor7Tml6Llronlhajlj4jlv6vmjbfjgIINCg0K56yU6K6wOyDmiJHkuI3n
n6XpgZPmiJHku6zopoHlnKjov5nph4zlkYblpJrkuYXvvIzkuZ/kuI3nn6XpgZPmiJHnmoTlkb3o
v5DvvIzlm6DkuLrmiJHlnKjov5nph4znu4/ljobkuobkuKTmrKHngrjlvLnooq3lh7vvvIzov5nl
r7zoh7TmiJHlr7vmib7kuIDkuKrlgLzlvpfkv6HotZbnmoTkurrmnaXluK7liqnmiJHmjqXmlLbl
kozmipXotYTln7rph5HvvIzlm6DkuLrmiJHlsIbmnaXliLDkvaDku6znmoTlm73lrrYNCuWHuui6
q+aKlei1hOW5tuW8gOWni+aWsOeahOeUn+a0u++8jOS4jeWGjeW9k+WFteOAgg0KDQrlpoLmnpzm
gqjmhL/mhI/osKjmhY7lpITnkIbmraTpl67popjvvIzor7flm57lpI3miJHjgIIg5oiR5Lya5ZGK
6K+J5oKo5o6l5LiL5p2l55qE5rWB56iL5bm25ZCR5oKo5Y+R6YCB5pyJ5YWz5q2k5Lqk5piT55qE
5pu05aSa5L+h5oGv44CCIOWmguaenOS9oOacieWFtOi2o++8jOivt+S4juaIkeiBlOezu+OAgg0K
