Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A73434645
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhJTHz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 03:55:26 -0400
Received: from www381.your-server.de ([78.46.137.84]:36364 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJTHz0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 03:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=G74WQpy7XqXEBo8MwB1yXF10x8W8dO8EK4hpwLHmrpg=; b=jBsNp5XgPl4eyqQjeri8Vg3LM8
        tiSDz1NHsV2QTiqpsDR91zzYHB8bYqni/ZCKaGgY1HhKKebL4HdKi+rHf06oCgxs9RvLk1j2b7bFG
        OjJep1A9KjUTFQ9Xqy61RPJDVzws4UMoK7muJZp67PpHISF7RmjyOoFAy/ELoXT8v40SovFUVh1E8
        4xohu6UFvpM4EZk5lZ6ePddmiLLaWEwwgEKbzEWgND0sfYauXbvNacGVj4Y/y8KBix4K0RwnWGNnq
        ShZZZYIPlbH0canUo4QTzMLJcp3jfw0A1zc3hO9d4Gp+Jl61Mj/jzdi7OQT3CZCkMmtCtsYX7o6xL
        Lp+lD9EA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1md6PM-000Fnx-9q; Wed, 20 Oct 2021 09:53:08 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1md6PM-0001Z6-5S; Wed, 20 Oct 2021 09:53:08 +0200
Subject: Re: [PATCH] iio: light: ltr501: Added ltr303 driver support
To:     Maslov Dmitry <maslovdmitry@seeed.cc>, jic23@kernel.org,
        linux-iio@vger.kernel.org
References: <20211020073518.3191-1-maslovdmitry@seeed.cc>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <921fa6c4-be0e-0be7-d1de-67d188b1c079@metafoo.de>
Date:   Wed, 20 Oct 2021 09:53:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211020073518.3191-1-maslovdmitry@seeed.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26327/Tue Oct 19 13:35:20 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/20/21 9:35 AM, Maslov Dmitry wrote:
> Previously ltr501 driver supported a number of light and,
> proximity sensors including ltr501, ltr559 and ltr301.
> This adds support for another light sensor ltr303
> used in Seeed Studio reTerminal, a carrier board
> for Raspberry Pi 4 CM.

Hi,

Thanks for the patch. This looks good. But there are a couple of 
different things in this change that go beyond what is described in the 
commit message. It would be best to split these out into separate 
patches and provide a description of what they are doing.


>
> Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>
> ---
>   drivers/iio/light/ltr501.c | 46 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 7e51aaac0bf..733f9224bd1 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * ltr501.c - Support for Lite-On LTR501 ambient light and proximity sensor
> + * ltr.c - Support for Lite-On LTR501, LTR509, LTR301, LTR303 ambient light
The filename did not change. Me personally I'm a big fan of not 
referencing the filename in the file, because it is easily outdated when 
renamed. So maybe just remove that part of the comment.
> + * and proximity sensors (only LTR5xx)
>    *
>    * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
>    *
> [...]
> @@ -1231,6 +1241,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>   		.channels = ltr301_channels,
>   		.no_channels = ARRAY_SIZE(ltr301_channels),
>   	},
> +	[ltr303] = {
> +		.partid = 0x0A,
> +		.als_gain = ltr559_als_gain_tbl,
> +		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> +		.als_mode_active = BIT(0),
> +		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
> +		.als_gain_shift = 2,
> +		.info = &ltr301_info,
> +		.info_no_irq = &ltr301_info_no_irq,
> +		.channels = ltr301_channels,
> +		.no_channels = ARRAY_SIZE(ltr301_channels),
> +	},
>   };
>   
>   static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
> @@ -1337,7 +1359,7 @@ static int ltr501_init(struct ltr501_data *data)
>   	if (ret < 0)
>   		return ret;
>   
> -	data->als_contr = status | data->chip_info->als_mode_active;
> +	data->als_contr = status | data->chip_info->als_mode_active | LTR501_ALS_DEF_GAIN;
This is not mentioned in the commit description. Why is this necessary 
now, but wasn't before?
>   
>   	ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
>   	if (ret < 0)
> @@ -1504,7 +1526,23 @@ static int ltr501_probe(struct i2c_client *client,
>   	if (ret < 0)
>   		return ret;
>   
> -	if (id) {
> +	if (client->dev.of_node) {
> +		int i = 0;
> +
> +		chip_idx = (int)of_device_get_match_data(&client->dev);
> +		for (i = 0; i < ltr_max; i++) {
> +			if (ltr501_id[i].name == NULL) {
> +				break;
> +			}
> +			if (ltr501_id[i].driver_data == chip_idx) {
> +				name = ltr501_id[i].name;
> +				break;
> +			}
> +		}
> +		if (i >= ltr_max) {
> +			name = LTR501_DRV_NAME;
> +		}

Same here, this doesn't seem to be 303 specific and there is no mention 
of why this is needed in the patch description. There are no other 
drivers which seem to do something similar, why is it need for this driver?


> +	} else if (id) {
>   		name = id->name;
>   		chip_idx = id->driver_data;
>   	} else  if (ACPI_HANDLE(&client->dev)) {


