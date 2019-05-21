Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C469824D1C
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfEUKrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 May 2019 06:47:01 -0400
Received: from mail.fixposition.ch ([212.51.146.252]:55560 "EHLO
        mail.fixposition.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUKrB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 May 2019 06:47:01 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 06:47:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.fixposition.ch (Postfix) with ESMTP id 4137B1FD7B;
        Tue, 21 May 2019 12:40:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixposition.ch;
        s=mail; t=1558435234;
        bh=bOSkK/vNPryyZLjRMMEEJCn1BxVNeEYE9p3piwO4zbk=;
        h=Cc:Date:Subject:From:From;
        b=UTCAoaam8Xc7tpAre8Aq8HJJuXQkJY0eccHMO7Njz3/h5DPUAQxDV4A8/zlRk3zU1
         VsjCUlZeoNpLNP3/83o55Lj6gVIc8IbysWkk0k7AyJwIAf0InYPTFctbjJjMVJcMDc
         wCLc3Zj1ZkF7RwSU6GQqoTlwM2pldtqUpI9qEtrhxDiXJoaOEW1dFnjKb+FIS6m2Fa
         nvwY1Y89+WmGMwCt5cy0R3ylSwy3oadKR9aDxewFQ5v30mtEXo2uRj9AI7ruAAwjuH
         jkasSqW/bAFkzPvMpgQM3Cn1Z+NROzyiLfZybz8qgbjchQPUvx0Er/CvwSYbkKtnjA
         IXcY93y6VbSFQ==
X-Virus-Scanned: Debian amavisd-new at fixposition.ch
Received: from mail.fixposition.ch ([127.0.0.1])
        by localhost (mail.fixposition.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jvi6qqwKv7Dj; Tue, 21 May 2019 12:40:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.fixposition.ch (Postfix) with ESMTP id EC7631FF92;
        Tue, 21 May 2019 12:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixposition.ch;
        s=mail; t=1558435233;
        bh=bOSkK/vNPryyZLjRMMEEJCn1BxVNeEYE9p3piwO4zbk=;
        h=Cc:Date:Subject:From:From;
        b=NGhMBksEhbrCerat69geTtlvDw7lyu+So0tEagXaTZXiWPu2zAaJPjZg+6Pg3aEVf
         siH5b+iU73asT7gnOLm1piWdUawBgaCmR/zxGrIJ2VWXQEnFv3v38gkgY+oKdaAJlz
         ICAKGnQyT/RUl5V4fHxxGTdFi0isBTeaVBhAIV3sccdxUAz4T5oNXM4FjL8hI8CArV
         O3lx5w3/zwQd2X/swxLoTWdo3m2Vb+FJ9I5m6PbM4NX9AR6Bf2/Qdl2cDOKaoLBPRE
         dYuqYFybitbEEXGCy4jaR4TjoTDcNFFb/40sdoGN9sgvlAWU3QgpqFLcgMz6dPFUWz
         QNC+dLwXaBw+Q==
Content-Type: text/plain; charset="utf-8"
Cc:     jmaneyrol@invensense.com, stevemo@skydio.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: SOGoMail 4.0.7
MIME-Version: 1.0
Date:   Tue, 21 May 2019 12:40:32 +0200
Subject: ICM20602 buffer issues with the =?utf-8?q?inv=5Fmpu6050?= driver
Message-ID: <42bd-5ce3d580-2b-ca9e8b0@181689754>
X-Forward: 213.55.184.190
From:   "Andreea Lutac" <andreea.lutac@fixposition.ch>
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I've been trying to get some data samples from the ICM20602 IMU using t=
he mpu6050 driver which recently added support for it, but I'm encounte=
ring an issue with the ordering of the data in the FIFO. 
According to the specs of the device, if the accel and gyro XYZ channel=
s are enabled, then the hardware FIFO is filled with 14 bytes correspon=
ding to the following channels: accel=5Fx, accel=5Fy, accel=5Fz, temp, =
anglvel=5Fx, anglvel=5Fy, anglvel=5Fz. However, when reading out the bu=
ffer, the value I get for anglvel=5Fx seems to actually be the temperat=
ure. This  occurs both when reading with iio=5Fchannel=5Fread (via libi=
io) and also if I read directly from /dev/iio:device with only in=5Fang=
lvel=5Fx=5Fen set. But in=5Fanglvel=5Fx=5Fraw reports correct values, w=
hich made me suspect that maybe somewhere in the driver this interleave=
d temp channel is not accounted for in the buffer structure.

I had a look at the driver code and inv=5Fmpu6050=5Fread=5Ffifo() in pa=
rticular, but I can't identify anything amiss. I've applied the recent =
patch that added the extra 2 temperature bytes (https://patchwork.kerne=
l.org/patch/10882883/), but the problem persists. So far I've tried cha=
nging the size of the data buffer, defined in inv=5Fmpu=5Fiio.h: 

/* 6 + 6 round up and plus 8 */
#define INV=5FMPU6050=5FOUTPUT=5FDATA=5FSIZE     24 

from 24 to 32, according to the intuition that 24 corresponds to readin=
gs without temperature (i.e. 6 bytes for accel, rounded up to 8 + 6 byt=
es for gyro, rounded up to 8 + 8 bytes for the timestamp =3D 24) and th=
us another 8 bytes would be needed, but that doesn't seem to have solve=
d it.

I'm quite new to driver development though, so I think there might be s=
omething I'm not getting. I would be really grateful if anyone could sh=
ed some light over what's happening here or give some advice as to what=
 I could be doing wrong.

Best regards,
Andreea Lutac

