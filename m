Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768615036FC
	for <lists+linux-iio@lfdr.de>; Sat, 16 Apr 2022 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiDPOFZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Apr 2022 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiDPOFZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2022 10:05:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CA326F6
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2022 07:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50726B82423
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2022 14:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E8BC385A1;
        Sat, 16 Apr 2022 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650117771;
        bh=FQ55tCjk1OXkUezRwdY5bAPl6uGKeK2kj/lSJ+sGez0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bBxu/LMIgcteOA6IFQCEloE8OaLYjOG8sQi5t4KtUrI3dJ9dvcy4aHjp3fzE5sOuy
         1XUeYFNGQdgZZQ1Kr9mkHak5pP7P88ai5LDB/imgLwheVR0iUY8ySGui10ccOkv52A
         cwQftDjV5up536s1rl9heF2kmauvyHBFNReCJyFiJ6JnE05f5ZHoBg8Gfo3nXsBg3h
         RGaEofX7z5iuJUKcU9wzDMQWm/tgYiZrJ/mgiZrz8cAytfqC3oTqGyWvC9FFYCc1oq
         cR62SBQpGbidgbS8h8CGTnDs92yqPFjILRgaEiIUNMdrNLy3zizfcp5FHTDEdPS4Oo
         DPpX/DlJLnL8w==
Date:   Sat, 16 Apr 2022 15:10:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: common: cros_ec_sensors: Add label attribute
Message-ID: <20220416151049.43844f70@jic23-huawei>
In-Reply-To: <20220412210703.3842914-1-gwendal@chromium.org>
References: <20220412210703.3842914-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Apr 2022 14:07:03 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> When sensor location is known, populate iio sysfs "label" attribute:
> 
> * "accel-base" : the sensor is in the base of the convertible (2-1)
>   device.
> * "accel-display" : the sensor is in the lid/display plane of the
>   device.
> 
> It apply to standalone accelerometer and IMU (accelerometer +
> gyroscope).
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I'm happy with this change, but I think it would
be good for the patch description to include 'why' you want to
add this. I assume that's to make use of the standard ABI rather
than the custom ABI we introduced for this driver. We'd have
used label for this in the first place if it had been an option
at the time, but given we didn't what is the logic for duplicating
this information?

Thanks,

Jonathan

> ---
>  .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 989b109a82f47..f86b938b36bf8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -325,6 +325,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	indio_dev->name = pdev->name;
>  
>  	if (physical_device) {
> +		enum motionsensor_location loc;
> +
>  		state->param.cmd = MOTIONSENSE_CMD_INFO;
>  		state->param.info.sensor_num = sensor_platform->sensor_num;
>  		ret = cros_ec_motion_send_host_cmd(state, 0);
> @@ -333,7 +335,12 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			return ret;
>  		}
>  		state->type = state->resp->info.type;
> -		state->loc = state->resp->info.location;
> +		loc = state->resp->info.location;
> +		if (loc == MOTIONSENSE_LOC_BASE)
> +			indio_dev->label = "accel-base";
> +		else if (loc == MOTIONSENSE_LOC_LID)
> +			indio_dev->label = "accel-display";
> +		state->loc = loc;
>  
>  		/* Set sign vector, only used for backward compatibility. */
>  		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);

