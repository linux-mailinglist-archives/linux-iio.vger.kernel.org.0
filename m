Return-Path: <linux-iio+bounces-22523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2B4B1FBB9
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA92188B9A2
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774E1D5ABA;
	Sun, 10 Aug 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT7uGAOb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F14690;
	Sun, 10 Aug 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754850889; cv=none; b=u683sHXo6b72xziDAo+qzrgs21hwN04PH7HiSVCrMtP5sDaH1PZ2mBl8if1IPquhGHtf9tFjWafNfn+20tlDVR1uLDnGltrRavEHj+in+jasNjWUWmt0hPeJatNtd3JcPtSyh4ySid6mex/1tsqhe2KjfzpXmNEGZkYdoUq8VHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754850889; c=relaxed/simple;
	bh=X9feSVn04Fe0VusKDK08PZdkNEAq31A8exzGNeOhil0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9QNWPJVWiHNwSzNZiLeWyHwzwVuS/UQ4dFUGjLkUCwPE/1wNVND02fF1+b4qA63KHkCn7YtEIESUnRLcks57bimezpsBBoBkBOJbZz+j6nYRuGI2PbV30DkwxDvT+hLhcfZ8W19P8oI87NUkOXjL7LL05cmRCLJXDMGwaFVIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT7uGAOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D32EC4CEEB;
	Sun, 10 Aug 2025 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754850889;
	bh=X9feSVn04Fe0VusKDK08PZdkNEAq31A8exzGNeOhil0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lT7uGAObO5BKH/YBZZe29j35aq9aVH+Pcso5FECNCcDm97ruzKZUEodems3mlk7zY
	 u+pB2Ek3pahcc8WLm18Z/U7twHKlqbCSaFP+dRcsgXKnc0Qum2qF6LKOJ48Nz7XZCr
	 zbkQGrgJtNf7VeIfaS+rJdXxgAr6VQmElgeL2T83QX0/rz6//3+OlDC7X3KGkvJWIM
	 c8vxHF7jODjbLTFwLYo8u2+Dn0DUi66XbJpSOzo7mYbVqQvz8vvKqMB2vdcqLdvnmD
	 xbhC6X8TJT4K4eW4ioVhz+F1Mm1/JdS6MVjrZqQG8CPMrqhVWhoB5cUXSgbUfrZNz9
	 mmbs5YKln8E+Q==
Date: Sun, 10 Aug 2025 19:34:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250810193440.7b8ddc5f@jic23-huawei>
In-Reply-To: <aJAmgX0876tu5Ss0@dixit>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
	<20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
	<20250802124333.67f64863@jic23-huawei>
	<aJAmgX0876tu5Ss0@dixit>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 08:48:25 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> On Sat, Aug 02, 2025 at 12:43:33PM +0100, Jonathan Cameron wrote:
> > On Sat, 02 Aug 2025 12:14:27 +0530
> > Dixit Parmar <dixitparmar19@gmail.com> wrote:
> >   
> > > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > > applications includes joysticks, control elements (white goods,
> > > multifunction knops), or electric meters (anti tampering) and any
> > > other application that requires accurate angular measurements at
> > > low power consumptions.
> > > 
> > > The Sensor is configured over I2C, and as part of Sensor measurement
> > > data it provides 3-Axis magnetic fields and temperature core measurement.
> > > 
> > > The driver supports raw value read and buffered input via external trigger
> > > to allow streaming values with the same sensing timestamp.
> > > 
> > > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> > > configurations interrupt(INT) is not recommended, unless timing constraints
> > > between I2C data transfers and interrupt pulses are monitored and aligned.
> > > 
> > > The Sensor's I2C register map and mode information is described in product
> > > User Manual[Link].
> > > 
> > > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf
> > > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>  
> > 
> > Hi Dixit,
> > 
> > Some additional comments inline.
> >   
> > > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> > > new file mode 100644
> > > index 000000000000..da1569ae97bf
> > > --- /dev/null
> > > +++ b/drivers/iio/magnetometer/tlv493d.c  
> >   
> > > +enum tlv493d_op_mode {
> > > +	TLV493D_OP_MODE_POWERDOWN = 0,
> > > +	TLV493D_OP_MODE_FAST,
> > > +	TLV493D_OP_MODE_LOWPOWER,
> > > +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > > +	TLV493D_OP_MODE_MASTERCONTROLLED,
> > > +	TLV493D_OP_MODE_MAX  
> > In order to be able to use this as the type for a parameter as suggested
> > below, you'll need to drop MODE_MAX.  Comments on why you shouldn't
> > need that anyway below.
> >   
> > > +};
> > > +
> > > +struct tlv493d_mode {
> > > +	u8 m;  
> > You have an enum type.  Much better to use it.
> >   
> > > +	u32 sleep_us;
> > > +};
> > > +
> > > +struct tlv493d_data {
> > > +	struct device *dev;
> > > +	struct i2c_client *client;
> > > +	/* protects from simultaneous sensor access and register readings */
> > > +	struct mutex lock;
> > > +	u8 mode;
> > > +	u8 wr_regs[TLV493D_WR_REG_MAX];
> > > +};
> > > +
> > > +/*
> > > + * Different mode has different measurement cycle time, this time is
> > > + * used in deriving the sleep and timemout while reading the data from
> > > + * sensor in polling.
> > > + * Power-down mode: No measurement.
> > > + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> > > + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> > > + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> > > + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> > > + */
> > > +static struct tlv493d_mode tlv493d_mode_info[TLV493D_OP_MODE_MAX] = {  
> > If you want to size it, do it using the enum values. [] is fine here
> > 	[TLV493D_OP_MODE_POWERDOWN] = { }
> > 
> > I'm not sure why this should embed the index.  Can you just drop .m?
> >  
> Indeed, In V2 I wanted to change this to a u32 array containing the
> timing values for all mode and drop struct, but was skeptical.
> IMO that would also be a clean way rather than having it in struct. Makes sense?


Yes, an array is what we want here.  But use the enum to index it both
when setting and querying.


> > > +	{ .m = TLV493D_OP_MODE_POWERDOWN, .sleep_us = 0 },
> > > +	{ .m = TLV493D_OP_MODE_FAST, .sleep_us = 305 },
> > > +	{ .m = TLV493D_OP_MODE_LOWPOWER, .sleep_us = 10 * USEC_PER_MSEC	},
> > > +	{ .m = TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us = 100 * USEC_PER_MSEC },
> > > +	{ .m = TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us = 305 }
> > > +};
> > > +
> > > +/*
> > > + * The datasheet mentions the sensor supports only direct byte-stream write
> > > + * starting from register address 0x0. So for any modification to be made to
> > > + * any write registers, it must be written starting from the register address
> > > + * 0x0. I2C write operation should not contain register address in the I2C
> > > + * frame, it should contains only raw byte stream for the write registers.
> > > + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> > > + */
> > > +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!data || !data->client)  
> > If either of these happen, something went very very wrong.
> > No need for the checks.  Remove all similar ones.
> >   
> Interesting, Is the idea behind is that this API is used within the
> driver and the inputs are known? Ofcourse it saves some CPU cycles.

Exactly - if it's local and we can see the tests are never needed then
maybe the compiler will notice, but we can avoid even having the code.

> > > +		return -EINVAL;
> > > +
> > > +	ret = i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->wr_regs));
> > > +	if (ret < 0) {
> > > +		dev_err(data->dev, "i2c write registers failed, error: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tlv493d_set_operating_mode(struct tlv493d_data *data, u8 mode)  
> > As below. Use the enum type.  
> > > +{
> > > +	if (!data)
> > > +		return -EINVAL;  
> > 
> > As above. Data is never going to be NULL, so don't check it.
> >   
> > > +
> > > +	u8 mode1_cfg, mode2_cfg;
> > > +
> > > +	switch (mode) {
> > > +	case TLV493D_OP_MODE_POWERDOWN:
> > > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 0);
> > > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > > +		break;
> > > +
> > > +	case TLV493D_OP_MODE_FAST:
> > > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 1);
> > > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > > +		break;
> > > +
> > > +	case TLV493D_OP_MODE_LOWPOWER:
> > > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
> > > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 1);
> > > +		break;
> > > +
> > > +	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
> > > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
> > > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > > +		break;
> > > +
> > > +	case TLV493D_OP_MODE_MASTERCONTROLLED:
> > > +		mode1_cfg = FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 3);
> > > +		mode2_cfg = FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> > > +		break;
> > > +
> > > +	default:
> > > +		dev_err(data->dev, "invalid mode configuration\n");
> > > +		return -EINVAL;  
> > And with the enum type you shouldn't need a default.
> >   
> Can you please help me understand this better? So far my learning was,
> wherever there is switch case, it must have default case handled
> appropriatly.

If you passing in an enum, the compiler should be able to tell if you
are out of range.  Every enum value has an entry in the switch statement
therefore default is covering nothing and can be dropped.

That then defends against later adding a new enum value and failing
to cover it as the compiler then complains a case is not handled.

Jonathan


