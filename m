Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D951A85141
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfHGQln (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 12:41:43 -0400
Received: from ns.pmeerw.net ([84.19.176.117]:39104 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbfHGQln (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Aug 2019 12:41:43 -0400
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 50840E0260; Wed,  7 Aug 2019 18:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1565196100; bh=vVDRy+58opdQSjRaeyg8Dd3tCc/WQSdk26W7/7SurvI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ljIn/unUN+qYb3vsWo/D/SIzCCjfgwtvi5mowiKdMFkcIpCrAqy6sQ6t/ekHrZaO8
         Ny+/eb+ll9IO3aLNxBpaHsSPexFczg+Nosuyte7awO+/8GI64lqqgryoldRRw/i8KZ
         MRQ7ETSjA+OofYSWmtGb7XLXdzVW5oT5WklXgi8w=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 1E478E01A6;
        Wed,  7 Aug 2019 18:41:40 +0200 (CEST)
Date:   Wed, 7 Aug 2019 18:41:40 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
cc:     jic23@kernel.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, biabeniamin@outlook.com,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7606: Add support for AD7606B ADC
In-Reply-To: <20190807133137.11185-1-beniamin.bia@analog.com>
Message-ID: <alpine.DEB.2.21.1908071834040.32509@vps.pmeerw.net>
References: <20190807133137.11185-1-beniamin.bia@analog.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="324302256-509562479-1565196100=:32509"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324302256-509562479-1565196100=:32509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Aug 2019, Beniamin Bia wrote:

> From: Stefan Popa <stefan.popa@analog.com>

please see some minor comments below

> The AD7606B is a 16-bit ADC that supports simultaneous sampling of 8
> channels. It is pin compatible to AD7606, but adds extra modes by
> writing to the register map.
> 
> The AD7606B can be configured to work in software mode by setting all
> oversampling pins to high. This mode is selected by default.
> The oversampling ratio is configured from the OS_MODE register (address
> 0x08) with the addition of OS=128 and OS=256 that were not available in
> hardware mode.
> 
> The device is configured to output data on a single spi channel, but this
> configuration must be done right after restart. That is why the delay was
> removed for devices which doesn't require it.
> 
> Moreover, in software mode, the range gpio has no longer its function.
> Instead, the scale can be configured individually for each channel from
> the RANGE_CH registers (address 0x03 to 0x06). Besides the already
> supported ±10 V and ±5 V ranges, software mode can also accommodate the
> ±2.5 V range.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changes in v2:
> -nothing changed
> 
>  drivers/iio/adc/ad7606.c     |  13 ++++-
>  drivers/iio/adc/ad7606.h     |   4 ++
>  drivers/iio/adc/ad7606_spi.c | 107 +++++++++++++++++++++++++++++++++++
>  3 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index ed2d08437e5d..f5ba94c03a8d 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -410,12 +410,19 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
> +	[ID_AD7606B] = {
> +		.channels = ad7606_channels,
> +		.num_channels = 9,
> +		.oversampling_avail = ad7606_oversampling_avail,
> +		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
> +	},
>  	[ID_AD7616] = {
>  		.channels = ad7616_channels,
>  		.num_channels = 17,
>  		.oversampling_avail = ad7616_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
>  		.os_req_reset = true,
> +		.init_delay_ms = 15,
>  	},
>  };
>  
> @@ -631,8 +638,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
>  	/* AD7616 requires al least 15ms to reconfigure after a reset */
> -	if (msleep_interruptible(15))
> -		return -ERESTARTSYS;
> +	if (st->chip_info->init_delay_ms) {
> +		if (msleep_interruptible(st->chip_info->init_delay_ms))
> +			return -ERESTARTSYS;
> +	}
>  
>  	st->write_scale = ad7606_write_scale_hw;
>  	st->write_os = ad7606_write_os_hw;
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index eeaaa8b905db..9350ef1f63b5 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -46,6 +46,8 @@
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail array
>   * @os_req_reset	some devices require a reset to update oversampling
> + * @init_delay_ms	required delay in miliseconds for initialization

mil_l_iseconds

> + *			after a restart
>   */
>  struct ad7606_chip_info {
>  	const struct iio_chan_spec	*channels;
> @@ -53,6 +55,7 @@ struct ad7606_chip_info {
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
> +	unsigned long			init_delay_ms;
>  };
>  
>  /**
> @@ -155,6 +158,7 @@ enum ad7606_supported_device_ids {
>  	ID_AD7606_8,
>  	ID_AD7606_6,
>  	ID_AD7606_4,
> +	ID_AD7606B,
>  	ID_AD7616,
>  };
>  
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 98ed52b74507..070ee7e31e2c 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -31,6 +31,20 @@
>  /* The range of the channel is stored on 2 bits*/

space before */
maybe: 'in' instead of 'on'

>  #define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
>  #define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
> +
> +#define AD7606_CONFIGURATION_REGISTER	0x02
> +#define AD7606_SINGLE_DOUT		0x0

maybe 0x00?

> +
> +/*
> + * Range for AD7606B channels are stored in registers starting with address 0x3.
> + * Each register stores range for 2 channels(4 bits per channel).
> + */
> +#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
> +#define AD7606_RANGE_CH_MODE(ch, mode)	\
> +	((GENMASK(3, 0) & mode) << (4 * ((ch) & 0x1)))
> +#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
> +#define AD7606_OS_MODE			0x08
> +
>  static const struct iio_chan_spec ad7616_sw_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(16),
>  	AD7616_CHANNEL(0),
> @@ -51,6 +65,22 @@ static const struct iio_chan_spec ad7616_sw_channels[] = {
>  	AD7616_CHANNEL(15),
>  };
>  
> +static const struct iio_chan_spec ad7606B_sw_channels[] = {

I find it strange to uppercase the B (but not ad)

> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +	AD7616_CHANNEL(0),
> +	AD7616_CHANNEL(1),
> +	AD7616_CHANNEL(2),
> +	AD7616_CHANNEL(3),
> +	AD7616_CHANNEL(4),
> +	AD7616_CHANNEL(5),
> +	AD7616_CHANNEL(6),
> +	AD7616_CHANNEL(7),
> +};
> +
> +static const unsigned int ad7606B_oversampling_avail[9] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256
> +};
> +
>  static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
>  {
>  	/*
> @@ -60,6 +90,16 @@ static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
>  	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
>  }
>  
> +static u16 ad7606B_spi_rd_wr_cmd(int addr, char isWriteOp)

bool isWriteOp?

> +{
> +	/*
> +	 * The address of register consists of one bit which
> +	 * specifies a read command placed bit 6, followed by

placed _in_ bit 6

> +	 * 6 bits of address.
> +	 */
> +	return (addr & 0x3F) | (((~isWriteOp) & 0x1) << 6);
> +}
> +
>  static int ad7606_spi_read_block(struct device *dev,
>  				 int count, void *buf)
>  {
> @@ -169,6 +209,23 @@ static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
>  				     AD7616_OS_MASK, val << 2);
>  }
>  
> +static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_spi_write_mask(st,
> +				     AD7606_RANGE_CH_ADDR(ch),
> +				     AD7606_RANGE_CH_MSK(ch),
> +				     AD7606_RANGE_CH_MODE(ch, val));
> +}
> +
> +static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_spi_reg_write(st, AD7606_OS_MODE, val);
> +}
> +
>  static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -189,6 +246,42 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
>  			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
>  }
>  
> +static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned long os[3] = {1};
> +
> +	/*
> +	 * Software mode is enabled when all three oversampling
> +	 * pins are set to high. If oversampling gpios are defined
> +	 * in the device tree, then they need to be set to high,
> +	 * otherwise, they must be hardwired to VDD
> +	 */
> +	if (st->gpio_os) {
> +		gpiod_set_array_value(ARRAY_SIZE(os),
> +				      st->gpio_os->desc, st->gpio_os->info, os);
> +	}
> +	/* OS of 128 and 256 are available only in software mode */
> +	st->oversampling_avail = ad7606B_oversampling_avail;
> +	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);
> +
> +	st->write_scale = ad7606_write_scale_sw;
> +	st->write_os = &ad7606_write_os_sw;
> +
> +	/* Configure device spi to output on a single channel */
> +	st->bops->reg_write(st,
> +			    AD7606_CONFIGURATION_REGISTER,
> +			    AD7606_SINGLE_DOUT);
> +
> +	/*
> +	 * Scale can be configured individually for each channel
> +	 * in software mode.
> +	 */
> +	indio_dev->channels = ad7606B_sw_channels;
> +
> +	return 0;
> +}
> +
>  static const struct ad7606_bus_ops ad7606_spi_bops = {
>  	.read_block = ad7606_spi_read_block,
>  };
> @@ -202,6 +295,15 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
>  	.sw_mode_config = ad7616_sw_mode_config,
>  };
>  
> +static const struct ad7606_bus_ops ad7606B_spi_bops = {
> +	.read_block = ad7606_spi_read_block,
> +	.reg_read = ad7606_spi_reg_read,
> +	.reg_write = ad7606_spi_reg_write,
> +	.write_mask = ad7606_spi_write_mask,
> +	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
> +	.sw_mode_config = ad7606B_sw_mode_config,
> +};
> +
>  static int ad7606_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -211,6 +313,9 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  	case ID_AD7616:
>  		bops = &ad7616_spi_bops;
>  		break;
> +	case ID_AD7606B:
> +		bops = &ad7606B_spi_bops;
> +		break;
>  	default:
>  		bops = &ad7606_spi_bops;
>  		break;
> @@ -226,6 +331,7 @@ static const struct spi_device_id ad7606_id_table[] = {
>  	{ "ad7606-4", ID_AD7606_4 },
>  	{ "ad7606-6", ID_AD7606_6 },
>  	{ "ad7606-8", ID_AD7606_8 },
> +	{ "ad7606b",  ID_AD7606B },
>  	{ "ad7616",   ID_AD7616 },
>  	{}
>  };
> @@ -236,6 +342,7 @@ static const struct of_device_id ad7606_of_match[] = {
>  	{ .compatible = "adi,ad7606-4" },
>  	{ .compatible = "adi,ad7606-6" },
>  	{ .compatible = "adi,ad7606-8" },
> +	{ .compatible = "adi,ad7606b" },
>  	{ .compatible = "adi,ad7616" },
>  	{ },
>  };
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
--324302256-509562479-1565196100=:32509--
