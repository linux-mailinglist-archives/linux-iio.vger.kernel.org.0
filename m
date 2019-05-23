Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD89B27991
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfEWJoS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 05:44:18 -0400
Received: from mail.fixposition.ch ([212.51.146.252]:57972 "EHLO
        mail.fixposition.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJoS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 05:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.fixposition.ch (Postfix) with ESMTP id 630B11FD7B;
        Thu, 23 May 2019 11:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixposition.ch;
        s=mail; t=1558604654;
        bh=8Uyl4akugqZ5R9heNYDK3ic4w8QphwwSRvcQ9cwfzuE=;
        h=In-Reply-To:From:Date:Cc:To:Subject:From;
        b=PgEVmLCY4EgDUcupuum02X7faXhtZrNAxvEHwmYKz+GMqlI7PF/JYNuNFLjPTDpuy
         Mj5PuUCWFTKmb5DDD9Tzi+v8G/bzvNg755n5utyFB4iqF5gjZZ1SXnG621dvEkRI4T
         NxRagCRmr/l+He9vQLKXD/O6dfMZBiUWEEk3NQb4k86S3MXRSB73o9F5H1z1sVXwbr
         d7ukRRvIoCGK8Wie4O6wWTNa6rv4U7qQd/kIDAjpCRbTNSUh9nu+kiHkUkXGsK5Dfm
         58GnNoTCxxpU160riKsmPgDIZwv1LFHCg2wI7ywLQWNYuNW6WEMjfpzpW3S46ICAyS
         tWw8ZOGkAkx6w==
X-Virus-Scanned: Debian amavisd-new at fixposition.ch
Received: from mail.fixposition.ch ([127.0.0.1])
        by localhost (mail.fixposition.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tBqc_teX1UTY; Thu, 23 May 2019 11:44:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.fixposition.ch (Postfix) with ESMTP id B01851FF91;
        Thu, 23 May 2019 11:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixposition.ch;
        s=mail; t=1558604651;
        bh=8Uyl4akugqZ5R9heNYDK3ic4w8QphwwSRvcQ9cwfzuE=;
        h=In-Reply-To:From:Date:Cc:To:Subject:From;
        b=FhwKNo/ck+Dh8kYfq39loDKjSunTkc14w++FokJBcjq40O53XNsceHs6Qylc1yPoK
         2RqkGsibxJJfdJXNt55/S2dg0iXQP+Xp4b6mqZAQv+nAljoA1snhlkgUfFeu4Kkfxz
         isfpaVnaN7kcaIfscGvTcb6LFvRO2Oe4Nt1Y4Kea4r5os6Bg2HSNhdweZlcclHtkqq
         YCK+lJLazTzr36YPgFTvGF1w176OUtB9m6cfi7VER0isz4vG4sDrqLCQX9z0eExlkz
         TscchjjbFI9fq8VJf1udtHJzVz8MA5WWEiAQ3aqpct8MX9XlY3JWp/WzLSU9GQttTU
         U1wCCDDZ/QF2Q==
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <MN2PR12MB33738DAE3CCA829C2046CCE4C4000@MN2PR12MB3373.namprd12.prod.outlook.com>
From:   "Andreea Lutac" <andreea.lutac@fixposition.ch>
X-Forward: 82.130.71.115
Date:   Thu, 23 May 2019 11:44:10 +0200
Cc:     =?utf-8?q?stevemo=40skydio=2Ecom?= <stevemo@skydio.com>,
        =?utf-8?q?jic23=40kernel=2Eorg?= <jic23@kernel.org>,
        =?utf-8?q?knaack=2Eh=40gmx=2Ede?= <knaack.h@gmx.de>,
        =?utf-8?q?lars=40metafoo=2Ede?= <lars@metafoo.de>,
        =?utf-8?q?pmeerw=40pmeerw=2Enet?= <pmeerw@pmeerw.net>,
        =?utf-8?q?linux-iio=40vger=2Ekernel=2Eorg?= 
        <linux-iio@vger.kernel.org>,
        =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>
To:     "Jean-Baptiste Maneyrol" <JManeyrol@invensense.com>
MIME-Version: 1.0
Message-ID: <42bd-5ce66b80-45-ca9e8b0@181725592>
Subject: =?utf-8?q?Re=3A?= ICM20602 buffer issues with the =?utf-8?q?inv=5Fmpu6050?= 
 driver
User-Agent: SOGoMail 4.0.7
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jean-Baptiste and Stepan,

Thanks so much for the replies and the advice. I've dug a bit deeper in=
to this and added a few printk statements to the driver, as suggested b=
y Stepan. It looks like the device is getting recognized correctly as I=
CM20602 and the buffer is being filled with 14 bytes as expected.

But I've identified some strange behaviour regarding the temperature ch=
anneI. If I manually enable all 7 scan elements and read 14 bytes from =
the device file, the readings appear correct and change accordingly whe=
n I move the chip around. However, if I set in=5Ftemp=5Fen set to 0 (wi=
th everything else still enabled) and read 12 bytes, the buffer doesn't=
 seem to acknowledge this change and shift the gyro values up, instead =
getting only the first 12 bytes (accel=5Fx, accel=5Fy, accel=5Fz, temp,=
 gyro=5Fx, gyro=5Fy), without gyro=5Fz. So this is why it looks as if t=
emp is replacing gyro=5Fx.
I made a pastebin here with some of the (unconverted) values I got whil=
e testing these cases: https://pastebin.com/BYVqDNch

Attempting the same reads with my C++ program via libiio always results=
 in only the first 12 bytes being read, as for some strange reason libi=
io fails to enable the temperature channel, so iio=5Fdevice=5Fget=5Fsam=
ple=5Fsize() is always 12 and it's actually gyro=5Fz that I can't get t=
o. 

I'll try to look through the code that is supposed to enable a channel =
and see why it's not succeeding via libiio. Do you have any clue as to =
which bit of code does the adjustment of the buffer values according to=
 which channels are enabled? Is this done in the driver or deeper in th=
e kernel?

Thanks once again for the help!
Best regards,
Andreea   

On Wednesday, May 22, 2019 16:33 CEST, Jean-Baptiste Maneyrol <JManeyro=
l@invensense.com> wrote: 
 
> Hello,
> 
> I had a look inside the driver to verify the buffer implementation. I=
t looks correct to me. I don't see where the problem can come from. I a=
m sorry I don't have a setup currently to test in live.
> 
> For sure you can have a different result by reading the buffer throug=
h the char device file compared to reading the raw sysfs entry. The buf=
fer is taking the data from the FIFO and the raw sysfs from the sensor =
data registers.
> 
> You can perhaps test value 1 by 1 in the buffer, and verify the corre=
ctness of every attributes. If you can also send a complete buffer log =
that would be helpful.
> Every data is 2 bytes long and in the following order: accel=5Fx, acc=
el=5Fy, accel=5Fz, temp, gyro=5Fx, gyro=5Fy, gyro=5Fz
> 
> Best regards,
> JB Maneyrol
> 
> From: Andreea Lutac <andreea.lutac@fixposition.ch>
> Sent: Tuesday, May 21, 2019 12:40
> Cc: Jean-Baptiste Maneyrol; stevemo@skydio.com; jic23@kernel.org; kna=
ack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-iio@vger.kernel=
.org; linux-kernel@vger.kernel.org
> Subject: ICM20602 buffer issues with the inv=5Fmpu6050 driver
> =C2=A0
> Hello,
> 
> I've been trying to get some data samples from the ICM20602 IMU using=
 the mpu6050 driver which recently added support for it, but I'm encoun=
tering an issue with the ordering of the data in the FIFO.
> According to the specs of the device, if the accel and gyro XYZ chann=
els are enabled, then the hardware FIFO is filled with 14 bytes corresp=
onding to the following channels: accel=5Fx, accel=5Fy, accel=5Fz, temp=
, anglvel=5Fx, anglvel=5Fy, anglvel=5Fz. However, when reading out the =
buffer, the value I get for anglvel=5Fx seems to actually be the temper=
ature. This=C2=A0 occurs both when reading with iio=5Fchannel=5Fread (v=
ia libiio) and also if I read directly from /dev/iio:device with only i=
n=5Fanglvel=5Fx=5Fen set. But in=5Fanglvel=5Fx=5Fraw reports correct va=
lues, which made me suspect that maybe somewhere in the driver this int=
erleaved temp channel is not accounted for in the buffer structure.
> 
> I had a look at the driver code and inv=5Fmpu6050=5Fread=5Ffifo() in =
particular, but I can't identify anything amiss. I've applied the recen=
t patch that added the extra 2 temperature bytes ( ), but the problem p=
ersists. So far I've tried changing the size of the data buffer, define=
d in inv=5Fmpu=5Fiio.h:
> 
> /* 6 + 6 round up and plus 8 */
> #define INV=5FMPU6050=5FOUTPUT=5FDATA=5FSIZE=C2=A0=C2=A0=C2=A0=C2=A0 =
24
> 
> from 24 to 32, according to the intuition that 24 corresponds to read=
ings without temperature (i.e. 6 bytes for accel, rounded up to 8 + 6 b=
ytes for gyro, rounded up to 8 + 8 bytes for the timestamp =3D 24) and =
thus another 8 bytes would be needed, but that doesn't seem to have sol=
ved it.
> 
> I'm quite new to driver development though, so I think there might be=
 something I'm not getting. I would be really grateful if anyone could =
shed some light over what's happening here or give some advice as to wh=
at I could be doing wrong.
> 
> Best regards,
> Andreea Lutac
>

