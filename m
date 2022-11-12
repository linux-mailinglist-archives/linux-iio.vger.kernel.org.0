Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8429626A81
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiKLQSq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQSo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 11:18:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23EC746
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 08:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 204CFB80968
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 16:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06360C433C1;
        Sat, 12 Nov 2022 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668269919;
        bh=nYai7w9ROZ3mlDyUIYDZZPjQm78VXw6pyFjIDYiYCJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n2CJt/yMQnXwKWcHu5URqd5bR+uO+t05kvfG5/CYIqSbhTiAV6qB70DLAPxwUS0Og
         03mleIvKaw3uJYOLB6hqZItey9ZgN0N4lRfjmlXcn1DbNqOYvO0AcFjMoMlB4SAIFm
         OHe7+bJzYeI3iDxLYcQO/XodFBz+W3MREqrsFPW7DnOqJ0i/XAbuLFvNBq5uP+zzlA
         fitfq05LTdjvqpZjoi9NUtr7x+DiQynZ9FKSl4L2P8lYTy8cNSB/z62f3ssnBOJM5B
         wtGg3gSUkPSuZ1DfKmVDgkzI7EbDN9npwklOPQkxOAhGTbTE/NsL5gwHo7mDsmFicY
         tAl3YwtoP3jIQ==
Date:   Sat, 12 Nov 2022 16:30:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, "Andrew F. Davis" <afd@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: health: afe4403: Fix oob read in
 afe4403_read_raw
Message-ID: <20221112163052.1d6ec9de@jic23-huawei>
In-Reply-To: <20221107151946.89260-1-weiyongjun@huaweicloud.com>
References: <20221107151946.89260-1-weiyongjun@huaweicloud.com>
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

On Mon,  7 Nov 2022 15:19:46 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> KASAN report out-of-bounds read as follows:
> 
> BUG: KASAN: global-out-of-bounds in afe4403_read_raw+0x42e/0x4c0
> Read of size 4 at addr ffffffffc02ac638 by task cat/279
> 
> Call Trace:
>  afe4403_read_raw
>  iio_read_channel_info
>  dev_attr_show
> 
> The buggy address belongs to the variable:
>  afe4403_channel_leds+0x18/0xffffffffffffe9e0
> 
> This issue can be reproduced by singe command:
> 
>  $ cat /sys/bus/spi/devices/spi0.0/iio\:device0/in_intensity6_raw
> 
> The array size of afe4403_channel_leds is less than channels, so access
> with chan->address cause OOB read in afe4403_read_raw. Fix it by moving
> access before use it.
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
>  drivers/iio/health/afe4403.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 3bb4028c5d74..df3bc5c3d378 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -245,14 +245,14 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct afe4403_data *afe = iio_priv(indio_dev);
> -	unsigned int reg = afe4403_channel_values[chan->address];
> -	unsigned int field = afe4403_channel_leds[chan->address];
> +	unsigned int reg, field;
>  	int ret;
>  
>  	switch (chan->type) {
>  	case IIO_INTENSITY:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
> +			reg = afe4403_channel_values[chan->address];
>  			ret = afe4403_read(afe, reg, val);
>  			if (ret)
>  				return ret;
> @@ -262,6 +262,7 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CURRENT:
>  		switch (mask) {
>  		case IIO_CHAN_INFO_RAW:
> +			field = afe4403_channel_leds[chan->address];
>  			ret = regmap_field_read(afe->fields[field], val);
>  			if (ret)
>  				return ret;

