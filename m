Return-Path: <linux-iio+bounces-8833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D996148D
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFA1F25946
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276561D04A8;
	Tue, 27 Aug 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MsYCwPEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76481745
	for <linux-iio@vger.kernel.org>; Tue, 27 Aug 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777156; cv=none; b=LTEWNfXwsqVHrrZeKhr6ftQWlnYii/oSJREuptdQlm6BQmRoiBlIfTd0IbCK9ruWCjBZpaLojC2dtriu84JTAw2C+L/tprQR6VxuQSHdfirnSF1lxOziX7qFWODHu+tGcRvKDq3nCz9BhvoXl2HNkfBHf67P/2MrU0j2yG6mXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777156; c=relaxed/simple;
	bh=LrwKhfn+7M4t7yDZyvvpWwUDN3fahJJbPlQxyZWlD00=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RA0RFk/RAk1sQhWVIHdggREPImp3asqA3xPNmzI6ukkPxo2b0kW2Ai0QcXTvtGl3v4NU/lV/nqEluojDpwghb1KddbUudEGRbjfFismT9H+Ni44eUnYDLkbQGxsZL97hSQJgkt+AQb1bwJgr2aAgZsGAMoi0jqXWXTScrh2NzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MsYCwPEO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3730749ee7aso3392225f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 27 Aug 2024 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724777151; x=1725381951; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD3PTpc3UAvdPxux1yFdbSoCtlfgWLDrWRyZ4DLf+dw=;
        b=MsYCwPEOtsLkPx9OGmAjGywqsBODvS9p857rxZM+mQmAe4JM3HuifPMcEOi1DlU9wh
         k8RgPcLxJGdSzhLuJi/GZxgPFFNm6cxYymN2hdPAjRZpxpy6ycuaVhqOsshkAjaczjhD
         Q1FLqVja6XgNWJoTWqOjXAWG2Ehlrvi9W/RRZ+gy4oVrYkY71bet7P9L+W0WkFF7JE7G
         ONzMcvSZGEKdP8rNzgQ+O7RUGjpsw4FM6fZ7ipZ+OK/CqKBuBMUjqYhZSH6ABvVOuRKm
         0+avVqW2W7xYnIeikGk88ViRAHKEy+zWiqKb+cKBH+PR6EI97X1kXq+Rfloyv7+A81By
         fFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777151; x=1725381951;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YD3PTpc3UAvdPxux1yFdbSoCtlfgWLDrWRyZ4DLf+dw=;
        b=sNi5jC+vxNMAOp9ggYmnylCKbjbJUzomdpEgIJKCQ5UWY4+G6Rb6RH0nCLgh66E4ix
         LHf2+aJc9U1/L+cs+tcJohSN4HFhQHFSlF73nohmt0SGTArmBNcminBY58TOT7wz7TIP
         NWLOdGKfTQXJ8dgExpfmIM4vdEsmFvQomDsHj9GQE7ghm7NeD4clw0r9mLgN7i/XGQjg
         wO+M2zYMFUkm8/mbkX4/gDHEJ4am6OTGIj1vGizSmcsI+/h3pepnDh7IkxmaBESC1zHd
         FCr8hnppiV36oqo14aJsN3Ibae8afSV6fc5kxrYhu00jyk5vKKKCxT71l4DOlZUie8U+
         LzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdJNiuawNpGExXHE2dPhgYX2BGYreuZf6V/DOsuX9pTgQI982OIGRDvYzZ99dKGsEUWEbVtU6ddjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Y8q1YCnIBaZUDtr+ykG8Lngj9MHyZLt7lhBEK4PWyjUg4TtV
	F+8JJGJ6h/YA1U8WFm6tsPRHOmih6QeU9s5SIk6ev2BIwuT5tN+H498Yyiqy25c=
X-Google-Smtp-Source: AGHT+IGqz2SN6D0Ze4LPRg9FQpAhZitgBfRbYDRYHsjseyBgTvjReqACfP+CfbEaD2nw3iyEpzq/vw==
X-Received: by 2002:a5d:6589:0:b0:368:6598:131e with SMTP id ffacd0b85a97d-3748c825bbamr2416206f8f.38.1724777151363;
        Tue, 27 Aug 2024 09:45:51 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:49a3:a2f2:ac60:c67f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308110014sm13532607f8f.19.2024.08.27.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 09:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 18:45:49 +0200
Message-Id: <D3QUGZYL7INK.R3U3WQR0OCUS@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
 <20240824122111.425fa689@jic23-huawei>
In-Reply-To: <20240824122111.425fa689@jic23-huawei>

On Sat Aug 24, 2024 at 1:21 PM CEST, Jonathan Cameron wrote:
> On Thu, 22 Aug 2024 14:45:18 +0200
> Esteban Blanc <eblanc@baylibre.com> wrote:
>
> > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> >=20
> > The driver implements basic support for the AD4030-24 1 channel
> > differential ADC with hardware gain and offset control.
> >=20
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> Hi Esteban
>
> Some additional comments.  David did a good review already so
> I've tried not to duplicate too much of that.
>
> The big one in here is don't use extended_name.
> It's effectively deprecated for new drivers plus
> it would have required you add a lot of ABI docs as every
> sysfs file would have a strange name.
>
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > new file mode 100644
> > index 000000000000..a981dce988e5
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4030.c
>
> > +struct ad4030_state {
> > +	struct spi_device *spi;
> > +	struct regmap *regmap;
> > +	const struct ad4030_chip_info *chip;
> > +	struct gpio_desc *cnv_gpio;
> > +	int vref_uv;
> > +	int vio_uv;
> > +	int offset_avail[3];
> > +	u32 conversion_speed_hz;
> > +	enum ad4030_out_mode mode;
> > +
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the transfer buffe=
rs
> > +	 * to live in their own cache lines.
> > +	 */
> > +	u8 tx_data[AD4030_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> > +	struct {
> > +		union {
> > +			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
> > +			struct {
> > +				s32 val;
> > +				u32 common;
> > +			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];
>
> David pointed out this doesn't need to be packed.
> Given you have a union here, add __beXX as needed to avoid casts below.

They also pointed out that I should reduce the size for the common field.
I was planing to use an u32 bitfield here, 8 bits for common and 24 bits fo=
r
padding. As far as I understood, the C standard is quite flexible on the
size used for bitfield, so I should probably keep the __packed, right?

> > +};
> > +
> > +#define AD4030_CHAN_CMO(_idx)  {					\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> > +	.type =3D IIO_VOLTAGE,						\
> > +	.indexed =3D 1,							\
> > +	.channel =3D _idx * 2 + 2,					\
> > +	.scan_index =3D _idx * 2 + 1,					\
> > +	.extend_name =3D "Channel" #_idx " common byte part",		\
>
> We more or less never use extend name any more because it makes writing
> userspace code much harder.  Use the label callback to assign a label ins=
tead.
>
> If we were still using this, it would need to be a lot simpler than that
> and no spaces etc as it ends up int he sysfs file names.

> > +	.scan_type =3D {							\
> > +		.sign =3D 'u',						\
> > +		.storagebits =3D 32,					\
> > +		.realbits =3D 8,						\
> > +		.endianness =3D IIO_BE,					\
> > +	},								\
> > +}
> > +
> > +#define AD4030_CHAN_IN(_idx, _storage, _real, _shift) {			\
> > +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE),		\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> > +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> > +		BIT(IIO_CHAN_INFO_RAW),					\
> > +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_CALIBBIAS) |	\
> > +		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
> > +	.type =3D IIO_VOLTAGE,						\
> > +	.indexed =3D 1,							\
> > +	.channel =3D _idx * 2,						\
> > +	.channel2 =3D _idx * 2 + 1,					\
> > +	.scan_index =3D _idx * 2,						\
> > +	.extend_name =3D "Channel" #_idx " differential part",		\
>
> As above, no to this for same reason.
> This will generate a crazy ABI so I'm a bit surprised that didn't show
> up in your testing.  Would have needed a lot of docs even if we did
> still do things this way.

I'm using ADI IIO oscilloscope to check the signals so I didn't get
impacted by the sysfs change. Anyway I will use labels.

> > +	.differential =3D true,						\
> > +	.scan_type =3D {							\
> > +		.sign =3D 's',						\
> > +		.storagebits =3D _storage,				\
> > +		.realbits =3D _real,					\
> > +		.shift =3D _shift,					\
> > +		.endianness =3D IIO_BE,					\
> > +	},								\
> > +}
> > +
> > +static int ad4030_spi_read(void *context, const void *reg, size_t reg_=
size,
> > +			   void *val, size_t val_size)
> > +{
> > +	struct ad4030_state *st =3D context;
> > +
> > +	struct spi_transfer xfer =3D {
> > +		.tx_buf =3D st->tx_data,
> > +		.rx_buf =3D st->rx_data.raw,
> > +		.len =3D reg_size + val_size,
> > +	};
> > +	int ret;
> > +
> > +	memcpy(st->tx_data, reg, reg_size);
> > +
> > +	/*
> > +	 * This should use spi_write_the_read but when doing so, CS never get
> > +	 * deasserted.
>
> I'm confused.  As a single transfer it won't be deasserted in the transfe=
r
> whereas spi_write_then_read() will. So is this comment backwards or
> is it referring to something else?

So, with a single transfer (what is done now), the transfer is working
as expected: CS goes low, the data is transferred, CS goes high again.
With spi_write_then_read(), CS goes low, data is transferred but CS never
goes high again. After some time I get a timeout error in the kernel logs.

> > +static int ad4030_conversion(struct ad4030_state *st,
> > +			     const struct iio_chan_spec *chan)
> > +{
> > +	unsigned int bytes_to_read;
> > +	unsigned char byte_index;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	/* Number of bytes for one differential channel */
> > +	bytes_to_read =3D BITS_TO_BYTES(chan->scan_type.realbits);
> > +	/* Add one byte if we are using a differential + common byte mode */
> > +	bytes_to_read +=3D (st->mode =3D=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM =
||
> > +			st->mode =3D=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 1 : 0;
> > +	/* Mulitiply by the number of hardware channels */
> > +	bytes_to_read *=3D st->chip->num_channels;
> > +
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 1);
> > +	ndelay(AD4030_TCNVH_NS);
> > +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> > +	ndelay(st->chip->tcyc);
> > +
> > +	ret =3D spi_read(st->spi, st->rx_data.raw, bytes_to_read);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> > +		return 0;
> > +
> > +	byte_index =3D BITS_TO_BYTES(chan->scan_type.realbits);
> > +	for (i =3D 0; i < st->chip->num_channels; i++)
> > +		st->rx_data.buffered[i].common =3D ((u8 *)&st->rx_data.buffered[i].v=
al)[byte_index];
> break line after =3D.
>
> When it doesn't significantly hurt readability we still try to keep to 80
> chars for IIO drivers.  People have big screens but a lot of kernel devs
> love to have lots of windows across them - or have bad eyesight due to
> years of code review!

I keep forgeting that checkpatch now defaults at 100 chars...

> > +static int ad4030_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int *val,
> > +			   int *val2, long info)
> > +{
> > +	struct ad4030_state *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +		switch (info) {
> > +		case IIO_CHAN_INFO_RAW:
> > +			return ad4030_single_conversion(indio_dev, chan, val);
> > +
> > +		case IIO_CHAN_INFO_SCALE:
> > +			*val =3D (st->vref_uv * 2) / MILLI;
> > +			*val2 =3D st->chip->precision_bits;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
>
> No reason you can't read this whilst buffered capture in progress.
> Maybe it's not worth the effort of special casing though.
>
> It is the one thing people do read whilst doing buffered capture
> though because they didn't cache it before starting the buffer
> and it's needed for data interpretation unlike all the other controls.
>
> Maybe just do a
> 	if (info =3D=3D IIO_CHAN_INFO_SCALE) {
> 	}
> block at top of function?

Good catch. I will check for IIO_CHAN_INFO_SCALE before the whole block

> > +static int ad4030_reset(struct ad4030_state *st)
> > +{
> > +	struct device *dev =3D &st->spi->dev;
> > +	struct gpio_desc *reset;
> > +	int ret;
> > +
> > +	/* Use GPIO if available ... */
> > +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset))
> > +		return dev_err_probe(dev, PTR_ERR(reset),
> > +				"Failed to get reset GPIO\n");
> > +
> > +	if (reset) {
> > +		ndelay(50);
> > +		gpiod_set_value_cansleep(reset, 0);
> > +	} else {
> > +		/* ... falback to software reset otherwise */
> > +		ret =3D ad4030_enter_config_mode(st);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
> > +				   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* Wait for reset to complete before communicating to it */
>
> I'd rather see a reference for the value than a generic comment
> like this.  Also pull the actual value down here. Not particularly
> useful to have a define for what is a real time unless you are going
>  to have some combined docs for a bunch of timings (i.e a datasheet
> table reference)

I will put the real value in fsleep call directly. When you say "I'd
rather see a reference for the value", you ment a reference to the place
the value is defined in the datasheet, right?

> > +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> > +{
> > +	unsigned int grade;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> > +	if (ret)
> > +		return ret;
> > +
> > +	grade =3D FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> > +	if (grade !=3D st->chip->grade)
> > +		return dev_err_probe(&st->spi->dev, -EINVAL,
> > +					"Unknown grade(0x%x) for %s\n", grade,
> > +					st->chip->name);
>
> Is this similar to a missmatch on a whoami value?

Yes. It also saved me multiple hours of debuging when the eval board
was not connected porperly and the SPI link was just not working.

> I.e. should we print a message and carry on in the interests of providing
> some degree of support for newer devices on older kernel?
> (fallback compatibles in DT)

Ok, let's go with a warning then.

> > +static const struct spi_device_id ad4030_id_table[] =3D {
> > +	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
> > +	{}
>
> I'm going to assume you have a bunch of other parts you plan to
> support soon. Otherwise we normally don't add the chip specific
> support until it is needed.  It tends to complicate initial driver
> review a little and experience says that sometimes no other devices
> are ever added.

I'm sending the other devices in the same series (patch 4 and 5).
For the sake of reducing noise in the later patches, I've put it in
the initial driver. If you feel like I should wait and do it in the
following patch (patch 4), I can do that.

Thanks for your time,

--=20
Esteban Blanc
BayLibre

