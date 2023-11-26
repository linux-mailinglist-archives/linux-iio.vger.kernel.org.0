Return-Path: <linux-iio+bounces-395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11D7F93DE
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8ABB20E72
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6790D285;
	Sun, 26 Nov 2023 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqIvg3f+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17FB15BD;
	Sun, 26 Nov 2023 16:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1E8C433C7;
	Sun, 26 Nov 2023 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701016474;
	bh=sXPwwX2+rpN+bhkF3PyDlCMa5Y9XQMft6HodtNwnGQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PqIvg3f+vr6MzJP6RqXravJ2rXNaSYgjzcfzPANcdIWTR2Vz5kRqXwHlWdCgm8Y0f
	 UiTxz18pdM67vti67Esdy95oqKQKcJlaRuRw5kNoUcbXUo7Mrs2tyeRcJpLYBq51l/
	 6MKi8g7r1/mflvdCFCB/Fhl+dx8S1/DJxZpRfW+m2BTPgcn9hRdvGxMJ0FXGOnEwLd
	 U/0tZKwemqj+orfUQO/0aEb2VOzQtuOFvuOESAH2VY1ZwIcVtUDpvGgmyheHFrtATM
	 WYRY8e8ucEpzTsOyA5H8mHGNwat97b8q8BQgw0ESNmlcPNco+ZotqJq4sH+4E10Wy3
	 a+Haa3pdkJJcA==
Date: Sun, 26 Nov 2023 16:34:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Peter Zijlstra <peterz@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7192: Add AD7194 support
Message-ID: <20231126163426.66e51114@jic23-huawei>
In-Reply-To: <20231114200533.137995-5-alisa.roman@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
	<20231114200533.137995-5-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 22:05:33 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
> 
> The default configuration is hardcoded in order to have a stable number
> of channels.
> 
> Also modify config AD7192 description for better scaling.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Not directly related to this patch (which looks fine to me)
but any idea why 3db_frequency_available is not using read_avail?

Seems sensible to convert it over given all the other cases are using that
and it will allow dropping at least some of the attributes infrastructure
for some devices.

Random aside on the fact that we should be able to do cleanup.h magic
to deal with the fwnode_handle_put() in error paths. +CC Peter Z, Andy S and Rafael,
mostly so they can shout if someone has already done it. That would avoid one
of our more common bugs with property handling and drop a bunch of lines in
every driver looping over fwnodes.
(my lore search foo isn't finding anything).

I have a bunch of other cleanup.h stuff to send out, but if no one points
out a nasty flaw, I'll circle back to this one in a week or two.

Jonathan

> ---
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 48e0357564af..0532678ad665 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
...

> +static int ad7192_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
> +	struct fwnode_handle *child;

Not specific to this driver, but someone (maybe me if I ever get
time) should look at a cleanup.h class for fwnode_handle.  Should be easy to do
and would get rid of all the manual fwnode_handle_put calls once and for all!

Would look something like (completely untested)
	DEFINE_FREE(fwnode_handle_put, struct fwnode_handle, if (_T) fwnode_handle_put(_T));

	struct fwnode_handle __free(fwnode_handle_put) *child = NULL;

minor benefit in this driver, but much larger in others that are parsing lots
of attributes under the fwnode.

> +	int ret;
> +
> +	device_for_each_child_node(dev, child) {
> +		ret = ad7192_parse_channel(indio_dev, child);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
> @@ -1150,6 +1282,12 @@ static int ad7192_probe(struct spi_device *spi)
>  		}
>  	}
>  
> +	if (st->chip_info->chip_id == CHIPID_AD7194) {

You match on 7194, then call a function named ad7192_xxx
which with that name we'd expect to apply to either the
ad7192 or to all parts in this driver.
So that function is not well named- it's find to rename it
to ad7194_parse_channels().  However...

> +		ret = ad7192_parse_channels(indio_dev);
I'd prefer to see this done via a callback in chip_info

	if (st->chip_info->channel_parse) {
		ret = st->chip_info->channel_parse(indio_dev);
		...

> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = ad7192_setup(indio_dev);
>  	if (ret)
>  		return ret;
> @@ -1161,6 +1299,7 @@ static const struct of_device_id ad7192_of_match[] = {
>  	{ .compatible = "adi,ad7190", .data = &ad7192_chip_info_tbl[ID_AD7190] },
>  	{ .compatible = "adi,ad7192", .data = &ad7192_chip_info_tbl[ID_AD7192] },
>  	{ .compatible = "adi,ad7193", .data = &ad7192_chip_info_tbl[ID_AD7193] },
> +	{ .compatible = "adi,ad7194", .data = &ad7192_chip_info_tbl[ID_AD7194] },
>  	{ .compatible = "adi,ad7195", .data = &ad7192_chip_info_tbl[ID_AD7195] },
>  	{}
>  };
> @@ -1170,6 +1309,7 @@ static const struct spi_device_id ad7192_ids[] = {
>  	{ "ad7190", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7190] },
>  	{ "ad7192", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7192] },
>  	{ "ad7193", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7193] },
> +	{ "ad7194", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7194] },
>  	{ "ad7195", (kernel_ulong_t)&ad7192_chip_info_tbl[ID_AD7195] },
>  	{}
>  };
> @@ -1186,6 +1326,6 @@ static struct spi_driver ad7192_driver = {
>  module_spi_driver(ad7192_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
> +MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7194, AD7195 ADC");

Maybe time to switch to 'and similar' here.

Thanks,

Jonathan

>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);


