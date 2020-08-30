Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC08256FB5
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgH3SfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 14:35:07 -0400
Received: from sonic315-53.consmr.mail.ne1.yahoo.com ([66.163.190.179]:40629
        "EHLO sonic315-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbgH3SfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Aug 2020 14:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598812505; bh=aQBm+9Bca4ejs9ftzYnk89bfX4ekoPZ6NeQWeQKD++E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=BMb0j55LIHIvp1+uvosuVf0TENrrhYDnskEgdxbee9TlmgXxvStk++XmwRpLQhP7frPXH3N8GwGLz6zNErDshbWYe3++NOYwNrtOCxy0pRFfQVZweGAmKLj1bMh893V+b1X619IDHKLbxiZZs8fx6wy6LXu6hwoR0RiVyWwZaa/36Md3A9ZSOQSkg0JaJlKKR6CmypTlszR76yMqTfMK+PSSGVnXoQFmYiG6oIOY+udbbTCKf46aMuY0nmLZmTJEXHAcnjb/fqRSe9aYL6wxn7cYVHlUf7UkDWyCvualiaHUfJ486uDRQ0qBL0qU8KelI665ZYNG2TxuQ3Hs9Lh4IA==
X-YMail-OSG: uASsZksVM1kZW9Q5V7j_bho6O5S7h3jiiesHdgX7L9b1O62.J8YJOwa.aQYaCmB
 1TfOSGO4h3pQCGd3CMlgZUGOONd2A1297oF91_g2XH7Fgi6OcrmW_8e1tQMRH_X4GCCvMZDH1VbX
 ogyW8G3q2VPsActWyoqKhLlsxrE4XVsc1_A2e_WggxJ5CALyUkoTZ9I7LBEEQUihiMVASJxmse_S
 9mZnpSw1UNgY2wmFwSCHgy5ri_QrYuV66Vd3jIbYnZunUKS81OHI2gCudrUOTWmEg3r8O1gGynbj
 PWcayjeENB_dirfnXj_mfRLtXDACbLhX8Ju2lUB0Kdkw65Q9hISgwsoUxPKdpM3T1C94ejsIQllH
 kh6Ym9ioq1paUJqUoX1R.vppg6kTKFXNiZNxOe4nU7ejLz4UcR3x0C6SYHEklyXp.G_Lnxfu8aDf
 TQfgxsdYz5Spx4vZagW_ksqV6uG1uhBgpWXoMy4d3ihGXCkMrdvnV3joFZ5g2UyPSKiGFIgRTmYk
 tJXwF_iu6Dmp8IwMCzKaxJBqIBh1h62gxvhg5cRzH0oEFGVpdzCn3sI0S.zjXo7EwdI5qEXe2Znt
 tstZCJ6Mt4tbPaWswz3hP6YV3zcRUCsz8wQsoGAO6rNx4uReseFHZYnw7yPUdz.SCBXXlDoBsfW8
 kL2huUg5iwx3mms1nT4PCFO24QCtuLqgW7Mjd4kMkUF9dTgV9w_pll4GL87bRonqRUSKiaJV_7Ku
 prLe9azmMeHd3ohGIFsS1y_4rw4o4EzKqMAQECiUsXd106IuzIzNERNsHxgZXZMJFltP1j2nm8Su
 8YnsD5dfM.FI8PXtL2oe3Y26umMVrMOBydG27leFDqrLx1mrH6o.5sz7H3b55b.HNXOD91heT8yX
 RHrLt_tXWQZ5Tawagjnz.Ywt6tJ13c6RXfTQsR4byT5KVMe_2zEbvKdaofOZd.hddpNc.cqrGR34
 l6BdieuKpo689ALrFGWC1qtxEc51wnboRU31ZSFlNO_KPm5Sa.5q2yt6YVMPvAyfYelRebqYRUcH
 Zdzz5MzIWbx8jWRRbNFeQP5PmqVMcyWRJSgB46GMnx7j8UZgLCcutirt6f9fk9iO5GYXubGdc0rc
 8Qa5M68rtJkUAi6SRLBrmY13NtmDOdIAAON4omcKsKOcUYIqyOTtF7JDeFJy19rnVRKotIfIZD0Z
 MioRdVWdfl4AOfadVGKLJn5CkT6eLqAtrMsZScpDXTFGSvpqTwXEa.GqDV6canl1H7apEv1BgiP9
 phQGR.99rxc9ofXU8QWuGm8bEsmILHP2tlIjShSdJVa2GJCce6TWx4RjlEUoCCThgnT_InnnfQtg
 6KBcDb4CaonGqPR9HmIuawLIRKW_DU6oQs6tSpzJ4tbtBTMc5Ii3iYg5Sl_Sc6QQc.CEA1iVdapZ
 K4kcQ5aaGf7TF17.NwnKh.O2rAd9rNq0OvadYs8iUjrAvF1ZB.fdRaBmcMZafwed1XjCSMGcWG4h
 1hVdz5Qlm9tU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 30 Aug 2020 18:35:05 +0000
Date:   Sun, 30 Aug 2020 18:33:04 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mau42@gcfta.in>
Reply-To: maurhinck5@gmail.com
Message-ID: <1647871249.505332.1598812384477@mail.yahoo.com>
Subject: RE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1647871249.505332.1598812384477.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck5@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
