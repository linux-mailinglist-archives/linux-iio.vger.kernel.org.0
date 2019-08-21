Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E562E96F19
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 03:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfHUB4S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 21:56:18 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:49317 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfHUB4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 21:56:18 -0400
Received: (qmail 14515 invoked by uid 5089); 21 Aug 2019 01:56:15 -0000
Received: by simscan 1.2.0 ppid: 14414, pid: 14415, t: 0.0643s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 21 Aug 2019 01:56:15 -0000
Subject: Re: [PATCH 1/4] iio: adc: ina2xx: Define *device_node only once
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
 <c13fb8284b68cf3dbe309941d767aa7701aa4c3a.1566310292.git.michal.simek@xilinx.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <fef37bf8-3c08-3bb2-b8f9-79c6447c9fac@electromag.com.au>
Date:   Wed, 21 Aug 2019 09:56:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c13fb8284b68cf3dbe309941d767aa7701aa4c3a.1566310292.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 20/08/2019 22:11, Michal Simek wrote:
> There is no reason to c&p full client->dev.of_node link when simple
> variable can keep it.
One comment

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>   drivers/iio/adc/ina2xx-adc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index bdd7cba6f6b0..37058d9c2054 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -951,6 +951,7 @@ static int ina2xx_probe(struct i2c_client *client,
>   	struct ina2xx_chip_info *chip;
>   	struct iio_dev *indio_dev;
>   	struct iio_buffer *buffer;
> +	struct device_node *np = client->dev.of_node;
>   	unsigned int val;
>   	enum ina2xx_ids type;
>   	int ret;
> @@ -970,7 +971,7 @@ static int ina2xx_probe(struct i2c_client *client,
>   		return PTR_ERR(chip->regmap);
>   	}
>   
> -	if (client->dev.of_node)
> +	if (np)
>   		type = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
>   	else
>   		type = id->driver_data;
> @@ -978,7 +979,7 @@ static int ina2xx_probe(struct i2c_client *client,
>   
>   	mutex_init(&chip->state_lock);
>   
> -	if (of_property_read_u32(client->dev.of_node,
> +	if (of_property_read_u32(np,
>   				 "shunt-resistor", &val) < 0) {

This will fit on one line <80 now.

>   		struct ina2xx_platform_data *pdata =
>   		    dev_get_platdata(&client->dev);
> @@ -1016,7 +1017,7 @@ static int ina2xx_probe(struct i2c_client *client,
>   
>   	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>   	indio_dev->dev.parent = &client->dev;
> -	indio_dev->dev.of_node = client->dev.of_node;
> +	indio_dev->dev.of_node = np;
>   	if (id->driver_data == ina226) {
>   		indio_dev->channels = ina226_channels;
>   		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
