Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5A550598
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiFROva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFROv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 10:51:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA7B17E1D;
        Sat, 18 Jun 2022 07:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B662BB80ABB;
        Sat, 18 Jun 2022 14:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC06AC3411A;
        Sat, 18 Jun 2022 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655563885;
        bh=4kuLQKxxkrRhT3u5UWmjDO7/mYT18nFTFGzmDPLDwmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KmuCglLOPO/961B+r0dSq4oLo7lcR5jVxZXp9T+6qRKKvPR1hprYXPVcjM/J6oSU0
         a4q56Qozohuxs1HfKFKEKtcZ+kvf+1jB/AtrwTAwrhe8wyj9ZQoDBxTes1RHdf/I4n
         BhQM1WtE93GG57mQSRKRMfOXbozX8Htnwb7GQ8wasx0JSTPOqAH2nwIop8K267mM9y
         p7Q7qcZJRdmizZANL2Amn/WwpM3wzZ669vPEaaeMxkAoglDrRayyKM8RYv8GLxvoih
         eZ0jPkatQ7DBGncXXMNbVGHcdo6Uxw4P14FAWXe8+hGuttRaoXVXM0g4mEyrjBqUtY
         BBvvDG8KELcEA==
Date:   Sat, 18 Jun 2022 16:00:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 6/8] iio: magnetometer: yas530: Rename functions and
 registers
Message-ID: <20220618160041.15798dcd@jic23-huawei>
In-Reply-To: <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jun 2022 02:13:14 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> This is a preparation for adding YAS537 variant.
> 
> Rename functions used only by YAS530 & YAS532 from yas5xx to yas530_532.

We've been bitten in the past by naming choices like this, so please
use yas530 only and rely on comments or code that makes it obvious that
it applies to the yas532 as well.

> Same for the registers.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 106 ++++++++++++-----------
>  1 file changed, 55 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index c6f5f25793c4..98c8d365fab7 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -40,20 +40,22 @@
>  
>  #include <asm/unaligned.h>
>  
> -/* This register map covers YAS530 and YAS532 but differs in YAS 537 and YAS539 */
> +/* Commonly used registers */
>  #define YAS5XX_DEVICE_ID		0x80
> -#define YAS5XX_ACTUATE_INIT_COIL	0x81
> -#define YAS5XX_MEASURE			0x82
> -#define YAS5XX_CONFIG			0x83
> -#define YAS5XX_MEASURE_INTERVAL		0x84
> -#define YAS5XX_OFFSET_X			0x85 /* [-31 .. 31] */
> -#define YAS5XX_OFFSET_Y1		0x86 /* [-31 .. 31] */
> -#define YAS5XX_OFFSET_Y2		0x87 /* [-31 .. 31] */
> -#define YAS5XX_TEST1			0x88
> -#define YAS5XX_TEST2			0x89
> -#define YAS5XX_CAL			0x90
>  #define YAS5XX_MEASURE_DATA		0xB0
>  
> +/* Registers used by YAS530 and YAS532 */
> +#define YAS530_532_ACTUATE_INIT_COIL	0x81
As below, don't start listing parts. Just go with the first one
and a comment to say it applies to other devices.  This approach
doesn't age well as a driver gains more supported parts.

#define YAS530_MEASURE is a better choice.

> +#define YAS530_532_MEASURE		0x82
> +#define YAS530_532_CONFIG		0x83
> +#define YAS530_532_MEASURE_INTERVAL	0x84
> +#define YAS530_532_OFFSET_X		0x85 /* [-31 .. 31] */
> +#define YAS530_532_OFFSET_Y1		0x86 /* [-31 .. 31] */
> +#define YAS530_532_OFFSET_Y2		0x87 /* [-31 .. 31] */
> +#define YAS530_532_TEST1		0x88
> +#define YAS530_532_TEST2		0x89
> +#define YAS530_532_CAL			0x90
> +
>  /* Bits in the YAS5xx config register */
>  #define YAS5XX_CONFIG_INTON		BIT(0) /* Interrupt on? */
>  #define YAS5XX_CONFIG_INTHACT		BIT(1) /* Interrupt active high? */
> @@ -182,7 +184,7 @@ static u16 yas532_extract_axis(u8 *data)
>  }
>  
>  /**
> - * yas5xx_measure() - Make a measure from the hardware
> + * yas530_532_measure() - Make a measure from the hardware
>   * @yas5xx: The device state
>   * @t: the raw temperature measurement
>   * @x: the raw x axis measurement
> @@ -190,7 +192,8 @@ static u16 yas532_extract_axis(u8 *data)
>   * @y2: the y2 axis measurement
>   * @return: 0 on success or error code
>   */
> -static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
> +static int yas530_532_measure(struct yas5xx *yas5xx, u16 *t,

This naming convention often causes us problems long run because
people feel they need to keep listing new devices that look similar.

Generally much better to just pick the first part that uses it and
name the function after that.  So here it would be simply
yas530_measure()

> +			      u16 *x, u16 *y1, u16 *y2)
>  {
>  	unsigned int busy;
>  	u8 data[8];
> @@ -198,7 +201,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
>  	u16 val;
>  
>  	mutex_lock(&yas5xx->lock);
> -	ret = regmap_write(yas5xx->map, YAS5XX_MEASURE, YAS5XX_MEASURE_START);
> +	ret = regmap_write(yas5xx->map, YAS530_532_MEASURE, YAS5XX_MEASURE_START);
>  	if (ret < 0)
>  		goto out_unlock;
>  
> @@ -264,7 +267,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
>  	return ret;
>  }
>  
> -static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
> +static s32 yas530_532_linearize(struct yas5xx *yas5xx, u16 val, int axis)
>  {
>  	struct yas5xx_calibration *c = &yas5xx->calibration;
>  	static const s32 yas532ac_coef[] = {
> @@ -306,7 +309,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
>  }
>  
>  /**
> - * yas5xx_get_measure() - Measure a sample of all axis and process
> + * yas530_532_get_measure() - Measure a sample of all axis and process
>   * @yas5xx: The device state
>   * @to: Temperature out
>   * @xo: X axis out
> @@ -314,7 +317,8 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
>   * @zo: Z axis out
>   * @return: 0 on success or error code
>   */
> -static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
> +static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
> +				  s32 *xo, s32 *yo, s32 *zo)
>  {
>  	struct yas5xx_calibration *c = &yas5xx->calibration;
>  	u16 t_ref, t, x, y1, y2;
> @@ -323,14 +327,14 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
>  	int ret;
>  
>  	/* We first get raw data that needs to be translated to [x,y,z] */
> -	ret = yas5xx_measure(yas5xx, &t, &x, &y1, &y2);
> +	ret = yas530_532_measure(yas5xx, &t, &x, &y1, &y2);
>  	if (ret)
>  		return ret;
>  
>  	/* Do some linearization if available */
> -	sx = yas5xx_linearize(yas5xx, x, 0);
> -	sy1 = yas5xx_linearize(yas5xx, y1, 1);
> -	sy2 = yas5xx_linearize(yas5xx, y2, 2);
> +	sx = yas530_532_linearize(yas5xx, x, 0);
> +	sy1 = yas530_532_linearize(yas5xx, y1, 1);
> +	sy2 = yas530_532_linearize(yas5xx, y2, 2);
>  
>  	/* Set the temperature reference value (unit: counts) */
>  	switch (yas5xx->devid) {
> @@ -602,11 +606,11 @@ static const struct regmap_config yas5xx_regmap_config = {
>  };
>  
>  /**
> - * yas53x_extract_calibration() - extracts the a2-a9 and k calibration
> + * yas530_532_extract_calibration() - extracts the a2-a9 and k calibration
>   * @data: the bitfield to use
>   * @c: the calibration to populate
>   */
> -static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
> +static void yas530_532_extract_calibration(u8 *data, struct yas5xx_calibration *c)
>  {
>  	u64 val = get_unaligned_be64(data);
>  
> @@ -644,12 +648,12 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
>  	int ret;
>  
>  	/* Dummy read, first read is ALWAYS wrong */
> -	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
> +	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
>  	if (ret)
>  		return ret;
>  
>  	/* Actual calibration readout */
> -	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
> +	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
>  	if (ret)
>  		return ret;
>  	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
> @@ -661,7 +665,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
>  	c->Cx = data[0] * 6 - 768;
>  	c->Cy1 = data[1] * 6 - 768;
>  	c->Cy2 = data[2] * 6 - 768;
> -	yas53x_extract_calibration(&data[3], c);
> +	yas530_532_extract_calibration(&data[3], c);
>  
>  	/*
>  	 * Extract linearization:
> @@ -692,11 +696,11 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
>  	int ret;
>  
>  	/* Dummy read, first read is ALWAYS wrong */
> -	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
> +	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
>  	if (ret)
>  		return ret;
>  	/* Actual calibration readout */
> -	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
> +	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
>  	if (ret)
>  		return ret;
>  	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
> @@ -715,7 +719,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
>  	c->Cx = data[0] * 10 - 1280;
>  	c->Cy1 = data[1] * 10 - 1280;
>  	c->Cy2 = data[2] * 10 - 1280;
> -	yas53x_extract_calibration(&data[3], c);
> +	yas530_532_extract_calibration(&data[3], c);
>  	/*
>  	 * Extract linearization:
>  	 * Linearization layout in the 32 bits at byte 10:
> @@ -738,7 +742,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
>  	return 0;
>  }
>  
> -static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
> +static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
>  {
>  	struct yas5xx_calibration *c = &yas5xx->calibration;
>  
> @@ -761,20 +765,20 @@ static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
>  	dev_dbg(yas5xx->dev, "dck = %d\n", c->dck);
>  }
>  
> -static int yas5xx_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
> +static int yas530_532_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
>  {
>  	int ret;
>  
> -	ret = regmap_write(yas5xx->map, YAS5XX_OFFSET_X, ox);
> +	ret = regmap_write(yas5xx->map, YAS530_532_OFFSET_X, ox);
>  	if (ret)
>  		return ret;
> -	ret = regmap_write(yas5xx->map, YAS5XX_OFFSET_Y1, oy1);
> +	ret = regmap_write(yas5xx->map, YAS530_532_OFFSET_Y1, oy1);
>  	if (ret)
>  		return ret;
> -	return regmap_write(yas5xx->map, YAS5XX_OFFSET_Y2, oy2);
> +	return regmap_write(yas5xx->map, YAS530_532_OFFSET_Y2, oy2);
>  }
>  
> -static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
> +static s8 yas530_532_adjust_offset(s8 old, int bit, u16 center, u16 measure)
>  {
>  	if (measure > center)
>  		return old + BIT(bit);
> @@ -783,7 +787,7 @@ static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
>  	return old;
>  }
>  
> -static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
> +static int yas530_532_measure_offsets(struct yas5xx *yas5xx)
>  {
>  	int ret;
>  	u16 center;
> @@ -792,7 +796,7 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
>  	int i;
>  
>  	/* Actuate the init coil and measure offsets */
> -	ret = regmap_write(yas5xx->map, YAS5XX_ACTUATE_INIT_COIL, 0);
> +	ret = regmap_write(yas5xx->map, YAS530_532_ACTUATE_INIT_COIL, 0);
>  	if (ret)
>  		return ret;
>  
> @@ -826,26 +830,26 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
>  	oy2 = 0;
>  
>  	for (i = 4; i >= 0; i--) {
> -		ret = yas5xx_set_offsets(yas5xx, ox, oy1, oy2);
> +		ret = yas530_532_set_offsets(yas5xx, ox, oy1, oy2);
>  		if (ret)
>  			return ret;
>  
> -		ret = yas5xx_measure(yas5xx, &t, &x, &y1, &y2);
> +		ret = yas530_532_measure(yas5xx, &t, &x, &y1, &y2);
>  		if (ret)
>  			return ret;
>  		dev_dbg(yas5xx->dev, "measurement %d: x=%d, y1=%d, y2=%d\n",
>  			5-i, x, y1, y2);
>  
> -		ox = yas5xx_adjust_offset(ox, i, center, x);
> -		oy1 = yas5xx_adjust_offset(oy1, i, center, y1);
> -		oy2 = yas5xx_adjust_offset(oy2, i, center, y2);
> +		ox = yas530_532_adjust_offset(ox, i, center, x);
> +		oy1 = yas530_532_adjust_offset(oy1, i, center, y1);
> +		oy2 = yas530_532_adjust_offset(oy2, i, center, y2);
>  	}
>  
>  	/* Needed for calibration algorithm */
>  	yas5xx->hard_offsets[0] = ox;
>  	yas5xx->hard_offsets[1] = oy1;
>  	yas5xx->hard_offsets[2] = oy2;
> -	ret = yas5xx_set_offsets(yas5xx, ox, oy1, oy2);
> +	ret = yas530_532_set_offsets(yas5xx, ox, oy1, oy2);
>  	if (ret)
>  		return ret;
>  
> @@ -854,27 +858,27 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
>  	return 0;
>  }
>  
> -static int yas5xx_power_on(struct yas5xx *yas5xx)
> +static int yas530_532_power_on(struct yas5xx *yas5xx)
>  {
>  	unsigned int val;
>  	int ret;
>  
>  	/* Zero the test registers */
> -	ret = regmap_write(yas5xx->map, YAS5XX_TEST1, 0);
> +	ret = regmap_write(yas5xx->map, YAS530_532_TEST1, 0);
>  	if (ret)
>  		return ret;
> -	ret = regmap_write(yas5xx->map, YAS5XX_TEST2, 0);
> +	ret = regmap_write(yas5xx->map, YAS530_532_TEST2, 0);
>  	if (ret)
>  		return ret;
>  
>  	/* Set up for no interrupts, calibrated clock divider */
>  	val = FIELD_PREP(YAS5XX_CONFIG_CCK_MASK, yas5xx->calibration.dck);
> -	ret = regmap_write(yas5xx->map, YAS5XX_CONFIG, val);
> +	ret = regmap_write(yas5xx->map, YAS530_532_CONFIG, val);
>  	if (ret)
>  		return ret;
>  
>  	/* Measure interval 0 (back-to-back?)  */
> -	return regmap_write(yas5xx->map, YAS5XX_MEASURE_INTERVAL, 0);
> +	return regmap_write(yas5xx->map, YAS530_532_MEASURE_INTERVAL, 0);
>  }
>  
>  static int yas5xx_probe(struct i2c_client *i2c,
> @@ -956,11 +960,11 @@ static int yas5xx_probe(struct i2c_client *i2c,
>  		goto assert_reset;
>  	}
>  
> -	yas5xx_dump_calibration(yas5xx);
> -	ret = yas5xx_power_on(yas5xx);
> +	yas530_532_dump_calibration(yas5xx);
> +	ret = yas530_532_power_on(yas5xx);
>  	if (ret)
>  		goto assert_reset;
> -	ret = yas5xx_meaure_offsets(yas5xx);
> +	ret = yas530_532_measure_offsets(yas5xx);
>  	if (ret)
>  		goto assert_reset;
>  

