Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF0E96F44
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfHUCLu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 22:11:50 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:55476 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfHUCLu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 22:11:50 -0400
Received: (qmail 21683 invoked by uid 5089); 21 Aug 2019 02:11:48 -0000
Received: by simscan 1.2.0 ppid: 21579, pid: 21580, t: 0.0514s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 21 Aug 2019 02:11:47 -0000
Subject: Re: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device
 identification
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
 <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <970c3988-24e4-26c2-9027-d8ff40c3a9bb@electromag.com.au>
Date:   Wed, 21 Aug 2019 10:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/08/2019 22:11, Michal Simek wrote:
> Add support for using label property for easier device identification via
> iio framework.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>   drivers/iio/adc/ina2xx-adc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 7c7c63677bf4..077c54915f70 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client *client,
>   	snprintf(chip->name, sizeof(chip->name), "%s-%s",
>   		 client->name, dev_name(&client->dev));
>   
> -	indio_dev->name = chip->name;
> +	indio_dev->name = of_get_property(np, "label", NULL) ? : chip->name;
>   	indio_dev->setup_ops = &ina2xx_setup_ops;
>   
>   	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
> 
I like this personally. It'd be nice if it was a core function so
it could be an opt in to any iio device.

Don't know how well received that'd be thou.


-- 
Regards
Phil Reid

