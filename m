Return-Path: <linux-iio+bounces-21397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9FAFA4C7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7781179E16
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46AC1FF7B4;
	Sun,  6 Jul 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd6lg/U+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857641C1ADB
	for <linux-iio@vger.kernel.org>; Sun,  6 Jul 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751801673; cv=none; b=fSU+v/UUQmK+RR+TF0ZiVRnK5hG1aMHXDtoWLpn5dDisG++5+mLmnAmDBdvJoWxSG8iBAvMrOlajiqeVxCOAtUuejPfiMd8zNH/xSeohpwdMVEHenGqRkPLINlEMldpiJVottE8G/LHOzIGON7VBBQpHaI4NxRHrf9Wg7AkEhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751801673; c=relaxed/simple;
	bh=7S9N7awiJ4HtOdvtEd1IgLAC8gFh/ZTEMXuL9wSj3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPkB9z1PYe6dtxTM6HqA4NuNQCjCbo9AKBTbXD9M22BZ5Y8fFDLc2mTXVRVpqmzUwcpmPd6a+LCwEx4YuS8iuOTgY65gY3WoPFpDh0TewPkz/3YekdKK4TJUvZiFb35xcQy8A4XtHRVywGOuO9QmnufW9xplqqCJzzB7lkMntyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd6lg/U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C156FC4CEED;
	Sun,  6 Jul 2025 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751801673;
	bh=7S9N7awiJ4HtOdvtEd1IgLAC8gFh/ZTEMXuL9wSj3cU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qd6lg/U+htTjgK/hWociMpOXyc1lXKgt6Elg0V+aO2YPs/BlsXuCqO8cXL2cM+CXf
	 xMeKb5N2O6Kjhpng+PVDdSXqMyKNEWYXqJJkRpgEn6BOxuUaGZ8rhthja26WvbEvND
	 K+D0li4OMVeEQzjgsi7mJ8EEazIKhpNpjxip3CzSevUQFm9ctP2H4Lpf/5kU9CU7TR
	 VqDM3MQOdcGUfYhxmdxK4RuGlKwMolh6k1I9w7E5vdPRTUH+gIknmKSoPK2xLtbqFG
	 GUmUvCQY3rEhXkiXfxwiaRtxD3SJ0tHZF9lwn7r7LWkwVO2Lt5pyVYqjDFeQ7GHBCE
	 mm8wXMeJgtkaw==
Date: Sun, 6 Jul 2025 12:34:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lucas Eiji Uchiyama <lucaseiji54@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dps310.c: Remove duplication in functions
Message-ID: <20250706123428.6df710ce@jic23-huawei>
In-Reply-To: <20250702233107.93975-1-lucaseiji54@gmail.com>
References: <20250702233107.93975-1-lucaseiji54@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 20:31:07 -0300
Lucas Eiji Uchiyama <lucaseiji54@gmail.com> wrote:

Look at patch titles for other recent patches in the subsystem you
are submitting changes for.

iio: pressure: dps310: Reduce code duplication

or something like that. 

> Consolidate the following functions into shared implementations:
> 
> - dps310_get_pres_precision
> - dps310_get_temp_precision
> - dps310_set_pres_precision
> - dps310_set_temp_precision
> - dps310_set_pres_samp_freq
> - dps310_set_temp_samp_freq
> - dps310_get_pres_samp_freq
> - dps310_get_temp_samp_freq
> - dps310_get_pres_k
> - dps310_get_temp_k
> 
> These were replaced by the following unified functions:
> 
> - dps310_get_precision
> - dps310_set_precision
> - dps310_set_samp_freq
> - dps310_get_samp_freq
> - dps310_get_k
> 
> Each now takes an additional `mode` parameter indicating whether the
> operation applies to temperature or pressure.
> 
> All call sites were updated accordingly. To improve readability, new
> macros PRESSURE and TEMPERATURE were introduced and passed to the
> shared functions.
> 
> Additionally, a new macro was defined for:
> 
>   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>   BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>   BIT(IIO_CHAN_INFO_PROCESSED)
> 
> since this combination was used twice in the same struct.
Simply reducing duplication of that is of little benefit as
it means we now have a mixture of information being immediately
visible and being hidden behind a level of macros.

> 
> Signed-off-by: Lucas Eiji Uchiyama <lucaseiji54@gmail.com>
> ---
>  drivers/iio/pressure/dps310.c | 182 +++++++++++++---------------------

>  1 file changed, 69 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 8edaa4d10..99188bf4a 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -56,6 +56,8 @@
>  #define DPS310_RESET		0x0c
>  #define  DPS310_RESET_MAGIC	0x09
>  #define DPS310_COEF_BASE	0x10
> +#define PRESSURE 0
> +#define TEMPERATURE 1

We have an address field in the channel definition that is used
for this sort of shared code reduction... See later.

Also, prefix these as high chance of a naming clash on a define
called TEMPERATURE.


>  
>  /* Make sure sleep time is <= 30ms for usleep_range */
>  #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
> @@ -65,6 +67,11 @@
>  #define DPS310_PRS_BASE		DPS310_PRS_B0
>  #define DPS310_TMP_BASE		DPS310_TMP_B0
>  
> +#define INFO_MASK_SEPARATE \
> +	 (BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) | \
> +	 BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +	 BIT(IIO_CHAN_INFO_PROCESSED))

I'm not convinced by this because it separates out part of the channel definition
from where we expect to see that info.  If there were lots of channels I'd suggest
a channel macro that took the type as a parameter, but for 2 that isn't worth the complexity

> +
>  /*
>   * These values (defined in the spec) indicate how to scale the raw register
>   * values for each level of precision available.
> @@ -95,15 +102,11 @@ struct dps310_data {
>  static const struct iio_chan_spec dps310_channels[] = {
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> -			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -			BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = INFO_MASK_SEPARATE
>  	},
>  	{
>  		.type = IIO_PRESSURE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> -			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -			BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = INFO_MASK_SEPARATE
>  	},
>  };
>  
> @@ -256,57 +259,24 @@ static int dps310_startup(struct dps310_data *data)
>  	return dps310_temp_workaround(data);
>  }
>  
> -static int dps310_get_pres_precision(struct dps310_data *data, int *val)
> -{
> -	int reg_val, rc;
> -
> -	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
> -	if (rc < 0)
> -		return rc;
> -
> -	*val = BIT(reg_val & GENMASK(2, 0));
> -
> -	return 0;
> -}
> -
> -static int dps310_get_temp_precision(struct dps310_data *data, int *val)
> +static int dps310_get_precision(struct dps310_data *data, int *val, int mode)
>  {
>  	int reg_val, rc;
> -
> -	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
> +	if (!mode)
> +		rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
> +	else
> +		rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);

So the conditional in here is a bit ugly. What we care about is the address
being manipulated.

The common way to solve this is to have a per channel structure which is
part of an array indexed by chan->address.

Then add an iio_chan_spec to the declaration and have something like

static const struct {
	u8 cfg;
	u8 otherreg;
} dps310_chans[] = {
	[DPS310_TEMP] = {
		.cfg = DP310_TMP_CFG,
	},
	[DPS310_PRES] = {
		.cfg = DPS310_PRES_CFG,
	},
};

static int dps310_get_precision(struct dps310_data *data,
				struct iio_chan_spec *chan, int *val)
{
	int reg_al, rc;

	rc = regmap_read(data->regmap, dps310_chans[chan->address].cfg, &reg_val);
	if (rc)
		return ret;

	*val = FIELD_GET(reg_val, SOMEMASKDEF);

	return 0;
}

That puts all the info about how the channels vary in one place where it is easy
to check against the datasheet and gives us simple functions to do the reading etc.

>  	if (rc < 0)
>  		return rc;
>  
> -	/*
> -	 * Scale factor is bottom 4 bits of the register, but 1111 is
> -	 * reserved so just grab bottom three
> -	 */
>  	*val = BIT(reg_val & GENMASK(2, 0));
>  
>  	return 0;
> -}

>  /* Called with lock held */
> -static int dps310_set_temp_precision(struct dps310_data *data, int val)
> +static int dps310_set_precision(struct dps310_data *data, int val, int mode)
>  {
>  	int rc;
>  	u8 shift_en;
> @@ -314,32 +284,29 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
>  	if (val < 0 || val > 128)
>  		return -EINVAL;
>  
> -	shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;
> -	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> -			       DPS310_TMP_SHIFT_EN, shift_en);
> -	if (rc)
> -		return rc;
> -
> -	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
> -				  DPS310_TMP_PRC_BITS, ilog2(val));
> -}
> -
> -/* Called with lock held */
> -static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
> -{
> -	u8 val;
> -
> -	if (freq < 0 || freq > 128)
> -		return -EINVAL;
> +	if (!mode) {
> +		shift_en = val >= 16 ? DPS310_PRS_SHIFT_EN : 0;
> +		rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +				DPS310_PRS_SHIFT_EN, shift_en);
> +		if (rc)
> +			return rc;
>  
> -	val = ilog2(freq) << 4;
> +		return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
> +				DPS310_PRS_PRC_BITS, ilog2(val));
> +	} else {
> +		shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;

similarly encode all the differences in here - so shifts etc in that
structure above so that it should all become look ups rather than
code.

> +		rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +				DPS310_TMP_SHIFT_EN, shift_en);
> +		if (rc)
> +			return rc;
>  
> -	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
> -				  DPS310_PRS_RATE_BITS, val);
> +		return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
> +				DPS310_TMP_PRC_BITS, ilog2(val));
> +	}
>  }

