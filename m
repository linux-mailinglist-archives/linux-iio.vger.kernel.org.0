Return-Path: <linux-iio+bounces-24521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F2BA6E1A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638A917D1C7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E172D4B7F;
	Sun, 28 Sep 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU23F/7h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD12BE7DF;
	Sun, 28 Sep 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052670; cv=none; b=V6Z/MthiCxXiBqrFbDGcqXII5SiJ9ah4w30vJrVH7rdLJsE4UZG3MZkIYZW/7RXVXtlj+fEad5Q4nOOUv+okEBzaVMvpbbu4E0V+R1utHnfVnp4PtiKzniyjCQFgIflxyGGDhJ1RAxSEFfOxgyU3BkQlZa9mqznZIoIz5jGjnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052670; c=relaxed/simple;
	bh=Z1fLhoPjnyx6F0KCMjP6L3SXqQcFcLJzUjAgQuQhYLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tU5N23LF0tk7XAiQX9702O2uMq1YV5zRc2Ju6xS1BRBIX8LEK0gqXiWRNDFF+noUN4SGPnz9l2SYu2e+Rx0cww77XFTVOcsvi+N1zGppWnYGrUHKaWDm7Cr88oc8HQoB1VPwnB0Ddt2RNJ/Sr9Xg6cwUwhNrQPupTBIyCFT2UJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU23F/7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F832C4CEF0;
	Sun, 28 Sep 2025 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759052668;
	bh=Z1fLhoPjnyx6F0KCMjP6L3SXqQcFcLJzUjAgQuQhYLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fU23F/7hBYcZQiDiND/fyAKA8H0l/n2C9oKzfui0wgG+S0XrYuqzkYTNiAanwClji
	 bqoFXzNIWd9yqiwwkhbOSA7z+0lSdDsZWletEUvCrUH2HPHX7KjOecdm8dx6FenKbR
	 QIIF3nbsJQa4mMHwBy6pqbze0db/wzOX1Nv6GhccYfKOB3zueiKQRCF9uJ/0mzS0qU
	 LgQ7znHQii+dxNYDKXYNAgWOik8ezkqkH7wT5MO68/OmKpeuCSetx/nlK2b4D+FAhc
	 htXskesaBXydk2BmFTnFR8Hnebn58bkOvF3WSCt/1QgPgb4+ki7LBalB0wz77v2G2E
	 zj+iE5b7nX8gQ==
Date: Sun, 28 Sep 2025 10:44:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bma400: Refactor generic interrupt
 configuration
Message-ID: <20250928104420.72e1978a@jic23-huawei>
In-Reply-To: <20250925170942.259314-1-akshayaj.lkd@gmail.com>
References: <20250925170942.259314-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 22:39:40 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Refactor generic interrupt configuration to replace hard-coded
> register values with logical macros and enums, thereby making the
> configuration understandable and in-style with common kernel
> patterns.
> 
> Introduce a const struct with a helper to map event direction to the
> corresponding generic interrupt and sanitize the input before use.
> 
> Rename activity_event_en() to generic_event_en() to better describe
> its role in activity and inactivity detection.
Hi Akshay,


This rename seems like a separable change.  Putting it in it's own
patch will make it easier to spot this description of why it
should have a more generic name.

> 
> No functional changes done.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>

I appreciate I replied probably after you sent this, but the request
to split the renames out as a precursor that Nuno made is still valid.
They add noise to the patch and make it harder to review.

In general I'd like to see this broken into several steps/patches.

I've mentioned some things to break out inline but it'll be something like
* Field renames.
* Documentation and explicit field definitions for initial values.
* activity_event_en() rename
* Change in how register addresses are obtained.
* White space changes if you want to make them.
Ordering is largely up to you to figure out.

So I think at least 4 separate patches doing much smaller things.
That should make it much easier to see what is going on in each.

Various specific comments inline.

Thanks,

Jonathan

> ---
> 
> Changes since v1:
> - Address Nuno's feedback of using a helper function to sanitize dir.
> - Fixed a bug introduced in v1 changes (incorrect bit set in GENINT_CONFIG0 register).
> - Rename bma400_activity_event_en() to bma400_generic_event_en(), since
>   bma400 offers 3 variety of events related to activity. Renaming to generic
>   makes it more relatable to the functionality.
> - Added Testing summary.
> - Edited minor comment.
> 
> Testing Summary:
> - Tested on raspberrypi 4b and 7-semi bma400 sensor breakout board.
> - Since no functional impact is there, so before functionality is
>   expected to be equal to after change functionality.
> - Tested mapping of GEN1 and GEN2 both on INT1 pin as before.
> - Tested both activity and inactivity detection by setting attributes
>   events/in_accel_mag_falling_en as well as events/in_accel_mag_rising_en.
> - Did read and writes on various attributes such that write_event_config(),
>   write_event_value() and read_event_value() callbacks are triggered.
> 
>  drivers/iio/accel/bma400.h      |  71 ++++++++++++--
>  drivers/iio/accel/bma400_core.c | 163 ++++++++++++++++++++------------
>  2 files changed, 161 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 932358b45f17..ab7d1d139b66 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -68,7 +68,19 @@
>  #define BMA400_CMD_REG              0x7e
>  
>  /* Interrupt registers */
> -#define BMA400_INT_CONFIG0_REG	    0x1f
> +#define BMA400_INT_CONFIG0_REG			0x1f
Seems original code was using spaces to align the value and this
switches it to tabs.  That is a valid cleanup if it is inconsistent
(stick to local style if it is not) but doesn't really
belong in a patch doing something else.

> +#define BMA400_INT_CONFIG0_ORTN_CHG_MASK	BIT(1)
> +#define BMA400_INT_CONFIG0_GEN1_MASK		BIT(2)
> +#define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
> +#define BMA400_INT_CONFIG0_FIFO_FULL_MASK	BIT(5)
> +#define BMA400_INT_CONFIG0_FIFO_WTRMRK_MASK	BIT(6)
> +#define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
> +
> +enum generic_intr {
> +	GEN1_INTR,
> +	GEN2_INTR

See below.   I'd suggest just using the numbers 1 and 2
as more intuitive than an enum that is only used to provide
a mapping 1->0 and 2->1

Alternative is go all in on the enum definition and make the
various places this is used type safe by using an enum.


> +};
> +
>  #define BMA400_INT_CONFIG1_REG	    0x20
>  #define BMA400_INT1_MAP_REG	    0x21
>  #define BMA400_INT_IO_CTRL_REG	    0x24
> @@ -96,15 +108,53 @@
>  #define BMA400_ACC_ODR_MIN_HZ       12
>  
>  /* Generic interrupts register */
> -#define BMA400_GEN1INT_CONFIG0      0x3f
> -#define BMA400_GEN2INT_CONFIG0      0x4A
> -#define BMA400_GEN_CONFIG1_OFF      0x01
> -#define BMA400_GEN_CONFIG2_OFF      0x02
> -#define BMA400_GEN_CONFIG3_OFF      0x03
> -#define BMA400_GEN_CONFIG31_OFF     0x04
> -#define BMA400_INT_GEN1_MSK         BIT(2)

This rename and move can precede the main change.

> -#define BMA400_INT_GEN2_MSK         BIT(3)
> -#define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> +#define BMA400_GENINT_CONFIG_REG_BASE	0x3f
> +#define BMA400_NUM_GENINT_CONFIG_REGS	11
> +#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx)	\
> +	(BMA400_GENINT_CONFIG_REG_BASE +		\
> +	(gen_intr) * BMA400_NUM_GENINT_CONFIG_REGS +	\
Given no type or range checking on gen_intr, I'd make the code
more intuitive by doing 
	((gen_intr) - 1) & BMA...

Then you can just use the values 1 and 2 to represent interrupt line 1 and
interrupt line 2.

> +	(config_idx))
> +
> +/* Generic Interrupt Config0 register */
> +#define BMA400_GENINT_CONFIG0_HYST_MASK			GENMASK(1, 0)
These field renames can be done independently of the rest.
That will need a little explanatory text in the patch, but it will remove
a bunch of places which end up being noisy int his diff distracting from
the other changes.

> +#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK		GENMASK(3, 2)
> +#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK		BIT(4)
> +#define BMA400_GENINT_CONFIG0_X_EN_MASK			BIT(5)
> +#define BMA400_GENINT_CONFIG0_Y_EN_MASK			BIT(6)
> +#define BMA400_GENINT_CONFIG0_Z_EN_MASK			BIT(7)
> +
> +enum bma400_hysteresis_config {
> +	NO_HYSTERESIS,
> +	HYSTERESIS_24MG,
> +	HYSTERESIS_48MG,
> +	HYSTERESIS_96MG

Last entry isn't strictly a terminating entry so convention, even though we know
there will never be more entries, is to have the trailing comma.

> +};
> +
> +enum bma400_accel_data_src {
> +	ACCEL_FILT1,
> +	ACCEL_FILT2
trailing comma etc.
> +};
> +
> +enum bma400_ref_updt_mode {
> +	BMA400_REF_MANUAL_UPDT_MODE,
> +	BMA400_REF_ONETIME_UPDT_MODE,
> +	BMA400_REF_EVERYTIME_UPDT_MODE,
> +	BMA400_REF_EVERYTIME_LP_UPDT_MODE
trailing comma.
> +};
> +
> +/* Generic Interrupt Config1 register */
> +#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK		BIT(0)
> +#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK		BIT(1)
> +
> +enum bma400_genintr_acceleval_axescomb {
> +	BMA400_EVAL_X_OR_Y_OR_Z,
> +	BMA400_EVAL_X_AND_Y_AND_Z,
> +};
> +
> +enum bma400_detect_criterion {
> +	BMA400_DETECT_INACTIVITY,
> +	BMA400_DETECT_ACTIVITY,
> +};
>  
>  /* TAP config registers */
>  #define BMA400_TAP_CONFIG           0x57
> @@ -119,6 +169,7 @@
>  #define BMA400_TAP_QUIETDT_MSK      GENMASK(5, 4)
>  #define BMA400_TAP_TIM_LIST_LEN     4
>  
> +
Unrelated change and one that wants to go away.  1 blank line is enough.

>  /*
>   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
>   * converting to micro values for +-2g range.
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 85e23badf733..aabbe74e1db7 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -121,6 +121,29 @@ struct bma400_data {
>  	__be16 duration;
>  };
>  
> +struct bma400_genintr_info {
> +	u8 genintr;

If you really want the enum for this that you have above, it needs to be used
here and in the local variables.


> +	unsigned int intrmask;
> +	enum iio_event_direction dir;
> +	enum bma400_detect_criterion detect_mode;
> +};
> +
> +/* Lookup struct for determining GEN1/GEN2 based on dir */
> +static const struct bma400_genintr_info bma400_genintrs[] = {
> +	[IIO_EV_DIR_RISING] = {
> +		.genintr = GEN1_INTR,	/* 0 for GEN1 */
> +		.intrmask = BMA400_INT_CONFIG0_GEN1_MASK,
> +		.dir = IIO_EV_DIR_RISING,
> +		.detect_mode = BMA400_DETECT_ACTIVITY,
> +	},
> +	[IIO_EV_DIR_FALLING] = {
> +		.genintr = GEN2_INTR,	/* 1 for GEN2 */
> +		.intrmask = BMA400_INT_CONFIG0_GEN2_MASK,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.detect_mode = BMA400_DETECT_INACTIVITY,
> +	}
> +};

> @@ -1155,63 +1178,83 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
>  	return 0;
>  }
>  
> -static int bma400_activity_event_en(struct bma400_data *data,
> -				    enum iio_event_direction dir,
> -				    int state)
> +static inline const struct bma400_genintr_info *
> +get_bma400_genintr_info(enum iio_event_direction dir)
>  {
> -	int ret, reg, msk, value;
> -	int field_value = 0;
> -
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
> -		reg = BMA400_GEN1INT_CONFIG0;
> -		msk = BMA400_INT_GEN1_MSK;
> -		value = 2;
> -		set_mask_bits(&field_value, BMA400_INT_GEN1_MSK,
> -			      FIELD_PREP(BMA400_INT_GEN1_MSK, state));
> -		break;
>  	case IIO_EV_DIR_FALLING:
> -		reg = BMA400_GEN2INT_CONFIG0;
> -		msk = BMA400_INT_GEN2_MSK;
> -		value = 0;
> -		set_mask_bits(&field_value, BMA400_INT_GEN2_MSK,
> -			      FIELD_PREP(BMA400_INT_GEN2_MSK, state));
> -		break;
> +		return &bma400_genintrs[dir];
>  	default:
Maybe add a comment that this should be unreachable.

> +		return NULL;
> +

No blank line here.

> +	};
> +}
> +
> +static int bma400_generic_event_en(struct bma400_data *data,
> +				   enum iio_event_direction dir,
> +				   int state)
> +{
> +	int ret, regval;
> +	u8 genintr, detect_criterion;
> +	unsigned int intrmask;
> +	const struct bma400_genintr_info *bma400_genintr;
> +
> +	bma400_genintr = get_bma400_genintr_info(dir);
> +	if (!bma400_genintr)
>  		return -EINVAL;
> -	}
>  
> -	/* Enabling all axis for interrupt evaluation */
> -	ret = regmap_write(data->regmap, reg, 0xF8);
> +	genintr = bma400_genintr->genintr;
> +	detect_criterion = bma400_genintr->detect_mode;
> +	intrmask = bma400_genintr->intrmask;
> +
> +	/*
> +	 * Enabling all axis for interrupt evaluation.
> +	 * Acc_filt2 is recommended as data source in datasheet (Section 4.7).
So this change could be argued to be matching the use of explicit register bits
below which is good.  That change isn't related to the GENINT_CONFIG_REG() macro
change though, so I'd break it out.  Would I think be fine to have a patch
that does docs updates like this one as well as using specific defines to
implement what the documentation is talking about.  

> +	 */
> +	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
> +			   BMA400_GENINT_CONFIG0_X_EN_MASK |
> +			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
> +			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
> +			   FIELD_PREP(BMA400_GENINT_CONFIG0_DATA_SRC_MASK, ACCEL_FILT2)|
> +			   FIELD_PREP(BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK,
> +				      BMA400_REF_EVERYTIME_UPDT_MODE));
>  	if (ret)
>  		return ret;
>  
>  	/* OR combination of all axis for interrupt evaluation */
> -	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
> +	regval = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
> +		 FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, detect_criterion);
> +	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 1), regval);
>  	if (ret)
>  		return ret;
>  
> -	/* Initial value to avoid interrupts while enabling*/
> -	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
> +	/*
> +	 * Initial value to avoid (activity) interrupts while enabling
> +	 * Value is in units of 8mg/lsb, i.e. effective val is val * 8mg/lsb

This extra comment is good, but unrelated to any of the other changes. Separate patch.
If there are other documentation improvements that aren't about new code, then they
can be in that same documentation only patch.

> +	 */
> +	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 2), 0x0A);
>  	if (ret)
>  		return ret;
>  
>  	/* Initial duration value to avoid interrupts while enabling*/
> -	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
> +	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 4), 0x0F);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
> -				 field_value);
> +	regval = FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state);
> +	if (genintr)
I'd match a specific value here to help understanding you are doing this
because the value is that of interrupt 2.

Also, don't set it them replace. Use an if / else as that better matches the
mental model of picking either interrupt 1 or interrupt 2.


> +		regval = FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state);
> +
> +	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, intrmask, regval);
>  	if (ret)
>  		return ret;
>  
> -	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
The variable name changes might make sense, but that isn''t clear in a patch that
is making other changes.   If you want to make that change break it out.

> -				 field_value);
> +	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, intrmask, regval);
>  	if (ret)
>  		return ret;
>  
> -	set_mask_bits(&data->generic_event_en, msk, field_value);
> +	set_mask_bits(&data->generic_event_en, intrmask, regval);
>  	return 0;
>  }
>  
> @@ -1303,7 +1346,7 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  		switch (type) {
>  		case IIO_EV_TYPE_MAG:
>  			mutex_lock(&data->mutex);
> -			ret = bma400_activity_event_en(data, dir, state);
> +			ret = bma400_generic_event_en(data, dir, state);

Rename is fine but it's not related to other changes that I can spot. Separate patch.

Though what does 'generic' bring over bma400_event_en()?

>  			mutex_unlock(&data->mutex);
>  			return ret;
>  		case IIO_EV_TYPE_GESTURE:
> @@ -1336,18 +1379,6 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
>  	}
>  }

>  			return -EINVAL;
> @@ -1444,16 +1479,18 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  				    int val, int val2)
>  {
>  	struct bma400_data *data = iio_priv(indio_dev);
> -	int reg, ret, raw;
> +	int genintr, ret, raw;
> +	const struct bma400_genintr_info *bma400_genintr;
Why not call it genitr_info; or something else shorter.
Maybe then can avoid the local variable 

>  
>  	if (chan->type != IIO_ACCEL)
>  		return -EINVAL;
>  
>  	switch (type) {
>  	case IIO_EV_TYPE_MAG:
> -		reg = get_gen_config_reg(dir);
> -		if (reg < 0)
> +		bma400_genintr = get_bma400_genintr_info(dir);
> +		if (!bma400_genintr)
>  			return -EINVAL;
> +		genintr = bma400_genintr->genintr;
>  
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:
> @@ -1461,7 +1498,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  				return -EINVAL;
>  
>  			return regmap_write(data->regmap,
> -					    reg + BMA400_GEN_CONFIG2_OFF,
> +					    BMA400_GENINT_CONFIG_REG(genintr, 2),
>  					    val);
>  		case IIO_EV_INFO_PERIOD:
>  			if (val < 1 || val > 65535)
> @@ -1470,7 +1507,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  			mutex_lock(&data->mutex);
>  			put_unaligned_be16(val, &data->duration);
>  			ret = regmap_bulk_write(data->regmap,
> -						reg + BMA400_GEN_CONFIG3_OFF,
> +						BMA400_GENINT_CONFIG_REG(genintr, 3),
>  						&data->duration,
>  						sizeof(data->duration));
>  			mutex_unlock(&data->mutex);
> @@ -1479,10 +1516,10 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
>  			if (val < 0 || val > 3)
>  				return -EINVAL;
>  
> -			return regmap_update_bits(data->regmap, reg,
> -						  BMA400_GEN_HYST_MSK,
> -						  FIELD_PREP(BMA400_GEN_HYST_MSK,
> -							     val));
> +			return regmap_update_bits(data->regmap,
> +						  BMA400_GENINT_CONFIG_REG(genintr, 0),
> +						  BMA400_GENINT_CONFIG0_HYST_MASK,

Again, if renames were done in separate patch it would separate the new register address
lookup from the renames.

> +						  FIELD_PREP(BMA400_GENINT_CONFIG0_HYST_MASK, val));
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1650,10 +1687,10 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
>  						  IIO_EV_DIR_DOUBLETAP),
>  			       timestamp);
>  
> -	if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))

The reason I'd like the field renames in a different patch is sections like this
will be handled just in that patch and not make it harder to spot which change
they are related to in this larger patch.

> +	if (FIELD_GET(BMA400_INT_CONFIG0_GEN1_MASK, le16_to_cpu(data->status)))
>  		ev_dir = IIO_EV_DIR_RISING;
>  
> -	if (FIELD_GET(BMA400_INT_GEN2_MSK, le16_to_cpu(data->status)))
> +	if (FIELD_GET(BMA400_INT_CONFIG0_GEN2_MASK, le16_to_cpu(data->status)))
>  		ev_dir = IIO_EV_DIR_FALLING;
>  
>  	if (ev_dir != IIO_EV_DIR_NONE) {


