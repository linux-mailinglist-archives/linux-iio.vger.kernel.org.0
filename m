Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631031D96D1
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 14:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgESM5P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 08:57:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:51738 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgESM5O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 08:57:14 -0400
IronPort-SDR: E2QBmr482Xm1x2Cte/j9hPGXZF5wmzhvMSGUe0h1yZ5/gchdZmHiNvOF20y7/nCXxy1O4TfSBL
 +hhPBBUjYeEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 05:57:14 -0700
IronPort-SDR: IGesn6ruI9c5l9UBged3IFqb32A4loP7jb2lhNCucO5P8GEmlPgK4PCkSGnPK1V2I1zFXjC8f9
 W4jeP7ggNFVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="373717845"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2020 05:57:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jb1o1-007dbT-2d; Tue, 19 May 2020 15:57:13 +0300
Date:   Tue, 19 May 2020 15:57:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v3 4/4] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519125713.GI1634618@smile.fi.intel.com>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-5-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519124402.26076-5-jonathan.albrieux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 02:43:54PM +0200, Jonathan Albrieux wrote:
> According to AK09911 datasheet, if reset gpio is provided then
> deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().
> 
> Without reset's deassertion during ak8975_power_on(), driver's probe fails
> on ak8975_who_i_am while() checking for device identity for AK09911 chip.

Wrong position of (), but hold on, this is so minor, no need to send a new
version because of this.

> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheed says that, if not used, reset pin should be connected
> to VID. This patch emulates this situation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index fd368455cd7b..a23422aad97d 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -358,6 +358,7 @@ struct ak8975_data {
>  	u8			asa[3];
>  	long			raw_to_gauss[3];
>  	struct gpio_desc	*eoc_gpiod;
> +	struct gpio_desc	*reset_gpiod;
>  	int			eoc_irq;
>  	wait_queue_head_t	data_ready_queue;
>  	unsigned long		flags;
> @@ -384,6 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  			 "Failed to enable specified Vid supply\n");
>  		return ret;
>  	}
> +
> +	gpiod_set_value_cansleep(data->reset_gpiod, 0);
> +
>  	/*
>  	 * According to the datasheet the power supply rise time is 200us
>  	 * and the minimum wait time before mode setting is 100us, in
> @@ -396,6 +400,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  /* Disable attached power regulator if any. */
>  static void ak8975_power_off(const struct ak8975_data *data)
>  {
> +	gpiod_set_value_cansleep(data->reset_gpiod, 1);
> +
>  	regulator_disable(data->vid);
>  	regulator_disable(data->vdd);
>  }
> @@ -839,6 +845,7 @@ static int ak8975_probe(struct i2c_client *client,
>  	struct ak8975_data *data;
>  	struct iio_dev *indio_dev;
>  	struct gpio_desc *eoc_gpiod;
> +	struct gpio_desc *reset_gpiod;
>  	const void *match;
>  	unsigned int i;
>  	int err;
> @@ -856,6 +863,16 @@ static int ak8975_probe(struct i2c_client *client,
>  	if (eoc_gpiod)
>  		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
>  
> +	/*
> +	 * According to AK09911 datasheet, if reset GPIO is provided then
> +	 * deassert reset on ak8975_power_on() and assert reset on
> +	 * ak8975_power_off().
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


