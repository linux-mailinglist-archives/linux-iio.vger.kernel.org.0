Return-Path: <linux-iio+bounces-22139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D8B1533A
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 21:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EC6541461
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA623FC42;
	Tue, 29 Jul 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I976hoEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0F46447;
	Tue, 29 Jul 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815922; cv=none; b=TFGYK/HYiZGdld4rvcRmlm++g84VvbK+siLbkJDIIw6sC9TmUvaU87rSW3PbuYf8yoiHPxDS6oOgllNfqN1TW4p8LLLxjpa/gMYcaTskagaOp9CPjfEaPzY1VYOvsmg9BM2d28y+0vxexNfS/mwK8zaDQ7Tc27spGoP0MhFg5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815922; c=relaxed/simple;
	bh=yxH+FULZ86o67g8LSiDf9ZC187TQ4TjAq094yJ7LAXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFd73WW4P7g9qToQYZcPs2THv3Cp5n99P8Ji2JIQNjgJ2Soyjbi7XGxhs8rLEDfSjCW/2k6dsKe9UwB3EZHepFCRYJB4oIZ+M0BjMIWG+VW+hXdt77EwZcqHRUuwfEq856+CgwTzzKSBPfYjCt7plVosOk8UQguonr4QH2kXGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I976hoEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D74CC4CEEF;
	Tue, 29 Jul 2025 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753815922;
	bh=yxH+FULZ86o67g8LSiDf9ZC187TQ4TjAq094yJ7LAXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I976hoEiVTNqqmojBTOTca/IRNa8rVO0DHreW6OvAWDJYt2uGQhpSaUCvwSLl/BIw
	 +QP696300upZaM904rfXCj3POg8LowIXZvBjGf/HBnCHGsgheKEQmOXxnKbf4ZTgat
	 uNRbl03uMlz4eW91+CsRILMoaVVGNdz3k8FhiHutGO9OFSyfm7xux+5Pvam7ChztMS
	 OLpisAKiW16MZeY+wy7RqMY3VJzd+8oi3Qizcov2ORQb7sAlvupkQlth0K6vK9biuG
	 4lq+FAnasEMYaXKJUPmVhyvxKKQqq13uVxKosAHnPC82VNk1fUBAF4Ot2qW2R+NNYF
	 YoRwMElX/O6hQ==
Date: Tue, 29 Jul 2025 20:05:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <20250729200513.275e0d98@jic23-huawei>
In-Reply-To: <aIhE5zwrPljqHqGX@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
	<20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
	<20250727140559.1f6c1668@jic23-huawei>
	<aIhE5zwrPljqHqGX@dixit>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 09:19:59 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> On Sun, Jul 27, 2025 at 02:05:59PM +0100, Jonathan Cameron wrote:
> > On Sat, 26 Jul 2025 15:07:01 +0530
> > Dixit Parmar <dixitparmar19@gmail.com> wrote:
> >=20
> > Hi Dixit,
> >=20
> > Very clean driver for a v1. Nice.
> >  =20
> > > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor =20
> >=20
> > Slightly odd wrap.  Aim for 75 chars for patch descriptions.
> > =20
> Okay, 75.
> > > applications includes joysticks, control elements (white goods,
> > > multifunction knops), or electric meters (anti tampering) and any
> > > other application that requires accurate angular measurements at
> > > low power consumptions.
> > >=20
> > > The Sensor is configured over I2C, and as part of Sensor measurement
> > > data it provides 3-Axis magnetic fields and temperature core measurem=
ent.
> > >=20
> > > The driver supports raw value read and buffered input via external tr=
igger
> > > to allow streaming values with the same sensing timestamp.
> > >=20
> > > The device can be configured in to different operating modes by optio=
nal
> > > device-tree "mode" property. Also, the temperature sensing part requi=
res
> > > raw offset captured at 25=C2=B0C and that can be specified by "temp-o=
ffset"
> > > optional device-tree property.
> > >=20
> > > While sensor has interrupt pin multiplexed with I2C SCL pin. But for =
bus
> > > configurations interrupt(INT) is not recommended, unless timing const=
raints
> > > between I2C data transfers and interrupt pulses are monitored and ali=
gned.
> > >=20
> > > The Sensor's I2C register map and mode information is described in pr=
oduct
> > > User Manual[1].
> > >=20
> > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49=
/infineon-tlv493d-a1b6-datasheet-en.pdf =20
> > Tag, so in the tags block (no blank line to the SoB) =20
> Sorry, didn't quite get it.

You should have it as Datasheet: <link>
That will then be a formal 'tag' so belongs alongside the Signed-off-by: et=
c with no blank
lines in that block.

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infin=
eon-tlv493d-a1b6-datasheet-en.pdf=20
Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserM=
anual-v01_03-EN.pdf #1
Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

> > > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-U=
serManual-v01_03-EN.pdf =20
> > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-U=
serManual-v01_03-EN.pdf #1
> >=20
> > So make it a tag with a trailing comment to give the reference number.
> >  =20
> > >=20
> > > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com> =20

> > > +
> > > +#define TLV493D_DATA_X_GET(b)	\
> > > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_MSB, b[TLV493D_RD_RE=
G_BX]) << 4 | \
> > > +			(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> =
4), 11) =20
> >=20
> > These are odd enough I'd make them c functions rather than macros. Burn=
 a few lines
> > for better readability.=20
> >  =20
> I saw this kind of data retrival and formation from registers as macros s=
o I sticked to
> it. Having all these as function will also require a seperate function
> for each channel coz the masks and the layout of the bits changes over
> the register. Do you still recommend it as c functions?

Is it more than 4 short functions?  I'd burn the few lines that costs.

s32 tlv493d_data_y_get(u8 *buff)
{
	u16 val =3D FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) <<=
 4 |
		  FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);

	return sign_extend32(val, 11);
}
> > > +/*
> > > + * The datasheet mentions the sensor supports only direct byte-strea=
m write starting from
> > > + * register address 0x0. So for any modification to be made to any w=
rite registers, it must
> > > + * be written starting from the register address 0x0.
> > > + * I2C write operation should not contain register address in the I2=
C frame, it should
> > > + * contains only raw byte stream for the write registers. As below,
> > > + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> > > + */
> > > +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!data || !data->client)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * As regmap does not provide raw write API which perform I2C write=
 without
> > > +	 * specifying register address, direct i2c_master_send() API is use=
d.
> > > +	 */
> > > +	ret =3D i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(dat=
a->wr_regs)); =20
> >=20
> > Given we have to do this, I'm a bit doubtful about regmap usage in gene=
ral in here.
> > Maybe it's just not a good fit and we should stick to direct use of the=
 i2c stuff
> > like here?
> >  =20
> Sorry, didn't get entirely? From what I understood, you meant we could
> drop regmap from this driver entirely and use direct I2C APIs. I believe
> that would be too much, coz of the frequency we perform operations and
> regmap is easier and clean imo.

The mixture is nasty though :(=20
> Also, we could have used regmap_raw_write() API by specifying register
> 0x0 as address and rest of the 3 bytes as data. regmap will perform raw
> write of these byte stream over the I2C the same way sensor expects. But
> the problem with that approach is we are not using it as per the API
> convention. let me know your thoughts? Is it a good option, it'll look
> like this:
> regmap_raw_write(data->map, data->wr_regs[0], &data->wr_regs[1],
> ARRAY_SIZE(data->wr_regs) - 1);

I'm not keen on that either.

If you really want to mix i2c and regmap then that's fine, I was just dubio=
us
whether we were getting value for money from regmap here.

> > > +	if (ret < 0) {
> > > +		dev_err(data->dev, "failed to write registers. error %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +	*x =3D TLV493D_DATA_X_GET(buff);
> > > +	*y =3D TLV493D_DATA_Y_GET(buff);
> > > +	*z =3D TLV493D_DATA_Z_GET(buff);
> > > +	*t =3D TLV493D_DATA_TEMP_GET(buff);
> > > +
> > > +out:
> > > +	pm_runtime_mark_last_busy(data->dev); =20
> >=20
> > As below  This should get simpler.
> >=20
> > Not directly relevant to this patch:
> >=20
> > If this cycle is quiet I plan to propose some cleanup.h based handling =
for runtime
> > pm as it's annoying how often we need a goto for it.  The new ACQUIRE()=
  / ACQUIRE_ERR()
> > should work for this.=20
> >  =20
> Does this need any modifications with current codebase?

Needs a bunch of work to show generality across many drivers and
convincing Rafael (PM maintainer) it's a good idea.
Don't try to do it in this series!

> >  =20
> > > +	pm_runtime_put_autosuspend(data->dev);
> > > +	return ret;
> > > +}
> > > +
> > > +static int tlv493d_init(struct tlv493d_data *data)
> > > +{
> > > +	int ret;
> > > +	u8 buff[TLV493D_RD_REG_MAX];
> > > +
> > > +	if (!data)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * The sensor initialization requires below steps to be followed,
> > > +	 * 1. Power-up sensor.
> > > +	 * 2. Read and store read-registers map (0x0-0x9).
> > > +	 * 3. Copy values from read reserved registers to write reserved fi=
elds (0x0-0x3).
> > > +	 * 4. Set operating mode.
> > > +	 * 5. Write to all registers.
> > > +	 */
> > > +	ret =3D regmap_bulk_read(data->map, TLV493D_RD_REG_BX, buff, ARRAY_=
SIZE(buff));
> > > +	if (ret) {
> > > +		dev_err(data->dev, "bulk read failed, error %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	data->wr_regs[0] =3D 0; /* Write register 0x0 is reserved. Does not=
 require to be updated.*/
> > > +	data->wr_regs[1] =3D buff[TLV493D_RD_REG_RES1] & TLV493D_RD_REG_RES=
1_WR_MASK;
> > > +	data->wr_regs[2] =3D buff[TLV493D_RD_REG_RES2] & TLV493D_RD_REG_RES=
2_WR_MASK;
> > > +	data->wr_regs[3] =3D buff[TLV493D_RD_REG_RES3] & TLV493D_RD_REG_RES=
3_WR_MASK;
> > > +
> > > +	ret =3D tlv493d_set_operating_mode(data, data->mode);
> > > +	if (ret < 0) {
> > > +		dev_err(data->dev, "failed to set operating mode\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	return ret; =20
> > return 0? =20
> Its the same though. ret from tlv493d_set_operating_mode is 0 on
> success and -ve on failure.

Then return 0 to make it explicit that if we get here we only return 0.
That can be useful to compilers.

Also check above as if (ret) is cleaner still.


> > > +	if (ret)
> > > +		val =3D 340;
> > > +	/*
> > > +	 * The above is a raw offset; however, IIO expects a single effecti=
ve offset.
> > > +	 * Since final temperature includes an additional fixed 25=C2=B0C (=
i.e. 25000 m=C2=B0C),
> > > +	 * we compute a combined offset using scale =3D 1100 (1.1 * 1000).
> > > +	 */
> > > +	data->temp_offset =3D -val + (s32)div_u64(25000, 1100);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tlv493d_read_raw(struct iio_dev *indio_dev, const struct =
iio_chan_spec *chan, =20
> >=20
> > wrap to keep this under 80.  Doesn't look like it will hurt readability.
> >  =20
> Ack. Is 80 standard for whole kernel or iio only?

It's kind of the the 'old' standard.  Used to be a fairly hard limit, but
over time there has been some relaxation.  So, if your code is nice and rea=
dable
you will rarely get anyone complaining if you stick to 80 chars.

>=20
> Thank you for such detailed review. Appriciate it,
You are welcome.

J
> Dixit


