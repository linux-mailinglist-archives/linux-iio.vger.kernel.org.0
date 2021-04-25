Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817F736A7E8
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhDYPQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 11:16:56 -0400
Received: from www381.your-server.de ([78.46.137.84]:51894 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYPQ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 11:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=rcM1mDotLLM1ehwVHiTLyrx9DdDtiH0Nl6OFkvOnz3I=; b=j06XSWN2CdUw8AT9BTyrSs05Zq
        OhJ1zyk7vwNxNeEpTYWrzqYyRx05fUsfRbSXbB0nKl63mc+7NGaoodCvshAGSHwsT9AdfpZgyb/Z3
        eDNiPYe9Z7iOEOOJuuc5Ig8YSVRIsKx7a1fnsvBv5gfUYxvhPHLbF7D1TXA1qJSOMmrYug72aZTqn
        OjLnuaxaJfe7xgO+43sLfmWofTk6+0OjBZiSy2Y50wek013FhTN0xJGJXnaeA+XPQ4oi9xjsUvbYY
        PbGw6FZt0WEQJ3cvOmyXvsrCrRemGyl2jlH3hM45knT/NOYHhQO7FyakZmFWReUQrDwKYJNsfJVng
        0AHLKNSA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lagUY-0005XR-VX; Sun, 25 Apr 2021 17:16:15 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lagUY-000KyF-Q5; Sun, 25 Apr 2021 17:16:14 +0200
Subject: Re: [PATCH 1/3] iio: sps30: separate core and interface specific code
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org
References: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
 <20210425135546.57343-2-tomasz.duszynski@octakon.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <38d5438d-7e00-ed5d-ed33-01ff04e26f33@metafoo.de>
Date:   Sun, 25 Apr 2021 17:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210425135546.57343-2-tomasz.duszynski@octakon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26151/Sun Apr 25 13:05:06 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/25/21 3:55 PM, Tomasz Duszynski wrote:
> Move code responsible for handling i2c communication to a separate file.
> Rationale for this change is preparation for adding support for serial
> communication.
>
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>

Hi,

The whole series looks really great. Couple of small comments inline.

> [...]
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 10bb431bc3ce..82af5f62fbc6 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -133,8 +133,6 @@ config SENSIRION_SGP30
>   
>   config SPS30
>   	tristate "SPS30 particulate matter sensor"
> -	depends on I2C
> -	select CRC8
>   	select IIO_BUFFER
>   	select IIO_TRIGGERED_BUFFER
>   	help
> @@ -144,6 +142,17 @@ config SPS30
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called sps30.
>   
> +config SPS30_I2C
> +	tristate "SPS30 particulate matter sensor I2C driver"
> +	depends on SPS30 && I2C
> +	select CRC8
Since the base module is not very useful without any of the drivers 
enabled, what you can do here is, make the base module 
non-user-selectable, e.g. remove the description text after the tristate 
and then do a `select SPS30` both here from he I2C module and the serial 
module.
> +	help
> +	  Say Y here to build support for the Sensirion SPS30 I2C interface
> +	  driver.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called sps30_i2c.
> +
>   config VZ89X
>   	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
>   	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index fef63dd5bf92..41c264a229c0 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>   obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
>   obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
>   obj-$(CONFIG_SPS30) += sps30.o
> +obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
>   obj-$(CONFIG_VZ89X)		+= vz89x.o
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index 7486591588c3..ec9db99e324c 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> [...]
> +EXPORT_SYMBOL(sps30_probe);
EXPORT_SYMBOL_GPL()
>   
>   MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
>   MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor driver");
> diff --git a/drivers/iio/chemical/sps30.h b/drivers/iio/chemical/sps30.h
> new file mode 100644
> index 000000000000..d2b7140fdeb4
> --- /dev/null
> +++ b/drivers/iio/chemical/sps30.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SPS30_H
> +#define _SPS30_H
> +
> +struct sps30_state;
> +struct sps30_ops {
> +	int (*start_meas)(struct sps30_state *state);
> +	int (*stop_meas)(struct sps30_state *state);
> +	int (*read_meas)(struct sps30_state *state, int *meas, int num);
> +	int (*reset)(struct sps30_state *state);
> +	int (*clean_fan)(struct sps30_state *state);
> +	int (*read_cleaning_period)(struct sps30_state *state, int *period);
> +	int (*write_cleaning_period)(struct sps30_state *state, int period);

The interface for {read,write}_cleaning_period() should use __be32, 
since that is what is being passed around.

I was a bit confused when reviewing the uart driver why we can just 
memcpy an int into the output buffer without endianess problems.

> +	int (*show_info)(struct sps30_state *state);
> +};
> +
[...]
