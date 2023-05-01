Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2F6F3338
	for <lists+linux-iio@lfdr.de>; Mon,  1 May 2023 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjEAPyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 May 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjEAPyZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 11:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CB5E58
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 08:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2BB361DC9
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 15:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E990C433D2;
        Mon,  1 May 2023 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682956454;
        bh=yE0HzNS4WnXg5XqhBBy5O69jUV9L3mcZydmnHrZTYY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOWoTeXPZfEx6xxfnQ8bhmEnC44EG9OfyVTzmChmw2b2/4DVfUpm8zfu2H1JtB7TH
         Qd9GQJNNk8qEaSshyWvADqRPlyIq4aQMET705nacWM/5LSDGHDQMbtBk9srnEbKxIN
         MNjkmKFlziBSHfoNSX2ilNyLgb6WeLLuezepK9U30UHitQyGfmohUbht7WPHwWHudI
         0X6lYlzLmlhst2hsn0LNMt6Bxlwe8Q2BBk0diB40f3BvCwd99B9hsuXtUKIjjVEGtl
         XDj8LxN2cGuOU8oXh5OlUz+WgWP7iPMhZCm7ybxq5dBq2pMdR4Q5ITOctTE65XTYkb
         LWUnBbv61P9HQ==
Date:   Mon, 1 May 2023 17:09:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     olivier.moysan@foss.st.com, alexandre.torgue@foss.st.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/2] iio: adc: stm32-adc: skip adc-channels setup if
 none is present
Message-ID: <20230501170959.48c9114f@jic23-huawei>
In-Reply-To: <20230421113516.2710454-2-sean@geanix.com>
References: <20230421113516.2710454-1-sean@geanix.com>
        <20230421113516.2710454-2-sean@geanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Apr 2023 13:35:16 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> If only adc differential channels are defined driver will fail with
> stm32-adc: probe of 48003000.adc:adc@0 failed with error -22
> 
> Fix this by skipping the initialization if no channels are defined.
> 
> This applies only to the legacy way of initializing adc channels.
> 
> Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Olivier,

You gave some good feedback on v1. Please take a look to see if it
has all been addressed in v2.

Thanks,

Jonathan

> ---
> Changes since v1:
>  - Ignore extra channel for timestamps in PIO mode
>  - Use single ended count in channel creation (Thanks Olivier Moysan)
> 
>  drivers/iio/adc/stm32-adc.c | 40 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 14524c1b5583..99bfe995b6f1 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2038,6 +2038,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>  	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
>  	struct device *dev = &indio_dev->dev;
>  	u32 num_diff = adc->num_diff;
> +	int num_se = nchans - num_diff;
>  	int size = num_diff * sizeof(*diff) / sizeof(u32);
>  	int scan_index = 0, ret, i, c;
>  	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
> @@ -2065,28 +2066,27 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>  		}
>  	}
>  
> -	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
> -					     nchans);
> -	if (ret)
> -		return ret;
> -
> -	for (c = 0; c < nchans; c++) {
> -		if (chans[c] >= adc_info->max_channels) {
> -			dev_err(&indio_dev->dev, "Invalid channel %d\n",
> -				chans[c]);
> -			return -EINVAL;
> -		}
> -
> -		/* Channel can't be configured both as single-ended & diff */
> -		for (i = 0; i < num_diff; i++) {
> -			if (chans[c] == diff[i].vinp) {
> -				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
> +	ret = device_property_read_u32_array(dev, "st,adc-channels", chans, num_se);
> +	if (ret == 0 && num_se > 0) {
> +		for (c = 0; c < num_se; c++) {
> +			if (chans[c] >= adc_info->max_channels) {
> +				dev_err(&indio_dev->dev, "Invalid channel %d\n",
> +					chans[c]);
>  				return -EINVAL;
>  			}
> +
> +			/* Channel can't be configured both as single-ended & diff */
> +			for (i = 0; i < num_diff; i++) {
> +				if (chans[c] == diff[i].vinp) {
> +					dev_err(&indio_dev->dev, "channel %d misconfigured\n",
> +						chans[c]);
> +					return -EINVAL;
> +				}
> +			}
> +			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> +						chans[c], 0, scan_index, false);
> +			scan_index++;
>  		}
> -		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> -					chans[c], 0, scan_index, false);
> -		scan_index++;
>  	}
>  
>  	if (adc->nsmps > 0) {
> @@ -2307,7 +2307,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
>  
>  	if (legacy)
>  		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
> -						 num_channels);
> +						 timestamping ? num_channels - 1 : num_channels);
>  	else
>  		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
>  	if (ret < 0)

