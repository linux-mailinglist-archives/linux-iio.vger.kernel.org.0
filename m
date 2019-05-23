Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5201927ED9
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfEWNyP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 09:54:15 -0400
Received: from mail.fixposition.ch ([212.51.146.252]:51390 "EHLO
        mail.fixposition.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbfEWNyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 09:54:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.fixposition.ch (Postfix) with ESMTP id 3BAA81FD7B;
        Thu, 23 May 2019 15:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixposition.ch;
        s=mail; t=1558619652;
        bh=PA8e0mAyI05eeyPdXbeaUuDGGdyjfTjWwscmDMjVUoc=;
        h=In-Reply-To:From:Date:Cc:To:Subject:From;
        b=TbW6+/HNtYT4iA3Zlv2GRktYYVo8WRtdfHUo2cJZhfQ9uzv5sgYFOrH1foCpqR0Y/
         BYFETHtc/PvCR7wKbgnSKlD+w7FYOFI1mfV80lXCJ0YTdrdTBayjxJ6L1cFy7pUelA
         QzcefFh4N6H2N13IsJVxPNxOIfWOFI3OIxuGeLBMVb8oweeHL+vEOWBEYyduh5WGqN
         6EVvZ5BI592/ZapYwo/HwsQSxpVmHLPoQBYSuXoU6lP5+aEvN33765+8fnC+EkflXm
         GZpDvCp1j7RbbASmNxPVitTstTU/jsy+IFC0bZAjOIH2lSkg3Pet5quuGbCadAoW+w
         80c1XLAa97aIQ==
X-Virus-Scanned: Debian amavisd-new at fixposition.ch
Received: from mail.fixposition.ch ([127.0.0.1])
        by localhost (mail.fixposition.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x8T_B6QxQIWG; Thu, 23 May 2019 15:54:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.fixposition.ch (Postfix) with ESMTP id 1C8A51FF91;
        Thu, 23 May 2019 15:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fixposition.ch;
        s=mail; t=1558619649;
        bh=PA8e0mAyI05eeyPdXbeaUuDGGdyjfTjWwscmDMjVUoc=;
        h=In-Reply-To:From:Date:Cc:To:Subject:From;
        b=RNvdWUXDs4JozcTX5gUu7ovxs4aHnKIH+PZ1JX7bkcPMID0+HUINTM73aBn7mAdQj
         A9u0DdPwp7kE0NBIS7gqmwxvg78JWJp2pIZOwngjHsNZDW/HmZLxSf1xuMryks0fg8
         zPWRLd1Scn/HcnQS001jo+ZRqC3vBbte2MON66mR6+Q6XUM1GDti3hw3t7rA1eoEFC
         WTOZ/XHWECmPVWHonKQ3TC9i39OPOPBd4RNxL/4y3dXnA2JdyJE/TrO3pOYMRNxZkN
         WPK83fWZx+JSCb3gaxTDa6Mb9ovP2qS8EcsAc6xT5wHuGW0qy6HLTQZJx6az9Sb/Z0
         g1jTrqU+T5x8g==
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <MN2PR12MB337375FCA3AAA2EB5F08B15AC4010@MN2PR12MB3373.namprd12.prod.outlook.com>
From:   "Andreea Lutac" <andreea.lutac@fixposition.ch>
X-Forward: 82.130.71.40
Date:   Thu, 23 May 2019 15:54:09 +0200
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
Message-ID: <42bd-5ce6a600-59-ca9e8b0@181727209>
Subject: =?utf-8?q?Re=3A?= ICM20602 buffer issues with the =?utf-8?q?inv=5Fmpu6050?= 
 driver
User-Agent: SOGoMail 4.0.7
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jean-Baptiste,

Thank you for the prompt response. Your explanation makes sense and I k=
now how to at least work around this issue for now. For my current purp=
oses, it is still useful to have the temperature data as well, so I'll =
stick to reading all 14 bytes for now and then see if there's a way to =
permanently enable temp as a more long-term solution.

I probably wouldn't have come across this problem had it not been the c=
ase that libiio fails to enable the temp channel. Looking into it I fou=
nd that libiio has an open issue where channels like temp that are neit=
her modified, nor indexed are not counted as scan elements and thus can=
't be enabled. So just in case someone facing a similar issue comes acr=
oss this thread, this can be either worked around by making temp an ind=
exed channel in the driver and hopefully solved definitively by waiting=
 for the fix to be merged into libiio.

Thanks for all the help!
All the best,
Andreea


On Thursday, May 23, 2019 12:12 CEST, Jean-Baptiste Maneyrol <JManeyrol=
@invensense.com> wrote: 

> Hi Andreea,
> 
> I understand the issue now. The problem is that temperature data are =
always present in the FIFO. Even when the attribute is disabled. This i=
s a limitation of this chip and cannot be changed on the hardware side.=

> 
> When temp attribute is disabled while accel and gyro are on, the iio =
buffer is expecting to have 12 bytes with accel + gyro data. But the dr=
iver will still provides 14 bytes with temperature in the middle since =
the FIFO will contain that. Always enabling temperature attribute on us=
erspace will solve this issue, but that's certainly not the best.
> 
> A correct solution would be to enforce temperature data in iio buffer=
 by having the temp attribute always enabled and read-only in userspace=
. That would reflect correctly the chip capabilities. But I don't know =
if this is feasible. A workaround would be to add data post-processing =
in the driver and delete temp data when it is disabled. But I don't lik=
e this kind of workaround because that goes against iio buffer design p=
rinciple.
> 
> Hope this help you.
> 
> Best regards,
> Jean-Baptiste Maneyrol
> 
> From: Andreea Lutac <andreea.lutac@fixposition.ch>
> Sent: Thursday, May 23, 2019 11:44
> To: Jean-Baptiste Maneyrol
> Cc: stevemo@skydio.com; jic23@kernel.org; knaack.h@gmx.de; lars@metaf=
oo.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux-kernel@vger.=
kernel.org
> Subject: Re: ICM20602 buffer issues with the inv=5Fmpu6050 driver
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization=
. Please make sure the sender is who they say they are and do not click=
 links or open attachments unless you recognize the sender and know the=
 content is safe.
> 
> Hi Jean-Baptiste and Stepan,
> 
> Thanks so much for the replies and the advice. I've dug a bit deeper =
into this and added a few printk statements to the driver, as suggested=
 by Stepan. It looks like the device is getting recognized correctly as=
 ICM20602 and the buffer is being filled with 14 bytes as expected.
> 
> But I've identified some strange behaviour regarding the temperature =
channeI. If I manually enable all 7 scan elements and read 14 bytes fro=
m the device file, the readings appear correct and change accordingly w=
hen I move the chip around. However, if I set in=5Ftemp=5Fen set to 0 (=
with everything else still enabled) and read 12 bytes, the buffer doesn=
't seem to acknowledge this change and shift the gyro values up, instea=
d getting only the first 12 bytes (accel=5Fx, accel=5Fy, accel=5Fz, tem=
p, gyro=5Fx, gyro=5Fy), without gyro=5Fz. So this is why it looks as if=
 temp is replacing gyro=5Fx.
> I made a pastebin here with some of the (unconverted) values I got wh=
ile testing these cases: https://urldefense.proofpoint.com/v2/url?u=3Dh=
ttps-3A=5F=5Fpastebin.com=5FBYVqDNch&d=3DDwIFaQ&c=3DWoJWtq5JV8YrKnzRxvD=
8NxmTP=5F1wxfE0prPmo0NeZwg&r=3D4jiDX=5F1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBwG=
28mVk&m=3DsbkHiUlsj8pOWjf2iTq5CXEFvv-MNyqBKOqCjxOj9kc&s=3DPmb23R-DoTj9h=
DwYk3qqiUfOCUWbtfpVQjUZ1lajeFI&e=3D
> 
> Attempting the same reads with my C++ program via libiio always resul=
ts in only the first 12 bytes being read, as for some strange reason li=
biio fails to enable the temperature channel, so iio=5Fdevice=5Fget=5Fs=
ample=5Fsize() is always 12 and it's actually gyro=5Fz that I can't get=
 to.
> 
> I'll try to look through the code that is supposed to enable a channe=
l and see why it's not succeeding via libiio. Do you have any clue as t=
o which bit of code does the adjustment of the buffer values according =
to which channels are enabled? Is this done in the driver or deeper in =
the kernel?
> 
> Thanks once again for the help!
> Best regards,
> Andreea
> 
> On Wednesday, May 22, 2019 16:33 CEST, Jean-Baptiste Maneyrol <JManey=
rol@invensense.com> wrote:
> 
> > Hello,
> >
> > I had a look inside the driver to verify the buffer implementation.=
 It looks correct to me. I don't see where the problem can come from. I=
 am sorry I don't have a setup currently to test in live.
> >
> > For sure you can have a different result by reading the buffer thro=
ugh the char device file compared to reading the raw sysfs entry. The b=
uffer is taking the data from the FIFO and the raw sysfs from the senso=
r data registers.
> >
> > You can perhaps test value 1 by 1 in the buffer, and verify the cor=
rectness of every attributes. If you can also send a complete buffer lo=
g that would be helpful.
> > Every data is 2 bytes long and in the following order: accel=5Fx, a=
ccel=5Fy, accel=5Fz, temp, gyro=5Fx, gyro=5Fy, gyro=5Fz
> >
> > Best regards,
> > JB Maneyrol
> >
> > From: Andreea Lutac <andreea.lutac@fixposition.ch>
> > Sent: Tuesday, May 21, 2019 12:40
> > Cc: Jean-Baptiste Maneyrol; stevemo@skydio.com; jic23@kernel.org; k=
naack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-iio@vger.kern=
el.org; linux-kernel@vger.kernel.org
> > Subject: ICM20602 buffer issues with the inv=5Fmpu6050 driver
> > =C2=A0
> > Hello,
> >
> > I've been trying to get some data samples from the ICM20602 IMU usi=
ng the mpu6050 driver which recently added support for it, but I'm enco=
untering an issue with the ordering of the data in the FIFO.
> > According to the specs of the device, if the accel and gyro XYZ cha=
nnels are enabled, then the hardware FIFO is filled with 14 bytes corre=
sponding to the following channels: accel=5Fx, accel=5Fy, accel=5Fz, te=
mp, anglvel=5Fx, anglvel=5Fy, anglvel=5Fz. However, when reading out th=
e buffer, the value I get for anglvel=5Fx seems to actually be the temp=
erature. This=C2=A0 occurs both when reading with iio=5Fchannel=5Fread =
(via libiio) and also if I read directly from /dev/iio:device with only=
 in=5Fanglvel=5Fx=5Fen set. But in=5Fanglvel=5Fx=5Fraw reports correct =
values, which made me suspect that maybe somewhere in the driver this i=
nterleaved temp channel is not accounted for in the buffer structure.
> >
> > I had a look at the driver code and inv=5Fmpu6050=5Fread=5Ffifo() i=
n particular, but I can't identify anything amiss. I've applied the rec=
ent patch that added the extra 2 temperature bytes ( ), but the problem=
 persists. So far I've tried changing the size of the data buffer, defi=
ned in inv=5Fmpu=5Fiio.h:
> >
> > /* 6 + 6 round up and plus 8 */
> > #define INV=5FMPU6050=5FOUTPUT=5FDATA=5FSIZE=C2=A0=C2=A0=C2=A0=C2=A0=
 24
> >
> > from 24 to 32, according to the intuition that 24 corresponds to re=
adings without temperature (i.e. 6 bytes for accel, rounded up to 8 + 6=
 bytes for gyro, rounded up to 8 + 8 bytes for the timestamp =3D 24) an=
d thus another 8 bytes would be needed, but that doesn't seem to have s=
olved it.
> >
> > I'm quite new to driver development though, so I think there might =
be something I'm not getting. I would be really grateful if anyone coul=
d shed some light over what's happening here or give some advice as to =
what I could be doing wrong.
> >
> > Best regards,
> > Andreea Lutac
> >
>

