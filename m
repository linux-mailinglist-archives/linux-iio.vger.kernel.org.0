Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14290D4FAC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfJLM1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfJLMZe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:25:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9C921850;
        Sat, 12 Oct 2019 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570883133;
        bh=dOmMGPZcz4SFD3WuVU+3mZjK8K1NyzQtl/S7u6nKy3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jMrTQrS2itFva2VZ7+zQ8K0TzTnZpYq/b4wqeqoAwqR56s/Vd0HaCj45lAccYj5c6
         3Ip6L9mxFWfs1vGsTbgwH5f8RHhnKSM/QEImYXx+foHufMX8ICbzHvcEkOrxKTJ5C2
         pF29iwswxCFjGw57xS7tD21E7ZBf0zpet0b6X9eg=
Date:   Sat, 12 Oct 2019 13:25:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 10/13] iio: imu: st_lsm6dsx: add wakeup_source in
 st_sensors_platform_data
Message-ID: <20191012132529.3f1a3b9c@archlinux>
In-Reply-To: <a237c2406825ff16c5606344420fd566b08525f9.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <a237c2406825ff16c5606344420fd566b08525f9.1570367532.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  6 Oct 2019 15:22:04 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add the possibility to enable/disable wakeup source through
> st_sensors_platform_data and not only through device tree
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
I'm going to assume you need this for something... In general
I'm not that keen on expanding platform data support.

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 6 ++++--
>  include/linux/platform_data/st_sensors_pdata.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index b0623b837abd..a2a0ac81e3d3 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2089,7 +2089,9 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> +	struct st_sensors_platform_data *pdata = dev->platform_data;
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	struct device_node *np = dev->of_node;
>  	struct st_lsm6dsx_hw *hw;
>  	const char *name = NULL;
>  	int i, err;
> @@ -2152,8 +2154,8 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> -	if (dev->of_node &&
> -	    of_property_read_bool(dev->of_node, "wakeup-source"))
> +	if ((np && of_property_read_bool(np, "wakeup-source")) ||
> +	    (pdata && pdata->wakeup_source))
>  		device_init_wakeup(dev, true);
>  
>  	return 0;
> diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
> index 30929c22227d..e40b28ca892e 100644
> --- a/include/linux/platform_data/st_sensors_pdata.h
> +++ b/include/linux/platform_data/st_sensors_pdata.h
> @@ -18,12 +18,14 @@
>   * @open_drain: set the interrupt line to be open drain if possible.
>   * @spi_3wire: enable spi-3wire mode.
>   * @pullups: enable/disable i2c controller pullup resistors.
> + * @wakeup_source: enable/disable device as wakeup generator.
>   */
>  struct st_sensors_platform_data {
>  	u8 drdy_int_pin;
>  	bool open_drain;
>  	bool spi_3wire;
>  	bool pullups;
> +	bool wakeup_source;
>  };
>  
>  #endif /* ST_SENSORS_PDATA_H */

