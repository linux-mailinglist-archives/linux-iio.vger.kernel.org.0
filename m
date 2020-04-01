Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2919AABA
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732146AbgDALZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 07:25:29 -0400
Received: from sonic316-13.consmr.mail.bf2.yahoo.com ([74.6.130.123]:40361
        "EHLO sonic316-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732121AbgDALZ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 07:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585740328; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=BO6XtL1VJ9VB09afy5FWPkAB3X1cQVJzOfDPSc9We29ak7l31/tdXfi3CZ0ECy7+ojGBV/KqyZs1MLaIs7DFBcdxZKzeiBtexlu1KpmSwOrSFW/hzJpdMsFgD/CNrKXSrMiX46GtzBD3R9SrQh3UrSAXoSaVCW4LF5aA14C9/5uK/wSzpa2/3ZFtU9tA+CnKDGJ2G25nmUoV56yE0IfZYSkO/SjAmS2GCuVzA1TKH0isQL3qZnPjvzfS4rsNQ1BSV37/2xJz/4rGnJkBhuhvXToSrfPf5GTx/KHmWNMrsslVZGvWi909X0bK4RKPMFoAZOPKC3oKPk4NNESjbtSkmg==
X-YMail-OSG: wwGB57wVM1nWRK8gFYKCST.A81orHkdXWeVsqTlC06Lrv1tWd4fKqJuIOA6jIhP
 tnSG6t9qcXfbN7aTexNIXJ2vaqGJ_tTAPVyeVVlXPE0WIXLyZSXBh4gAWGp0GvuhpsgeGposPyA_
 MIBXEg2ONEt2hCJIiTVwys486r2bjCzWIoXc.OfhuOgU7e4smznfeBwdw5r3HnpwUH9qPLJUbil5
 ckba5aANyQCRhB3WOyoREoFrMbt8SCwffh9bckuekY_ViixmtDGYfX.ToGQenY8DeOfF0us8G37J
 SL6GPfS6nwXXP9YqhsrS_fR5Gw4R0449hMMyWIrPq0qkK_UERX4gWPSkdsde_sCDRDqdxHSdyuZx
 EwyxoHo79Zj4c91fkCpQt3dHZly7.EXa0gxAVzlYfL6SDq96Ct.Qdy8tb9hdkRErFy0.V4rGzDsi
 eXll5w8SSx0Awrm1EPYR61_Fo7buPmlrq2x10HX8XsSGHX.eiLmgjN7_1l2wBN7hIvX7xUpzdLBi
 Xj9h7XfxWxdNn3Rj6rRhvm9Pfy5Dz0WcOoUlNKolJ6dmvg4ScdhyptmleioQVl.bEg.U5LCcONKz
 pegc3eE4KXv_kCDa7wcNPArw3AQS4mMQWx32kcgaGwojG0ZCNwwZr0IHWPBliCLn.W__3FNLJQTB
 K4jQrC4X_D6jY4RJBPE7W2wEsYFum5Of70jkIIf7cytW6kQw2iluOwp2RcLXJSJJmHPtIXX.NDjx
 4X2I0P3_h4xubJDpuIONiju9q6KEhOVCv6guIP0V.eeENpgl54QABdUjeERPGptP_D4bjHxMcnCz
 q_7Va0lBAL14UW92sSAZVQ3vIdzW.a1w6g_paYbZPeBBznFdQhgpRPE_6nY.6y092CX4ny5k5yni
 xF6TGfONUqqJAKF_XaYJ6LYv0SFYhDOglSlbvb_ePnFHKwB2NbpePpgBq3AYzKMmow2CEdJ.mWuK
 rNKkyDVCy3ZS.ukrjvhbpmtn.5SNP2F.TZ1Wrw3YTjUO8TXysnxHqJwvo4P.uH7pVOGuDa3xhqSm
 ubmAspvZkbXC51J1dFBQs9MeS1HCUI62AXuU4QvMyO0gSg7.P.QITBxm6eiwXLG1bnQGYAOpKS31
 iKage9munt174WHRMA_L_KCCFKcAhni95UkD1otYcKRmrRHYSbNadK9YcgW525tPX8OPmJ.ZQMpF
 x7nddWtoCHEPnB2pWC2Cf_K_G5CHo9rX..PvhNIUVl2Y7BZMPgCo2pDC5sQly3d1o6lpmQZkxe.a
 4CnNSvu8fnPrJhokQw5S3rfs6gcy_wxnOrwKdl3RjDLUjjW6_d5gA_ww_GlVCOw6i1pU6G7av2rY
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 1 Apr 2020 11:25:28 +0000
Date:   Wed, 1 Apr 2020 11:25:22 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <499881988.130253.1585740322781@mail.yahoo.com>
Subject: BUSINESS TRANSFER FROM MS LISA HUGH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <499881988.130253.1585740322781.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15585 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
