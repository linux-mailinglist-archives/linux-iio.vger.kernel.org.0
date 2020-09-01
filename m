Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC295258B59
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAJUR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 05:20:17 -0400
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:43207
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgIAJUR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 05:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598952016; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=GsneJkp2sraeCod/J0HV9wb4JLPF6SOZfGpZav5hVdbgubG/dhFVQ24DFcF2Ic4a3MeaxZxhqILSKoEkVoSnR7EHtJd1Sm3DvwYB8BK8YX7alMpSdEW8YCdCvDjZglBxZ1oYx3coUT/AvaFYQp76FIHgLzW95FW3p0MovRPeWT3mptZn7C2NihHeSjr8XCx98gujPYVaXJaKuzYLYZ/OYp0G76aN0vGAkt8rx6S8DywhEEuW53aOXlpPN17m+sWZiDmskReoAlv75WpJDjuBR2AeW0nSH+C35zx/b0l1zH1UM1BQvjcJgjraes2u1PtVgePr0ubRIQCESCmbQqlUKg==
X-YMail-OSG: 4xJkBtcVM1mYWY5oTKqVQf7EhP5mZaaBK.9FDZtVwjVAGbd0sdM1gcZxbDMwh.n
 BFYKcY7eMHeaXVnqRuICksHjQ1Znvq6HjsUMmYbk9Yq5A8r6Og26vb67.VkAgHwshKDVNEWHVQA_
 W6UgXqWfckz65yGa0gxNdqBqn8jt7RVPcrxc.b_.jVgdzN.lcVR1WU05QFBPs1hP6j5lTkvuK6BY
 NGjh.q.fVBxWcLwnU62rSnQ1RSUBxHYOKl_tu.XLW2eR3NTm2ikW5cD2JOBBum4r8JWGbqScQrYp
 WVIbceFOVQp4cyqEsFXJxb4O117iiGUnR0wjRd58Zr1b0nbd3KVj0XinwyjMoSulo.4mJqLgySiS
 UjeiINqoT681s_09VDxoPUmOwAemeMPxP9IydusL5MgBFg2xLUIcqEBGdDwPi8.alpDht.ja36PS
 5N8jRd6WC0WIDPMn44Y3I.V8y5bzqUoabutqOc.qy08WfceLUw25mEqAS8hnWsgR1AVf_ctYderh
 iPPgVe2rKJ.KWx2RyqGst2gt5_yTsawOvntxLapawwst._5ariylEejdW9VJktidF51pcuD2yXr7
 CSlR2xk5h6CpqVuMMouOwBarJWEgUdL8uToE8BI1E00a2YgHB7qhJUAJV08zTe1wjmlzgTGpwihM
 ZJlOkVLLZIR548KUUIMOirTU2QUR_3FbZn96gwlFOm4QxRoeouR1tPHkTp38Ql6kiNdzfhhkenF5
 RvEgcyZmX9eVizfBkjQRkIc8jH5FXM3hX17p6.8fKhqfH1iWQsDgEc04P7rc8EsPJcsIf_qWDHjd
 iVGu1JGzPMBl.sjESJnQ96AZDJqQ87hb_O8bh23__0Jii7k9KpoUUXAGrzlyK5QN1Tn.GFTV.PGY
 0rv_tusB6xWLxULsgtv2yVa609Mdz6RWuI6wuh6nFttFdfSdcDkkGUmQnZHaxa7FhMuOI3AfTT7R
 eqg0sDIr5pY_5jUXlyl89roQZ0oj6LoXPwQNJzUZpbVUz1DvoKXUDqTuLwrL0naEI2QLn2Kbzzjc
 woiLEV74MTVH0XF26IiCZihh2tVqGRANFFJsib7UIf_2F5N9mSC8EzJVq3u2Aq932ewiJmIluB3k
 iP73l10V7ekc3zyfDe.346i8Jgfnvjt7Cq9_8Or47MlkJpirqsengCqzGyjnu5K4dAmDGgwVCWkv
 8jaCC.s5F5scbwyEqYfOoDOuEKCtNvoC5ZCPdJ_XGCPATEKxncZTadNDdKaOmsP5r9Mj4f6wFyIm
 17F0l2xlUsSzyF8yeC6_GaN40AjwyTrFVG1px4jjstK35LSbAgLSSWHdihTF4mwJzl2ZVwbIrQys
 yqHGi.Vd9KLH5rGI7eMMNOXJSa7UzHje1asPQJxWBQxrr6cDhdzy_HMrSRDFTpPCEZirFzKrlRQq
 WWq.1rAeoXENPybm6U0bLIio8XLmD26_GEoNAvVocZ57jKw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 1 Sep 2020 09:20:16 +0000
Date:   Tue, 1 Sep 2020 09:20:16 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <brunelminaa2@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <872962258.1010260.1598952016332@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <872962258.1010260.1598952016332.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
