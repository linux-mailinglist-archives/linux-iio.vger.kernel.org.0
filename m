Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072DF626A82
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 17:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKLQSz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 11:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKLQSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 11:18:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52E1C746
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 08:18:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CF47B80989
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 16:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1370C433C1;
        Sat, 12 Nov 2022 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668269931;
        bh=IzkzBD5FRpX1z2gTII4Vvkq3OIqOjiOvjzHFkbTyL0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uppDdpVAVCx/s+WWHUKu8zyxEbIKUVpWXtfmS/mlmwP9JsujV871wyES8vE1hRNat
         iDyuNXEtzBpEatXbsFLBJ1Ym18Kg/ySozkzSI4LjGrhOzUrkMLx/MNYOEES/cbzpmp
         Z88OVa65A+2uD34LG2YltqqM4UYRb7yIEgrefoN36mf0VdzgE6VNGBp+7t+a9jVAfY
         S9LkV3VV/vTXQzblsktWNCm6uoTX9BuZSWpc0aLvIMQaAly2LzlDPb8JQ6OxTLIOw9
         K6zQQK4mfV/DSDicT36bwZE9VNtbCwnj9wz6DV8Y8dCUAeHGdk4Xm/TGSdBnjY8L8j
         UauoTjllIEQag==
Date:   Sat, 12 Nov 2022 16:31:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof =?UTF-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>,
        "Andrew F. Davis" <afd@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: health: afe4404: Fix oob read in
 afe4404_[read|write]_raw
Message-ID: <20221112163104.3c34631d@jic23-huawei>
In-Reply-To: <20221107152010.95937-1-weiyongjun@huaweicloud.com>
References: <20221107152010.95937-1-weiyongjun@huaweicloud.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon,  7 Nov 2022 15:20:10 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> KASAN report out-of-bounds read as follows:
> 
> BUG: KASAN: global-out-of-bounds in afe4404_read_raw+0x2ce/0x380
> Read of size 4 at addr ffffffffc00e4658 by task cat/278
> 
> Call Trace:
>  afe4404_read_raw
>  iio_read_channel_info
>  dev_attr_show
> 
> The buggy address belongs to the variable:
>  afe4404_channel_leds+0x18/0xffffffffffffe9c0
> 
> This issue can be reproduce by singe command:
> 
>  $ cat /sys/bus/i2c/devices/0-0058/iio\:device0/in_intensity6_raw
> 
> The array size of afe4404_channel_leds and afe4404_channel_offdacs
> are less than channels, so access with chan->address cause OOB read
> in afe4404_[read|write]_raw. Fix it by moving access before use them.
> 
> Fixes: b36e8257641a ("iio: health/afe440x: Use regmap fields")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Andrew Davis <afd@ti.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
> v2 -> v3: re-format backtraces
> v1 -> v2: also moved 'reg' to right before we use it
>           added Acked-by
> 
>  drivers/iio/health/afe4404.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 8fca787b2524..836da31b7e30 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -250,20 +250,20 @@ static int afe4404_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct afe4404_data *afe = iio_priv(indio_dev);
> -	unsigned int value_reg = afe4404_channel_values[chan->address];
> -	unsigned int led_field = afe4404_channel_leds[chan->address];
> -	unsigned int offdac_field = afe4404_channel_offdacs[chan->address];
> +	unsigned int value_reg, led_field, offdac_field;
>  	int ret;
>  
>  	switch (chan->type) {
>  	case IIO_INTENSITY:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
> +			value_reg = afe4404_channel_values[chan->address];
>  			ret = regmap_read(afe->regmap, value_reg, val);
>  			if (ret)
>  				return ret;
>  			return IIO_VAL_INT;
>  		case IIO_CHAN_INFO_OFFSET:
> +			offdac_field = afe4404_channel_offdacs[chan->address];
>  			ret = regmap_field_read(afe->fields[offdac_field], val);
>  			if (ret)
>  				return ret;
> @@ -273,6 +273,7 @@ static int afe4404_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CURRENT:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
> +			led_field = afe4404_channel_leds[chan->address];
>  			ret = regmap_field_read(afe->fields[led_field], val);
>  			if (ret)
>  				return ret;
> @@ -295,19 +296,20 @@ static int afe4404_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct afe4404_data *afe = iio_priv(indio_dev);
> -	unsigned int led_field = afe4404_channel_leds[chan->address];
> -	unsigned int offdac_field = afe4404_channel_offdacs[chan->address];
> +	unsigned int led_field, offdac_field;
>  
>  	switch (chan->type) {
>  	case IIO_INTENSITY:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_OFFSET:
> +			offdac_field = afe4404_channel_offdacs[chan->address];
>  			return regmap_field_write(afe->fields[offdac_field], val);
>  		}
>  		break;
>  	case IIO_CURRENT:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
> +			led_field = afe4404_channel_leds[chan->address];
>  			return regmap_field_write(afe->fields[led_field], val);
>  		}
>  		break;

