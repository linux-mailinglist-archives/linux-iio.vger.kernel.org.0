Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458C7479C8B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 21:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhLRUWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 15:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhLRUWb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 15:22:31 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66FC061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:22:30 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id m6so5652301qvh.10
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2bQihXVcduTMb7xYRfRhu+Gih+Pyo7UPfTGRZ4hM9Ic=;
        b=ddaW292dYP8Ni1iS23og7KAyaKZUYrajrNPH9BzRg9D+fLhX6LeVAl4Ly1XqQ4M//0
         n0Gf3bbh9V85UgXnVbHHxqN8SH0tHvGRgZfgHtuIfmzgQoBcsCerWKSj4Vg5pcESjF5P
         sT5jYTOEbgvEteswsMNJOUt0cnlXZ+5Nmqb61XKJfNb2WQt4wWNzq/zUsCO9pPGR+G2a
         liB+MIIB6JN5kGmFwmE05bSE4P8+XixQLcJ7c9YgJ+m7uYNBLdMHGvsIwJcUaxENKDM/
         qOryU0pLARo5MpiL3LoXfQcmscshufMgBuxFV5b4n2sQWGRo0mhJIjhzz0LMwctKqDiT
         8HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2bQihXVcduTMb7xYRfRhu+Gih+Pyo7UPfTGRZ4hM9Ic=;
        b=UItDoj1/wzgoRoHP2HM16FJ+1Q7qWIrNK7Sc0Jb8foy3SwgZ/omHljVjKSqhn2cFpu
         TBeDbSsgIWphNN+16158GNzMGnKnwR9H6U6QaVJ7WhVrmooHxzUUaswH6H96jgJ5Vgdt
         j2aCGtxlz+LkX3MWW25I4lhDO8wSpnox9wZi8RW6Fj56vC2srZtjLAgugEZPhciH/e4a
         Bag5RcnxHTWZcy71Dqz/4h/B6fs6I49nYYj7S0NiEJDo3prBDgwFqNYKaAIMF2GvkiOa
         FGGIhln9NJuir4pU4kcc4mHn1UR1sNkXCfFihE9M5oOSFE96lP/A3sVpCz0SDXkwPk74
         N+cw==
X-Gm-Message-State: AOAM530Mr8kfBIQoieg2M2AUu2vBpUm6vUr/dSYJoC17SE17O5uIcyeE
        0o1T0mW6g8X4VSnbtHMkGuwh+YWQJko=
X-Google-Smtp-Source: ABdhPJweKyEslU4o8gIvTV0GIp5v2XLk5BshQYlGB7RlwZEZ89E2QtpoGhxbhkDqCmMeom+3OqCA9w==
X-Received: by 2002:a05:6214:27cf:: with SMTP id ge15mr7284793qvb.129.1639858949970;
        Sat, 18 Dec 2021 12:22:29 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id bq36sm7702877qkb.6.2021.12.18.12.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:22:29 -0800 (PST)
Date:   Sat, 18 Dec 2021 17:22:26 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/17] staging:iio:adc:ad7280a: Make
 oversampling_ratio a runtime control
Message-ID: <Yb5DAqsfNK30AIJ3@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-11-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211205202710.2847005-11-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Oversampling has nothing directly to do with analog circuits or
> similar so belongs in the control of userspace as a policy decision.
> 
> The only complexity in here was that the acquisition time needs
> updating if this setting is changed at runtime (as oversampling
> is time consuming).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 100 +++++++++++++++++++++---------
>  drivers/staging/iio/adc/ad7280a.h |   6 --
>  2 files changed, 72 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b186dda03432..90241560f5cf 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -129,6 +129,10 @@
>  
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F
> +
> +static const unsigned short ad7280a_n_avg[4] = {1, 2, 4, 8};
> +static const unsigned short ad7280a_t_acq_ns[4] = {465, 1010, 1460, 1890};
> +
>  /* 5-bit device address is sent LSB first */
>  static unsigned int ad7280a_devaddr(unsigned int addr)
>  {
> @@ -161,7 +165,8 @@ struct ad7280_state {
>  	int				scan_cnt;
>  	int				readback_delay_us;
>  	unsigned char			crc_tab[CRC8_TABLE_SIZE];
> -	unsigned char			ctrl_hb;
> +	u8				oversampling_ratio;
> +	u8				acquisition_time;
>  	unsigned char			ctrl_lb;
>  	unsigned char			cell_threshhigh;
>  	unsigned char			cell_threshlow;
> @@ -260,7 +265,8 @@ static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
>  				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
>  			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
>  				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
> -			   st->ctrl_hb);
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
>  	if (ret)
>  		return ret;
>  
> @@ -270,7 +276,8 @@ static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
>  				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
>  			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
>  				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
> -			   st->ctrl_hb);
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
>  	if (ret)
>  		return ret;
>  
> @@ -310,7 +317,8 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
>  				      AD7280A_CTRL_HB_CONV_INPUT_ALL) |
>  			   FIELD_PREP(AD7280A_CTRL_HB_CONV_RREAD_MSK,
>  				      AD7280A_CTRL_HB_CONV_RREAD_NO) |
> -			   st->ctrl_hb);
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
>  	if (ret)
>  		return ret;
>  
> @@ -321,7 +329,8 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
>  				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
>  			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
>  				      AD7280A_CTRL_HB_CONV_START_CS) |
> -			   st->ctrl_hb);
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
>  	if (ret)
>  		return ret;
>  
> @@ -359,7 +368,8 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
>  				      AD7280A_CTRL_HB_CONV_RREAD_ALL) |
>  			   FIELD_PREP(AD7280A_CTRL_HB_CONV_START_MSK,
>  				      AD7280A_CTRL_HB_CONV_START_CS) |
> -			   st->ctrl_hb);
> +			   FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK,
> +				      st->oversampling_ratio));
>  	if (ret)
>  		return ret;
>  
> @@ -389,7 +399,8 @@ static void ad7280_sw_power_down(void *data)
>  	struct ad7280_state *st = data;
>  
>  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
> +		     AD7280A_CTRL_HB_PWRDN_SW |
> +		     FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, st->oversampling_ratio));
>  }
>  
>  static int ad7280_chain_setup(struct ad7280_state *st)
> @@ -442,7 +453,8 @@ static int ad7280_chain_setup(struct ad7280_state *st)
>  
>  error_power_down:
>  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CTRL_HB_REG, 1,
> -		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
> +		     AD7280A_CTRL_HB_PWRDN_SW |
> +		     FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, st->oversampling_ratio));
>  
>  	return ret;
>  }
> @@ -590,6 +602,7 @@ static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
>  	chan->indexed = 1;
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>  	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
>  	chan->address = addr;
>  	chan->scan_index = cnt;
>  	chan->scan_type.sign = 'u';
> @@ -814,6 +827,26 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static void ad7280_update_delay(struct ad7280_state *st)
> +{
> +	/*
> +	 * Total Conversion Time = ((tACQ + tCONV) *
> +	 *			   (Number of Conversions per Part)) −
> +	 *			   tACQ + ((N - 1) * tDELAY)
> +	 *
> +	 * Readback Delay = Total Conversion Time + tWAIT
> +	 */
> +
> +	st->readback_delay_us =
> +		((ad7280a_t_acq_ns[st->acquisition_time & 0x3] + 695) *
> +			(AD7280A_NUM_CH * ad7280a_n_avg[st->oversampling_ratio & 0x3])) -
> +		ad7280a_t_acq_ns[st->acquisition_time & 0x3] + st->slave_num * 250;
> +
> +	/* Convert to usecs */
> +	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);
> +	st->readback_delay_us += 5; /* Add tWAIT */
> +}
> +
>  static int ad7280_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val,
> @@ -847,19 +880,46 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  
>  		*val2 = AD7280A_BITS;
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = ad7280a_n_avg[st->oversampling_ratio];
> +		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
>  }
>  
> +static int ad7280_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad7280_state *st = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2 != 0)
> +			return -EINVAL;
> +		for (i = 0; i < ARRAY_SIZE(ad7280a_n_avg); i++) {
> +			if (val == ad7280a_n_avg[i]) {
> +				st->oversampling_ratio = i;
> +				ad7280_update_delay(st);
> +				return 0;
> +			}
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_info ad7280_info = {
>  	.read_raw = ad7280_read_raw,
> +	.write_raw = ad7280_write_raw,
>  	.read_event_value = &ad7280a_read_thresh,
>  	.write_event_value = &ad7280a_write_thresh,
>  };
>  
>  static const struct ad7280_platform_data ad7793_default_pdata = {
>  	.acquisition_time = AD7280A_ACQ_TIME_400ns,
> -	.conversion_averaging = AD7280A_CONV_AVG_DIS,
>  	.thermistor_term_en = true,
>  };
>  
> @@ -868,8 +928,6 @@ static int ad7280_probe(struct spi_device *spi)
>  	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad7280_state *st;
>  	int ret;
> -	const unsigned short t_acq_ns[4] = {465, 1010, 1460, 1890};
> -	const unsigned short n_avg[4] = {1, 2, 4, 8};
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -892,7 +950,7 @@ static int ad7280_probe(struct spi_device *spi)
>  
>  	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, pdata->acquisition_time) |
>  		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, pdata->thermistor_term_en);
> -	st->ctrl_hb = FIELD_PREP(AD7280A_CTRL_HB_CONV_AVG_MSK, pdata->conversion_averaging);
> +	st->oversampling_ratio = 0; /* No oversampling */
>  
>  	ret = ad7280_chain_setup(st);
>  	if (ret < 0)
> @@ -902,27 +960,13 @@ static int ad7280_probe(struct spi_device *spi)
>  	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
>  	st->cell_threshhigh = 0xFF;
>  	st->aux_threshhigh = 0xFF;
> +	st->acquisition_time = pdata->acquisition_time;
>  
>  	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Total Conversion Time = ((tACQ + tCONV) *
> -	 *			   (Number of Conversions per Part)) −
> -	 *			   tACQ + ((N - 1) * tDELAY)
> -	 *
> -	 * Readback Delay = Total Conversion Time + tWAIT
> -	 */
> -
> -	st->readback_delay_us =
> -		((t_acq_ns[pdata->acquisition_time & 0x3] + 695) *
> -		 (AD7280A_NUM_CH * n_avg[pdata->conversion_averaging & 0x3])) -
> -		t_acq_ns[pdata->acquisition_time & 0x3] + st->slave_num * 250;
> -
> -	/* Convert to usecs */
> -	st->readback_delay_us = DIV_ROUND_UP(st->readback_delay_us, 1000);
> -	st->readback_delay_us += 5; /* Add tWAIT */
> +	ad7280_update_delay(st);
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> index 23f18bb9e279..99297789a46d 100644
> --- a/drivers/staging/iio/adc/ad7280a.h
> +++ b/drivers/staging/iio/adc/ad7280a.h
> @@ -17,11 +17,6 @@
>  #define AD7280A_ACQ_TIME_1200ns			2
>  #define AD7280A_ACQ_TIME_1600ns			3
>  
> -#define AD7280A_CONV_AVG_DIS			0
> -#define AD7280A_CONV_AVG_2			1
> -#define AD7280A_CONV_AVG_4			2
> -#define AD7280A_CONV_AVG_8			3
> -
>  #define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
>  #define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
>  #define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
> @@ -29,7 +24,6 @@
>  
>  struct ad7280_platform_data {
>  	unsigned int		acquisition_time;
> -	unsigned int		conversion_averaging;
>  	unsigned int		chain_last_alert_ignore;
>  	bool			thermistor_term_en;
>  };
> -- 
> 2.34.1
> 
