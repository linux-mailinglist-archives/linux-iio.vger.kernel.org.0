Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E682D1D9338
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgESJV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 05:21:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:39871 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgESJV2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 05:21:28 -0400
IronPort-SDR: F1JZkk9Qj2sEjc2RHdnhqnvift+iDxCWB7zDa7zonajqEgP5KVxZACAkchcJ0MgOLngwh27GZ7
 oXaskZS7UF5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 02:21:27 -0700
IronPort-SDR: uHncHa+/1V+Q/2aBf+8o7XI8OA0oUARElpu9cG6qJK+A5LMD/PkBnP8qXOvFMbchpgAhGlPgRM
 O2dfpX36FoOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="253188831"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2020 02:21:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jayRD-007bh4-0v; Tue, 19 May 2020 12:21:27 +0300
Date:   Tue, 19 May 2020 12:21:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jilayne Lovejoy <opensource@jilayne.com>
Subject: Re: [PATCH v2 3/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519092127.GS1634618@smile.fi.intel.com>
References: <20200519065749.4624-1-jonathan.albrieux@gmail.com>
 <20200519065749.4624-4-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519065749.4624-4-jonathan.albrieux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 08:57:43AM +0200, Jonathan Albrieux wrote:

Thanks for an update, my comments below.

> According to AK09911 datasheet, if reset gpio is provided then 

Trailing whitespace.

> deassert reset on ak8975_power_on and assert reset on ak8975_power_off.
> 
> Without reset's deassertion during ak8975_power_on, driver's probe fails on
> ak8975_who_i_am while checking for device identity for AK09911 chip
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheed says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation

Please, put periods at the end of the phrases.

>  	/*
> -	 * According to the datasheet the power supply rise time i 200us
> +	 * According to the datasheet the power supply rise time is 200us
>  	 * and the minimum wait time before mode setting is 100us, in
> -	 * total 300 us. Add some margin and say minimum 500us here.
> +	 * total 300us. Add some margin and say minimum 500us here.
>  	 */

This is not related change (perhaps, you may do in separate patch), but I'm not
against it. Up to maintainer.

> +	/*
> +	 * According to AK09911 datasheet, if reset gpio is provided then
> +	 * deassert reset on ak8975_power_on and assert reset on
> +	 * ak8975_power_off.

We try to refer to the code accordingly to the kernel doc recommendations (even
for non-kdoc comments). So, here, 'function' as 'function()' (without quotes)
and so on.

> +	 */
> +	reset_gpiod = devm_gpiod_get_optional(&client->dev,
> +					      "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpiod))
> +		return PTR_ERR(reset_gpiod);
> +
>  	/* Register with IIO */
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (indio_dev == NULL)
> @@ -866,6 +883,7 @@ static int ak8975_probe(struct i2c_client *client,
>  
>  	data->client = client;
>  	data->eoc_gpiod = eoc_gpiod;
> +	data->reset_gpiod = reset_gpiod;
>  	data->eoc_irq = 0;
>  
>  	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


