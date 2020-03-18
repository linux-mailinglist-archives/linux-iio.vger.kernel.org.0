Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01918A19B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 18:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCRReG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 13:34:06 -0400
Received: from www381.your-server.de ([78.46.137.84]:40248 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCRReG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 13:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=55s4KdzIkIbrPk24SHC9GIhNl5gysbT015bgWowvoYE=; b=B0xM0xac8I/sAY/v4Fy1CC5a1d
        IUZx+cRKdtENa8HeY/f41HzkgA37T0SiEPmsCqf92GOSYBIC/wzXZYqA+T8PsPMfgqFcqjp3Ba8Ln
        0alyli/aojkBt9KY391U0dtUsPQnTvXT9zIlVsCC5bgULlR+Uxb67nKnV7kq6t7zAznYkwAQCHP7G
        43VPflDV+bY3NloMR7c8wyLSE9TFDydqTX4iua24yizb7Nzb276m9+6MQ3YcwfnvGWumM1ePBMphQ
        yJkFBIhWW9oqEax/H4z+YZKFiaOBA0RlH0aPrSSF3OVZOaSwIFUvri2zVmlB5F9xyyYNUkcvWc7iC
        fCTCrmUA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEcZr-0004ZL-PW; Wed, 18 Mar 2020 18:34:00 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEcZr-000P08-Fy; Wed, 18 Mar 2020 18:33:59 +0100
Subject: Re: [PATCH 2/3] iio: dac: ad5686: add of_match_table
To:     Michael Auchter <michael.auchter@ni.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200318153434.62833-1-michael.auchter@ni.com>
 <20200318153434.62833-2-michael.auchter@ni.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b67c7147-e35c-2408-8324-c688af4e82b7@metafoo.de>
Date:   Wed, 18 Mar 2020 18:33:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318153434.62833-2-michael.auchter@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 4:34 PM, Michael Auchter wrote:
> Add of_match_table to this driver, so devices can be probed based on
> device tree contents.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>   drivers/iio/dac/ad5696-i2c.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index f100a5fe4219..26818bccffa2 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -88,9 +88,28 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
>   
> +static const struct of_device_id ad5686_of_match[] = {
> +	{ .compatible = "adi,ad5311r" },
> +	{ .compatible = "adi,ad5671r" },
> +	{ .compatible = "adi,ad5675r" },
> +	{ .compatible = "adi,ad5691r" },
> +	{ .compatible = "adi,ad5692r" },
> +	{ .compatible = "adi,ad5693" },
> +	{ .compatible = "adi,ad5693r" },
> +	{ .compatible = "adi,ad5694" },
> +	{ .compatible = "adi,ad5694r" },
> +	{ .compatible = "adi,ad5695r" },
> +	{ .compatible = "adi,ad5696" },
> +	{ .compatible = "adi,ad5696r" },
> +	{ .compatible = "adi,ad5338r" },

Same here, table should be ordered.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad5686_of_match);
> +
>   static struct i2c_driver ad5686_i2c_driver = {
>   	.driver = {
>   		.name = "ad5696",
> +		.of_match_table = of_match_ptr(ad5686_of_match),
>   	},
>   	.probe = ad5686_i2c_probe,
>   	.remove = ad5686_i2c_remove,
> 

