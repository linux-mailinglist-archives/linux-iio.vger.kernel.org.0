Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F68649469
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiLKNZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNZt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:25:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E60FAEA
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A8B360DE6
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE354C433D2;
        Sun, 11 Dec 2022 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765146;
        bh=J61/60hNOlApIAlcwc8vYF7WNiYya8AOAwdpjuzA6hg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sHttPON5fTkQWSipVvICMz59NqXlqocsTN5KmojXly921y75mYzzVfarfq2SK1xqY
         F6twyD4XGILGerqvPyGj0j0T8ibrLuC+D10WSqXqqQZJvA6zBbw03fQM/5RfWEB4Pd
         o48wRzNhKY8PZcEUjAxM01X+RV3lxhEmF4TonWRAs+H9Izh14r9GswfajEaj1vsFet
         YDs05f0vypPabDmeypIlMMPdikbRbh18qg7FHNlZDSolymxqgWTQjWUEEuLAC0f3H4
         f9wd13K35j8tWfU8iQqnAPBHU2htoMpjANzH6IQKYINHEPqXfbdr0X88mDYBGhvRKZ
         ALc0vbDtTeiEg==
Date:   Sun, 11 Dec 2022 13:38:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     linux-iio@vger.kernel.org, swboyd@chromium.org,
        victording@chromium.org
Subject: Re: [PATCH] iio: proximity: sx_common: Add old register mapping
Message-ID: <20221211133841.7ae99a88@jic23-huawei>
In-Reply-To: <20221208184812.53754-1-gwendal@chromium.org>
References: <20221208184812.53754-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Thu,  8 Dec 2022 10:48:12 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Older firmwares still send sensor configuration using a list of
> registers with opaque values defined during sensor tuning.
> sx9234 and sx9360 sensor on ACPI based devices are concerned.

This is weird enough that I'd like to see some form of documentation or
at least an example of the DSDT disassembly for this.

> More schema to configure the sensors will be needed to support devices
> designed for windows, like Samsung Galaxy Book2.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c    |  50 +++++++--------
>  drivers/iio/proximity/sx9324.c    | 101 ++++++++++++++++--------------
>  drivers/iio/proximity/sx9360.c    |  40 ++++++------
>  drivers/iio/proximity/sx_common.c |  26 ++++++++
>  drivers/iio/proximity/sx_common.h |   5 ++
>  5 files changed, 132 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 0e4747ccd3cf7..e8f8c727d2467 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -726,45 +726,45 @@ static int sx9310_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct sx_common_reg_default sx9310_default_regs[] = {
> -	{ SX9310_REG_IRQ_MSK, 0x00 },
> -	{ SX9310_REG_IRQ_FUNC, 0x00 },
> +	{ NULL, SX9310_REG_IRQ_MSK, 0x00 },
> +	{ NULL, SX9310_REG_IRQ_FUNC, 0x00 },
>  	/*
>  	 * The lower 4 bits should not be set as it enable sensors measurements.
>  	 * Turning the detection on before the configuration values are set to
>  	 * good values can cause the device to return erroneous readings.
>  	 */
> -	{ SX9310_REG_PROX_CTRL0, SX9310_REG_PROX_CTRL0_SCANPERIOD_15MS },
> -	{ SX9310_REG_PROX_CTRL1, 0x00 },
> -	{ SX9310_REG_PROX_CTRL2, SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2 |
> +	{ NULL, SX9310_REG_PROX_CTRL0, SX9310_REG_PROX_CTRL0_SCANPERIOD_15MS },
> +	{ NULL, SX9310_REG_PROX_CTRL1, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL2, SX9310_REG_PROX_CTRL2_COMBMODE_CS1_CS2 |
>  				 SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC },
> -	{ SX9310_REG_PROX_CTRL3, SX9310_REG_PROX_CTRL3_GAIN0_X8 |
> +	{ NULL, SX9310_REG_PROX_CTRL3, SX9310_REG_PROX_CTRL3_GAIN0_X8 |
>  				 SX9310_REG_PROX_CTRL3_GAIN12_X4 },
> -	{ SX9310_REG_PROX_CTRL4, SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST },
> -	{ SX9310_REG_PROX_CTRL5, SX9310_REG_PROX_CTRL5_RANGE_SMALL |
> +	{ NULL, SX9310_REG_PROX_CTRL4, SX9310_REG_PROX_CTRL4_RESOLUTION_FINEST },
> +	{ NULL, SX9310_REG_PROX_CTRL5, SX9310_REG_PROX_CTRL5_RANGE_SMALL |
>  				 SX9310_REG_PROX_CTRL5_STARTUPSENS_CS1 |
>  				 SX9310_REG_PROX_CTRL5_RAWFILT_1P25 },
> -	{ SX9310_REG_PROX_CTRL6, SX9310_REG_PROX_CTRL6_AVGTHRESH_DEFAULT },
> -	{ SX9310_REG_PROX_CTRL7, SX9310_REG_PROX_CTRL7_AVGNEGFILT_2 |
> +	{ NULL, SX9310_REG_PROX_CTRL6, SX9310_REG_PROX_CTRL6_AVGTHRESH_DEFAULT },
> +	{ NULL, SX9310_REG_PROX_CTRL7, SX9310_REG_PROX_CTRL7_AVGNEGFILT_2 |
>  				 SX9310_REG_PROX_CTRL7_AVGPOSFILT_512 },
> -	{ SX9310_REG_PROX_CTRL8, SX9310_REG_PROX_CTRL8_9_PTHRESH_96 |
> +	{ NULL, SX9310_REG_PROX_CTRL8, SX9310_REG_PROX_CTRL8_9_PTHRESH_96 |
>  				 SX9310_REG_PROX_CTRL8_9_BODYTHRESH_1500 },
> -	{ SX9310_REG_PROX_CTRL9, SX9310_REG_PROX_CTRL8_9_PTHRESH_28 |
> +	{ NULL, SX9310_REG_PROX_CTRL9, SX9310_REG_PROX_CTRL8_9_PTHRESH_28 |
>  				 SX9310_REG_PROX_CTRL8_9_BODYTHRESH_900 },
> -	{ SX9310_REG_PROX_CTRL10, SX9310_REG_PROX_CTRL10_HYST_6PCT |
> +	{ NULL, SX9310_REG_PROX_CTRL10, SX9310_REG_PROX_CTRL10_HYST_6PCT |
>  				  SX9310_REG_PROX_CTRL10_FAR_DEBOUNCE_2 },
> -	{ SX9310_REG_PROX_CTRL11, 0x00 },
> -	{ SX9310_REG_PROX_CTRL12, 0x00 },
> -	{ SX9310_REG_PROX_CTRL13, 0x00 },
> -	{ SX9310_REG_PROX_CTRL14, 0x00 },
> -	{ SX9310_REG_PROX_CTRL15, 0x00 },
> -	{ SX9310_REG_PROX_CTRL16, 0x00 },
> -	{ SX9310_REG_PROX_CTRL17, 0x00 },
> -	{ SX9310_REG_PROX_CTRL18, 0x00 },
> -	{ SX9310_REG_PROX_CTRL19, 0x00 },
> -	{ SX9310_REG_SAR_CTRL0, SX9310_REG_SAR_CTRL0_SARDEB_4_SAMPLES |
> +	{ NULL, SX9310_REG_PROX_CTRL11, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL12, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL13, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL14, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL15, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL16, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL17, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL18, 0x00 },
> +	{ NULL, SX9310_REG_PROX_CTRL19, 0x00 },
> +	{ NULL, SX9310_REG_SAR_CTRL0, SX9310_REG_SAR_CTRL0_SARDEB_4_SAMPLES |
>  				SX9310_REG_SAR_CTRL0_SARHYST_8 },
> -	{ SX9310_REG_SAR_CTRL1, SX9310_REG_SAR_CTRL1_SLOPE(10781250) },
> -	{ SX9310_REG_SAR_CTRL2, SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT },
> +	{ NULL, SX9310_REG_SAR_CTRL1, SX9310_REG_SAR_CTRL1_SLOPE(10781250) },
> +	{ NULL, SX9310_REG_SAR_CTRL2, SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT },
>  };
>  
>  /* Activate all channels and perform an initial compensation. */
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 977cf17cec52b..729252538e4bc 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -782,74 +782,76 @@ static int sx9324_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct sx_common_reg_default sx9324_default_regs[] = {
> -	{ SX9324_REG_IRQ_MSK, 0x00 },
> -	{ SX9324_REG_IRQ_CFG0, 0x00 },
> -	{ SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND },
> -	{ SX9324_REG_IRQ_CFG2, 0x00 },
> -	{ SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS },
> +	{ NULL, SX9324_REG_IRQ_MSK, 0x00 },
> +	{ "irq_cfg0", SX9324_REG_IRQ_CFG0, 0x00 },
> +	{ "irq_cfg1", SX9324_REG_IRQ_CFG1, SX9324_REG_IRQ_CFG1_FAILCOND },
> +	{ "irq_cfg2", SX9324_REG_IRQ_CFG2, 0x00 },
> +	{ "gnrl_ctrl0", SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS },
>  	/*
>  	 * The lower 4 bits should not be set as it enable sensors measurements.
>  	 * Turning the detection on before the configuration values are set to
>  	 * good values can cause the device to return erroneous readings.
>  	 */
> -	{ SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
> +	{ "gnrl_ctrl1", SX9324_REG_GNRL_CTRL1, SX9324_REG_GNRL_CTRL1_PAUSECTRL },
>  
> -	{ SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST },
> -	{ SX9324_REG_AFE_CTRL3, 0x00 },
> -	{ SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
> +	{ "afe_ctrl0", SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL0_RINT_LOWEST },
> +	{ "afe_ctrl3", SX9324_REG_AFE_CTRL3, 0x00 },
> +	{ "afe_ctrl4", SX9324_REG_AFE_CTRL4, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
>  		SX9324_REG_AFE_CTRL4_RES_100 },
> -	{ SX9324_REG_AFE_CTRL6, 0x00 },
> -	{ SX9324_REG_AFE_CTRL7, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
> +	{ "afe_ctrl6", SX9324_REG_AFE_CTRL6, 0x00 },
> +	{ "afe_ctrl7", SX9324_REG_AFE_CTRL7, SX9324_REG_AFE_CTRL4_FREQ_83_33HZ |
>  		SX9324_REG_AFE_CTRL4_RES_100 },
>  
>  	/* TODO(gwendal): PHx use chip default or all grounded? */
> -	{ SX9324_REG_AFE_PH0, 0x29 },
> -	{ SX9324_REG_AFE_PH1, 0x26 },
> -	{ SX9324_REG_AFE_PH2, 0x1a },
> -	{ SX9324_REG_AFE_PH3, 0x16 },
> +	{ "afe_ph0", SX9324_REG_AFE_PH0, 0x29 },
> +	{ "afe_ph1", SX9324_REG_AFE_PH1, 0x26 },
> +	{ "afe_ph2", SX9324_REG_AFE_PH2, 0x1a },
> +	{ "afe_ph3", SX9324_REG_AFE_PH3, 0x16 },
>  
> -	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESERVED |
> +	{ "afe_ctrl8", SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESERVED |
>  		SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM },
> -	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
> +	{ "afe_ctrl9", SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
>  
> -	{ SX9324_REG_PROX_CTRL0,
> +	{ "prox_ctrl0", SX9324_REG_PROX_CTRL0,
>  		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
>  		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9324_REG_PROX_CTRL1,
> +	{ "prox_ctrl1", SX9324_REG_PROX_CTRL1,
>  		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
>  		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
> -	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
> +	{ "prox_ctrl2", SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
> +	{ "prox_ctrl3", SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
>  		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
> -	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
> +	{ "prox_ctrl4", SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
>  		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 },
> -	{ SX9324_REG_PROX_CTRL5, 0x00 },
> -	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> -	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> -	{ SX9324_REG_ADV_CTRL0, 0x00 },
> -	{ SX9324_REG_ADV_CTRL1, 0x00 },
> -	{ SX9324_REG_ADV_CTRL2, 0x00 },
> -	{ SX9324_REG_ADV_CTRL3, 0x00 },
> -	{ SX9324_REG_ADV_CTRL4, 0x00 },
> -	{ SX9324_REG_ADV_CTRL5, SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1 |
> +	{ "prox_ctrl5", SX9324_REG_PROX_CTRL5, 0x00 },
> +	{ "prox_ctrl6", SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> +	{ "prox_ctrl7", SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
> +	{ "adv_ctrl0", SX9324_REG_ADV_CTRL0, 0x00 },
> +	{ "adv_ctrl1", SX9324_REG_ADV_CTRL1, 0x00 },
> +	{ "adv_ctrl2", SX9324_REG_ADV_CTRL2, 0x00 },
> +	{ "adv_ctrl3", SX9324_REG_ADV_CTRL3, 0x00 },
> +	{ "adv_ctrl4", SX9324_REG_ADV_CTRL4, 0x00 },
> +	{ "adv_ctrl5", SX9324_REG_ADV_CTRL5, SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1 |
>  		SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1 },
> -	{ SX9324_REG_ADV_CTRL6, 0x00 },
> -	{ SX9324_REG_ADV_CTRL7, 0x00 },
> -	{ SX9324_REG_ADV_CTRL8, 0x00 },
> -	{ SX9324_REG_ADV_CTRL9, 0x00 },
> +	{ "adv_ctrl6", SX9324_REG_ADV_CTRL6, 0x00 },
> +	{ "adv_ctrl7", SX9324_REG_ADV_CTRL7, 0x00 },
> +	{ "adv_ctrl8", SX9324_REG_ADV_CTRL8, 0x00 },
> +	{ "adv_ctrl9", SX9324_REG_ADV_CTRL9, 0x00 },
>  	/* Body/Table threshold */
> -	{ SX9324_REG_ADV_CTRL10, 0x00 },
> -	{ SX9324_REG_ADV_CTRL11, 0x00 },
> -	{ SX9324_REG_ADV_CTRL12, 0x00 },
> +	{ "adv_ctrl10", SX9324_REG_ADV_CTRL10, 0x00 },
> +	{ "adv_ctrl11", SX9324_REG_ADV_CTRL11, 0x00 },
> +	{ "adv_ctrl12", SX9324_REG_ADV_CTRL12, 0x00 },
>  	/* TODO(gwendal): SAR currenly disabled */
> -	{ SX9324_REG_ADV_CTRL13, 0x00 },
> -	{ SX9324_REG_ADV_CTRL14, 0x00 },
> -	{ SX9324_REG_ADV_CTRL15, 0x00 },
> -	{ SX9324_REG_ADV_CTRL16, 0x00 },
> -	{ SX9324_REG_ADV_CTRL17, 0x00 },
> -	{ SX9324_REG_ADV_CTRL18, 0x00 },
> -	{ SX9324_REG_ADV_CTRL19, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> -	{ SX9324_REG_ADV_CTRL20, SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> +	{ "adv_ctrl13", SX9324_REG_ADV_CTRL13, 0x00 },
> +	{ "adv_ctrl14", SX9324_REG_ADV_CTRL14, 0x00 },
> +	{ "adv_ctrl15", SX9324_REG_ADV_CTRL15, 0x00 },
> +	{ "adv_ctrl16", SX9324_REG_ADV_CTRL16, 0x00 },
> +	{ "adv_ctrl17", SX9324_REG_ADV_CTRL17, 0x00 },
> +	{ "adv_ctrl18", SX9324_REG_ADV_CTRL18, 0x00 },
> +	{ "adv_ctrl19", SX9324_REG_ADV_CTRL19,
> +		SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
> +	{ "adv_ctrl20", SX9324_REG_ADV_CTRL20,
> +		SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION },
>  };
>  
>  /* Activate all channels and perform an initial compensation. */
> @@ -871,6 +873,8 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
>  					20000, 2000000);
>  }
>  
> +extern const struct acpi_device_id sx9324_acpi_match[];
> +
>  static const struct sx_common_reg_default *
>  sx9324_get_default_reg(struct device *dev, int idx,
>  		       struct sx_common_reg_default *reg_def)
> @@ -888,7 +892,10 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  	int ret, count, ph, pin;
>  	const char *res;
>  
> +
Take a close look and clean out unrelated white space changes from v2.

>  	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
> +	sx_common_get_raw_register_config(dev, sx9324_acpi_match, reg_def);
> +
>  	switch (reg_def->reg) {
>  	case SX9324_REG_AFE_PH0:
>  	case SX9324_REG_AFE_PH1:
> @@ -1116,7 +1123,7 @@ static int sx9324_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
>  
> -static const struct acpi_device_id sx9324_acpi_match[] = {
> +const struct acpi_device_id sx9324_acpi_match[] = {
>  	{ "STH9324", SX9324_WHOAMI_VALUE },
>  	{ }
>  };
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 7fa2213d23baf..95c2df36729e2 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -662,38 +662,38 @@ static int sx9360_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct sx_common_reg_default sx9360_default_regs[] = {
> -	{ SX9360_REG_IRQ_MSK, 0x00 },
> -	{ SX9360_REG_IRQ_CFG, 0x00 },
> +	{ NULL, SX9360_REG_IRQ_MSK, 0x00 },
> +	{ "irq_cfg", SX9360_REG_IRQ_CFG, 0x00 },
>  	/*
>  	 * The lower 2 bits should not be set as it enable sensors measurements.
>  	 * Turning the detection on before the configuration values are set to
>  	 * good values can cause the device to return erroneous readings.
>  	 */
> -	{ SX9360_REG_GNRL_CTRL0, 0x00 },
> -	{ SX9360_REG_GNRL_CTRL1, 0x00 },
> -	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
> +	{ "gnrl_ctrl0", SX9360_REG_GNRL_CTRL0, 0x00 },
> +	{ "gnrl_ctrl1", SX9360_REG_GNRL_CTRL1, 0x00 },
> +	{ "gnrl_ctrl2", SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
>  
> -	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS },
> -	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
> +	{ "afe_ctrl0", SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS },
> +	{ "afe_param0_phr", SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
>  		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
> -	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> +	{ "afe_param1_phr", SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
>  		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
> -	{ SX9360_REG_AFE_PARAM0_PHM, SX9360_REG_AFE_PARAM0_RSVD |
> +	{ "afe_param0_phm", SX9360_REG_AFE_PARAM0_PHM, SX9360_REG_AFE_PARAM0_RSVD |
>  		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
> -	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> +	{ "afe_param1_phm", SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
>  		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ },
>  
> -	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
> +	{ "prox_ctrl0_phr", SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
>  		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
> +	{ "prox_ctrl0_phm", SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
>  		SX9360_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
> -	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
> +	{ "prox_ctrl1", SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K },
> +	{ "prox_ctrl2", SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
>  		SX9360_REG_PROX_CTRL2_AVGPOS_THRESH_16K },
> -	{ SX9360_REG_PROX_CTRL3, SX9360_REG_PROX_CTRL3_AVGNEG_FILT_2 |
> +	{ "prox_ctrl3", SX9360_REG_PROX_CTRL3, SX9360_REG_PROX_CTRL3_AVGNEG_FILT_2 |
>  		SX9360_REG_PROX_CTRL3_AVGPOS_FILT_256 },
> -	{ SX9360_REG_PROX_CTRL4, 0x00 },
> -	{ SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32 },
> +	{ "prox_ctrl4", SX9360_REG_PROX_CTRL4, 0x00 },
> +	{ "prox_ctrl5", SX9360_REG_PROX_CTRL5, SX9360_REG_PROX_CTRL5_PROXTHRESH_32 },
>  };
>  
>  /* Activate all channels and perform an initial compensation. */
> @@ -715,6 +715,8 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
>  				       20000, 2000000);
>  }
>  
> +extern const struct acpi_device_id sx9360_acpi_match[];
> +
>  static const struct sx_common_reg_default *
>  sx9360_get_default_reg(struct device *dev, int idx,
>  		       struct sx_common_reg_default *reg_def)
> @@ -723,6 +725,8 @@ sx9360_get_default_reg(struct device *dev, int idx,
>  	int ret;
>  
>  	memcpy(reg_def, &sx9360_default_regs[idx], sizeof(*reg_def));
> +	sx_common_get_raw_register_config(dev, sx9360_acpi_match, reg_def);

This isn't ACPI specific code.  May not matter as we'll get a property read
fail anyway, but it's rather odd to do this.

> +
>  	switch (reg_def->reg) {
>  	case SX9360_REG_AFE_CTRL1:
>  		ret = device_property_read_u32(dev,
> @@ -863,7 +867,7 @@ static int sx9360_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
>  
> -static const struct acpi_device_id sx9360_acpi_match[] = {
> +const struct acpi_device_id sx9360_acpi_match[] = {
>  	{ "STH9360", SX9360_WHOAMI_VALUE },
>  	{ }
>  };
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index d70a6b4f0bf86..ce8f99b6fc3d9 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -424,6 +424,7 @@ static const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
>  	.postdisable = sx_common_buffer_postdisable,
>  };
>  
> +
>  static void sx_common_regulator_disable(void *_data)
>  {
>  	struct sx_common_data *data = _data;
> @@ -431,6 +432,31 @@ static void sx_common_regulator_disable(void *_data)
>  	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
>  }
>  
> +void sx_common_get_raw_register_config(struct device *dev,
> +		const struct acpi_device_id *acpi_ids,
> +		struct sx_common_reg_default *reg_def)
> +{
> +	const struct acpi_device_id *id;
> +	u32 raw = 0, ret;
> +	char prop[80];
> +
> +	if (!reg_def->property)
> +		return;
> +
> +	for (id = acpi_ids; id->id[0]; id++) {

I'm confused.  Why iterate over acpi_device_id array?
Should know which device this is when calling this.

> +		scnprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s",
> +				id->id, reg_def->property);
> +		ret = device_property_read_u32(dev, prop, &raw);
> +		if (ret)
> +			continue;
> +
> +		reg_def->def = raw;
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(sx_common_get_raw_register_config, SEMTECH_PROX);
> +
> +
>  #define SX_COMMON_SOFT_RESET				0xde
>  
>  static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
> diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> index 5d3edeb75f4e0..ba6472eb9988d 100644
> --- a/drivers/iio/proximity/sx_common.h
> +++ b/drivers/iio/proximity/sx_common.h
> @@ -24,6 +24,7 @@ struct sx_common_data;
>  static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
>  
>  struct sx_common_reg_default {
> +	const char *property;
>  	u8 reg;
>  	u8 def;
>  };
> @@ -151,6 +152,10 @@ int sx_common_probe(struct i2c_client *client,
>  		    const struct sx_common_chip_info *chip_info,
>  		    const struct regmap_config *regmap_config);
>  
> +void sx_common_get_raw_register_config(struct device *dev,
> +		const struct acpi_device_id *acpi_ids,
> +		struct sx_common_reg_default *reg_def);
> +
>  /* 3 is the number of events defined by a single phase. */
>  extern const struct iio_event_spec sx_common_events[3];
>  

