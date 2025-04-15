Return-Path: <linux-iio+bounces-18127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208FBA89748
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195DE440C7C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39E27B4EE;
	Tue, 15 Apr 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXOwZrw4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFE1DE4CE;
	Tue, 15 Apr 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707500; cv=none; b=jJWYSbT89xw78pwdcxwuhFAIL+S2uFUW+efW9WDQ637d3SO0H101jPjzvxq5uyRv+iY79izt7qB2dgAKRpSnne9dHKuB8cmPq8bSykcb2COS3DAu8Aufg3RG2smaWyXQE+9xOGWaVwtraK3yy06dX46/UqzmZfndKfefyxya9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707500; c=relaxed/simple;
	bh=Cr419uGeBN6LGkQzD3SUqWU2w+rtig4ltgmAmmubvdg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q5Mtq6kLwXOZ404vSZEHm9RNC8x/SX7a/li1cMAu7L0r94k8kQFjHTxJbPX3niIux7reY449le1loCLjV0ZqGUE4r7iVn5t4UgAZe4/rMlIO9Wn49cBQzW2LwHCK6E8TOzfnHfcT0HP3/5PqP7+i0wJ7nO+QhfoRUbMM0gXpbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXOwZrw4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3151192f8f.0;
        Tue, 15 Apr 2025 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744707496; x=1745312296; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl8WytWGG2hX+p0gSyoLuVFcUsTAjft3S+RP0lT3jPs=;
        b=AXOwZrw4E6gllcV+iH9dqD3iUaIOUReTyWeoNJF1QAN9HHCXqtjCrdDcyvkyKrxlmg
         CjUCn5UPX0GgIb6SbtwaFjl1x6FBlKAS4D/QV+k6Z5/q+2Hmxhl4aIayAyFErU9WDt4s
         GwzAxfxcRpArFhHesudnpTc3VOOrqQh2YWpt+zowZCOc1v1cLzgDaLjl/WQILu2hoJud
         wrqHYvlzlUpiNmIl03qIMmAky1SHYCjmOeQZyl6Enfm6jMJvS8h7tl0N8Z+ywhrRPWYG
         OpIizU3VAHjheA1NEd0ggBhEPznhFiv1MqbHT6yDiJkQhxC4+XQ1AD/gwov6HDRdvKPM
         ZBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744707496; x=1745312296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rl8WytWGG2hX+p0gSyoLuVFcUsTAjft3S+RP0lT3jPs=;
        b=bSAa4sxX+4oKHLL1cwGt2y13tH9oe/+DSKQkI5DnxFwzO10tb9j1Y/vaEahAltSch9
         8fzCQz47rAOHkwmA/XDfC9V76pEQ6LgY/JaG8QVwfGEmMpDZAzUkSBkg373as7lf68uK
         bcfWs3wXyg2KM/PET6AugEivTL+qSn6sjSd/5HQs4BDma31C2Iz6I8/5r8MhfoLdKVtA
         Tygje62oDFkhP/2nwjv3lXq2Db0C/FXU1YlPKDbSpTVei1yYxY3w3ND2u2JUv+8B5R/d
         VMPDRwQH0a664qHJiMnirAJobQCMhsNBaM0hmesttMKPvVBcPtj+h3YAl5Y2rtHeyMzU
         X8QA==
X-Forwarded-Encrypted: i=1; AJvYcCUMJND9fQm9z4CkN9Btllro723lqlpqxn4Y2cRdAsEGxjlpfF+8shXDzGTa8PitjtlIIUeFUoJ4bhw3@vger.kernel.org, AJvYcCUwYhVtJEZ8zukXLxaAk8FyT3rYj+RSRPefMYO3hseUdabA3nRUTi3tmRy0cyClbte8X0sAwIBgvbefDTZS@vger.kernel.org, AJvYcCWSc0E7Zhtj3UL5OTK5lJ6PQSh/UHKyXukYBMFVLtVZUybt3NFjsnqGTTNazJRV8QtYmitJlpuhPx/Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj3fOydMv8PgjL51nymLdVhqpv/WBSjgtvZMgD6auIhgT13Bfk
	SuiOxpAeXyiwUb4XQU80w+w+brJZPT/+c1NzE5BN5S7SHtHww9f+
X-Gm-Gg: ASbGnctIPZN30yve8EoMLJyfMLRyCejbajAj/cVMVeijHcYvtwIxZO98OSgbzc1+2y1
	Uki7ytwgLT7H23ClESnBtc+CnHNn2as/8/qh0spFV0bCB0ZJz6KGSdaxiWjI/GouxKf2UyyxkwI
	/H8WjEKFqV5SlwayjzXE+WVTDtBnWt8BlvIUSgY6+8eCShWOc0ZRH1gRoGaqnKRg5urnus379X8
	iCattdhk3E5LzUzJHJnNisTXXFEQngDOw0edUgR/AUFMfmW5RPFE8QJSFgudAKZloEMAb/Xr5JL
	N1KwJc+sgfVpNQDTkmR5WQ33daBixFpq+TfAfg1jQ+DLErYQbG4brL/m4agP/5N1jhRUzL2VRN8
	wIrF6RZPvcoof
X-Google-Smtp-Source: AGHT+IF6zODT/i84+DNp6SO4b+Lw13NFf/JlJZ/uevRVuedzovwHaltzapTshb6oHMSGMFdNb3ECIQ==
X-Received: by 2002:a05:6000:240c:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39eaaebee70mr12268639f8f.36.1744707496220;
        Tue, 15 Apr 2025 01:58:16 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae977a7fsm13412451f8f.45.2025.04.15.01.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 01:58:15 -0700 (PDT)
Message-ID: <4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
Subject: Re: [PATCH v2 13/13] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Apr 2025 09:58:17 +0100
In-Reply-To: <20250411123627.6114-14-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
	 <20250411123627.6114-14-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Antoniu,

I still have doubts regarding the new backend API mostly because it's still
unclear how it should all work. I had some questions in the first version o=
f the
series that were not clarified so I'll likely repeat myself... Please don't=
 rush
into a v3 without having this sorted out.

Anyways, see below...
=20
On Fri, 2025-04-11 at 15:36 +0300, Antoniu Miclaus wrote:
> Add support for AD4080 high-speed, low noise, low distortion,
> 20-bit, Easy Drive, successive approximation register (SAR)
> analog-to-digital converter (ADC).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
> =C2=A0- set num_lanes during probe.
> =C2=A0- rename bitslitp to iio_backend_data_alignment_enable
> =C2=A0- do ad4080_lvds_sync_write only once during probe.
> =C2=A0- use ETIMEDOUT
> =C2=A0- rename to `cnv` instead of `adc-clk`
> =C2=A0- update Kconfig help section
> =C2=A0- drop extra blank line.
> =C2=A0- replace `/**` with `/*` for comments
> =C2=A0- drop redundant return 0.
> =C2=A0- use `dev_dbg` during while(--timeout) procedure
> =C2=A0- use while (--timeout && !sync_en)
> =C2=A0- return -ETIME where applicable and check missing return codes.
> =C2=A0- regmap_update_bits used where applicable
> =C2=A0- use defines instead of GENMASK inline.
> =C2=A0- return FIELD_GET()
> =C2=A0- st->filter_enabled =3D mode and dropping the if else statement.
> =C2=A0- remove redundant brackets.
> =C2=A0- use OVERSAMPLING_RATIO attribute and drop custom ABI for it
> =C2=A0- use already existing filter_type attribute
> =C2=A0- fix indentation
> =C2=A0- remove comma on 'terminators'
> =C2=A0- use dev_err_probe instead of dev_err
> =C2=A0- check missing return values.
> =C2=A0- rework num_lanes property parse.
> =C2=A0- keep ad4080_chip_info since the driver will be extended for more =
parts
> =C2=A0=C2=A0 in the future (also stated in cover letter).
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 14 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4080.c | 653 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 668 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4080.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..17df328f5322 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -47,6 +47,20 @@ config AD4030
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad4030.
> =C2=A0
> +config AD4080
> +	tristate "Analog Devices AD4080 high speed ADC"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4080
> +	=C2=A0 high speed, low noise, low distortion, 20-bit, Easy Drive,
> +	=C2=A0 successive approximation register (SAR) analog-to-digital
> +	=C2=A0 converter (ADC). Supports iio_backended devices for AD4080.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad4080.
> +
> =C2=A0config AD4130
> =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9f26d5eca822..e6efed5b4e7a 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4030) +=3D ad4030.o
> +obj-$(CONFIG_AD4080) +=3D ad4080.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> =C2=A0obj-$(CONFIG_AD4851) +=3D ad4851.o
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> new file mode 100644
> index 000000000000..3a0b1ad13765
> --- /dev/null
> +++ b/drivers/iio/adc/ad4080.c
> @@ -0,0 +1,653 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4080 SPI ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
>=20

...

> +static int ad4080_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long m)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	int dec_rate;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4080_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (st->filter_type =3D=3D SINC_5_COMP)
> +			dec_rate =3D st->dec_rate * 2;
> +		else
> +			dec_rate =3D st->dec_rate;
> +		if (st->filter_en)
> +			*val =3D DIV_ROUND_CLOSEST(clk_get_rate(st->clk),
> dec_rate);
> +		else
> +			*val =3D clk_get_rate(st->clk);

Are we expecting the clock rate to change at runtime. Typically, we can jus=
t
cache the rate during probe and do it "dynamically" if we ever need it.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D ad4080_get_dec_rate(indio_dev, chan);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4080_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4080_lvds_sync_write(struct ad4080_state *st)
> +{

This whole function seems to depend on using the LVDS signal for cnv. Why? =
If we
have CMOS don't we also need some kind of interface alignment/calibration? =
If
not, that's sensible enough that should be stated in a comment.

> +	unsigned int timeout =3D 100;
> +	bool sync_en;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +	if (st->num_lanes =3D=3D 1)
> +		ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +				=C2=A0=C2=A0 AD4080_INTF_CHK_EN_MSK);
> +	else
> +		ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +				=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +				=C2=A0=C2=A0 AD4080_INTF_CHK_EN_MSK |
> +				=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_data_alignment_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		ret =3D iio_backend_sync_status_get(st->back, &sync_en);
> +		if (ret)
> +			return ret;
> +
> +		if (!sync_en)
> +			dev_dbg(&st->spi->dev, "Not Locked: Running Bit
> Slip\n");
> +	} while (--timeout && !sync_en);
> +
> +	if (timeout) {
> +		dev_info(&st->spi->dev, "Success: Pattern correct and
> Locked!\n");
> +		if (st->num_lanes =3D=3D 1)
> +			return regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> +		else
> +			return regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +					=C2=A0=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> +	} else {
> +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> +		if (st->num_lanes =3D=3D 1) {
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret =3D regmap_write(st->regmap,
> AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> +					=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> +					=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return -ETIMEDOUT;

So, first the things that I don't really get (also the hdl docs need to be
improved FWIW):

* It seems that we can have data alignment or data capture synchronization
through an internal AMD FPGA technique called bit-slip or an external signa=
l,
right? In here, it seems that we only use bit-slip and never disable it. Is=
 that
really the goal?

* This whole process seems to be some kind of calibration at the interface
level, right?

* What's the point of the conv clock? Is it only used to get the sample rat=
e? If
so, the hdl docs are misleading as it seems that it can be used instead of =
bit-
slip for data capture alignment?

Now, speaking about the backend API's, it looks like that
iio_backend_self_sync_enable() and iio_backend_data_alignment_enable() coul=
d be
merged into one API. From what I can tell, iio_backend_data_alignment_enabl=
e()
just enables the bit-slip process but that likely does nothing unless the
SELF_SYNC bit is also set to bit-slip, right? In fact, we could think about=
 a
more generic (less flexible though) API like:

* iio_backend_intf_data_align(back, timeout_us), or
* iio_backend_intf_calib(back, timeout_us), or
* iio_backend_intf_data_capture_sync(back, timeout_us)

On the backend side, you could then enable bit-slip and do the status read =
(with
timeout) and return success or an error code.

The above seems to be pretty much what you're doing but in just one API tha=
t
makes sense to me.

Of course that the following questions still come to mind:

* Do we need to disable bit-slip after we're done (still fits into the one =
API
model)?
* Do we need a meaningful API to change between the syncing/alignment metho=
ds?
External signal vs bit-slip?

The above is key to better think of an API. Right now it feels that you're =
just
adding an API for every bit you want to control in this process...

If we end up needing more flexibility for this, we can also consider the
existing iio_backend_data_sample_trigger() API. I know is abusing a bit and=
 a
stretch but in the end of the day the whole thing is related with aligning,
syncing, calibrating the interface for properly sampling data. Even bit-sli=
p
(while not a traditional external trigger) looks like some kind of self-
adjusting, data-driven trigger mechanism to establish the correct starting =
point
for capturing data. So having two new enums like:

IIO_BACKEND_SAMPLE_TRIGGER_EXT_SIGNAL,
IIO_BACKEND_SAMPLE_TRIGGER_BIT_SLIP // or maybe a more generic name like
s/BIT_SLIP/INTERNAL

I do not think the above is that horrible :P... But I would really like to =
get
more opinions about this.

> +	}
> +}

...

>=20
> +static const struct ad4080_chip_info ad4080_chip_info =3D {
> +	.name =3D "AD4080",
> +	.product_id =3D AD4080_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D ad4080_channels,
> +};
> +
> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st =3D iio_priv(indio_dev);
> +	unsigned int id;
> +	int ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4080_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4080_SDO_ENABLE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id !=3D AD4080_CHIP_ID)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unrecognized CHIP_ID 0x%X\n", id);
> +
> +	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_GPO_1_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
> +			=C2=A0=C2=A0 FIELD_PREP(AD4080_GPIO_1_SEL, 3));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_num_lanes_set(st->back, st->num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_backend_self_sync_enable(st->back);
> +	if (ret)
> +		return ret;
> +

AFAIU, the above is enabling bit-slip?
=20
> +	if (st->lvds_cnv_en) {
> +		if (st->num_lanes) {
> +			ret =3D regmap_update_bits(st->regmap,
> +					=09
> AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +						 AD4080_LVDS_CNV_CLK_CNT_MSK,
> +					=09
> FIELD_PREP(AD4080_LVDS_CNV_CLK_CNT_MSK, 7));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret =3D regmap_set_bits(st->regmap,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4080_LVDS_CNV_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		return ad4080_lvds_sync_write(st);
> +	}
> +
> +	return 0;
> +}
> +
> +static void ad4080_properties_parse(struct ad4080_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	st->lvds_cnv_en =3D device_property_read_bool(&st->spi->dev,
> +						=C2=A0=C2=A0=C2=A0 "adi,lvds-cnv-enable");
> +

nit: I would probably drop the enable part. The property is about stating t=
hat
the signal is LVDS instead of CMOS. And IIUC, this should also depend on th=
e
existence of `st->clk`
=20
> +	st->num_lanes =3D 1;
> +	ret =3D device_property_read_u32(&st->spi->dev, "adi,num_lanes", &val);
> +	if (!ret)
> +		st->num_lanes =3D val;
> +}
> +
> +static int ad4080_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev =3D &spi->dev;
> +	struct ad4080_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad4080_power_supplies),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad4080_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable supplies\n");
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +

The above is duplicated...

> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->info =3D &ad4080_iio_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ad4080_properties_parse(st);
> +
> +	st->clk =3D devm_clk_get_enabled(&spi->dev, "cnv");
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);
> +

From the datasheet it looks like this clock is optional? Moreover in the IP=
 docs
we have the following:


"SELF_SYNC: Controls if the data capture synchronization is done through CN=
V
signal or bit-slip."

So I wonder, is the cnv clock meaning that we want to have capture
sync/alignment through that external signal instead of bit-slip?

- Nuno S=C3=A1

