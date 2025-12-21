Return-Path: <linux-iio+bounces-27277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49356CD4374
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E743007C5F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF01F302756;
	Sun, 21 Dec 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQoOPr/3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D759277035;
	Sun, 21 Dec 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766339353; cv=none; b=Pqh1tZzeb0TsYHI/T+6DDUp3fUGgK8Iuw1wUgNCjuW26i843szSFqKHX7nmUINKuSrFhr8tLc7DwHB/MLrQQ5Di3sgP3INz21AoSsInhKXzAqkjBps5DSuJ4fLs7Xd2z3R0+4pQ2qZMe387FhZcr6LgKTLzU2JVbIZsHqyxvK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766339353; c=relaxed/simple;
	bh=m3P07QW/VRtk5wZBhOLB4eqY0vMn5gH6JBShlm+2Kgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0fvaOb2WLlWYoS34ZGDWp43UxYsax5oF+T5R8dRmg8TIQhjtBInq+b1LhrEIFVy9XJHX2XRh73Yekn9UPOxotKoAOypEQG4tyel3L+eFqulSBcG0U6MsdsVt4X29u0PkmTXmluAMjQHsvrPe7P8RJ3rUn+/0vnLMqvmz/Ge9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQoOPr/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04AC4CEFB;
	Sun, 21 Dec 2025 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766339353;
	bh=m3P07QW/VRtk5wZBhOLB4eqY0vMn5gH6JBShlm+2Kgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQoOPr/34pqNlw8vTzMUU4Tpe3RoVKluYWKJGIYJ5bvxjVmFT4Dk8pDe7lCxkPs8t
	 O7AxOmuXW+dL3Wmi1hMGSv0azMAOgIFrv6XjnGgxM1gcKWPSOte555QmlKS1/E6k1w
	 Gyj8ozdHKtXNb0YZukRUtDw4X0+fyAVfzaU/6ERk6G0GW5QyhrG1JuQpZPURKzU9CO
	 DmADmbgIWCK+Y650kOTg7VCS02xvgO/OQ1ItSWhtR0qlGklwFG0W8hYqxaBa8sRx+3
	 aduBhYdQXyW+0s1UgAO1fZLZkTjxDcPU+QPH2n6fy4dCcITFE8DJ0JJbIKxmGNLtBb
	 XtFpKdQrAOZXg==
Date: Sun, 21 Dec 2025 17:49:02 +0000
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
Subject: Re: [PATCH v2 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <20251221174902.7ebb9e74@jic23-huawei>
In-Reply-To: <20251219-adf41513-iio-driver-v2-2-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-2-be29a83d5793@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 12:34:49 +0000
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

Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf=
41513.c
> new file mode 100644
> index 000000000000..a967dc4479e7
> --- /dev/null
> +++ b/drivers/iio/frequency/adf41513.c


> +
> +static int adf41513_sync_config(struct adf41513_state *st, u16 sync_mask)
> +{
> +	int ret;
> +	int i;
> +
> +	/* write registers in reverse order (R13 to R0)*/
> +	for (i =3D ADF41513_REG13; i >=3D ADF41513_REG0; i--) {
> +		if (st->regs_hw[i] !=3D st->regs[i] || sync_mask & BIT(i)) {
For code cases like this where you want to only do something if a condition=
 is matched
it can be neater to invert the condition.  e.g.

		if (st->regs_hw[i] =3D=3D st->regs[i] && !(sync_mask & BIT(i)))
			continue;

		st->buf =3D cpu...

> +			st->buf =3D cpu_to_be32(st->regs[i] | i);
> +			ret =3D spi_write(st->spi, &st->buf, sizeof(st->buf));
> +			if (ret < 0)
> +				return ret;
> +			st->regs_hw[i] =3D st->regs[i];
> +			dev_dbg(&st->spi->dev, "REG%d <=3D 0x%08X\n", i, st->regs[i] | i);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static u64 adf41513_pll_get_rate(struct adf41513_state *st)
> +{
> +	struct adf41513_pll_settings *cfg =3D &st->settings;
> +
> +	if (cfg->mode !=3D ADF41513_MODE_INVALID)
> +		return cfg->actual_frequency_uhz;
> +
> +	/* get pll settings from regs_hw */
> +	cfg->int_value =3D FIELD_GET(ADF41513_REG0_INT_MSK,
> +				   st->regs_hw[ADF41513_REG0]);
> +	cfg->frac1 =3D FIELD_GET(ADF41513_REG1_FRAC1_MSK,
> +			       st->regs_hw[ADF41513_REG1]);
> +	cfg->frac2 =3D FIELD_GET(ADF41513_REG3_FRAC2_MSK,
> +			       st->regs_hw[ADF41513_REG3]);
> +	cfg->mod2 =3D FIELD_GET(ADF41513_REG4_MOD2_MSK,
> +			      st->regs_hw[ADF41513_REG4]);
> +	cfg->r_counter =3D FIELD_GET(ADF41513_REG5_R_CNT_MSK,
> +				   st->regs_hw[ADF41513_REG5]);
> +	cfg->ref_doubler =3D FIELD_GET(ADF41513_REG5_REF_DOUBLER_MSK,
> +				     st->regs_hw[ADF41513_REG5]);
> +	cfg->ref_div2 =3D FIELD_GET(ADF41513_REG5_RDIV2_MSK,
> +				  st->regs_hw[ADF41513_REG5]);
> +	cfg->prescaler =3D FIELD_GET(ADF41513_REG5_PRESCALER_MSK,
> +				   st->regs_hw[ADF41513_REG5]);
For cases like this I think keeping to 80 chars is hurting readability
and so it is fine to go a little higher.=20
	cfg->int_value =3D FIELD_GET(ADF41513_REG0_INT_MSK, st->regs_hw[ADF41513_R=
EG0]);
	cfg->frac1 =3D FIELD_GET(ADF41513_REG1_FRAC1_MSK, st->regs_hw[ADF41513_REG=
1]);
	cfg->frac2 =3D FIELD_GET(ADF41513_REG3_FRAC2_MSK, st->regs_hw[ADF41513_REG=
3]);
	cfg->mod2 =3D FIELD_GET(ADF41513_REG4_MOD2_MSK, st->regs_hw[ADF41513_REG4]=
);
	cfg->r_counter =3D FIELD_GET(ADF41513_REG5_R_CNT_MSK, st->regs_hw[ADF41513=
_REG5]);
	cfg->ref_doubler =3D FIELD_GET(ADF41513_REG5_REF_DOUBLER_MSK, st->regs_hw[=
ADF41513_REG5]);
	cfg->ref_div2 =3D FIELD_GET(ADF41513_REG5_RDIV2_MSK, st->regs_hw[ADF41513_=
REG5]);
	cfg->prescaler =3D FIELD_GET(ADF41513_REG5_PRESCALER_MSK,st->regs_hw[ADF41=
513_REG5]);
Is fine here. I'd also be fine with wrapping the ref_doubler line as it's r=
ather
longer than the others.

> +
> +	/* calculate pfd frequency */
> +	cfg->pfd_frequency_uhz =3D st->ref_freq_hz * MICROHZ_PER_HZ;
> +	if (cfg->ref_doubler)
> +		cfg->pfd_frequency_uhz <<=3D 1;
> +	if (cfg->ref_div2)
> +		cfg->pfd_frequency_uhz >>=3D 1;
> +	cfg->pfd_frequency_uhz =3D div_u64(cfg->pfd_frequency_uhz,
> +					 cfg->r_counter);
> +	cfg->actual_frequency_uhz =3D (u64)cfg->int_value * cfg->pfd_frequency_=
uhz;
> +
> +	/* check if int mode is selected */
> +	if (FIELD_GET(ADF41513_REG6_INT_MODE_MSK, st->regs_hw[ADF41513_REG6])) {
> +		cfg->mode =3D ADF41513_MODE_INTEGER_N;
> +	} else {
> +		cfg->actual_frequency_uhz +=3D mul_u64_u64_div_u64(cfg->frac1,
> +								 cfg->pfd_frequency_uhz,
> +								 ADF41513_FIXED_MODULUS);
> +
> +		/* check if variable modulus is selected */
> +		if (FIELD_GET(ADF41513_REG0_VAR_MOD_MSK, st->regs_hw[ADF41513_REG0])) {
> +			cfg->actual_frequency_uhz +=3D
> +				mul_u64_u64_div_u64(cfg->frac2,
> +						    cfg->pfd_frequency_uhz,
> +						    ADF41513_FIXED_MODULUS * cfg->mod2);
> +
> +			cfg->mode =3D ADF41513_MODE_VARIABLE_MODULUS;
> +		} else {
> +			/* LSB_P1 offset */
> +			if (!FIELD_GET(ADF41513_REG5_LSB_P1_MSK, st->regs_hw[ADF41513_REG5]))
> +				cfg->actual_frequency_uhz +=3D
> +					div_u64(cfg->pfd_frequency_uhz,
> +						ADF41513_FIXED_MODULUS * 2);
> +			cfg->mode =3D ADF41513_MODE_FIXED_MODULUS;
> +		}
> +	}
> +
> +	cfg->target_frequency_uhz =3D cfg->actual_frequency_uhz;
> +
> +	return cfg->actual_frequency_uhz;
> +}


> +static int adf41513_calc_pll_settings(struct adf41513_state *st,
> +				      struct adf41513_pll_settings *result,
> +				      u64 rf_out_uhz)
> +{
> +	u64 max_rf_freq_uhz =3D st->chip_info->max_rf_freq_hz * MICROHZ_PER_HZ;
> +	u64 min_rf_freq_uhz =3D ADF41513_MIN_RF_FREQ * MICROHZ_PER_HZ;
> +	u64 pfd_freq_limit_uhz;
> +	int ret;
> +
> +	/* input validation */

That's obvious.  No need to have the comment.

> +	if (rf_out_uhz < min_rf_freq_uhz || rf_out_uhz > max_rf_freq_uhz) {
> +		dev_err(&st->spi->dev, "RF frequency %llu uHz out of range [%llu, %llu=
] uHz\n",
> +			rf_out_uhz, min_rf_freq_uhz, max_rf_freq_uhz);
> +		return -EINVAL;
> +	}
> +
> +	result->target_frequency_uhz =3D rf_out_uhz;
> +
> +	/* try integer-N first (best phase noise performance) */
> +	pfd_freq_limit_uhz =3D min(div_u64(rf_out_uhz, ADF41513_MIN_INT_4_5),
> +				 ADF41513_MAX_PFD_FREQ_INT_N_UHZ);
> +	ret =3D adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D adf41513_calc_integer_n(st, result);
> +	if (ret < 0) {
> +		/* try fractional-N: recompute pfd frequency if necessary */
> +		pfd_freq_limit_uhz =3D min(div_u64(rf_out_uhz, ADF41513_MIN_INT_FRAC_4=
_5),
> +					 ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ);
> +		if (pfd_freq_limit_uhz < result->pfd_frequency_uhz) {
> +			ret =3D adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		/* fixed-modulus attempt */
> +		ret =3D adf41513_calc_fixed_mod(st, result);
> +		if (ret < 0) {
> +			/* variable-modulus attempt */
> +			ret =3D adf41513_calc_variable_mod(st, result);
> +			if (ret < 0) {
> +				dev_err(&st->spi->dev,
> +					"no valid PLL configuration found for %llu uHz\n",
> +					rf_out_uhz);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int adf41513_set_frequency(struct adf41513_state *st, u64 freq_uh=
z, u16 sync_mask)
> +{
> +	struct adf41513_pll_settings result;
> +	int ret;
> +
> +	/* calculate pll settings candidate */
> +	ret =3D adf41513_calc_pll_settings(st, &result, freq_uhz);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* apply computed results to pll settings */
> +	memcpy(&st->settings, &result, sizeof(struct adf41513_pll_settings));

sizeof(st->settings)

> +
> +	dev_dbg(&st->spi->dev,
> +		"%s mode: int=3D%u, frac1=3D%u, frac2=3D%u, mod2=3D%u, fpdf=3D%llu Hz,=
 prescaler=3D%s\n",
> +		(result.mode =3D=3D ADF41513_MODE_INTEGER_N) ? "integer-n" :
> +		(result.mode =3D=3D ADF41513_MODE_FIXED_MODULUS) ? "fixed-modulus" : "=
variable-modulus",
> +		result.int_value, result.frac1, result.frac2, result.mod2,
> +		div64_u64(result.pfd_frequency_uhz, MICROHZ_PER_HZ),
> +		result.prescaler ? "8/9" : "4/5");
> +
> +	/* int */
> +	st->regs[ADF41513_REG0] =3D FIELD_PREP(ADF41513_REG0_INT_MSK,
> +					     st->settings.int_value);
> +	if (st->settings.mode =3D=3D ADF41513_MODE_VARIABLE_MODULUS)
> +		st->regs[ADF41513_REG0] |=3D ADF41513_REG0_VAR_MOD_MSK;
> +	/* frac1 */
> +	st->regs[ADF41513_REG1] =3D FIELD_PREP(ADF41513_REG1_FRAC1_MSK,
> +					     st->settings.frac1);
> +	if (st->settings.mode !=3D ADF41513_MODE_INTEGER_N)
> +		st->regs[ADF41513_REG1] |=3D ADF41513_REG1_DITHER2_MSK;
> +
> +	/* frac2 */

Where the field name makes it obvious there is little point in
adding a comment to say the same thing. I'd clear out most if not all
of these. Stick to comments that add significant value.

> +	st->regs[ADF41513_REG3] =3D FIELD_PREP(ADF41513_REG3_FRAC2_MSK,
> +					     st->settings.frac2);
> +	/* mod2 */
> +	st->regs[ADF41513_REG4] &=3D ADF41513_REG4_MOD2_MSK;
> +	st->regs[ADF41513_REG4] |=3D FIELD_PREP(ADF41513_REG4_MOD2_MSK,
> +					      st->settings.mod2);
> +
> +	/* r-cnt | doubler | rdiv2 | prescaler */
> +	st->regs[ADF41513_REG5] &=3D ~(ADF41513_REG5_R_CNT_MSK |
> +				     ADF41513_REG5_REF_DOUBLER_MSK |
> +				     ADF41513_REG5_RDIV2_MSK |
> +				     ADF41513_REG5_PRESCALER_MSK);
> +	st->regs[ADF41513_REG5] |=3D FIELD_PREP(ADF41513_REG5_R_CNT_MSK,
> +					      st->settings.r_counter);
> +	st->regs[ADF41513_REG5] |=3D FIELD_PREP(ADF41513_REG5_REF_DOUBLER_MSK,
> +					      st->settings.ref_doubler);
> +	st->regs[ADF41513_REG5] |=3D FIELD_PREP(ADF41513_REG5_RDIV2_MSK,
> +					      st->settings.ref_div2);
> +	st->regs[ADF41513_REG5] |=3D FIELD_PREP(ADF41513_REG5_PRESCALER_MSK,
> +					      st->settings.prescaler);

Probably better to use FIELD_MODIFY for all of these and let the compiler
figure out it can mask them all in one go.

> +
> +	if (st->settings.mode =3D=3D ADF41513_MODE_INTEGER_N) {
> +		st->regs[ADF41513_REG6] |=3D ADF41513_REG6_INT_MODE_MSK;
> +		st->regs[ADF41513_REG6] &=3D ~ADF41513_REG6_BLEED_ENABLE_MSK;
> +	} else {
> +		st->regs[ADF41513_REG6] &=3D ~ADF41513_REG6_INT_MODE_MSK;
> +		st->regs[ADF41513_REG6] |=3D ADF41513_REG6_BLEED_ENABLE_MSK;
> +	}
> +
> +	return adf41513_sync_config(st, sync_mask | ADF41513_SYNC_REG0);
> +}

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
> +				dev_dbg(&st->spi->dev, "PLL un-locked\n");
> +				return -EBUSY;
> +			}
> +		break;
> +	case ADF41513_FREQ_RESOLUTION:
> +		freq_uhz =3D st->data.freq_resolution_uhz;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return adf41513_uhz_to_str(freq_uhz, buf);
This is a more marginal case than the ones below wrt to a common
function making sense as there is more overlap. I''m not sure it
is worth doing even so (rather than separate callbacks).

> +}
> +
> +static ssize_t adf41513_read(struct iio_dev *indio_dev,
> +			     uintptr_t private,
> +			     const struct iio_chan_spec *chan,
> +			     char *buf)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u32 val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {
> +	case ADF41513_FREQ_REFIN:
> +		st->ref_freq_hz =3D clk_get_rate(st->ref_clk);
> +		return sysfs_emit(buf, "%llu\n", st->ref_freq_hz);

Not much sharing here either (see below). I'd be tempted to just spit this
into specific callbacks.

> +	case ADF41513_POWER_DOWN:
> +		val =3D FIELD_GET(ADF41513_REG6_POWER_DOWN_MSK,
> +				st->regs_hw[ADF41513_REG6]);
> +		return sysfs_emit(buf, "%u\n", val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static ssize_t adf41513_write(struct iio_dev *indio_dev,
> +			      uintptr_t private,
> +			      const struct iio_chan_spec *chan,
> +			      const char *buf, size_t len)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	unsigned long readin, tmp;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 10, &readin);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {
> +	case ADF41513_FREQ_REFIN:

There isn't a lot of shared code between different calls of this.
Perhaps just have separate callbacks for each one.

> +		if (readin < ADF41513_MIN_REF_FREQ || readin > ADF41513_MAX_REF_FREQ)
> +			return -EINVAL;
> +
> +		tmp =3D clk_round_rate(st->ref_clk, readin);
> +		if (tmp !=3D readin)
> +			return -EINVAL;
> +
> +		ret =3D clk_set_rate(st->ref_clk, tmp);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->ref_freq_hz =3D readin;
> +		ret =3D adf41513_set_frequency(st, st->settings.target_frequency_uhz,
> +					     ADF41513_SYNC_DIFF);
> +		break;
> +	case ADF41513_POWER_DOWN:
> +		if (readin)
> +			ret =3D adf41513_suspend(st);
> +		else
> +			ret =3D adf41513_resume(st);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ? ret : len;
> +}
> +
> +#define _ADF41513_EXT_INFO(_name, _ident) { \
> +	.name =3D _name, \
> +	.read =3D adf41513_read, \
> +	.write =3D adf41513_write, \
> +	.private =3D _ident, \
> +	.shared =3D IIO_SEPARATE, \
> +}
> +
> +#define _ADF41513_EXT_UHZ_INFO(_name, _ident) { \
> +	.name =3D _name, \
> +	.read =3D adf41513_read_uhz, \
> +	.write =3D adf41513_write_uhz, \
> +	.private =3D _ident, \
> +	.shared =3D IIO_SEPARATE, \
> +}
> +
> +static const struct iio_chan_spec_ext_info adf41513_ext_info[] =3D {
> +	/*
> +	 * Ideally we would use IIO_CHAN_INFO_FREQUENCY, but the device supports
> +	 * frequency values greater 2^32 with sub-Hz resolution, i.e. 64-bit
> +	 * fixed point with 6 decimal places values are used to represent
> +	 * frequencies.
> +	 */
> +	_ADF41513_EXT_UHZ_INFO("frequency", ADF41513_FREQ),
> +	_ADF41513_EXT_UHZ_INFO("frequency_resolution", ADF41513_FREQ_RESOLUTION=
),
> +	_ADF41513_EXT_INFO("refin_frequency", ADF41513_FREQ_REFIN),
Some of these are not things I recall as being standard ABI.
This one is in one other driver but to make it generic you need to promote
the ABI documentation to a shared file.

> +	_ADF41513_EXT_INFO("powerdown", ADF41513_POWER_DOWN),
> +	{ },

No comma on terminating entries like this.

> +};
> +
> +static const struct iio_chan_spec adf41513_chan =3D {
> +	.type =3D IIO_ALTVOLTAGE,
> +	.indexed =3D 1,
> +	.output =3D 1,
> +	.channel =3D 0,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_PHASE),
> +	.ext_info =3D adf41513_ext_info,
> +};
> +
> +static int adf41513_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u32 phase_mdeg;
> +	u16 phase_val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_PHASE:
> +		phase_val =3D FIELD_GET(ADF41513_REG2_PHASE_VAL_MSK,
> +				      st->regs_hw[ADF41513_REG2]);
> +		phase_mdeg =3D DIV_ROUND_CLOSEST(360 * MILLI * phase_val, BIT(12));
> +		*val =3D phase_mdeg / MILLI;
> +		*val2 =3D (phase_mdeg % MILLI) * 1000;

This sounds like it is in degrees. Note _phase attributes are in the docume=
nted
ABI Documentation/ABI/testing/sysfs-bus-iio as in radians.

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adf41513_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u32 phase_mdeg;
> +	u16 phase_val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_PHASE:
> +		val %=3D 360;
> +		if (val < 0)
> +			val +=3D 360;
> +		phase_mdeg =3D val * MILLI + val2 / 1000;
> +		phase_val =3D DIV_ROUND_CLOSEST(phase_mdeg << 12, 360 * MILLI);
> +
> +		st->regs[ADF41513_REG2] |=3D ADF41513_REG2_PHASE_ADJ_MSK;
> +		st->regs[ADF41513_REG2] &=3D ~ADF41513_REG2_PHASE_VAL_MSK;

FIELD_MODIFY() can save doing the clear and fill as separate calls.

> +		st->regs[ADF41513_REG2] |=3D FIELD_PREP(ADF41513_REG2_PHASE_VAL_MSK, p=
hase_val);
> +		return adf41513_sync_config(st, ADF41513_SYNC_REG0);
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static int adf41513_parse_fw(struct adf41513_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +	u32 tmp;
> +	u32 cp_resistance;
> +	u32 cp_current;
Where you have set of variables of same type and grouping doesn't hurt
readability, declare them all on one line.

	u32 tmp, cp_resistance, cp_current;

I'll not repeat comments I made on the dt-binding in here but I'd expect
this code to change somewhat in response to those.

> +

...


> +static int adf41513_setup(struct adf41513_state *st)
> +{
> +	u32 tmp;
> +
> +	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
> +
> +	/* assume DLD pin is used for digital lock detect */
> +	st->regs[ADF41513_REG5] =3D FIELD_PREP(ADF41513_REG5_DLD_MODES_MSK,
> +					     ADF41513_DLD_DIG_LD);
> +
> +	/* configure charge pump current settings */
> +	tmp =3D DIV_ROUND_CLOSEST(st->data.charge_pump_voltage_mv, ADF41513_MIN=
_CP_VOLTAGE_mV);
> +	st->regs[ADF41513_REG5] |=3D FIELD_PREP(ADF41513_REG5_CP_CURRENT_MSK, t=
mp - 1);
> +
> +	/* narrow ABP | loss of lock detect enable | SD reset | LDP from data */

I'm not sure what LPD from data means. Can't correlate that with the datash=
eet.
Perhaps add more info or reword.

> +	st->regs[ADF41513_REG6] =3D ADF41513_REG6_ABP_MSK |
> +				  ADF41513_REG6_LOL_ENABLE_MSK |
> +				  ADF41513_REG6_SD_RESET_MSK;
> +	if (st->data.phase_detector_polarity)
> +		st->regs[ADF41513_REG6] |=3D ADF41513_REG6_PD_POLARITY_MSK;
> +
> +	/* PS bias | lock detect count */
Confusing comment as covering multiple bits of code. I'd just drop
it on basis the field names in the code are less confusing than the comment.
> +	st->regs[ADF41513_REG7] =3D FIELD_PREP(ADF41513_REG7_PS_BIAS_MSK, 2);

That magic 2 is interesting as it is truely magic with no explanation on
the datasheet beyond 'program this value'. Even better, on the datasheet I'm
looking at the Prescaler (PS) bias section says set it to 3 and figure 30
say set it to 2.  Maybe add a commeon on this.

> +	tmp =3D ilog2(st->data.lock_detect_count);
> +	if (st->data.lock_detect_count < ADF41513_LD_COUNT_FAST_LIMIT) {
> +		tmp -=3D const_ilog2(ADF41513_LD_COUNT_FAST_MIN);
> +		st->regs[ADF41513_REG7] |=3D ADF41513_REG7_LD_CLK_SEL_MSK;
> +	} else {
> +		tmp -=3D const_ilog2(ADF41513_LD_COUNT_MIN);
> +	}
> +	st->regs[ADF41513_REG7] |=3D FIELD_PREP(ADF41513_REG7_LD_COUNT_MSK, tmp=
);
> +
> +	/* power down select */
> +	st->regs[ADF41513_REG11] =3D ADF41513_REG11_POWER_DOWN_SEL_MSK;
> +
> +	/* muxout */
> +	st->regs[ADF41513_REG12] =3D FIELD_PREP(ADF41513_REG12_MUXOUT_MSK,
> +					      st->data.muxout_select);
> +	st->regs[ADF41513_REG12] |=3D FIELD_PREP(ADF41513_REG12_LOGIC_LEVEL_MSK,
> +					       st->data.muxout_1v8_en ? 0 : 1);
> +
> +	/* perform initialization sequence with power-up frequency */
> +	return adf41513_set_frequency(st, (u64)st->data.power_up_frequency_hz *=
 MICROHZ_PER_HZ,
> +				      ADF41513_SYNC_ALL);
> +}

...

> +
> +static int adf41513_pm_suspend(struct device *dev)
> +{
> +	struct adf41513_state *st =3D dev_get_drvdata(dev);
> +
> +	return adf41513_suspend(st);

Not at lot in point in the local variable

	return adf41513_suspend(dev_get_drvdata(dev));

> +}
> +
> +static int adf41513_pm_resume(struct device *dev)
> +{
> +	struct adf41513_state *st =3D dev_get_drvdata(dev);
> +
> +	return adf41513_resume(st);
As above.
> +}
> +
> +static const struct adf41513_chip_info adf41513_chip_info =3D {
> +	.name =3D "adf41513",
> +	.has_prescaler_8_9 =3D true,
> +	.max_rf_freq_hz =3D ADF41513_MAX_RF_FREQ,
> +};
> +
> +static const struct adf41513_chip_info adf41510_chip_info =3D {

Just for long term organization when many devices are supported:
keep these structures in alphanumeric order.

> +	.name =3D "adf41510",
> +	.has_prescaler_8_9 =3D false,
> +	.max_rf_freq_hz =3D ADF41510_MAX_RF_FREQ,
> +};
> +
> +static int adf41513_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adf41513_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));

I'd use a=20
	struct device *dev =3D &spi->dev;
so that you can shorten all the lines where spi->dev is used in here.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +	st->chip_info =3D spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -EINVAL;
> +
> +	spi_set_drvdata(spi, st);
> +
> +	st->ref_clk =3D devm_clk_get_enabled(&spi->dev, NULL);
> +	if (IS_ERR(st->ref_clk))
> +		return PTR_ERR(st->ref_clk);
> +
> +	st->ref_freq_hz =3D clk_get_rate(st->ref_clk);
> +	if (st->ref_freq_hz < ADF41513_MIN_REF_FREQ || st->ref_freq_hz > ADF415=
13_MAX_REF_FREQ)
> +		return dev_err_probe(&spi->dev, -ERANGE,
> +				     "reference frequency %llu Hz out of range\n",
> +				     st->ref_freq_hz);
> +
> +	ret =3D adf41513_parse_fw(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> +					     ARRAY_SIZE(adf41513_power_supplies),
> +					     adf41513_power_supplies);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to get and enable regulators\n");
> +
> +	st->chip_enable =3D devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_=
OUT_HIGH);
> +	if (IS_ERR(st->chip_enable))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->chip_enable),
> +				     "fail to request chip enable GPIO\n");
> +
> +	st->lock_detect =3D devm_gpiod_get_optional(&spi->dev, "lock-detect", G=
PIOD_IN);
> +	if (IS_ERR(st->lock_detect))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->lock_detect),
> +				     "fail to request lock detect GPIO\n");
> +
> +	ret =3D devm_mutex_init(&spi->dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D st->chip_info->name;
> +	indio_dev->info =3D &adf41513_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D &adf41513_chan;
> +	indio_dev->num_channels =3D 1;
> +
> +	ret =3D adf41513_setup(st);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret, "failed to setup device: %d\n", r=
et);
Look at what dev_err_probe() prints.  (short answer, it includes a much nic=
er print
of the error value than the one you have here).  So dev_err_probe() should =
never
include the error value itself as that is duplicating the info.
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev, adf41513_power_down, st);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to add power down action:=
 %d\n", ret);

As above.  No printing ret by hand in dev_err_probe() calls.

> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

