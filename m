Return-Path: <linux-iio+bounces-15934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9DA40860
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7F57A930B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480120B1FC;
	Sat, 22 Feb 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baLr8jb7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68220AF9F;
	Sat, 22 Feb 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227906; cv=none; b=jPSKZFvHLkD0tBgi3JcAO8ffWag8pBXS4RYH3Nm0LBq3owqiEKUSFN0asCkRqCeKkgUWJ+qTeSBR4Pm0c8NrEXm63Y3SozoF3CllE9aE+8PowBlEpmH1T95Hf8kjhzwsObZUfTfKuJg74yBKVL46DX+LAIXUoI6/mIPHYAtp4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227906; c=relaxed/simple;
	bh=gA6V0QYrK7MkRdcr4Vp2oLWITnhzVQghnDem+xh17dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th0MuSNyFRFvTJMo+Ue3W1bZw29b1b3PKUhec37b/Nc+ho564cLbwefG0xhyuBjtlBnNsGuiX4dcW+piPGskYfD65rWJJSmLVxtupKkfjRdXdXoWZBs+AzDV7QBos1LwvpVr5umpDy8isdp/qYBX148cKymJHtCRDcljEHN0MY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baLr8jb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C4DC4CED1;
	Sat, 22 Feb 2025 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740227905;
	bh=gA6V0QYrK7MkRdcr4Vp2oLWITnhzVQghnDem+xh17dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=baLr8jb7eqtGeHVbgrWdlhbobiJ9byteKNz9oBUvVDiFDojZwuTM1zn88lv0kKoJI
	 Awr/myIucp0VHv2jwNVIyneqomvpOwTzOS3cOUql9UOry3poyPA7hbUKFgBpPVAKD6
	 SPHq0NNBpGdk4Y8HbnciR38i4oVmHfJwW8VnL6HM9v1ziQONBRHpxA41SxmWmrrT8p
	 n9FCTCKqPA5c8rE4wqSFG4vOu+ADb5S1IE5ttbzfTlNWN//XtBGpQn8sKJQVqafSiK
	 2ss7WyjsgA8Nt1XkLPVOY++v0oyIO1uGw+8MyjAUR71nDhVtbC2YbdIvQ930Up9jD3
	 IjynifPJ/+YOA==
Date: Sat, 22 Feb 2025 12:38:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Budai, Robert" <Robert.Budai@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, "Gradinariu, Ramona"
 <Ramona.Gradinariu@analog.com>, "Miclaus, Antoniu"
 <Antoniu.Miclaus@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550
 support
Message-ID: <20250222123815.0521df87@jic23-huawei>
In-Reply-To: <45d64de8a1074788b7c4bffc29788742@analog.com>
References: <20250217105753.605465-1-robert.budai@analog.com>
	<20250217105753.605465-6-robert.budai@analog.com>
	<aee93ef96e71adf70a48ee5877bd75966d9c78c1.camel@gmail.com>
	<45d64de8a1074788b7c4bffc29788742@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 13:43:04 +0000
"Budai, Robert" <Robert.Budai@analog.com> wrote:

> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Thursday, February 20, 2025 10:22 AM
> > To: Budai, Robert <Robert.Budai@analog.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > Sa, Nuno <Nuno.Sa@analog.com>; Gradinariu, Ramona
> > <Ramona.Gradinariu@analog.com>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>; Jonathan Cameron <jic23@kernel.org>; Rob
> > Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Co=
nor
> > Dooley <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
> > iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kern=
el.org;
> > linux-doc@vger.kernel.org
> > Subject: Re: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550
> > support
> >=20
> > [External]
> >=20
> > On Mon, 2025-02-17 at 12:57 +0200, Robert Budai wrote: =20
> > > The ADIS16550 is a complete inertial system that includes a triaxis
> > > gyroscope and a triaxis accelerometer. Each inertial sensor in the
> > > ADIS16550 combines industry leading MEMS only technology with signal
> > > conditioning that optimizes dynamic performance. The factory calibrat=
ion
> > > characterizes each sensor for sensitivity, bias, and alignment. As a
> > > result, each sensor has its own dynamic compensation formulas that
> > > provide accurate sensor measurements.
> > >
> > > Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > > ---
> > > =20
> >=20
> > I guess it would make sense a Co-developed-by: for Robert?

The From is set to Robert, so that is implicit.  It is an odd chain
though. Now I've looked at it this doesn't
seem quite right but I am struggling with what it should be :(

I think this chain means that Ramona, Antoniu and Robert made significant
contributions. Robert's was after Nuno had handled the patch on some
ADI tree?=20

In the end Roberts was large enough to take 'ownership' rather
than the original 'from'. That part is unusual. We rarely do that.

However, from what I can see publicly that isn't what happened.

This patch v1 was posted with Robert as Co-developed and Nuno as
the From + SoB (which puts Nuno at same level as a co-developer but
the one who posted it).

So really the ownership trail should have remained the same with
the From set to Nuno.  However that gives us another fun corner.

Robert then started handing the series. That would normally require
a SoB to cover that part, but he already has one.  Gah.=20

Anyhow I think the best way to fix this up is actually to
add Co-developed-by for Nuno which does transfer patch ownership
but at least refects that all of you played some significant part.

Alternative is modify the author ship to reflect earliest posting.

To keep things moving I'm going to assume you are fine with
me adding Co-developed by to explain Nuno's SoB where relevant
rather than changing the From and adding Co-developed-by for Robert.

The DT binding has a similar issue. There we have Ramona who
handled the patch but no co-developed. That's clearly not right
as v1 is form Ramona.  There I'll make it Codev Ramona.

If you'd prefer to fix this all up with the original From:
then send me a new version and I'll switch out what I have applied.

Interesting this patch doesn't build and has a warning. I tweaked as:
For some reason the first of the u16 val cases didn't trigger the size
mismatch that __adis_update_bits() has a BUILD_BUG check on
but given the similarity of the two cases I'm not sure why and I tweaked
them both. Give me a shout if any of this breaks things.

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 16f01c61a429..8ec3afe6140b 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -509,10 +509,10 @@ static int adis16550_get_accl_filter_freq(struct adis=
16550 *st, int *freq_hz)
 static int adis16550_set_accl_filter_freq(struct adis16550 *st, int freq_h=
z)
 {
        u8 en =3D freq_hz ? 1 : 0;
+       u16 val =3D FIELD_PREP(ADIS16550_ACCL_FIR_EN_MASK, en);
=20
        return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
-                                 ADIS16550_ACCL_FIR_EN_MASK,
-                                 FIELD_PREP(ADIS16550_ACCL_FIR_EN_MASK, en=
));
+                                 ADIS16550_ACCL_FIR_EN_MASK, val);
 }
=20
 static int adis16550_get_gyro_filter_freq(struct adis16550 *st, int *freq_=
hz)
@@ -535,10 +535,10 @@ static int adis16550_get_gyro_filter_freq(struct adis=
16550 *st, int *freq_hz)
 static int adis16550_set_gyro_filter_freq(struct adis16550 *st, int freq_h=
z)
 {
        u8 en =3D freq_hz ? 1 : 0;
+       u16 val =3D FIELD_PREP(ADIS16550_GYRO_FIR_EN_MASK, en);
=20
        return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
-                                 ADIS16550_GYRO_FIR_EN_MASK,
-                                 FIELD_PREP(ADIS16550_GYRO_FIR_EN_MASK, en=
));
+                                 ADIS16550_GYRO_FIR_EN_MASK, val);
 }
=20
 enum {
@@ -832,7 +832,6 @@ static u32 adis16550_validate_crc(__be32 *buffer, const=
 u8 n_elem)
=20
 static irqreturn_t adis16550_trigger_handler(int irq, void *p)
 {
-       u32 crc;
        int ret;
        u16 dummy;
        bool valid;
@@ -1143,7 +1142,7 @@ module_spi_driver(adis16550_driver);
 MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
 MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
 MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
-MODULE_AUTHOR("Robert Budai <robert.budai@analog.com>")
+MODULE_AUTHOR("Robert Budai <robert.budai@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
 MODULE_IMPORT_NS("IIO_

> >=20
> > Anyways, all looks good except for one thing that I just spotted...
> >  =20
> > > v8:
> > > - removed __aligned from struct adis16550, as suggested
> > > - crc buffer extraction into the crc check function
> > > - passed buffer into crc validation as original, __be32 and performed=
 check
> > > using be32_to_cpu conversion of the buffer
> > > - added trailing comma to line 993
> > > - removed trailing comma from line 877
> > >
> > > =C2=A0drivers/iio/imu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1=
3 +
> > > =C2=A0drivers/iio/imu/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 =
1 +
> > > =C2=A0drivers/iio/imu/adis16550.c | 1149 =20
> > +++++++++++++++++++++++++++++++++++ =20
> > > =C2=A03 files changed, 1163 insertions(+)
> > > =C2=A0create mode 100644 drivers/iio/imu/adis16550.c
> > > =20
> >=20
> > ...
> >  =20
> > >
> > > +static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
> > > +{
> > > +	u16 dec;
> > > +	int ret;
> > > +	u32 sample_rate =3D st->clk_freq_hz;
> > > +	/*
> > > +	 * The optimal sample rate for the supported IMUs is between
> > > +	 * int_clk - 1000 and int_clk + 500.
> > > +	 */
> > > +	u32 max_sample_rate =3D st->info->int_clk * 1000 + 500000;
> > > +	u32 min_sample_rate =3D st->info->int_clk * 1000 - 1000000;
> > > +
> > > +	if (!freq_hz)
> > > +		return -EINVAL;
> > > +
> > > +	adis_dev_auto_lock(&st->adis);
> > > +
> > > +	if (st->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> > > +		unsigned long scaled_rate =3D lcm(st->clk_freq_hz, freq_hz);
> > > +		int sync_scale;
> > > +
> > > +		if (scaled_rate > max_sample_rate)
> > > +			scaled_rate =3D max_sample_rate / st->clk_freq_hz * st- =20
> > > >clk_freq_hz; =20
> > > +		else
> > > +			scaled_rate =3D max_sample_rate / scaled_rate *
> > > scaled_rate;
> > > +
> > > +		if (scaled_rate < min_sample_rate)
> > > +			scaled_rate =3D roundup(min_sample_rate, st- =20
> > > >clk_freq_hz); =20
> > > + =20
> >=20
> > I would imagine the above is the same deal as in other devices [1] or d=
o you
> > know for a fact this one is different? Maybe it's simple enough for Jon=
athan to
> > tweak while applying...
> >=20
> > [1]:
> > https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.13.3/so=
urce
> > /drivers/iio/imu/adis16475.c*L364__;Iw!!A3Ni8CS0y2Y!7Y71yPaQAxVzNRd
> > O_jT7wEz4k-
> > s6z4tJHOcES84HYkq8qNGsgJH7zxwjfPNjLF3OEGVInSolo1ennLU_mwpmEbo$
> >=20
> > - Nuno S=C3=A1 =20
>=20
> [Robert Budai]=20
> No differences were found in the scaled_sync behavior of the ADIS16475 and
> ADIS16550. It is safe to add from my side.
>=20
If we want to do such a module parameter override I am fine with adding
it but as a separate patch on top that provides the reasoning etc.
It is a little to messy for me to do as a tweak.

Jonathan
=09
> Best regards,
> Robert B


