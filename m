Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38F69BA48
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 14:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBRNoK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 08:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRNoJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 08:44:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C013518
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 05:44:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93318CE233A
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 13:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B1C433EF;
        Sat, 18 Feb 2023 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676727843;
        bh=7FEWJrMqCIvYum6ik4X43RPu/TX2z2oWg+49x/4DRNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SSCtMJPHGM2YLcecqGcCjF8FwiMQxb+zdnF61fv0Q3u2bqIHOfBelZB1hrmqolmBJ
         4Ixr712KqKAW20GtE7ZWwHIUUWtoQr9vLE0NIDlT1q3jccwJQbE4L2Oj2JGPtOythp
         zzPYZ0xogrQA2c4MIenqw0Xqp3cMEqkMF5xyicxvLkv5KjM5b5zJbR14fvD6yucRMs
         JeK7c565u/4YINRCvL8fi/No3SfEk7csIOWDyrZH98dPugm5fxArxEKof9bU8gnqxg
         eDP13Sdg0PNru1A+5qU2EYuMyeLU5gzWorNsBKuU4oqvU2EzakXlMZmEljlIUsT8ne
         lauDnuSwpc96w==
Date:   Sat, 18 Feb 2023 13:58:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     dianders@chromium.org, swboyd@chromium.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: proximity: sx_common: Add old register mapping
Message-ID: <20230218135823.488c6094@jic23-huawei>
In-Reply-To: <20230211002421.3447060-1-gwendal@chromium.org>
References: <20230211002421.3447060-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Feb 2023 16:24:21 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Older firmwares still send sensor configuration using a list of
> registers with opaque values defined during sensor tuning.
> sx9234 and sx9360 sensor on ACPI based devices are concerned.
> More schema to configure the sensors will be needed to support devices
> designed for windows, like Samsung Galaxy Book2.
> 
> Support schema is: "<_HID>.<register_name>". For instance
> "STH9324,reg_adv_ctrl2" in:
> 
>     Scope (\_SB.PCI0.I2C2)
>     {
>         Device (SX28)
>         {
>             Name (_HID, "STH9324")  // _HID: Hardware ID
> ...
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> Device Properties for _DSD */,
>                 Package (0x3F)
>                 {
> ...
>                     Package (0x02)
>                     {
>                         "STH9324,reg_adv_ctrl2",
>                         Zero
>                     },`
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Applied to the togreg branch of iio.git but for now I'll only push it out as
testing until I can rebase that tree on rc1 in a few weeks time.

I'd slightly have preferred adding the stubs to the ACPI header but that
can always happen at a later date.

Jonathan

> ---
> Changes since v3:
> - Fix compilation issue when CONFIG_ACPI is not defined (ARM).
> 
> Changes since v2:
> - Use snprintf instead of scnprintf
> - Use acpi_device_hid() from the ACPI companion device to get the device
>   name.
> 
> Changes since v1:
> - remove double empty lines.
> - Add |property| field at end of structure to minimize changes.
> - Cache acpi_id entry, use standard API to retrieve it from parent
>   device.
> - Use that entry to see if a legacy APCI entry exists.
> 
>  drivers/iio/proximity/sx9324.c    | 96 ++++++++++++++++---------------
>  drivers/iio/proximity/sx9360.c    | 32 +++++------
>  drivers/iio/proximity/sx_common.c | 21 +++++++
>  drivers/iio/proximity/sx_common.h |  5 ++
>  4 files changed, 92 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 977cf17cec52b..9a40ca32bb1ca 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -783,73 +783,75 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
>  
>  static const struct sx_common_reg_default sx9324_default_regs[] = {
>  	{ SX9324_REG_IRQ_MSK, 0x00 },
> -	{ SX9324_REG_IRQ_CFG0, 0x00 },
> -	{ SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND },
> -	{ SX9324_REG_IRQ_CFG2, 0x00 },
> -	{ SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS },
> +	{ SX9324_REG_IRQ_CFG0, 0x00, "irq_cfg0" },
> +	{ SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND, "irq_cfg1" },
> +	{ SX9324_REG_IRQ_CFG2, 0x00, "irq_cfg2" },
> +	{ SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS, "gnrl_ctrl0" },
>  	/*
>  	 * The lower 4 bits should not be set as it enable sensors measurements.
>  	 * Turning the detection on before the configuration values are set to
>  	 * good values can cause the device to return erroneous readings.
>  	 */
> -	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
> +	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL, "gnrl_ctrl1" },
>  
> -	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST },
> -	{ SX9324_REG_AFE_CTRL3, 0x00 },
> +	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST, "afe_ctrl0" },
> +	{ SX9324_REG_AFE_CTRL3, 0x00, "afe_ctrl3" },
>  	{ SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
> -		SX9324_REG_AFE_CTRL4_RES_100 },
> -	{ SX9324_REG_AFE_CTRL6, 0x00 },
> +		SX9324_REG_AFE_CTRL4_RES_100, "afe_ctrl4" },
> +	{ SX9324_REG_AFE_CTRL6, 0x00, "afe_ctrl6" },
>  	{ SX9324_REG_AFE_CTRL7, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
> -		SX9324_REG_AFE_CTRL4_RES_100 },
> +		SX9324_REG_AFE_CTRL4_RES_100, "afe_ctrl7" },
>  
>  	/* TODO(gwendal): PHx use chip default or all grounded? */
> -	{ SX9324_REG_AFE_PH0, 0x29 },
> -	{ SX9324_REG_AFE_PH1, 0x26 },
> -	{ SX9324_REG_AFE_PH2, 0x1a },
> -	{ SX9324_REG_AFE_PH3, 0x16 },
> +	{ SX9324_REG_AFE_PH0, 0x29, "afe_ph0" },
> +	{ SX9324_REG_AFE_PH1, 0x26, "afe_ph1" },
> +	{ SX9324_REG_AFE_PH2, 0x1a, "afe_ph2" },
> +	{ SX9324_REG_AFE_PH3, 0x16, "afe_ph3" },
>  
>  	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESERVED |
> -		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },
> -	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
> +		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM, "afe_ctrl8" },
> +	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1, "afe_ctrl9" },
>  
>  	{ SX9324_REG_PROX_CTRL0,
>  		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
> -		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> +		SX9324_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0" },
>  	{ SX9324_REG_PROX_CTRL1,
>  		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
> -		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
> +		SX9324_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl1" },
> +	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K, "prox_ctrl2" },
>  	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
> -		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
> +		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K, "prox_ctrl3" },
>  	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
> -		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 },
> -	{ SX9324_REG_PROX_CTRL5, 0x00 },
> -	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> -	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> -	{ SX9324_REG_ADV_CTRL0, 0x00 },
> -	{ SX9324_REG_ADV_CTRL1, 0x00 },
> -	{ SX9324_REG_ADV_CTRL2, 0x00 },
> -	{ SX9324_REG_ADV_CTRL3, 0x00 },
> -	{ SX9324_REG_ADV_CTRL4, 0x00 },
> +		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256, "prox_ctrl4" },
> +	{ SX9324_REG_PROX_CTRL5, 0x00, "prox_ctrl5" },
> +	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32, "prox_ctrl6" },
> +	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32, "prox_ctrl7" },
> +	{ SX9324_REG_ADV_CTRL0, 0x00, "adv_ctrl0" },
> +	{ SX9324_REG_ADV_CTRL1, 0x00, "adv_ctrl1" },
> +	{ SX9324_REG_ADV_CTRL2, 0x00, "adv_ctrl2" },
> +	{ SX9324_REG_ADV_CTRL3, 0x00, "adv_ctrl3" },
> +	{ SX9324_REG_ADV_CTRL4, 0x00, "adv_ctrl4" },
>  	{ SX9324_REG_ADV_CTRL5, SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1 |
> -		SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1 },
> -	{ SX9324_REG_ADV_CTRL6, 0x00 },
> -	{ SX9324_REG_ADV_CTRL7, 0x00 },
> -	{ SX9324_REG_ADV_CTRL8, 0x00 },
> -	{ SX9324_REG_ADV_CTRL9, 0x00 },
> +		SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1, "adv_ctrl5" },
> +	{ SX9324_REG_ADV_CTRL6, 0x00, "adv_ctrl6" },
> +	{ SX9324_REG_ADV_CTRL7, 0x00, "adv_ctrl7" },
> +	{ SX9324_REG_ADV_CTRL8, 0x00, "adv_ctrl8" },
> +	{ SX9324_REG_ADV_CTRL9, 0x00, "adv_ctrl9" },
>  	/* Body/Table threshold */
> -	{ SX9324_REG_ADV_CTRL10, 0x00 },
> -	{ SX9324_REG_ADV_CTRL11, 0x00 },
> -	{ SX9324_REG_ADV_CTRL12, 0x00 },
> +	{ SX9324_REG_ADV_CTRL10, 0x00, "adv_ctrl10" },
> +	{ SX9324_REG_ADV_CTRL11, 0x00, "adv_ctrl11" },
> +	{ SX9324_REG_ADV_CTRL12, 0x00, "adv_ctrl12" },
>  	/* TODO(gwendal): SAR currenly disabled */
> -	{ SX9324_REG_ADV_CTRL13, 0x00 },
> -	{ SX9324_REG_ADV_CTRL14, 0x00 },
> -	{ SX9324_REG_ADV_CTRL15, 0x00 },
> -	{ SX9324_REG_ADV_CTRL16, 0x00 },
> -	{ SX9324_REG_ADV_CTRL17, 0x00 },
> -	{ SX9324_REG_ADV_CTRL18, 0x00 },
> -	{ SX9324_REG_ADV_CTRL19, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> -	{ SX9324_REG_ADV_CTRL20, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> +	{ SX9324_REG_ADV_CTRL13, 0x00, "adv_ctrl13" },
> +	{ SX9324_REG_ADV_CTRL14, 0x00, "adv_ctrl14" },
> +	{ SX9324_REG_ADV_CTRL15, 0x00, "adv_ctrl15" },
> +	{ SX9324_REG_ADV_CTRL16, 0x00, "adv_ctrl16" },
> +	{ SX9324_REG_ADV_CTRL17, 0x00, "adv_ctrl17" },
> +	{ SX9324_REG_ADV_CTRL18, 0x00, "adv_ctrl18" },
> +	{ SX9324_REG_ADV_CTRL19,
> +		SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION, "adv_ctrl19" },
> +	{ SX9324_REG_ADV_CTRL20,
> +		SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION, "adv_ctrl20" },
>  };
>  
>  /* Activate all channels and perform an initial compensation. */
> @@ -889,13 +891,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	const char *res;
>  
>  	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
> +
> +	sx_common_get_raw_register_config(dev, reg_def);
>  	switch (reg_def->reg) {
>  	case SX9324_REG_AFE_PH0:
>  	case SX9324_REG_AFE_PH1:
>  	case SX9324_REG_AFE_PH2:
>  	case SX9324_REG_AFE_PH3:
>  		ph = reg_def->reg - SX9324_REG_AFE_PH0;
> -		scnprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
> +		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
>  
>  		count = device_property_count_u32(dev, prop);
>  		if (count != ARRAY_SIZE(pin_defs))
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 6e19d22e6a015..a50d9176411a1 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -663,37 +663,37 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
>  
>  static const struct sx_common_reg_default sx9360_default_regs[] = {
>  	{ SX9360_REG_IRQ_MSK, 0x00 },
> -	{ SX9360_REG_IRQ_CFG, 0x00 },
> +	{ SX9360_REG_IRQ_CFG, 0x00, "irq_cfg" },
>  	/*
>  	 * The lower 2 bits should not be set as it enable sensors measurements.
>  	 * Turning the detection on before the configuration values are set to
>  	 * good values can cause the device to return erroneous readings.
>  	 */
> -	{ SX9360_REG_GNRL_CTRL0, 0x00 },
> -	{ SX9360_REG_GNRL_CTRL1, 0x00 },
> -	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
> +	{ SX9360_REG_GNRL_CTRL0, 0x00, "gnrl_ctrl0" },
> +	{ SX9360_REG_GNRL_CTRL1, 0x00, "gnrl_ctrl1" },
> +	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS, "gnrl_ctrl2" },
>  
> -	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS },
> +	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS, "afe_ctrl0" },
>  	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
> -		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
> +		SX9360_REG_AFE_PARAM0_RESOLUTION_128, "afe_param0_phr" },
>  	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> -		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
> +		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phr" },
>  	{ SX9360_REG_AFE_PARAM0_PHM, SX9360_REG_AFE_PARAM0_RSVD |
> -		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
> +		SX9360_REG_AFE_PARAM0_RESOLUTION_128, "afe_param0_phm" },
>  	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> -		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
> +		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phm" },
>  
>  	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
> -		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
> +		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phr" },
>  	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
> -		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
> +		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phm" },
> +	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K, "prox_ctrl1" },
>  	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
> -		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K },
> +		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K, "prox_ctrl2" },
>  	{ SX9360_REG_PROX_CTRL3, SX9360_REG_PROX_CTRL3_AVGNEG_FILT_2 |
> -		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256 },
> -	{ SX9360_REG_PROX_CTRL4, 0x00 },
> -	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32 },
> +		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256, "prox_ctrl3" },
> +	{ SX9360_REG_PROX_CTRL4, 0x00, "prox_ctrl4" },
> +	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32, "prox_ctrl5" },
>  };
>  
>  /* Activate all channels and perform an initial compensation. */
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index eba9256730ec1..fe07d1444ac37 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -424,6 +424,27 @@ static const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
>  	.postdisable = sx_common_buffer_postdisable,
>  };
>  
> +void sx_common_get_raw_register_config(struct device *dev,
> +				       struct sx_common_reg_default *reg_def)
> +{
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	u32 raw = 0, ret;
> +	char prop[80];
> +
> +	if (!reg_def->property || !adev)
> +		return;
> +
> +	snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_hid(adev), reg_def->property);
> +	ret = device_property_read_u32(dev, prop, &raw);
> +	if (ret)
> +		return;
> +
> +	reg_def->def = raw;
> +#endif
> +}
> +EXPORT_SYMBOL_NS_GPL(sx_common_get_raw_register_config, SEMTECH_PROX);
> +
>  #define SX_COMMON_SOFT_RESET				0xde
>  
>  static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
> diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> index 49d4517103b0f..85bb5af7c6ea0 100644
> --- a/drivers/iio/proximity/sx_common.h
> +++ b/drivers/iio/proximity/sx_common.h
> @@ -8,6 +8,7 @@
>  #ifndef IIO_SX_COMMON_H
>  #define IIO_SX_COMMON_H
>  
> +#include <linux/acpi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
>  #include <linux/regulator/consumer.h>
> @@ -26,6 +27,7 @@ static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
>  struct sx_common_reg_default {
>  	u8 reg;
>  	u8 def;
> +	const char *property;
>  };
>  
>  /**
> @@ -149,6 +151,9 @@ int sx_common_probe(struct i2c_client *client,
>  		    const struct sx_common_chip_info *chip_info,
>  		    const struct regmap_config *regmap_config);
>  
> +void sx_common_get_raw_register_config(struct device *dev,
> +				       struct sx_common_reg_default *reg_def);
> +
>  /* 3 is the number of events defined by a single phase. */
>  extern const struct iio_event_spec sx_common_events[3];
>  

