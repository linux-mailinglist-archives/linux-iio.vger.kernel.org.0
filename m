Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860BC2231B
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfERKUh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 06:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfERKUg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 06:20:36 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A21CE20882;
        Sat, 18 May 2019 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558174835;
        bh=6NB9Z0T4EVef3CpmXtyWuLQlD836mhIpMXiN7OIS92U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uotz2nEgDQovm2TQSdJ6NAI+XVi+5qRJ/XYINMVixiX908IepDgKjS+tN0rWEm5+R
         Qb1g6ABesGGcm66qeA2361AROgMx4+PzEKkdHrnSmlMI32eau3h7vN/0FZ6DjTiScN
         0iP0MoNLAPm96xCRfhz4eqAyvGwmX4hP7XuSaHJI=
Date:   Sat, 18 May 2019 11:20:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 3/5] iio: adc: ad7606: Make SPI register calculation
 generic and add spi support
Message-ID: <20190518112030.56c0411f@archlinux>
In-Reply-To: <20190516143208.19294-3-beniamin.bia@analog.com>
References: <20190516143208.19294-1-beniamin.bia@analog.com>
 <20190516143208.19294-3-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 May 2019 17:32:06 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> In order to support AD7616 software mode, the spi register access must be
> added and the calculation of registers address must be generic.
> The length of address and bit which specifies the read/write operation is
> different for every device, that is why it was made generic.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
The break up patches has ended up a little odd. This one introduced unused
functions for example. Probably best to merge this and the next patch.

As a potential follow up, could this driver just use a 16 bit word
length and avoid some of the endian handling? (this might also fix
the casting issues).

However, there are some nasty casts in here that sparse is unhappy about.
I would definitely like those cleaned up before we add more of them.

If changing to 16bit SPI words doesn't do the job, then perhaps
we have to have a be16 version of data (as a union to avoid more
space usage).

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 60 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7606.h |  2 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index aba0fd123a51..6df81117cacc 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -25,6 +25,8 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> +#include <linux/spi/spi.h>
> +
>  #include "ad7606.h"
>  
>  /*
> @@ -43,6 +45,11 @@ static const unsigned int ad7616_oversampling_avail[8] = {
>  	1, 2, 4, 8, 16, 32, 64, 128,
>  };
>  
> +static int ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
> +{
> +	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
> +}
> +
>  static int ad7606_reset(struct ad7606_state *st)
>  {
>  	if (st->gpio_reset) {
> @@ -55,6 +62,59 @@ static int ad7606_reset(struct ad7606_state *st)
>  	return -ENODEV;
>  }
>  
> +static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->data[0],
> +			.len = 2,
> +			.cs_change = 0,
> +		}, {
> +			.rx_buf = &st->data[1],
> +			.len = 2,
> +		},
> +	};
> +	int ret;
> +
> +	st->data[0] = cpu_to_be16(st->chip_info->spi_rd_wr_cmd(addr, 0) << 8);
> +
> +	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(st->data[1]);
> +}
> +
> +static int ad7606_spi_reg_write(struct ad7606_state *st,
> +				unsigned int addr,
> +				unsigned int val)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +
> +	st->data[0] = cpu_to_be16((st->chip_info->spi_rd_wr_cmd(addr, 1) << 8) |
> +				  (val & 0x1FF));
> +
> +	return spi_write(spi, &st->data[0], sizeof(st->data[0]));
> +}
> +
> +static int ad7606_spi_write_mask(struct ad7606_state *st,
> +				 unsigned int addr,
> +				 unsigned long mask,
> +				 unsigned int val)
> +{
> +	int readval;
> +
> +	readval = ad7606_spi_reg_read(st, addr);
> +	if (readval < 0)
> +		return readval;
> +
> +	readval &= ~mask;
> +	readval |= val;
> +
> +	return ad7606_spi_reg_write(st, addr, readval);
> +}
> +
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels;
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index d8a509c2c428..dfc60af9b8ac 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -16,6 +16,7 @@
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail array
>   * @os_req_reset	some devices require a reset to update oversampling
> + * @spi_rd_wr_cmd	pointer to the function which calculates the spi address
>   * @write_scale_sw	pointer to the function which writes the scale via spi
>  			in software mode
>   * @write_os_sw		pointer to the function which writes the os via spi
> @@ -29,6 +30,7 @@ struct ad7606_chip_info {
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
> +	int (*spi_rd_wr_cmd)(int addr, char isWriteOp);
>  	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
>  	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
>  	int (*sw_mode_config)(struct iio_dev *indio_dev);

