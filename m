Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757422AB5B
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2019 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfEZRbJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 May 2019 13:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfEZRbJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 May 2019 13:31:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FDB20815;
        Sun, 26 May 2019 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558891868;
        bh=0rAboCc8XEOGzXP0MtgGj7KHDtMUTxgvOsIANyyfQXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zJXIoddpUytuEu0WOc3yzfVVCNJ8qeeYfz6vrtY2Es8Pq1FXhxpVyUQBPKq3kagDX
         NbAgSQppGobz4WAxqwYYDdz3AU0Qim4XsyIhMTs4U+wznSwm+JU6Tf79AnA6GME5Ac
         zjvzzQQqETXqzeaAtwXH3DXDfmdZpV0yHE/FIJoQ=
Date:   Sun, 26 May 2019 18:31:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Andreea Lutac" <andreea.lutac@fixposition.ch>
Cc:     "Jean-Baptiste Maneyrol" <JManeyrol@invensense.com>,
        "stevemo@skydio.com" <stevemo@skydio.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org " <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org " <linux-kernel@vger.kernel.org>
Subject: Re: ICM20602 buffer issues with the inv_mpu6050  driver
Message-ID: <20190526183103.51d33e6c@archlinux>
In-Reply-To: <42bd-5ce6a600-59-ca9e8b0@181727209>
References: <MN2PR12MB337375FCA3AAA2EB5F08B15AC4010@MN2PR12MB3373.namprd12.prod.outlook.com>
        <42bd-5ce6a600-59-ca9e8b0@181727209>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 May 2019 15:54:09 +0200
"Andreea Lutac" <andreea.lutac@fixposition.ch> wrote:

> Hi Jean-Baptiste,
>=20
> Thank you for the prompt response. Your explanation makes sense and I kno=
w how to at least work around this issue for now. For my current purposes, =
it is still useful to have the temperature data as well, so I'll stick to r=
eading all 14 bytes for now and then see if there's a way to permanently en=
able temp as a more long-term solution.
>=20
> I probably wouldn't have come across this problem had it not been the cas=
e that libiio fails to enable the temp channel. Looking into it I found tha=
t libiio has an open issue where channels like temp that are neither modifi=
ed, nor indexed are not counted as scan elements and thus can't be enabled.=
 So just in case someone facing a similar issue comes across this thread, t=
his can be either worked around by making temp an indexed channel in the dr=
iver and hopefully solved definitively by waiting for the fix to be merged =
into libiio.
>=20
> Thanks for all the help!
> All the best,
> Andreea

Hi Andreea / Jean-Baptiste.

One 'easy' way to make this work (based on your discussion)
is to provide the available_scan_masks element of the iio_dev.

That is used to find a 'superset' of the channels that have been
intentionally enabled, and enable that on the hardware side.
If userspace has requested something that isn't an exact match
there is demux code that will automatically reorganize the
incoming data so that userspace sees what it is expecting.

That code will be bypassed in the event of the channel selection
matching a case that is in the list.

Jonathan
>=20
>=20
> On Thursday, May 23, 2019 12:12 CEST, Jean-Baptiste Maneyrol <JManeyrol@i=
nvensense.com> wrote:=20
>=20
> > Hi Andreea,
> >=20
> > I understand the issue now. The problem is that temperature data are al=
ways present in the FIFO. Even when the attribute is disabled. This is a li=
mitation of this chip and cannot be changed on the hardware side.
> >=20
> > When temp attribute is disabled while accel and gyro are on, the iio bu=
ffer is expecting to have 12 bytes with accel + gyro data. But the driver w=
ill still provides 14 bytes with temperature in the middle since the FIFO w=
ill contain that. Always enabling temperature attribute on userspace will s=
olve this issue, but that's certainly not the best.
> >=20
> > A correct solution would be to enforce temperature data in iio buffer b=
y having the temp attribute always enabled and read-only in userspace. That=
 would reflect correctly the chip capabilities. But I don't know if this is=
 feasible. A workaround would be to add data post-processing in the driver =
and delete temp data when it is disabled. But I don't like this kind of wor=
karound because that goes against iio buffer design principle.
> >=20
> > Hope this help you.
> >=20
> > Best regards,
> > Jean-Baptiste Maneyrol
> >=20
> > From: Andreea Lutac <andreea.lutac@fixposition.ch>
> > Sent: Thursday, May 23, 2019 11:44
> > To: Jean-Baptiste Maneyrol
> > Cc: stevemo@skydio.com; jic23@kernel.org; knaack.h@gmx.de; lars@metafoo=
.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux-kernel@vger.kernel=
.org
> > Subject: Re: ICM20602 buffer issues with the inv_mpu6050 driver
> > =C2=A0
> > =C2=A0CAUTION: This email originated from outside of the organization. =
Please make sure the sender is who they say they are and do not click links=
 or open attachments unless you recognize the sender and know the content i=
s safe.
> >=20
> > Hi Jean-Baptiste and Stepan,
> >=20
> > Thanks so much for the replies and the advice. I've dug a bit deeper in=
to this and added a few printk statements to the driver, as suggested by St=
epan. It looks like the device is getting recognized correctly as ICM20602 =
and the buffer is being filled with 14 bytes as expected.
> >=20
> > But I've identified some strange behaviour regarding the temperature ch=
anneI. If I manually enable all 7 scan elements and read 14 bytes from the =
device file, the readings appear correct and change accordingly when I move=
 the chip around. However, if I set in_temp_en set to 0 (with everything el=
se still enabled) and read 12 bytes, the buffer doesn't seem to acknowledge=
 this change and shift the gyro values up, instead getting only the first 1=
2 bytes (accel_x, accel_y, accel_z, temp, gyro_x, gyro_y), without gyro_z. =
So this is why it looks as if temp is replacing gyro_x.
> > I made a pastebin here with some of the (unconverted) values I got whil=
e testing these cases: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3=
A__pastebin.com_BYVqDNch&d=3DDwIFaQ&c=3DWoJWtq5JV8YrKnzRxvD8NxmTP_1wxfE0prP=
mo0NeZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBwG28mVk&m=3DsbkHiUlsj8pOWj=
f2iTq5CXEFvv-MNyqBKOqCjxOj9kc&s=3DPmb23R-DoTj9hDwYk3qqiUfOCUWbtfpVQjUZ1laje=
FI&e=3D
> >=20
> > Attempting the same reads with my C++ program via libiio always results=
 in only the first 12 bytes being read, as for some strange reason libiio f=
ails to enable the temperature channel, so iio_device_get_sample_size() is =
always 12 and it's actually gyro_z that I can't get to.
> >=20
> > I'll try to look through the code that is supposed to enable a channel =
and see why it's not succeeding via libiio. Do you have any clue as to whic=
h bit of code does the adjustment of the buffer values according to which c=
hannels are enabled? Is this done in the driver or deeper in the kernel?
> >=20
> > Thanks once again for the help!
> > Best regards,
> > Andreea
> >=20
> > On Wednesday, May 22, 2019 16:33 CEST, Jean-Baptiste Maneyrol <JManeyro=
l@invensense.com> wrote:
> >  =20
> > > Hello,
> > >
> > > I had a look inside the driver to verify the buffer implementation. I=
t looks correct to me. I don't see where the problem can come from. I am so=
rry I don't have a setup currently to test in live.
> > >
> > > For sure you can have a different result by reading the buffer throug=
h the char device file compared to reading the raw sysfs entry. The buffer =
is taking the data from the FIFO and the raw sysfs from the sensor data reg=
isters.
> > >
> > > You can perhaps test value 1 by 1 in the buffer, and verify the corre=
ctness of every attributes. If you can also send a complete buffer log that=
 would be helpful.
> > > Every data is 2 bytes long and in the following order: accel_x, accel=
_y, accel_z, temp, gyro_x, gyro_y, gyro_z
> > >
> > > Best regards,
> > > JB Maneyrol
> > >
> > > From: Andreea Lutac <andreea.lutac@fixposition.ch>
> > > Sent: Tuesday, May 21, 2019 12:40
> > > Cc: Jean-Baptiste Maneyrol; stevemo@skydio.com; jic23@kernel.org; kna=
ack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org=
; linux-kernel@vger.kernel.org
> > > Subject: ICM20602 buffer issues with the inv_mpu6050 driver
> > > =C2=A0
> > > Hello,
> > >
> > > I've been trying to get some data samples from the ICM20602 IMU using=
 the mpu6050 driver which recently added support for it, but I'm encounteri=
ng an issue with the ordering of the data in the FIFO.
> > > According to the specs of the device, if the accel and gyro XYZ chann=
els are enabled, then the hardware FIFO is filled with 14 bytes correspondi=
ng to the following channels: accel_x, accel_y, accel_z, temp, anglvel_x, a=
nglvel_y, anglvel_z. However, when reading out the buffer, the value I get =
for anglvel_x seems to actually be the temperature. This=C2=A0 occurs both =
when reading with iio_channel_read (via libiio) and also if I read directly=
 from /dev/iio:device with only in_anglvel_x_en set. But in_anglvel_x_raw r=
eports correct values, which made me suspect that maybe somewhere in the dr=
iver this interleaved temp channel is not accounted for in the buffer struc=
ture.
> > >
> > > I had a look at the driver code and inv_mpu6050_read_fifo() in partic=
ular, but I can't identify anything amiss. I've applied the recent patch th=
at added the extra 2 temperature bytes ( ), but the problem persists. So fa=
r I've tried changing the size of the data buffer, defined in inv_mpu_iio.h:
> > >
> > > /* 6 + 6 round up and plus 8 */
> > > #define INV_MPU6050_OUTPUT_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0 24
> > >
> > > from 24 to 32, according to the intuition that 24 corresponds to read=
ings without temperature (i.e. 6 bytes for accel, rounded up to 8 + 6 bytes=
 for gyro, rounded up to 8 + 8 bytes for the timestamp =3D 24) and thus ano=
ther 8 bytes would be needed, but that doesn't seem to have solved it.
> > >
> > > I'm quite new to driver development though, so I think there might be=
 something I'm not getting. I would be really grateful if anyone could shed=
 some light over what's happening here or give some advice as to what I cou=
ld be doing wrong.
> > >
> > > Best regards,
> > > Andreea Lutac
> > > =20
> > =20
>=20

