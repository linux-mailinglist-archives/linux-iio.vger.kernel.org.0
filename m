Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673FE1E981F
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgEaO2u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgEaO2u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:28:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00CF2076B;
        Sun, 31 May 2020 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590935329;
        bh=WJ048ICWOTY+GRwHR44Gd5AyJQwMiCSu66cBgCEcpiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HwO/HmGcwQU+AlFXcDkLX/cpQxEe7tAFrWXFo9G11C6Zjhq6LJRRdYkC29Ly+D4mA
         dpCRXKoPoDM9LlEebcOF7TuV7GJ+Pgv2Cek9F29FSdwK2sTsGqXTJTHNNlSVgpjDQy
         P0eQz9IhVvyB6ctpltibAC+N3wPBxR8ieEwu3+w0=
Date:   Sun, 31 May 2020 15:28:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v4 4/5] iio: imu: bmi160: added regulator support
Message-ID: <20200531152845.2aeaba14@archlinux>
In-Reply-To: <20200525164615.14962-5-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
        <20200525164615.14962-5-jonathan.albrieux@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 18:46:03 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> Add vdd-supply and vddio-supply support.
> 
> While working on an msm8916 device and having explicit declarations for
> regulators, without setting these regulators to regulators-always-on it
> happened those lines weren't ready because they could have been controlled
> by other components, causing failure in module's probe.
> 
> This patch aim is to solve this situation by adding regulators control
> during bmi160_chip_init() and bmi160_chip_uninit(), assuring power to
> this component.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
>  drivers/iio/imu/bmi160/bmi160_core.c | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index 621f5309d735..923c3b274fde 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -3,10 +3,12 @@
>  #define BMI160_H_
>  
>  #include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
>  
>  struct bmi160_data {
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
> +	struct regulator_bulk_data supplies[2];
>  };
>  
>  extern const struct regmap_config bmi160_regmap_config;
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 77b05bd4a2b2..d3316ca02fbd 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/of_irq.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -709,6 +710,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  	unsigned int val;
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
>  	if (ret)
>  		return ret;
> @@ -793,9 +800,16 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
>  static void bmi160_chip_uninit(void *data)
>  {
>  	struct bmi160_data *bmi_data = data;
> +	struct device *dev = regmap_get_device(bmi_data->regmap);
> +	int ret;
>  
>  	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
>  	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(bmi_data->supplies),
> +				     bmi_data->supplies);
> +	if (ret)
> +		dev_err(dev, "Failed to disable regulators: %d\n", ret);
>  }
>  
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> @@ -815,6 +829,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
>  
> +	data->supplies[0].supply = "vdd";
> +	data->supplies[1].supply = "vddio";
> +	ret = devm_regulator_bulk_get(dev,
> +				      ARRAY_SIZE(data->supplies),
> +				      data->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = bmi160_chip_init(data, use_spi);
>  	if (ret)
>  		return ret;

