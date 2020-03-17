Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7189018870C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 15:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQOQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 10:16:22 -0400
Received: from www381.your-server.de ([78.46.137.84]:54382 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgCQOQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YfS8o63jfAqwGDkdP2CSSYM3Rf1BRlF0LrbfMG+UcYQ=; b=hVo+iLHdbWnEILZnD50R5jkBBg
        cOTsgW6J/L9KIq/OWWbITAn3DEkYAgYJQYAXLaaw13z01bIjW/+kzSvqejvLacYIeHGt45wkZb+O5
        mnQKxCzx5ocQFTBvP6o+XB7Hz60BX4KZPPBbC1skQdVGx3UMd7PIWHYKkxRV4gyr+ZnCRl4kJqGmR
        e4R7ZHGb2o5h7mAOvJ+FtrcBNqn9ejNWeC7M+dyZWt0ehETk6He9ALyqEfwDoCt/BXh0XoiCGlUDl
        BiudTM9Lpcihx+ZscoJTkmyL5cOuqWwe9dRzGKVj3ZM5vb+WTcno/eNY/umNR3HrJsiACQ38GmNsZ
        b4J3AeaA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jED0v-0006JD-Pu; Tue, 17 Mar 2020 15:16:13 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jED0v-000XDr-F0; Tue, 17 Mar 2020 15:16:13 +0100
Subject: Re: [PATCH 1/2] iio: adc: ad7291: convert to device tree
To:     Michael Auchter <michael.auchter@ni.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200317135649.8876-1-michael.auchter@ni.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7ee1dfe4-3289-4428-5787-6dddd63111b2@metafoo.de>
Date:   Tue, 17 Mar 2020 15:16:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317135649.8876-1-michael.auchter@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 2:56 PM, Michael Auchter wrote:
> There are no in-tree users of the platform data for this driver, so
> remove it and convert the driver to use device tree instead.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>

Hi,

Thanks for the patch, looks good for the most part. One comment inline.

> 
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index b2b137fed246..536e31862309 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -495,8 +482,19 @@ static int ad7291_probe(struct i2c_client *client,
>   			AD7291_T_SENSE_MASK | /* Tsense always enabled */
>   			AD7291_ALERT_POLARITY; /* set irq polarity low level */
>   
> -	if (pdata && pdata->use_external_ref)
> +	chip->reg = devm_regulator_get_optional(&client->dev, "vref");
> +	if (IS_ERR(chip->reg)) {
> +		if (PTR_ERR(chip->reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

We should only continue if the error is ENODEV, which means that no 
regulator was specified. Any other error means it was specified but 
there was an issue requesting it. See for example ad7266.c

> +
> +		chip->reg = NULL;
> +	} else {
> +		ret = regulator_enable(chip->reg);
> +		if (ret)
> +			return ret;
> +
>   		chip->command |= AD7291_EXT_REF;
> +	}
