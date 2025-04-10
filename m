Return-Path: <linux-iio+bounces-17907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D91A840EE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAB81B858D8
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087427C174;
	Thu, 10 Apr 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2piEIUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9CBA33;
	Thu, 10 Apr 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281588; cv=none; b=ssgGIGTttvNwKoxI0ktG/GF/ruCZSys1r6Xhvl9/WmFUR5ES2y3Okn9l7MeDqG/JRoaaF4LHNJ00MQC9ew1/IxI3U/oRd1Xb84I3awis/qU780PbcMf1hYoBAevgQ8a2Obolhms2PuJ07SIM8JyvE+k9wRVBDQQ8igciDZjkVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281588; c=relaxed/simple;
	bh=+B3g7hJrq0NhP7fMwX42imq5bftlva8KrWwq3uuALik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sbOldNaH16GpqexPYiSXr3YlOuNGes6zgmmux0U1KTuIgE+1+YETRIZWi8m5Qp0APVBrnIgP/p3DcZjGHNSpo/NyF7b3n/UFwA8opl5tUAwZ960WY5Yf6otWmmHlQejiVciEkOw6F6K4z8QkeWnfnF8yKf6UhBmOYXTXeArDuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2piEIUS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso4887055e9.3;
        Thu, 10 Apr 2025 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744281585; x=1744886385; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tYUZGEQszCIEdfQvqts2TfbL6KlaJBNQkK8Bg4ZLOg=;
        b=f2piEIUS/uuCyylLfoabooYUpbw2esY175OeSzRi6ZBr0JTQOAREcJSjKEL+bzU/pI
         CRvHpnVPNMNoSZXeyf5xYjvYKlNMS1PCnHe7qUeFcUzspvNj6atC8jS5jNXjS9cx3gnl
         YStAoEzq+B4QEinjqaGeawdnm/Z+u/Zf7OzulNwc8eXIcWwW5Dzz/GBQpKhK8DsqdT/5
         Lf0ymF7gOpR6wxCSsFXHNx8qX0xXCHuI7zczZafyxu331FLH2tsmlIWk63J7yZjy2iNd
         ECu4bMXyimfF0wWIuwzW0wUe6r5OvQK+8VRoq/IBBTSPM93SPRF2trEc60xDHsDH7yFi
         Izcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744281585; x=1744886385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tYUZGEQszCIEdfQvqts2TfbL6KlaJBNQkK8Bg4ZLOg=;
        b=UTbzcyP3LQm3FduMX3HGiRfRipaCCNCdfT0CMCTs/aZwk8PkFX+/2oit5SX4dRoCNJ
         5GoEMHGeU+5+yvan+xlZE7nHzrjKGyaf7sWo234Lf8U/oiKA5G77KxlUbK/DRcH/M6z5
         jmUH7KRkRz43jHDN9OyPP50w0vEO4NQ/9SqeKHClMKFqRUVipq13MzWAYoQ1PHJx7ze8
         tWu4GaJAQlX0PkMpy+nGEy6+dRdyjWNxX17A0kks+690GiIlgKAIokG+I53wQ+Y6pDL/
         uxUBAidzGwtYis8rvMrCp8dcypNYZDWbxsunPD+JantWBld9KwYBKBKDFLL4HeXqaAWJ
         kXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo2wsq3UrOr4st62MDiPAsGLkszPOHvxAmVNbXjLagKO3YEDHTWpDhDfF5iAvQtAT45+dEWw//K0q5@vger.kernel.org, AJvYcCWDrdD7GujlJ/zuyRXfnjEWZSYcehb7RQBD8Ldr0vEoCUVHg5QHEx91lv4wc2cOGWI39HJ8VDfwdS/DNANq@vger.kernel.org, AJvYcCXxMFtwrE9fr0jxoXwO+4tTHvHSsigKtTmsjWVP+PyFfT9gOxWgA4GcqvTm+Vj7QXe/S1sWAGrrS5Dr@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAvLVfso3DfYlTUWEmEqPXkbchAlAESUqW6TxnoG3Aqubt+bd
	fWXfNUT81f5Yr93jpoj09Q4YscnmAgEwBCGWqAPdqv2Zqpl1oPWkNxmjvTIv7cZ0Ew==
X-Gm-Gg: ASbGncvEA3YO3Y2NEA8+JjrsRwbXYuNCwdlJKQSrsDi94U53J+CS2SG3CyNah1AF/eo
	BI8Whxmb8oHazt1szQRZoKS3BhRAey9KfyCK+FMxsNtTgOk0PNtzvYWBBlLPdt8bwU975ZNWAqr
	+QZ1sN0A5YqStWUQ7NFabt8PKhzRFEL0An/9LasjxLWGj8rlM8MkQZvczioVgpynmYFhzeFfrYD
	JXe0M1io8hYvrRSvMJa/yq2mqeMl/Z7shxg6rPZfR9KkUveTvfK4k97yAYNPe1aDlLYrilUp2nK
	MMesYulFrZ8g4T39H+CY0aFtcppxXXygiDhNaAETezhi1T5i0VgLYzcdcJyMhEm9iZSiHWVmibZ
	OisgSn7ic7h/Q
X-Google-Smtp-Source: AGHT+IEUYK3abJlyt5HgH62f94YjR849g/VWZIjVvRTToR+Im45S67UpdPTJJrNs3/Tk6+lF8aLsIA==
X-Received: by 2002:a05:600c:154c:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43f2d7bc1a3mr18308205e9.11.1744281584607;
        Thu, 10 Apr 2025 03:39:44 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fca5sm52428665e9.32.2025.04.10.03.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:39:44 -0700 (PDT)
Message-ID: <149672e84f09fb178c90856920e3cfd4f140529d.camel@gmail.com>
Subject: Re: [PATCH v1 7/7] iio: adc: ad4170: Add support for weigh scale
 and RTD sensors
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
Date: Thu, 10 Apr 2025 11:39:45 +0100
In-Reply-To: <56e76070b72d15950bf1fb01e68e94c42e79905b.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	 <56e76070b72d15950bf1fb01e68e94c42e79905b.1744200264.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 09:26 -0300, Marcelo Schmitt wrote:
> The AD4170 design has features to aid interfacing with weigh scale and RT=
D
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circu=
it
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
>=20
> Configure AD4170 to handle external circuit sensors.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad4170.c | 341 ++++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 338 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index d204f8ca840f..2cf578608316 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -77,6 +77,7 @@
> =C2=A0#define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
> =C2=A0#define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
> =C2=A0#define AD4170_V_BIAS_REG				0x135
> +#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
> =C2=A0#define AD4170_FIR_CTRL					0x141
> =C2=A0#define AD4170_COEFF_DATA_REG				0x14A
> =C2=A0#define AD4170_COEFF_ADDR_REG				0x14C
> @@ -127,6 +128,10 @@
> =C2=A0/* AD4170_FILTER_REG */
> =C2=A0#define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
> =C2=A0
> +/* AD4170_CURRENT_SRC_REG */
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK		GENMASK(12, 8)
> +#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK		GENMASK(2, 0)
> +
> =C2=A0/* AD4170 register constants */
> =C2=A0
> =C2=A0/* AD4170_CLOCK_CTRL_REG constants */
> @@ -188,6 +193,21 @@
> =C2=A0#define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
> =C2=A0#define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
> =C2=A0
> +/* AD4170_CURRENT_SRC_REG constants */
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN0		0
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN1		1
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN2		2
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN3		3
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN4		4
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN5		5
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN6		6
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN7		7
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN8		8
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0		17
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO1		18
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO2		19
> +#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO3		20
> +
> =C2=A0/* Device properties and auxiliary constants */
> =C2=A0

...

> =C2=A0#define AD4170_NUM_ANALOG_PINS				9
> @@ -222,6 +242,12 @@
> =C2=A0#define AD4170_PIN_UNASIGNED				0x00
> =C2=A0#define AD4170_PIN_ANALOG_IN				0x01
> =C2=A0#define AD4170_PIN_CURRENT_OUT				0x02
> +#define AD4170_PIN_VBIAS				0x04
> +
> +/* GPIO pin functions=C2=A0 */
> +#define AD4170_GPIO_UNASIGNED				0x00
> +#define AD4170_GPIO_AC_EXCITATION			0x02
> +#define AD4170_GPIO_OUTPUT				0x04
> =C2=A0
> =C2=A0enum ad4170_ref_buf {
> =C2=A0	AD4170_REF_BUF_PRE,	/* Pre-charge referrence buffer */
> @@ -278,6 +304,33 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[]=
 =3D {
> =C2=A0	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256
> =C2=A0};
> =C2=A0
> +static const unsigned int ad4170_iout_pin_tbl[] =3D {
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN0,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN1,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN2,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN3,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN4,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN5,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN6,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN7,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_AIN8,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO1,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO2,
> +	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO3,
> +};
> +
> +static const unsigned int ad4170_iout_current_ua_tbl[] =3D {
> +	0, 10, 50, 100, 250, 500, 1000, 1500
> +};
> +
> +enum ad4170_sensor_type {
> +	AD4170_ADC_SENSOR =3D 0,
> +	AD4170_WEIGH_SCALE_SENSOR =3D 1,
> +	AD4170_THERMOCOUPLE_SENSOR =3D 2,
> +	AD4170_RTD_SENSOR =3D 3,
> +};
> +
> =C2=A0static const char * const ad4170_chip_names[] =3D {
> =C2=A0	"ad4170",
> =C2=A0	"ad4190",
> @@ -343,6 +396,7 @@ struct ad4170_state {
> =C2=A0	struct clk *ext_clk;
> =C2=A0	struct clk_hw int_clk_hw;
> =C2=A0	int pins_fn[AD4170_NUM_ANALOG_PINS];
> +	int gpio_fn[AD4170_NUM_GPIO_PINS];
> =C2=A0	struct gpio_chip gpiochip;
> =C2=A0	u32 int_pin_sel;
> =C2=A0	int
> sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> @@ -956,6 +1010,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_=
state
> *st, int ain_n,
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0
> =C2=A0	*ain_voltage =3D 0;
> +	/*
> +	 * The voltage bias (vbias) sets the common-mode voltage of the
> channel
> +	 * to (AVDD + AVSS)/2. If provided, AVSS supply provides the
> magnitude
> +	 * (absolute value) of the negative voltage supplied to the AVSS pin.
> +	 * So, we do AVDD - AVSS to compute the DC voltage generated by the
> bias
> +	 * voltage generator.
> +	 */
> +	if (st->pins_fn[ain_n] & AD4170_PIN_VBIAS) {
> +		*ain_voltage =3D (st->vrefs_uv[AD4170_AVDD_SUP]
> +				- st->vrefs_uv[AD4170_AVSS_SUP]) / 2;
> +		return 0;
> +	}
> +
> =C2=A0	if (ain_n <=3D AD4170_CHAN_MAP_TEMP_SENSOR)
> =C2=A0		return 0;
> =C2=A0
> @@ -1746,6 +1813,242 @@ static int ad4170_gpio_init(struct iio_dev *indio=
_dev)
> =C2=A0	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip,
> indio_dev);
> =C2=A0}
> =C2=A0
> +static int _ad4170_find_table_index(const unsigned int *tbl, size_t len,
> +				=C2=A0=C2=A0=C2=A0 unsigned int val)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < len; i++)
> +		if (tbl[i] =3D=3D val)
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +#define ad4170_find_table_index(table, val) \
> +	_ad4170_find_table_index(table, ARRAY_SIZE(table), val)
> +
> +static int ad4170_validate_excitation_pins(struct ad4170_state *st,
> +					=C2=A0=C2=A0 u32 *exc_pins, int num_exc_pins)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret, i;
> +
> +	for (i =3D 0; i < num_exc_pins; i++) {
> +		unsigned int pin =3D exc_pins[i];
> +
> +		ret =3D ad4170_find_table_index(ad4170_iout_pin_tbl, pin);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid excitation pin: %u\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 pin);
> +
> +		if (pin <=3D AD4170_MAX_ANALOG_PINS) {
> +			if (st->pins_fn[pin] !=3D AD4170_PIN_UNASIGNED)
> +				return dev_err_probe(dev, -EINVAL,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "Pin %u already used
> with fn %u\n",
> +						=C2=A0=C2=A0=C2=A0=C2=A0 pin, st->pins_fn[pin]);
> +
> +			st->pins_fn[pin] =3D AD4170_PIN_CURRENT_OUT;
> +		} else {
> +			unsigned int gpio =3D pin -
> AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0;
> +
> +			if (st->gpio_fn[gpio] !=3D AD4170_GPIO_UNASIGNED)
> +				return dev_err_probe(dev, -EINVAL,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "GPIO %u already used
> with fn %u\n",
> +						=C2=A0=C2=A0=C2=A0=C2=A0 gpio, st-
> >gpio_fn[gpio]);
> +
> +			st->gpio_fn[gpio] =3D AD4170_GPIO_AC_EXCITATION;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int ad4170_setup_rtd(struct ad4170_state *st,
> +			=C2=A0=C2=A0=C2=A0 struct fwnode_handle *child,
> +			=C2=A0=C2=A0=C2=A0 struct ad4170_setup *setup, u32 *exc_pins,
> +			=C2=A0=C2=A0=C2=A0 int num_exc_pins, int exc_cur, bool ac_excited)
> +{
> +	int current_src, ret, i;
> +
> +	for (i =3D 0; i < num_exc_pins; i++) {
> +		unsigned int pin =3D exc_pins[i];
> +
> +		current_src |=3D FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK,
> pin);
> +		current_src |=3D FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK,
> exc_cur);
> +
> +		ret =3D regmap_write(st->regmap16, AD4170_CURRENT_SRC_REG(i),
> +				=C2=A0=C2=A0 current_src);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (ac_excited)
> +		setup->misc |=3D FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
> +					=C2=A0 num_exc_pins =3D=3D 2 ? 0x2 : 0x3);
> +
> +	return 0;
> +}

In the above I do not see any explicit GPIO configuration which makes me wo=
nder
if having the RTD is mutual exclusive with having GPIOs?

> +
> +static int ad4170_setup_bridge(struct ad4170_state *st,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *child,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ad4170_setup *setup, u32 =
*exc_pins,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_exc_pins, int exc_cur, b=
ool
> ac_excited)
> +{
> +	int current_src, ret, i;
> +
> +	if (!ac_excited)
> +		return 0;

Same as above, if !ac_excited, can't we use the GPIOs? because
ad4170_validate_excitation_pins() just unconditionally sets
AD4170_GPIO_AC_EXCITATION. Or maybe this DT property is only adding
complexity... See below
> +
> +	/*
> +	 * If a specific current is provided through
> +	 * adi,excitation-current-microamp, set excitation pins provided
> through
> +	 * adi,excitation-pins to AC excite the bridge circuit. Else, use
> +	 * predefined ACX1, ACX1 negated, ACX2, ACX2 negated signals to AC
> +	 * excite the bridge. Those signals are output on GPIO2, GPIO0,
> GPIO3,
> +	 * and GPIO1, respectively. If only two pins are specified for AC
> +	 * excitation, use ACX1 and ACX2. See AD4170 datasheet for
> instructions
> +	 * on how to setup the bridge circuit.
> +	 *
> +	 * Also, to avoid any short-circuit condition when more than one
> channel
> +	 * is enabled, set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low
> to
> +	 * DC excite the bridge whenever a channel without AC excitation is
> +	 * selected. That is needed because GPIO pins are controlled by the
> next
> +	 * highest priority GPIO function when a channel doesn't enable AC
> +	 * excitation. See datasheet Figure 113 Weigh Scale (AC Excitation)
> for
> +	 * an example circuit diagram.
> +	 */
> +	if (exc_cur =3D=3D 0) {
> +		if (num_exc_pins =3D=3D 2) {
> +			setup->misc |=3D FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK,
> 0x3);
> +			ret =3D regmap_set_bits(st->regmap16,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4170_GPIO_MODE_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(7) | BIT(5));
> +			if (ret)
> +				return ret;
> +
> +			ret =3D regmap_set_bits(st->regmap16,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4170_GPIO_OUTPUT_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) | BIT(2));
> +			if (ret)
> +				return ret;
> +
> +			st->gpio_fn[3] |=3D AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[2] |=3D AD4170_GPIO_OUTPUT;
> +		} else {
> +			setup->misc |=3D FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK,
> 0x2);
> +			ret =3D regmap_set_bits(st->regmap16,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4170_GPIO_MODE_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(7) | BIT(5) | BIT(3) |
> BIT(1));
> +			if (ret)
> +				return ret;
> +
> +			ret =3D regmap_set_bits(st->regmap16,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4170_GPIO_OUTPUT_REG,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) | BIT(2) | BIT(1) |
> BIT(0));
> +			if (ret)
> +				return ret;
> +
> +			st->gpio_fn[3] |=3D AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[2] |=3D AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[1] |=3D AD4170_GPIO_OUTPUT;
> +			st->gpio_fn[0] |=3D AD4170_GPIO_OUTPUT;

Not sure if you gain much with having the funcs OR'ed like this... If I'm n=
ot
missing nothing it's only about logging in ad4170_validate_excitation_pins(=
)?
It's up to you but I would consider using bitmaps (unsigned long) for this =
and
just test the bits.


> +		}
> +
> +		return 0;
> +	}
> +	for (i =3D 0; i < num_exc_pins; i++) {
> +		unsigned int pin =3D exc_pins[i];
> +
> +		current_src |=3D FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK,
> pin);
> +		current_src |=3D FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK,
> exc_cur);
> +
> +		ret =3D regmap_write(st->regmap16, AD4170_CURRENT_SRC_REG(i),
> +				=C2=A0=C2=A0 current_src);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	setup->misc |=3D FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
> +				=C2=A0 num_exc_pins =3D=3D 2 ? 0x2 : 0x3);
> +
> +	return 0;
> +}
> +
> +static int ad4170_parse_external_sensor(struct ad4170_state *st,
> +					struct fwnode_handle *child,
> +					struct ad4170_setup *setup,
> +					struct iio_chan_spec *chan, u8
> s_type)
> +{
> +	unsigned int num_exc_pins, exc_cur, reg_val;
> +	struct device *dev =3D &st->spi->dev;
> +	u32 pins[2], exc_pins[4];
> +	bool ac_excited, vbias;
> +	int ret;
> +
> +	ret =3D fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(pins));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read sensor diff-
> channels\n");
> +
> +	chan->differential =3D true;
> +	chan->channel =3D pins[0];
> +	chan->channel2 =3D pins[1];
> +
> +	ac_excited =3D fwnode_property_read_bool(child, "adi,ac-excited");
> +
> +	num_exc_pins =3D fwnode_property_count_u32(child, "adi,excitation-
> pins");
> +	if (num_exc_pins !=3D 2 && num_exc_pins !=3D 4)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid number of excitation pins\n");

Can't we assume that a valid num_exc_pins property means ac_excited =3D tru=
e?
Because that looks to be the logic in ad4170_validate_excitation_pins().

> +
> +	ret =3D fwnode_property_read_u32_array(child, "adi,excitation-pins",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 exc_pins, num_exc_pins);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read adi,excitation-pins\n");
> +
> +	ret =3D ad4170_validate_excitation_pins(st, exc_pins, num_exc_pins);
> +	if (ret)
> +		return ret;
> +
> +	exc_cur =3D 0;
> +	ret =3D fwnode_property_read_u32(child, "adi,excitation-current-
> microamp",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &exc_cur);
> +	if (ret && s_type =3D=3D AD4170_RTD_SENSOR)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read adi,excitation-current-
> microamp\n");
> +
> +	ret =3D ad4170_find_table_index(ad4170_iout_current_ua_tbl, exc_cur);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid excitation current: %uuA\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 exc_cur);
> +
> +	/* Get the excitation current configuration value */
> +	exc_cur =3D ret;
> +
> +	if (s_type =3D=3D AD4170_THERMOCOUPLE_SENSOR) {
> +		vbias =3D fwnode_property_read_bool(child, "adi,vbias");
> +		if (vbias) {
> +			st->pins_fn[chan->channel2] |=3D AD4170_PIN_VBIAS;
> +			reg_val =3D BIT(chan->channel2);
> +			return regmap_write(st->regmap16, AD4170_V_BIAS_REG,
> +					=C2=A0=C2=A0=C2=A0 reg_val);
> +		}
> +	}
> +	if (s_type =3D=3D AD4170_WEIGH_SCALE_SENSOR ||
> +	=C2=A0=C2=A0=C2=A0 s_type =3D=3D AD4170_THERMOCOUPLE_SENSOR) {

I guess you have this because of indentation levels but is it that bad if w=
e do
		if (s_typ =3D=3D AD4170_THERMOCOUPLE_SENSOR && fwnode_property_read_bool(=
child, "adi,vbias") {
			...
		}

> +		ret =3D ad4170_setup_bridge(st, child, setup, exc_pins,
> +					=C2=A0 num_exc_pins, exc_cur, ac_excited);
> +	} else {
> +		ret =3D ad4170_setup_rtd(st, child, setup, exc_pins,
> num_exc_pins,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exc_cur, ac_excited);
> +	}
> +	return ret;
> +}
> +
> =C2=A0static int ad4170_parse_reference(struct ad4170_state *st,
> =C2=A0				=C2=A0 struct fwnode_handle *child,
> =C2=A0				=C2=A0 struct ad4170_setup *setup)
> @@ -1827,6 +2130,7 @@ static int ad4170_parse_channel_node(struct iio_dev
> *indio_dev,
> =C2=A0	struct ad4170_state *st =3D iio_priv(indio_dev);
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0	struct ad4170_chan_info *chan_info;
> +	u8 s_type =3D AD4170_ADC_SENSOR;
> =C2=A0	struct ad4170_setup *setup;
> =C2=A0	struct iio_chan_spec *chan;
> =C2=A0	unsigned int ch_reg;
> @@ -1857,10 +2161,34 @@ static int ad4170_parse_channel_node(struct iio_d=
ev
> *indio_dev,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D ad4170_parse_adc_channel_type(dev, child, chan);
> -	if (ret < 0)
> -		return ret;
> +	ret =3D fwnode_property_read_u8(child, "adi,sensor-type", &s_type);
> +	if (!ret) {
> +		if (s_type > AD4170_RTD_SENSOR)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,sensor-type: %u\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 s_type);
> +	}
> +	switch (s_type) {
> +	case AD4170_ADC_SENSOR:
> +		ret =3D ad4170_parse_adc_channel_type(dev, child, chan);
> +		if (ret < 0)
> +			return ret;
> =C2=A0
> +		break;
> +	case AD4170_WEIGH_SCALE_SENSOR:
> +		fallthrough;
> +	case AD4170_THERMOCOUPLE_SENSOR:
> +		fallthrough;
> +	case AD4170_RTD_SENSOR:
> +		ret =3D ad4170_parse_external_sensor(st, child, setup, chan,
> +						=C2=A0=C2=A0 s_type);
> +		if (ret < 0)
> +			return ret;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> =C2=A0	bipolar =3D fwnode_property_read_bool(child, "bipolar");
> =C2=A0	setup->afe |=3D FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
> =C2=A0	if (bipolar)
> @@ -2057,6 +2385,9 @@ static int ad4170_parse_firmware(struct iio_dev
> *indio_dev)
> =C2=A0	for (i =3D 0; i < AD4170_NUM_ANALOG_PINS; i++)
> =C2=A0		st->pins_fn[i] =3D AD4170_PIN_UNASIGNED;
> =C2=A0
> +	for (i =3D 0; i < AD4170_NUM_GPIO_PINS; i++)
> +		st->gpio_fn[i] =3D AD4170_GPIO_UNASIGNED;
> +
> =C2=A0	/* On power on, device defaults to using SDO pin for data ready
> signal */
> =C2=A0	st->int_pin_sel =3D AD4170_INT_PIN_SDO;
> =C2=A0	ret =3D device_property_match_property_string(dev, "interrupt-name=
s",
> @@ -2081,6 +2412,10 @@ static int ad4170_parse_firmware(struct iio_dev
> *indio_dev)
> =C2=A0
> =C2=A0	/* Only create a GPIO chip if flagged for it */
> =C2=A0	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
> +		for (i =3D 0; i < AD4170_NUM_GPIO_PINS; i++)
> +			if (st->gpio_fn[i] !=3D AD4170_GPIO_UNASIGNED)
> +				return 0;

I think you could improve this... You're taking an all or nothing approach.
IIUC, we can have cases where only two GPIOs are in use which means we coul=
d use
the other 2? There the gpiochio init_valid_mask() call that you could
potentially use.

- Nuno S=C3=A1


