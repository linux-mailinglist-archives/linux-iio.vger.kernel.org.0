Return-Path: <linux-iio+bounces-9212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFAF96E224
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 20:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DC1C23726
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300AD187868;
	Thu,  5 Sep 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyMN9tJC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBE17BA5;
	Thu,  5 Sep 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561663; cv=none; b=Up1HMTSneittHKpsRnApWXdrrTHxbrNBZSz9UZAPC+22aih1unxWFj9pOohnxobeICLeHChleqyt+6HUQmMlz03PGEEAw1HSIriWlZ8EGsQtRbO+/kxIxvTTbrka4pXkEynESrQufObQZcufUjF1o1PL0wW0a96RxwtnMTVEyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561663; c=relaxed/simple;
	bh=qiVHGKZRWD0sQOUS8fwIzdfvLAiUwhXxB/xvbhnTGzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngHcrTDohZAd0v6rlvNUbtrji5o0Jo+TAh8cyzFfFh6/3jSgmH1priSsEGq+71WPWPhG9bdz4ACyOLfIqBmYkiICtHW48oe7T1pbySwka583x5eLIQeVZkuGuPxcaX65NbDY/g2JaSh4mKckrhp+IJbElLwjWLE16j9s02Ty/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyMN9tJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF4C4CEC3;
	Thu,  5 Sep 2024 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561662;
	bh=qiVHGKZRWD0sQOUS8fwIzdfvLAiUwhXxB/xvbhnTGzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hyMN9tJCvXnglu1dfWfNJqLK6PgW09r43bpODL4K3DK1MGXhI4TvopiatqSFa8OaK
	 EmrrDKxf0p1wmiZhdY2r0UBMXqMFAbwCQpuD+Sb1HatE18VUxbfhk6yjKEIhxeLDZy
	 zSIJ9Z8Ws+ln/l+twLbpPMiHgZVBL51UgetA+D9pUhu82xcnnoY02koetJ8gXl9XVA
	 Puud/VJxE36DoiUHSwpPLhl+UQ+gotxUjuVXNmxLJs86u/CpanLD0YkDlPbdut3INp
	 4c91wB1/bTWaQvcs7s2+N1oOGk2tzrCNWcOut2gg3nbvKSr9rOtq0/Dydixti1ENao
	 nTWJyDmAGaniw==
Date: Thu, 5 Sep 2024 19:40:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: wangshuaijie@awinic.com, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V9 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <20240905194054.13ed8d6d@jic23-huawei>
In-Reply-To: <ZteqKroYjYKETqn7@surfacebook.localdomain>
References: <20240827080229.1431784-1-wangshuaijie@awinic.com>
	<20240827080229.1431784-3-wangshuaijie@awinic.com>
	<ZteqKroYjYKETqn7@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 03:30:34 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Tue, Aug 27, 2024 at 08:02:29AM +0000, wangshuaijie@awinic.com kirjoitti:
> > From: shuaijie wang <wangshuaijie@awinic.com>
> > 
> > AW96103 is a low power consumption capacitive touch and proximity controller.
> > Each channel can be independently config as sensor input, shield output.
> > 
> > Channel Information:
> >   aw96103: 3-channel
> >   aw96105: 5-channel  
> 
> Instead of review the below is the diff that I think makes sense to apply
> (in any convenient form, e.g., squash to the existing commit, splitting
>  and making followups)

At this point other than one fix for a reported bug with an false early return
I'm not taking any additional tweaks because we are very near the end of
the cycle.

> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index 89f7e1bde928..eabbb6b08e67 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -6,19 +6,24 @@
>   *
>   * Copyright (c) 2024 awinic Technology CO., LTD
>   */
> +#include <linux/array_size.h>
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/firmware.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/iio/events.h>
> -#include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/types.h>
> +
>  #include <asm/unaligned.h>
>  
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +
>  #define AW_DATA_PROCESS_FACTOR			1024
>  #define AW96103_CHIP_ID				0xa961
>  #define AW96103_BIN_VALID_DATA_OFFSET		64
> @@ -94,8 +99,8 @@ enum aw96103_sensor_type {
>  };
>  
>  struct aw_channels_info {
> -	bool used;
>  	unsigned int old_irq_status;
> +	bool used;

not worthwhile.

>  };
>  
>  struct aw_chip_info {
> @@ -254,8 +259,8 @@ static int aw96103_get_diff_raw(struct aw96103 *aw96103, unsigned int chan,
>  			  AW96103_REG_DIFF_CH0 + chan * 4, &data);
>  	if (ret)
>  		return ret;
> -	*buf = (int)(data / AW_DATA_PROCESS_FACTOR);
>  
> +	*buf = data / AW_DATA_PROCESS_FACTOR;
Reasonable though I find it hard to care that much :)

>  	return 0;
>  }
>  
> @@ -302,8 +307,8 @@ static int aw96103_read_out_debounce(struct aw96103 *aw96103,
>  			  AW96103_REG_PROXCTRL_CH(chan->channel), &reg_val);
>  	if (ret)
>  		return ret;
> -	*val = FIELD_GET(AW96103_OUTDEB_MASK, reg_val);
>  
> +	*val = FIELD_GET(AW96103_OUTDEB_MASK, reg_val);
>  	return IIO_VAL_INT;
>  }
>  
> @@ -317,8 +322,8 @@ static int aw96103_read_in_debounce(struct aw96103 *aw96103,
>  			  AW96103_REG_PROXCTRL_CH(chan->channel), &reg_val);
>  	if (ret)
>  		return ret;
> -	*val = FIELD_GET(AW96103_INDEB_MASK, reg_val);
>  
> +	*val = FIELD_GET(AW96103_INDEB_MASK, reg_val);
>  	return IIO_VAL_INT;
>  }
>  
> @@ -332,8 +337,8 @@ static int aw96103_read_hysteresis(struct aw96103 *aw96103,
>  			  AW96103_REG_PROXCTRL_CH(chan->channel), &reg_val);
>  	if (ret)
>  		return ret;
> -	*val = FIELD_GET(AW96103_THHYST_MASK, reg_val);
>  
> +	*val = FIELD_GET(AW96103_THHYST_MASK, reg_val);
>  	return IIO_VAL_INT;
>  }
>  
> @@ -454,11 +459,10 @@ static int aw96103_channel_scan_start(struct aw96103 *aw96103)
>  			    aw96103->hostirqen);
>  }
>  
> -static int aw96103_reg_version_comp(struct aw96103 *aw96103,
> -				    struct aw_bin *aw_bin)
> +static int aw96103_reg_version_comp(struct aw96103 *aw96103, struct aw_bin *aw_bin)
>  {
>  	u32 blfilt1_data, fw_ver;
> -	unsigned char i;
> +	unsigned int i;
The char is a bit odd. So agreed on this one.
>  	int ret;
>  
>  	ret = regmap_read(aw96103->regmap, AW96103_REG_FWVER2, &fw_ver);
> @@ -474,16 +478,17 @@ static int aw96103_reg_version_comp(struct aw96103 *aw96103,
>  
>  	for (i = 0; i < aw96103->max_channels; i++) {
>  		ret = regmap_read(aw96103->regmap,
> -			AW96103_REG_BLFILT_CH0 + (AW96103_BLFILT_CH_STEP * i),
> +			AW96103_REG_BLFILT_CH0 + AW96103_BLFILT_CH_STEP * i,
>  			&blfilt1_data);
>  		if (ret)
>  			return ret;
> +
>  		if (FIELD_GET(AW96103_BLERRTRIG_MASK, blfilt1_data) != 1)
>  			return 0;
>  
>  		return regmap_update_bits(aw96103->regmap,
> -			AW96103_REG_BLRSTRNG_CH0 + (AW96103_BLFILT_CH_STEP * i),
> -			AW96103_BLRSTRNG_MASK, 1 << i);
> +			AW96103_REG_BLRSTRNG_CH0 + AW96103_BLFILT_CH_STEP * i,
> +			AW96103_BLRSTRNG_MASK, BIT(i));

This is a bug anyway so I've fixed that, but sure, can drop the brackets etc

>  	}

>  
>  	return 0;
> @@ -493,25 +498,22 @@ static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
>  				    struct aw_bin *aw_bin_data_s)
>  {
>  	unsigned int start_addr = aw_bin_data_s->valid_data_addr;
> -	u32 i, reg_data;
> +	unsigned int i;
> +	u32 reg_data;
>  	u16 reg_addr;
>  	int ret;
>  
> -	for (i = 0; i < aw_bin_data_s->valid_data_len;
> -	     i += 6, start_addr += 6) {
> +	for (i = 0; i < aw_bin_data_s->valid_data_len; i += 6, start_addr += 6) {
>  		reg_addr = get_unaligned_le16(aw_bin_data_s->data + start_addr);
> -		reg_data = get_unaligned_le32(aw_bin_data_s->data +
> -					      start_addr + 2);
> -		if ((reg_addr == AW96103_REG_EEDA0) ||
> -		    (reg_addr == AW96103_REG_EEDA1))
> +		reg_data = get_unaligned_le32(aw_bin_data_s->data + start_addr + 2);
> +		if ((reg_addr == AW96103_REG_EEDA0) || (reg_addr == AW96103_REG_EEDA1))
>  			continue;
Maybe. I'd not bother with the churn now but would have been slightly neater like this.

>  		if (reg_addr == AW96103_REG_IRQEN) {
>  			aw96103->hostirqen = reg_data;
>  			continue;
>  		}
>  		if (reg_addr == AW96103_REG_SCANCTRL0)
> -			aw96103->chan_en = FIELD_GET(AW96103_CHAN_EN_MASK,
> -						     reg_data);
> +			aw96103->chan_en = FIELD_GET(AW96103_CHAN_EN_MASK, reg_data);
>  
>  		ret = regmap_write(aw96103->regmap, reg_addr, reg_data);
>  		if (ret < 0)
> @@ -527,19 +529,21 @@ static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
>  
>  static int aw96103_para_loaded(struct aw96103 *aw96103)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(aw96103_reg_default); i += 2) {
> -		ret = regmap_write(aw96103->regmap,
> -				   (u16)aw96103_reg_default[i],
> -				   (u32)aw96103_reg_default[i + 1]);
> +		u16 offset = aw96103_reg_default[i];
> +		u32 value = aw96103_reg_default[i + 1];
> +
> +		ret = regmap_write(aw96103->regmap, offset, value);
>  		if (ret)
>  			return ret;
> -		if (aw96103_reg_default[i] == AW96103_REG_IRQEN)
> -			aw96103->hostirqen = aw96103_reg_default[i + 1];
> -		else if (aw96103_reg_default[i] == AW96103_REG_SCANCTRL0)
> -			aw96103->chan_en = FIELD_GET(AW96103_CHAN_EN_MASK,
> -					   aw96103_reg_default[i + 1]);
> +
> +		if (offset == AW96103_REG_IRQEN)
> +			aw96103->hostirqen = value;
> +		else if (offset == AW96103_REG_SCANCTRL0)
> +			aw96103->chan_en = FIELD_GET(AW96103_CHAN_EN_MASK, value);
That is indeed better.

>  	}
>  
>  	return aw96103_channel_scan_start(aw96103);
> @@ -567,7 +571,8 @@ static int aw96103_cfg_all_loaded(const struct firmware *cont,
>  static void aw96103_cfg_update(const struct firmware *fw, void *data)
>  {
>  	struct aw96103 *aw96103 = data;
> -	int ret, i;
> +	unsigned int i;
> +	int ret;
>  
>  	if (!fw || !fw->data) {
>  		dev_err(aw96103->dev, "No firmware.\n");
> @@ -588,12 +593,9 @@ static void aw96103_cfg_update(const struct firmware *fw, void *data)
>  		}
>  	}
>  
> -	for (i = 0; i < aw96103->max_channels; i++) {
> -		if ((aw96103->chan_en >> i) & 0x01)
> -			aw96103->channels_arr[i].used = true;
> -		else
> +	for (i = 0; i < aw96103->max_channels; i++)
> +		aw96103->channels_arr[i].used = aw96103->chan_en & BIT(i);
>  			aw96103->channels_arr[i].used = false;

That's not quite right as last line should go as well.
I did think about suggesting this in an earlier review, but it's
not particularly elegant either way.

> -	}
>  }
>  
>  static int aw96103_sw_reset(struct aw96103 *aw96103)
> @@ -603,7 +605,7 @@ static int aw96103_sw_reset(struct aw96103 *aw96103)
>  	ret = regmap_write(aw96103->regmap, AW96103_REG_RESET, 0);
>  	/*
>  	 * After reset, the initialization process starts to perform and
> -	 * it will last for a bout 20ms.
> +	 * it will last for about 20ms.
>  	 */
>  	msleep(20);
>  
> @@ -611,7 +613,7 @@ static int aw96103_sw_reset(struct aw96103 *aw96103)
>  }
>  
>  enum aw96103_irq_trigger_position {
> -	FAR = 0,
> +	FAR         = 0x00,
>  	TRIGGER_TH0 = 0x01,
>  	TRIGGER_TH1 = 0x03,
>  	TRIGGER_TH2 = 0x07,
> @@ -623,7 +625,8 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>  	unsigned int irq_status, curr_status_val, curr_status;
>  	struct iio_dev *indio_dev = data;
>  	struct aw96103 *aw96103 = iio_priv(indio_dev);
> -	int ret, i;
> +	unsigned int i;
Maybe, but if so move it to the set of unsigned ints above.

> +	int ret;
>  
>  	ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC, &irq_status);
>  	if (ret)
> @@ -641,10 +644,12 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>  		if (!aw96103->channels_arr[i].used)
>  			continue;
>  
> -		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> -			      (((curr_status_val >> (16 + i)) & 0x1) << 1) |
> -			      (((curr_status_val >> (8 + i)) & 0x1) << 2) |
> -			      (((curr_status_val >> i) & 0x1) << 3);
> +		curr_status = curr_status_val >> i;
> +		curr_status = ((curr_status >> 24 + 0) & BIT(0)) |
> +			      ((curr_status >> 16 + 1) & BIT(0)) |
> +			      ((curr_status >>  8 + 2) & BIT(0)) |
> +			      ((curr_status >>  0 + 3) & BIT(0));
Not sure that's the same.  I think they should be - as original was mixture of right
and left shifts and I'm also not convinced that is easier to read.
original was bad - this still is.


> +
>  		if (aw96103->channels_arr[i].old_irq_status == curr_status)
>  			continue;
>  
> @@ -675,8 +680,7 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int aw96103_interrupt_init(struct iio_dev *indio_dev,
> -				  struct i2c_client *i2c)
> +static int aw96103_interrupt_init(struct iio_dev *indio_dev, struct i2c_client *i2c)

No to that one. Not significantly more readable.

>  {
>  	struct aw96103 *aw96103 = iio_priv(indio_dev);
>  	unsigned int irq_status;
> @@ -685,9 +689,11 @@ static int aw96103_interrupt_init(struct iio_dev *indio_dev,
>  	ret = regmap_write(aw96103->regmap, AW96103_REG_IRQEN, 0);
>  	if (ret)
>  		return ret;
> +
>  	ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC, &irq_status);
>  	if (ret)
>  		return ret;
> +
These are reasonable whitespace improvements.

>  	ret = devm_request_threaded_irq(aw96103->dev, i2c->irq, NULL,
>  					aw96103_irq, IRQF_ONESHOT,
>  					"aw96103_irq", indio_dev);
> @@ -700,26 +706,17 @@ static int aw96103_interrupt_init(struct iio_dev *indio_dev,
>  
>  static int aw96103_wait_chip_init(struct aw96103 *aw96103)
>  {
> -	unsigned int cnt = 20;
>  	u32 reg_data;
>  	int ret;
>  
> -	while (cnt--) {
> -		/*
> -		 * The device should generate an initialization completion
> -		 * interrupt within 20ms.
> -		 */
> -		ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC,
> -				  &reg_data);
> -		if (ret)
> -			return ret;
> -
> -		if (FIELD_GET(AW96103_INITOVERIRQ_MASK, reg_data)
> -			return 0;
> -		fsleep(1000);
> -	}
> -
> -	return -ETIMEDOUT;
> +	/*
> +	 * The device should generate an initialization completion
> +	 * interrupt within 20ms.
> +	 */
> +	return regmap_read_poll_timeout(aw96103->regmap, AW96103_REG_IRQSRC,
> +				       reg_data,
> +				       FIELD_GET(AW96103_INITOVERIRQ_MASK, reg_data),
> +				       1000, 20000);
>  }
That's a good point. wangshuaijie, please create patches for the bits I
didn't say no to above.  They won't merge now until next cycle however.

Jonathan


>  
>  static int aw96103_read_chipid(struct aw96103 *aw96103)
> 


