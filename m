Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6868107E66
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWMqU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:46:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMqU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:46:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA59620714;
        Sat, 23 Nov 2019 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574513179;
        bh=8L9uLsyxlpqU/nNh/HO9q+k/G/QD658xMmAephFglGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lMAzkNkg1wa07icO12ftiMrOhus/4EwEDJIlGZV7T3+y+kp5kjNgDDaZBsB3DbFit
         klmQdBDcoTzDwXjSrXi0HnDY1Mj9dB+W7A62vMS2cHq/Mo/EaZF+kEM7v71MnSPrQG
         dWnBMv8emH5U0qnglk802UvvQ6AY42nI/9Z+g7fE=
Date:   Sat, 23 Nov 2019 12:46:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [v3 8/9] RFC/RFT: iio: maxim_thermocouple: add
 thermocouple_type sysfs attribute
Message-ID: <20191123124613.483bca11@archlinux>
In-Reply-To: <20191120144756.28424-9-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-9-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:55 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> We added a sysfs ABI for getting/setting the type of a thermocouple. This
> driver supports chips that support specific fixed thermocouple types; we
> cannot set it, but still we can add this sysfs attribute in RO mode to
> read-back the thermocouple type.
> 
> This driver supports actually several chips:
>  - max6675
>  - max31855[k/j/n/s/t/e/r]asa family
> 
> Max6675 supports only K-type thermocouples, so we can just report that.
> 
> Each chip in max31855 family supports just one specific thermocouple type
> (in the obvious way: i.e. max31855jasa supports J-type). This driver did
> accept a generic SPI ID and OF compatible "max31855" which does not give
> any clue about which chip is really involved (and unfortunately it seems
> we have no way to detect it).
> 
> This patch introduces a new set of, more specific, SPI IDs and OF
> compatible strings to better match the chip type.
> 
> The old, generic, "max31855" binding is kept for compatibility reasons, but
> this patch aims to deprecate it, so, should we hit it, a warning is spit.
> In such case the reported thermocouple type in sysfs is '?', because we
> have no way to know.
> 
> Regarding the implementation: the thermocouple type information is stored
> in the driver private data and I've kept only two maxim_thermocouple_chip
> types in order to avoid a lot of duplications (seven chip types with just
> a different thermocouple type).
> 
> RFT because I have no real HW to test this.
I'm going to gamble on this as seems fairly obviously correct plus
your DT spoofing tests should have tested the new code.

Obviously actual tests appreciated if anyone with hardware has time.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 44 ++++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index d1360605209c..9906b31fe863 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -24,13 +25,25 @@
>  enum {
>  	MAX6675,
>  	MAX31855,
> +	MAX31855K,
> +	MAX31855J,
> +	MAX31855N,
> +	MAX31855S,
> +	MAX31855T,
> +	MAX31855E,
> +	MAX31855R,
> +};
> +
> +const char maxim_tc_types[] = {
> +	'K', '?', 'K', 'J', 'N', 'S', 'T', 'E', 'R'
>  };
>  
>  static const struct iio_chan_spec max6675_channels[] = {
>  	{	/* thermocouple temperature */
>  		.type = IIO_TEMP,
>  		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 's',
> @@ -48,7 +61,8 @@ static const struct iio_chan_spec max31855_channels[] = {
>  		.type = IIO_TEMP,
>  		.address = 2,
>  		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 's',
> @@ -110,6 +124,7 @@ struct maxim_thermocouple_data {
>  	const struct maxim_thermocouple_chip *chip;
>  
>  	u8 buffer[16] ____cacheline_aligned;
> +	char tc_type;
>  };
>  
>  static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
> @@ -196,6 +211,10 @@ static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
>  			ret = IIO_VAL_INT;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> +		*val = data->tc_type;
> +		ret = IIO_VAL_CHAR;
> +		break;
>  	}
>  
>  	return ret;
> @@ -210,8 +229,9 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	struct iio_dev *indio_dev;
>  	struct maxim_thermocouple_data *data;
> +	const int chip_type = (id->driver_data == MAX6675) ? MAX6675 : MAX31855;
>  	const struct maxim_thermocouple_chip *chip =
> -			&maxim_thermocouple_chips[id->driver_data];
> +		&maxim_thermocouple_chips[chip_type];
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> @@ -229,6 +249,7 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
>  	data = iio_priv(indio_dev);
>  	data->spi = spi;
>  	data->chip = chip;
> +	data->tc_type = maxim_tc_types[id->driver_data];
>  
>  	ret = devm_iio_triggered_buffer_setup(&spi->dev,
>  				indio_dev, NULL,
> @@ -236,12 +257,22 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	if (id->driver_data == MAX31855)
> +		dev_warn(&spi->dev, "generic max31855 ID is deprecated\nplease use more specific part type");
> +
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id maxim_thermocouple_id[] = {
>  	{"max6675", MAX6675},
>  	{"max31855", MAX31855},
> +	{"max31855k", MAX31855K},
> +	{"max31855j", MAX31855J},
> +	{"max31855n", MAX31855N},
> +	{"max31855s", MAX31855S},
> +	{"max31855t", MAX31855T},
> +	{"max31855e", MAX31855E},
> +	{"max31855r", MAX31855R},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
> @@ -249,6 +280,13 @@ MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
>  static const struct of_device_id maxim_thermocouple_of_match[] = {
>          { .compatible = "maxim,max6675" },
>          { .compatible = "maxim,max31855" },
> +	{ .compatible = "maxim,max31855k" },
> +	{ .compatible = "maxim,max31855j" },
> +	{ .compatible = "maxim,max31855n" },
> +	{ .compatible = "maxim,max31855s" },
> +	{ .compatible = "maxim,max31855t" },
> +	{ .compatible = "maxim,max31855e" },
> +	{ .compatible = "maxim,max31855r" },
>          { },
>  };
>  MODULE_DEVICE_TABLE(of, maxim_thermocouple_of_match);

