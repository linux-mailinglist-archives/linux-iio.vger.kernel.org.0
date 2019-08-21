Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8A96F42
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHUCKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 22:10:25 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:60358 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfHUCKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 22:10:25 -0400
Received: (qmail 30310 invoked by uid 5089); 21 Aug 2019 02:10:22 -0000
Received: by simscan 1.2.0 ppid: 30163, pid: 30164, t: 0.0600s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 21 Aug 2019 02:10:22 -0000
Subject: Re: [PATCH 2/4] iio: adc: ina2xx: Setup better name then simple
 ina2xx
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, linux@roeck-us.net
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1566310292.git.michal.simek@xilinx.com>
 <e1a9d7c5f94a4942a97a242e530a3bfdda8bbc74.1566310292.git.michal.simek@xilinx.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <1c96bed1-2651-3667-3573-2167cd788bd7@electromag.com.au>
Date:   Wed, 21 Aug 2019 10:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e1a9d7c5f94a4942a97a242e530a3bfdda8bbc74.1566310292.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/08/2019 22:11, Michal Simek wrote:
> On systems with multiple ina2xx chips it is impossible to find out which
> iio device is which one based on probe order. That's why it is necessary to
> setup better name based on possition.
> The patch is reusing dev_name which is setup by core with client->name.
> 
> name char array was setup to 128 byte length to correspond the same name
> length by HID device.
> 
> Before this patch:
> iio:device9: ina226 (buffer capable)
> After:
> iio:device9: ina226-3-004a (buffer capable)

Could this break existing user space code that's just looking for just ina226.
I2c bus numbers aren't all that great at id'ing devices either. It's better than
nothing but depending on what cards we have plugged into our system the same device gets
a different bus number.


> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Also id->name can be used as prefix. On ina226 output is the same.
> 
> Also I am happy to change that space for name will be dynamicky allocated
> to save a space if needed.
> ---
>   drivers/iio/adc/ina2xx-adc.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 37058d9c2054..7c7c63677bf4 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -146,6 +146,7 @@ struct ina2xx_chip_info {
>   	int range_vbus; /* Bus voltage maximum in V */
>   	int pga_gain_vshunt; /* Shunt voltage PGA gain */
>   	bool allow_async_readout;
> +	char name[128];
>   };
>   
>   static const struct ina2xx_config ina2xx_config[] = {
> @@ -1027,7 +1028,12 @@ static int ina2xx_probe(struct i2c_client *client,
>   		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
>   		indio_dev->info = &ina219_info;
>   	}
> -	indio_dev->name = id->name;
> +
> +	/* Compose chip name to unified i2c format */
> +	snprintf(chip->name, sizeof(chip->name), "%s-%s",
> +		 client->name, dev_name(&client->dev));
> +
> +	indio_dev->name = chip->name;
>   	indio_dev->setup_ops = &ina2xx_setup_ops;
>   
>   	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
> 


-- 
Regards
Phil Reid
