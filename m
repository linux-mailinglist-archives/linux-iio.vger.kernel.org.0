Return-Path: <linux-iio+bounces-27616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E7D0F005
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA7A300C6C8
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6090533B6C6;
	Sun, 11 Jan 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfNpudni"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150EB500940;
	Sun, 11 Jan 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768139644; cv=none; b=qBKYRU4Z0Ovlt/GSkpNAt5teioTkxLjwcqD+Cq6LDFiJ7Jqmp8Q/DaCvgWS5G+aIu14pM9FyvNX5APB+wEmj9qT8yk00An/9iS08xpiJXT0zltsr0UuTkIr4s0hkhX21m7kDU6VwVeN7JXXYM+KWYQlAQr02BmiFftlwB7mYKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768139644; c=relaxed/simple;
	bh=oMa5cMqCzCtN84qkf4MMO1xXRt1FwvzJFvBHfEVhMTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/D/BZgQ9cnwzSFNNxeDfQk/R2OtCkicfuZ2s90XTkzYXgj0yCanQo+W751TPBOTCZ1YcpUjC8yeG4abB+y3gIJ3bJmIXI46ya9mI1h9NHLA6jB3SbSFmeDdRxk/aG+YJIkbFTcjeXAqnTLLPNTRFwGVbDIKB6wMcANXlwfyIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfNpudni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AF4C4CEF7;
	Sun, 11 Jan 2026 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768139643;
	bh=oMa5cMqCzCtN84qkf4MMO1xXRt1FwvzJFvBHfEVhMTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfNpudniHUZ/Y7JqeA5bUDSFnQRtPmM4K62dAdpbgXFzRlFHILdwBzXCAkeyRKWuq
	 YO6eWRXxW9Xm0LwjyCEZ7AFSEXh84JlgZFyjzbzsTZ8iGMSrIZwCQZ1phoXrz8E/if
	 K7Dxz7dOqU79BYbtfAmsH31pg+fQCCYdAmBFEXkMJaOy+AnBLDhOMC/OFhX67VDt8j
	 B1QDFJTOeJrn3HUeg/HBZY/1CRHKe1B3tsntV4maOmTWdkh9i7i/tQWxzWJwQBFRF8
	 rRH+M9gdcSwLDOY0/fe97gyHWypmY1pxlv+6+pK06xWWg9JJZe1UcaH6C36oG9fot1
	 ngTb5bX3a0PBw==
Date: Sun, 11 Jan 2026 13:53:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <20260111135352.5f37bb51@jic23-huawei>
In-Reply-To: <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
	<20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Jan 2026 12:14:51 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> The driver is based on existing PLL drivers in the IIO subsystem and
> implements the following key features:
>=20
> - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> - High-resolution frequency calculations using microhertz (=C2=B5Hz) prec=
ision
>   to handle sub-Hz resolution across multi-GHz frequency ranges
> - IIO debugfs interface for direct register access
> - FW property parsing from devicetree including charge pump settings,
>   reference path configuration and muxout options
> - Power management support with suspend/resume callbacks
> - Lock detect GPIO monitoring
>=20
> The driver uses 64-bit microhertz values throughout PLL calculations to
> maintain precision when working with frequencies that exceed 32-bit Hz
> representation while requiring fractional Hz resolution.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo,

Just one significant point (though it's repeated a few times!).
I think you can simplify the firmware parsing code by changing how you
set the defaults.  That should both make it more readable and make
it more obvious that the necessary checks have parsed when you have
a mixture of default and values from DT.

thanks,

Jonathan

> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf=
41513.c
> new file mode 100644
> index 000000000000..69dcbbc1f393
> --- /dev/null
> +++ b/drivers/iio/frequency/adf41513.c
...

> +
> +static ssize_t adf41513_read_uhz(struct iio_dev *indio_dev,
> +				 uintptr_t private,
> +				 const struct iio_chan_spec *chan,
> +				 char *buf)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u64 freq_uhz;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {
> +	case ADF41513_FREQ:
> +		freq_uhz =3D adf41513_pll_get_rate(st);
> +		if (st->lock_detect)
> +			if (!gpiod_get_value_cansleep(st->lock_detect)) {
Trivial, ignore if you like:

Might as well combine the conditions
		if (st->lock_detect &&
		    !gpio_get_value_can_sleep(st->lock_detect)) {
		}
given the first is just a check on whether the second makes sense or not.

> +				dev_dbg(&st->spi->dev, "PLL un-locked\n");
> +				return -EBUSY;
> +			}
> +		break;

> +
> +static int adf41513_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int writeval,
> +			       unsigned int *readval)

static int adf41513_reg_access(struct iio_dev *indio_dev, unsigned int reg,
			       unsigned int writeval, unsigned int *readval)

would be fine for wrap here and save us a few lines of scrolling.

> +
> +static int adf41513_parse_fw(struct adf41513_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +	u32 tmp, cp_resistance, cp_current;
> +
> +	/* power-up frequency */
> +	st->data.power_up_frequency_hz =3D ADF41510_MAX_RF_FREQ;
> +	ret =3D device_property_read_u32(dev, "adi,power-up-frequency-mhz", &tm=
p);
> +	if (!ret) {
> +		st->data.power_up_frequency_hz =3D (u64)tmp * HZ_PER_MHZ;
> +		if (st->data.power_up_frequency_hz < ADF41513_MIN_RF_FREQ ||
> +		    st->data.power_up_frequency_hz > ADF41513_MAX_RF_FREQ)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "power-up frequency %llu Hz out of range\n",
> +					     st->data.power_up_frequency_hz);
> +	}
> +
> +	st->data.ref_div_factor =3D ADF41513_MIN_R_CNT;
Small thing, but for all of these, if you instead set the temporary variable
to whatever is the DT default (not the register value it maps to) then the =
handling
ends up simpler.  We don't care if we have to do a small amount of unnecess=
ary maths
if the default is used.

	tmp =3D ADF41513_MIN_R_CNT;
	device_property_read_u32(dev, "adi,....", &tmp);
	if (tmp < ......)
		return dev_err_probe();

	st->data.ref_div_factor =3D tmp;

etc.  If you want to check ret for the explicit return value that means no =
property
then that's fine too but I've always been a bit relaxed on these.


> +	ret =3D device_property_read_u32(dev, "adi,reference-div-factor", &tmp);
> +	if (!ret) {
> +		if (tmp < ADF41513_MIN_R_CNT || tmp > ADF41513_MAX_R_CNT)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "invalid reference div factor %u\n", tmp);
> +		st->data.ref_div_factor =3D tmp;
> +	}
> +
> +	st->data.ref_doubler_en =3D device_property_read_bool(dev, "adi,referen=
ce-doubler-enable");
> +	st->data.ref_div2_en =3D device_property_read_bool(dev, "adi,reference-=
div2-enable");
> +
> +	cp_resistance =3D ADF41513_DEFAULT_R_SET;
> +	ret =3D device_property_read_u32(dev, "adi,charge-pump-resistor-ohms", =
&cp_resistance);
> +	if (!ret && (cp_resistance < ADF41513_MIN_R_SET || cp_resistance > ADF4=
1513_MAX_R_SET))

Don't need the if (!ret) bit, as the default will pass the other tests.

> +		return dev_err_probe(dev, -ERANGE, "R_SET %u Ohms out of range\n", cp_=
resistance);
> +
> +	st->data.charge_pump_voltage_mv =3D ADF41513_DEFAULT_CP_VOLTAGE_mV;
> +	ret =3D device_property_read_u32(dev, "adi,charge-pump-current-microamp=
", &cp_current);
> +	if (!ret) {
> +		tmp =3D DIV_ROUND_CLOSEST(cp_current * cp_resistance, MILLI); /* conve=
rt to mV */
> +		if (tmp < ADF41513_MIN_CP_VOLTAGE_mV || tmp > ADF41513_MAX_CP_VOLTAGE_=
mV)
One advantage of the suggested approach above is that we don't have to think
carefully on whether the default here * a custom value for cp_resistance wo=
uld fail this
test because we check that explicitly.

> +			return dev_err_probe(dev, -ERANGE, "I_CP %u uA (%u Ohms) out of range=
\n",
> +					     cp_current, cp_resistance);
> +		st->data.charge_pump_voltage_mv =3D tmp;
> +	}
> +
> +	st->data.phase_detector_polarity =3D
> +		device_property_read_bool(dev, "adi,phase-detector-polarity-positive-e=
nable");
> +
> +	st->data.logic_lvl_1v8_en =3D device_property_read_bool(dev, "adi,logic=
-level-1v8-enable");
> +
> +	st->data.lock_detect_count =3D ADF41513_LD_COUNT_MIN;
> +	ret =3D device_property_read_u32(dev, "adi,lock-detector-count", &tmp);
> +	if (!ret) {
> +		if (tmp < ADF41513_LD_COUNT_FAST_MIN || tmp > ADF41513_LD_COUNT_MAX ||
> +		    !is_power_of_2(tmp))
> +			return dev_err_probe(dev, -ERANGE,
> +					     "invalid lock detect count: %u\n", tmp);
> +		st->data.lock_detect_count =3D tmp;
> +	}
> +
> +	st->data.freq_resolution_uhz =3D MICROHZ_PER_HZ;
> +
> +	return 0;
> +}

