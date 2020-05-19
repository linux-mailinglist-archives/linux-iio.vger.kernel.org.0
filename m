Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD01D97A9
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgESN0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESN0e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 09:26:34 -0400
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5302::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F5C08C5C0;
        Tue, 19 May 2020 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1589894792;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/iyQysFjE7xolBZ1naSvo7228GHiugrOaI4sO8bPUTk=;
        b=fwr+dDGEkpoZpHRFsi8fcLwOsy/sYVESVb8GgLSpv79t4LUto9ST3ru1G2W+/CNwUq
        jsKGEs64/RRB2TBFLOhxGwgyGUi/0C9R/12t0ttN6ghkc7h7qa4ziOZQH0bTDYb4fIhG
        zfMC/tbsIUoA8ygDpRE9b0aSD1/Mo1N2L3fKZEfEuJTL1xOZP869A/CZ+/Hulugqnwh6
        EIWjwN126W3TG9fRQZHxF1QPQaCMFZaD7X7Wc7+TX444DaIfLjlxyxxCLoAx+H17hnAU
        u5Yauj09xAg7rlIo7bs97bvRPURUeYWWuh/+E7UPFhw770eXxnIwg1CFGQpUJnkc1yNy
        sJsQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9IczFaoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.6.2 DYNA|AUTH)
        with ESMTPSA id 60b02dw4JDPDl1o
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 19 May 2020 15:25:13 +0200 (CEST)
Date:   Tue, 19 May 2020 15:25:12 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200519132512.GC4623@gerhold.net>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-5-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519124402.26076-5-jonathan.albrieux@gmail.com>
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
> 
> AK09911 has an active low reset gpio to handle register's reset.
> AK09911 datasheed says that, if not used, reset pin should be connected

Another minor typo: datasheed -> datasheet

In any case, FWIW:
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> to VID. This patch emulates this situation.
> 
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
