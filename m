Return-Path: <linux-iio+bounces-27877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C0D385DC
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B404300751F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09D3A1CFC;
	Fri, 16 Jan 2026 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S76gOrZ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95436A036;
	Fri, 16 Jan 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591766; cv=none; b=kNS/Zgd7GqlTlmOru2I9WBHmz7DrJfw+yjG0Q7mRp7q7k/JsnKPTbEMTTrTpZ0c4beqUmRci0evPf6xJXUNxH/cOgMd9hsRiTWJcDvAFXlCHxnEqRCS1hzDia4EdG849/YNxmiheJg5cf+6hbDC9gHPbk9iybqEEXza+e+QBF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591766; c=relaxed/simple;
	bh=JUdVGwrQBP70IPOM3GRt0sUXKorpEx+rLp6QE6NzE0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2T8woGvBBpqa1lGMzYA7dPRcr5DNywcYT1ZbVhO2zAItJOAa5ox2FnfdAHPDh/MAR7YhUutp6hG0EcJe4yUuCue9FTDcaBsbaImqeOetdBkvu4NXW5xs8H1rquV+QGT4Oex813u2Qd9eIAS+La/v5iKcUlWqJKkS5jOn/yakIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S76gOrZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3529FC19422;
	Fri, 16 Jan 2026 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768591765;
	bh=JUdVGwrQBP70IPOM3GRt0sUXKorpEx+rLp6QE6NzE0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S76gOrZ5hRzdjbsaj/rvorPXATOW+BM9dLJz9vkYDwlnKlsIUZTF163fDPknrQkkM
	 BJgP5T9qLqnhUsDkMsPg/xOcAqopqP3hOwuHa8VDcU+kKZkKvvJlVbSh+SPMmEkizh
	 QMUCouPloCLUShqDiUndslKl3toYsYv6eBOYmR9oG62gPI5Lin9hrtCYyBBui1OiMp
	 XOK1MI8J5hSG+t9dKMiT3L2HWJHGZM9icRnsJOJ3sqzEDxELvU8wLfEtHaCveRzbsQ
	 he/HEa+shUU0Av4hVXDsWUuktOu53wlDGjCT215BaJz/di/SQ3mBQzLiLXM1LUyhcL
	 a/bI36/1y5/TQ==
Date: Fri, 16 Jan 2026 19:29:16 +0000
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
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <20260116192916.436d24c9@jic23-huawei>
In-Reply-To: <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
	<20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 14:32:22 +0000
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

A couple of additional comments for this version.

Thanks,

Jonathan

> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf=
41513.c
> new file mode 100644
> index 000000000000..9068c427d8e9
> --- /dev/null
> +++ b/drivers/iio/frequency/adf41513.c



> +
> +static int adf41513_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u64 phase_urad;
> +	u16 phase_val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_PHASE:
> +		phase_urad =3D (u64)val * MICRO + val2;
> +		if (val < 0 || val2 < 0 || phase_urad >=3D ADF41513_MAX_PHASE_MICRORAD)

Check val and val2 before setting phase_urad.  Whilst it's not a bug it
is a lot less readable to perform checks on inputs after you've already used
them to compute something.
		if (val < 0 || val2 < 0)
			return -EINVAL;

		phase_urad =3D ...
		if (phase_urad >=3D ...)
			return -EINVAL;

> +			return -EINVAL;
> +
> +		phase_val =3D DIV_U64_ROUND_CLOSEST(phase_urad << 12,
> +						  ADF41513_MAX_PHASE_MICRORAD);
> +		phase_val =3D min(phase_val, ADF41513_MAX_PHASE_VAL);
> +		st->regs[ADF41513_REG2] |=3D ADF41513_REG2_PHASE_ADJ_MSK;
> +		FIELD_MODIFY(ADF41513_REG2_PHASE_VAL_MSK,
> +			     &st->regs[ADF41513_REG2], phase_val);
> +		return adf41513_sync_config(st, ADF41513_SYNC_REG0);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int adf41513_parse_fw(struct adf41513_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +	u32 tmp, cp_resistance, cp_current;
> +
> +	/* power-up frequency */
> +	st->data.power_up_frequency_hz =3D ADF41510_MAX_RF_FREQ_HZ;
> +	ret =3D device_property_read_u32(dev, "adi,power-up-frequency-mhz", &tm=
p);
> +	if (!ret) {
Can easily do the same as below here  No precision issue given definition of
the _MAX_RF_FREQ_HZ value includes a larger power 10 multiplier.
=09
	tmp =3D ADF41510_MAX_RF_FREQ_HZ / HZ_PER_MHZ;
	device_property_read_u32(dev, "adi,power-up-frequency-mhz", &tmp;
	st->data.power_up_frequency_hz =3D (u64)tmp * HZ_PER_MHZ;
	if (st...

or use a local u64 for a temporary you only assign to power_up_frequency_hz
after checks. That would be more consistent with the code that follows.

> +		st->data.power_up_frequency_hz =3D (u64)tmp * HZ_PER_MHZ;
> +		if (st->data.power_up_frequency_hz < ADF41513_MIN_RF_FREQ_HZ ||
> +		    st->data.power_up_frequency_hz > ADF41513_MAX_RF_FREQ_HZ)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "power-up frequency %llu Hz out of range\n",
> +					     st->data.power_up_frequency_hz);
> +	}
> +
> +	tmp =3D ADF41513_MIN_R_CNT;
> +	device_property_read_u32(dev, "adi,reference-div-factor", &tmp);
> +	if (tmp < ADF41513_MIN_R_CNT || tmp > ADF41513_MAX_R_CNT)
> +		return dev_err_probe(dev, -ERANGE,
> +				     "invalid reference div factor %u\n", tmp);
> +	st->data.ref_div_factor =3D tmp;
> +
> +	st->data.ref_doubler_en =3D device_property_read_bool(dev, "adi,referen=
ce-doubler-enable");
> +	st->data.ref_div2_en =3D device_property_read_bool(dev, "adi,reference-=
div2-enable");
> +
> +	cp_resistance =3D ADF41513_DEFAULT_R_SET;
> +	device_property_read_u32(dev, "adi,charge-pump-resistor-ohms", &cp_resi=
stance);
> +	if (cp_resistance < ADF41513_MIN_R_SET || cp_resistance > ADF41513_MAX_=
R_SET)
> +		return dev_err_probe(dev, -ERANGE, "R_SET %u Ohms out of range\n", cp_=
resistance);
> +
> +	st->data.charge_pump_voltage_mv =3D ADF41513_DEFAULT_CP_VOLTAGE_mV;

This leaves some odd corner cases.
If DT defines cp_resistance but not cp_current then we ignore the cp_resita=
nce.
If you want to insist it is either both or nothing, that needs enforcing in=
 the dt-binding.
I think I slightly prefer this option..

Alternative is define a default current such that the maths works to give t=
he DEFAULT_CP_VOLTAGE_mV
if both properties use defaults and use that here + document in the dt-bind=
ing as the default
for this property.   That may mean if only one property is set we reject th=
e pair and fail
to probe.  You have comment about valid combinations in the dt-binding so t=
hat's fine.
=20
> +	ret =3D device_property_read_u32(dev, "adi,charge-pump-current-microamp=
", &cp_current);
> +	if (!ret) {
> +		tmp =3D DIV_ROUND_CLOSEST(cp_current * cp_resistance, MILLI); /* conve=
rt to mV */
> +		if (tmp < ADF41513_MIN_CP_VOLTAGE_mV || tmp > ADF41513_MAX_CP_VOLTAGE_=
mV)
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
> +	tmp =3D ADF41513_LD_COUNT_MIN;
> +	device_property_read_u32(dev, "adi,lock-detector-count", &tmp);
> +	if (tmp < ADF41513_LD_COUNT_FAST_MIN || tmp > ADF41513_LD_COUNT_MAX ||
> +	    !is_power_of_2(tmp))
> +		return dev_err_probe(dev, -ERANGE,
> +				     "invalid lock detect count: %u\n", tmp);
> +	st->data.lock_detect_count =3D tmp;
> +
> +	st->data.freq_resolution_uhz =3D MICROHZ_PER_HZ;
> +
> +	return 0;
> +}


