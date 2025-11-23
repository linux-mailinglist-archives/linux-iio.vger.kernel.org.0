Return-Path: <linux-iio+bounces-26395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E0C7E6C2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 20:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D039B4E3CFC
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5076026;
	Sun, 23 Nov 2025 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX66cndC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832F25A2BB
	for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763927296; cv=none; b=LDnhnxoMCYc9rpZZW+I1DYW7EirYqzu0dU1UfszRZOrh1ZNdN+z4l1BtVQDv1ldQWc3c9Wi5wU1WxhKh6us3RKGmQoinjgU5F/bgMPWmlyK54k5DT4QsXoXXeQhx79nIKVSkH4XiygR8DezcidHTxKK6EEDRweXnV/oSGQgCp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763927296; c=relaxed/simple;
	bh=WQJL9ozrgY6dlfwtKWdc6XaQbzRy4r/BeFr7/xI5NiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9DX/MEUHgt3H8SA+KWUu7M4rFsm4oIlti/c/L3sEAlZY+A6LsNKXktYFja19jPctYs5boAFogpXUibTM9dRIrs9j3/hJJwnOsRftuHGDVHbXryJZnCGkra8MCLqL8hWAhjL+ozWqUc73FYjB/DvcwpNi8TCARZkQAUfJ+xTuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX66cndC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so630656266b.3
        for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2025 11:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763927292; x=1764532092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jO+pEg7JwOGM6dglSEjgBtEB6ZjLDnLUgMElzIqZU2g=;
        b=LX66cndCTHeAIuAXj59dQgAKtOVfPFvDGMUHgjFCl7TTHuwYlOa4n+v6nCVzX+4zK2
         BMencDmkrP/+W6gQ5nLWnwardx1i+f0RdNQ8SRGI3kB7m7cmTgrbFzAY30rU4zb4lzFQ
         GyraoQ0/k5LbmSZpHzMpBNRSDpmUOEfmRgl4v1jfcjCWZMt+YFXdwMS+OF3wg9o6tr4S
         3dHEt8mZ1OuUdhIPbw19GDvOEDNkBYo7xMI+YRhjSKD+/J+5ppkFfbM1FYK9kL2JmJgw
         EnlfwZDKFkEGgV1VqaVkS/1Xc2kswzz9qKG4iA3hrGYRoPLp1zfJ38m+qdJ0kppgx6Up
         T9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763927292; x=1764532092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO+pEg7JwOGM6dglSEjgBtEB6ZjLDnLUgMElzIqZU2g=;
        b=dnpTrUXDTIseQcyJWCnpiz9R3ZghkRaoc8iTx2rn92rezqJ3RHWK2D2wVanRXdD55l
         2cA7yOu+S5u3K+KDMvwDSBvTCrXFlxwte5PF3QX3jg30ytBcPYD/Nd1k1XTlsF/iXlTN
         pAyG0PDQV4tV6SJ9DU6jjtl9IFvbUGKKRC4fyK5bIMdRILoy3vO6QD9R9ed7A8FNeJ+p
         NYCe6dfEuwF6LtRJwaZ96hAqzxVFPYylMqby2Mm+/yGYz4cljSAQzGwnR9zqO/UqlaAJ
         gy3D7a945B3AsWWgpO1vVpSoATVUz08+Tazq60mrZs4yFOCP2RjjNsh0qYFcHJ7DMlok
         micQ==
X-Forwarded-Encrypted: i=1; AJvYcCWThC53qZj2WC9bKMPuWKa4VI1lr421mxzHtF/z4fUmEReLdSo1QHGh9VYL9G9AtM3DuCG01KxGRIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwrY+G59H4U9fXkfVSvhD9CYlEk4Mz/HZHOPgI7ZlPPHCsa27
	l69+k07CXqhYqvJvJ03cwVKcZ4v96BA85UnnjB8EoTnZKQY5oAaK5XVw
X-Gm-Gg: ASbGncvy+R7HLDa13AasTakVHTDY/18D8hnPtT6ReO92Z/4F0d5rzmcATLYG3+fn5Nm
	FXCao8Fi6U3t4UtT5Q56aCk9y/hoYOcVUNKUR3mum+DvJOICzu34Lb0Mm/GCXKyVVbTvGsMFLZm
	gHSVuSQo+Nf3t9e7qQWhOytt++LuTjkmxRUpdbyoYv5dczrLKhSPN0LNmICZaRMf9wXkFxoercX
	S7xuKyIpPBEte4IIcOLKEVclGKvbrL+OpCRZSR9OinfPFkMKjVazkdPM2syoIwHTtaBA2vKceqP
	GfkkCR0vhmUTSxqoGWY34yxTIistLyKtC9HMhQxKZdfGylWJwfUyq3kLzQndgiEqfBHEvo3qZq3
	2r+0K88dCPuv0hYZC1UtiYBQOssWrJ2+s7ASqpM+RzUWE+hWkJ90/l4aRaSiw6XqB3DnTqSqXUs
	N/qDqwVwUPkMrVK8PoZp8wZbO3UgatfZCOeYsiGQJfCfhKlYaTmMMCGh5zcM0+B8scgrE=
X-Google-Smtp-Source: AGHT+IE2MQ5j+w48lnReyH/IhLYNQNPJjllKEtf7E8mmH1c7d3EC/hRsgrmYnV8hbjKMpiA+VK29pw==
X-Received: by 2002:a17:907:948e:b0:b73:70c9:1780 with SMTP id a640c23a62f3a-b767183c122mr1103189466b.41.1763927291619;
        Sun, 23 Nov 2025 11:48:11 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:38ae:e5e8:159a:3b69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cefe53sm1076781966b.13.2025.11.23.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 11:48:11 -0800 (PST)
Date: Sun, 23 Nov 2025 20:48:09 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: Add support for ad4062
Message-ID: <ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
 <20251018171032.144a126c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171032.144a126c@jic23-huawei>

On Sat, Oct 18, 2025 at 05:10:32PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 09:28:01 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
> > register (SAR) analog-to-digital converter (ADC) that enables low-power,
> > high-density data acquisition solutions without sacrificing precision.
> > This ADC offers a unique balance of performance and power efficiency,
> > plus innovative features for seamlessly switching between
> > high-resolution and low-power modes tailored to the immediate needs of
> > the system. The AD4060/AD4062 are ideal for battery-powered, compact
> > data acquisition and edge sensing applications.
Hi Jonathan,

Mostly acknowledgements and explanations, except a comment on ACQUIRE usage.

> 
> Little bit marketing heavy for a patch description.. I'd stick to
> type, resolution and typical usecases. Skip the sacrificing precision etc
> wording!  It'll just make the readers eyes glaze over ;)
> 
Yep, will tune down a bit. The description was from the website.
> The mixing of regmap and direct accesses is a little unfortunate but seems unavoidable.
> 
Yes, it is not possible to use only the regmap due to the adc sample
transfers that require reads without writing the address.
> 
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> 
> Various comments inline.  In general looks good for a v1.
> 
> 
> > diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e55a69c62694a71a4e29f29b9a2bfeec3b16c990
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4062.c
> > @@ -0,0 +1,905 @@
> 
> > +#define     AD4062_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
> > +#define AD4062_REG_MIN_SAMPLE				0x45
> > +#define AD4062_REG_IBI_STATUS				0x48
> > +#define AD4062_REG_CONV_READ_LSB			0x50
> > +#define AD4062_REG_CONV_READ				0x53
> > +#define AD4062_REG_CONV_TRIGGER				0x59
> > +#define AD4062_REG_CONV_AUTO				0x61
> > +#define AD4062_MAX_REG					0x61
> 
> I'd define this in terms of the reg that it happens to be
> #define AD4052_MAX_REG AD6062_REG_CONF_AUTO
> 
Ack.
> 
> > +#define AD4062_VIO_3V3		3300000
> 
> This is a real value rather than a magic number so better to not hide it in a define.
> Just use the value inline.
> 
Ack.
> 
> > +#define AD4062_SPI_MAX_ADC_XFER_SPEED(x)	((x) >= AD4062_VIO_3V3 ? 83333333 : 58823529)
> > +#define AD4062_SPI_MAX_REG_XFER_SPEED		16000000
> So these might explain the locking in debugfs functions, but they aren't currently used.
> So either use them or drop them.
> 
Those are dead code for this driver, I will remove as well as others
unused defines.
> > +
> > +enum ad4062_grade {
> > +	AD4062_2MSPS,
> > +};

Since only one speed grade is available in the market, this will be
dropped and all usage simplified.

> > +
> > +enum ad4062_operation_mode {
> > +	AD4062_SAMPLE_MODE = 0,
> > +	AD4062_BURST_AVERAGING_MODE = 1,
> > +	AD4062_MONITOR_MODE = 3,
> > +};
> > +
> > +enum ad4062_gp_mode {
> > +	AD4062_GP_DISABLED,
> > +	AD4062_GP_INTR,
> > +	AD4062_GP_DRDY,
> > +};
> > +
> > +enum ad4062_interrupt_en {
> > +	AD4062_INTR_EN_NEITHER,
> Where these correspond to specific register values make sure
> to specify those values with = 0x0 etc
> 
> I'd use defines unless the type is useful, for example as ad4062_operation_mode above is.
> 
Ack.
> > +	AD4062_INTR_EN_MIN,
> > +	AD4062_INTR_EN_MAX,
> > +	AD4062_INTR_EN_EITHER,
> > +};
> 
> > +struct ad4062_state {
> > +	const struct ad4062_chip_info *chip;
> > +	const struct ad4062_bus_ops *ops;
> > +	enum ad4062_operation_mode mode;
> > +	struct completion completion;
> > +	struct iio_trigger *trigger;
> > +	struct iio_dev *indio_dev;
> > +	struct i3c_device *i3cdev;
> > +	struct regmap *regmap;
> > +	u16 sampling_frequency;
> > +	int vref_uv;
> > +	u8 raw[4] __aligned(IIO_DMA_MINALIGN);
> As I mention below, many of the uses of this seem to be a single __be16 so
> I'd suggestion a union with one of those so we know it's aligned and can use
> sizeof() instead of hard coded 2s.  If you prefer just add a __be16 variable
> after this as that always fits anyway (IIO_DMA_MINALIGN >= 8).
> 
Will do

        union {
                __be32 be32;
                __be16 be16;
                u8 bytes[4];
        } buf __aligned(IIO_DMA_MINALIGN);

> > +};
> 
> > +
> > +static const struct iio_enum AD4062_2MSPS_conversion_freq_enum = {
> > +	.items = AD4062_FS(AD4062_2MSPS),
> > +	.num_items = AD4062_FS_LEN(AD4062_2MSPS),
> > +	.set = ad4062_sampling_frequency_set,
> > +	.get = ad4062_sampling_frequency_get,
> > +};
> > +
> > +#define AD4062_EXT_INFO(grade)						\
> > +static struct iio_chan_spec_ext_info grade##_ext_info[] = {		\
> > +	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL,		\
> > +		 &grade##_conversion_freq_enum),			\
> 
> if it's shared by all why can't you use the standard
>  info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) ?
> That enables simple in kernel use etc that is a pain with ext info.
> 

Yes definitely.
> 
> > +	IIO_ENUM_AVAILABLE("sampling_frequency", IIO_SHARED_BY_ALL,	\
> > +			   &grade##_conversion_freq_enum),		\
> 
> And this should use the read_avail handling rather than being done this way.
> ext_info is for stuff that isn't particularly standard or which doesn't
> fit in the normal interfaces (like mount matrix).
> 
Ack.
> > +	{ }								\
> > +}
> > +
> > +AD4062_EXT_INFO(AD4062_2MSPS);
> > +
> > +#define AD4062_CHAN(bits, grade) {							\
> > +	.type = IIO_VOLTAGE,								\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
> > +				    BIT(IIO_CHAN_INFO_SCALE) |				\
> > +				    BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> > +				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> > +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> > +	.indexed = 1,									\
> > +	.channel = 0,									\
> > +	.has_ext_scan_type = 1,								\
> > +	.ext_scan_type = ad4062_scan_type_##bits##_s,					\
> > +	.num_ext_scan_type = ARRAY_SIZE(ad4062_scan_type_##bits##_s),			\
> > +	.ext_info = grade##_ext_info,							\
> > +}
> > +
> > +static const struct ad4062_chip_info ad4060_chip_info = {
> > +	.name = "ad4060",
> > +	.channels = { AD4062_CHAN(12, AD4062_2MSPS) },
> > +	.prod_id = 0x7A,
> > +	.max_avg = AD4050_MAX_AVG,
> > +	.grade = AD4062_2MSPS,
> > +};
> > +
> > +static const struct ad4062_chip_info ad4062_chip_info = {
> > +	.name = "ad4062",
> > +	.channels = { AD4062_CHAN(16, AD4062_2MSPS) },
> > +	.prod_id = 0x7C,
> > +	.max_avg = AD4062_MAX_AVG,
> > +	.grade = AD4062_2MSPS,
> 
> We'd normally only introduce elements to chip_info when then differ between
> supported chips.  For now this .grade seems unnecessary complexity. 
> 
Yes, grade will be completely removed since the is only one speed grade
in the market.
> > +};
> 
> 
> > +static int ad4062_check_ids(struct ad4062_state *st)
> > +{
> > +	int ret;
> > +	u16 val;
> > +
> > +	ret = regmap_bulk_read(st->regmap, AD4062_REG_PROD_ID_1, &st->raw, 2);
> 
> You do a lot of __be16 reads in this driver. Maybe use a union for raw so we can
> type these correctly and use sizeof() for that 2.
Ack.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = get_unaligned_be16(st->raw);
> > +	if (val != st->chip->prod_id)
> > +		dev_warn(&st->i3cdev->dev,
> > +			 "Production ID x%x does not match known values", val);
> > +
> > +	ret = regmap_bulk_read(st->regmap, AD4062_REG_VENDOR_H, &st->raw, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = get_unaligned_be16(st->raw);
> > +	if (val != AD4062_I3C_VENDOR) {
> > +		dev_err(&st->i3cdev->dev,
> > +			"Vendor ID x%x does not match expected value\n", val);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> > +
> > +static int ad4062_soft_reset(struct ad4062_state *st)
> > +{
> > +	u8 val = 0x81;
> 
> That probably wants to a define as definitely a magic number.
> 
Ack.
> > +	int ret;
> > +
> > +	ret = regmap_write(st->regmap, AD4062_REG_INTERFACE_CONFIG_A, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Wait AD4062 treset time */
> > +	fsleep(5000);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> > +			const bool *ref_sel)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	const struct iio_scan_type *scan_type;
> > +	int ret;
> > +
> > +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> > +	if (IS_ERR(scan_type))
> > +		return PTR_ERR(scan_type);
> > +
> > +	u8 val = FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0, AD4062_GP_INTR) |
> 
> I'm a bit confused on why this routes anything to GP0 given we haven't requested that interrupt.
> 
Is used in the next commit, on v2 I will be more careful to define things
only for the particular patch.
> > +		 FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_DRDY);
> > +
> > +	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
> > +				 AD4062_REG_GP_CONF_MODE_MSK_1 | AD4062_REG_GP_CONF_MODE_MSK_0,
> > +				 val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val = FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_0, (AD4062_INTR_EN_EITHER)) |
> > +	      FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_1, (AD4062_INTR_EN_NEITHER));
> 
> Filling val up here and using it much later seems odd. Probably better moved down.
> Also excess brackets.
> I'm lost on what this is doing though. Seems to be enabling interrupts that aren't
> routed anywhere.
Ack, reason same as above, belongs to the next commit.
> 
> > +
> > +	ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_MODES,
> > +				 AD4062_REG_ADC_CONFIG_REF_EN_MSK,
> > +				 FIELD_PREP(AD4062_REG_ADC_CONFIG_REF_EN_MSK,
> > +					    *ref_sel));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(st->regmap, AD4062_REG_DEVICE_STATUS,
> > +			   AD4062_REG_DEVICE_STATUS_DEVICE_RESET);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_update_bits(st->regmap, AD4062_REG_INTR_CONF,
> > +				  AD4062_REG_INTR_CONF_EN_MSK_0 | AD4062_REG_INTR_CONF_EN_MSK_1,
> > +				  val);
> > +}
> 
> > +
> > +static int ad4062_request_irq(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	struct device *dev = &st->i3cdev->dev;
> > +	int ret;
> > +
> > +	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
> > +	if (ret >= 0) {
> > +		ret = devm_request_threaded_irq(dev, ret, NULL,
> > +						 ad4062_irq_handler_drdy,
> > +						 IRQF_ONESHOT, indio_dev->name,
> > +						 indio_dev);
> return directly here.
Ack
> > +	} else if (ret != -EPROBE_DEFER) {
> I'd prefer we did the error handling first. It's a little fiddly but
> something like
Ack.
> 
> 	if (ret == -EPROBE_DEFER)
> 		return ret;
> 	if (ret < 0) { //I'd prefer an explicit match against whatever indicates nothing provided.
> 		return ...
> 
> 	return devm_request_threaded_irq();
> 
> > +		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
> > +					 AD4062_REG_ADC_IBI_EN_CONV_TRIGGER,
> > +					 AD4062_REG_ADC_IBI_EN_CONV_TRIGGER);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const int ad4062_oversampling_avail[] = {
> > +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
> I don't mind this style, but you'll likely get feedback that you might as well
> use
> 	BIT(0), BIT(1),
> etc here as it makes it less likely a typo will hid in these powers of 2.
> 
I think it is fine as is.
> > +};
> 
> > +static int __ad4062_read_chan_raw(struct ad4062_state *st, int *val)
> > +{
> > +	struct i3c_device *i3cdev = st->i3cdev;
> > +	u8 addr = AD4062_REG_CONV_TRIGGER;
> > +	struct i3c_priv_xfer t[2] = {
> > +		{
> > +			.data.out = &addr,
> > +			.len = 1,
> > +			.rnw = false,
> > +		},
> > +		{
> > +			.data.in = &st->raw,
> > +			.len = 4,
> > +			.rnw = true,
> > +		}
> > +	};
> > +	int ret;
> > +
> > +	reinit_completion(&st->completion);
> > +	/* Change address pointer to trigger conversion */
> > +	ret = i3c_device_do_priv_xfers(i3cdev, &t[0], 1);
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * Single sample read should be used only for oversampling and
> > +	 * sampling frequency pairs that take less than 1 sec.
> > +	 */
> > +	ret = wait_for_completion_timeout(&st->completion,
> > +					  msecs_to_jiffies(1000));
> > +	if (!ret)
> > +		return -ETIMEDOUT;
> > +
> > +	ret = i3c_device_do_priv_xfers(i3cdev, &t[1], 1);
> > +	if (ret)
> > +		return ret;
> > +	*val = get_unaligned_be32(st->raw);
> > +	return ret;
> 
> return 0;
> Makes it clear it must be 0 if we get here and that this is the 'good' exit path.
> 
Ack.
> > +}
> > +
> > +static int ad4062_read_chan_raw(struct iio_dev *indio_dev, int *val)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> There is a nice new
> 	ACQUIRE()/ACQUIRE_ERR() related set of conditional guards defined that
> let you do this using cleanup.h style.
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a0abc39450a3123fd52533a662fbd37e0d1508c
> 
> This looks like a perfect example of where those help.
> 
> When I catch up with review backlog I plan to look for other
> places to use that infrastructure in IIO.
> 
I tried implementing, here becomes

        ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
        ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);

At buffer and monitor, since we put the device as active during the
lifetime of the buffer and monitor mode, either I leave as is, or I bump
the counter with pm_runtime_get_noresume, so when the method leaves, the
counter drops to 1 and not 0, then on disable I drop the counter back to
0 and queue the autosuspend with pm_runtime_put_autosuspend.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_set_operation_mode(st, st->mode);
> > +	if (ret)
> > +		goto out_error;
> > +
> > +	ret = __ad4062_read_chan_raw(st, val);
> > +
> > +out_error:
> > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > +	return ret;
> > +}
> 
> 
> > +static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> > +				     unsigned int writeval, unsigned int *readval)
> > +{
> > +	struct ad4062_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> Add a comment on why reading registers isn't fine when buffered mode is in use.
> 
> If it's just a case of preventing writes that will change the state, then we typically
> don't prevent those. It's a debug interface, no problem with people shooting themselves
> in the foot.
> 
> If you are avoiding disrupting RMW sequences then use a local lock to ensure that
> is atomic, not this big heavy one.
> 
I dropped the lock and will let the user mess-up the transfer.
On buffer or monitor mode, a register access will cause the device to
drop of those modes. For the buffer acquisition, it will stop filling up
the buffer. The user can then recover the state by disabling and
enabling again the buffer or monitor mode.
> > +		return -EBUSY;
> > +
> > +	if (readval)
> > +		ret = regmap_read(st->regmap, reg, readval);
> > +	else
> > +		ret = regmap_write(st->regmap, reg, writeval);
> > +
> > +	iio_device_release_direct(indio_dev);
> > +	return ret;
> > +}
> 
> > +
> > +static int ad4062_regulators_get(struct ad4062_state *st, bool *ref_sel)
> > +{
> > +	struct device *dev = &st->i3cdev->dev;
> > +	int uv;
> > +
> > +	uv = devm_regulator_get_enable_read_voltage(dev, "vio");
> 
> Why are you reading the voltages then throwing them away?
> If we don't need to read it just use
> devm_regulator_get_enabled()
> 
Ack, I will just enable vio, not read it.
> 
> > +	if (uv < 0)
> > +		return dev_err_probe(dev, uv,
> > +				     "Failed to enable and read vio voltage\n");
> > +
> > +	uv = devm_regulator_get_enable_read_voltage(dev, "vdd");
> 
> Unless there is some ordering constraint I don't know of, you shouldn't
> fail on being unable to read the vdd voltage unless we are actually using it.
> So try ref first and if that succeeds use devm_regulator_get_enabled(), if not
> try the voltage reading approach..
> 

Ack, I reordered it and won't read vdd if ref exists (!= -ENODEV).

> > +	if (uv < 0)
> > +		return dev_err_probe(dev, uv,
> > +				     "Failed to enable vdd regulator\n");
> > +
> > +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> > +	*ref_sel = st->vref_uv == -ENODEV;
> > +	if (st->vref_uv == -ENODEV)
> > +		st->vref_uv = uv;
> > +	else if (st->vref_uv < 0)
> > +		return dev_err_probe(dev, st->vref_uv,
> > +				     "Failed to enable and read ref voltage\n");
> > +	return 0;
> > +}
> > +
> > +static const struct i3c_device_id ad4062_id_table[] = {
> > +	I3C_DEVICE(AD4062_I3C_VENDOR, ad4060_chip_info.prod_id, &ad4060_chip_info),
> > +	I3C_DEVICE(AD4062_I3C_VENDOR, ad4062_chip_info.prod_id, &ad4062_chip_info),
> > +	{}
> Trivial but I'm trying to slowly standardize spacing in IIO for these and
> a while back chose at random (more or less) to go with
> 	{ }
Ack.
> 
> > +};
> > +MODULE_DEVICE_TABLE(i3c, ad4062_id_table);
> > +
> > +static int ad4062_probe(struct i3c_device *i3cdev)
> > +{
> > +	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, ad4062_id_table);
> > +	const struct ad4062_chip_info *chip = id->data;
> > +	struct device *dev = &i3cdev->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct ad4062_state *st;
> > +	bool ref_sel;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->i3cdev = i3cdev;
> > +	i3cdev_set_drvdata(i3cdev, st);
> > +	init_completion(&st->completion);
> > +
> > +	ret = ad4062_regulators_get(st, &ref_sel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->regmap = devm_regmap_init_i3c(i3cdev, &ad4062_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> > +				     "Failed to initialize regmap\n");
> > +
> > +	st->mode = AD4062_SAMPLE_MODE;
> > +	st->chip = chip;
> > +	st->sampling_frequency = AD4062_FS_OFFSET(st->chip->grade);
> > +	st->indio_dev = indio_dev;
> > +
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->num_channels = 1;
> > +	indio_dev->info = &ad4062_info;
> > +	indio_dev->name = chip->name;
> > +	indio_dev->channels = chip->channels;
> > +
> > +	ret = ad4062_soft_reset(st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "AD4062 failed to soft reset\n");
> > +
> > +	ret = ad4062_check_ids(st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "AD4062 fields assertions failed\n");
> Seems like you print enough in the check_ids function that this print is
> perhaps just confusing?  Maybe add a print in the only path in there that
> doesn't already have one.
Ack, I will remove this error message.
> > +
> > +	ret = ad4062_setup(indio_dev, indio_dev->channels, &ref_sel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_request_irq(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_set_active(dev);
> > +	ret = devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to enable pm_runtime\n");
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, 1000);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	ret = ad4062_request_ibi(i3cdev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to request i3c ibi\n");
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> 
> Related to below. There is a race on tear down as you'll remove some of the
> i3c infrastructure before removing the userspace ABI that might result in
> that being used.
I submitted a patch at
https://lore.kernel.org/linux-i3c/aRYLc%2F+KAD13g7T7@lizhi-Precision-Tower-5810/T/#t
to allow using the devm_ based cleanup.
As is, the devm_ calls occurs after i3c_device_remove, this that calls
i3c_device_free_ibi and causes an exception if i3c_device_disable_ibi is
not called.

> 
> > +}
> > +
> > +static void ad4062_remove(struct i3c_device *i3cdev)
> > +{
> > +	i3c_device_disable_ibi(i3cdev);
> > +	i3c_device_free_ibi(i3cdev);
> You should never mix devm_ based cleanup and manual cleanup.
> 
> Basic rule is that the 1st time you add something that needs non devm cleanup
> for some reason then you must stop using any devm_ calls after that in probe().
> 
> There are some handy helpers for defining your own cleanup functions.
> devm_add_action_or_reset() is helpful for extending how far we can use devm_
> and typically solves this problem.
> 
Explained above, will use the devm_ helper in v2.
> > +}
> 
> > +
> > +static int ad4062_runtime_resume(struct device *dev)
> > +{
> > +	struct ad4062_state *st = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = regmap_clear_bits(st->regmap, AD4062_REG_DEVICE_CONFIG,
> > +				AD4062_REG_DEVICE_CONFIG_POWER_MODE_MSK);
> If it failed, little point in sleeping.  I'd do
> 	if (ret)
> 		return ret;
> 	
> 	fsleep(4000);
> 	return 0;
> 
> So the flow on error is clearer.
Ack.
> > +
> > +	fsleep(4000);
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops ad4062_pm_ops = {
> > +	SET_RUNTIME_PM_OPS(ad4062_runtime_suspend, ad4062_runtime_resume, NULL)
> Should have trailing comma.
> 
> Also rare that we can't just enable the system suspend/resume stuff that uses
> the runtime PM callbacks by using:
> DEFINE_RUNTIME_DEV_PM_OPS().  If we can't I'd add a comment on why not alongside
> this code.
> 
> > +};
> 
> 
Ack.

Best regards,
Jorge

