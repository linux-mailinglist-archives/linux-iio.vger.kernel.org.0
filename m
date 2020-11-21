Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961DF2BC04B
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgKUPoj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgKUPoj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:44:39 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345F1221FE;
        Sat, 21 Nov 2020 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605973479;
        bh=SyC1dhqCsDOI19dIs9bJQBVes0qMiioBiPrRPnoChck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eGN2PncVzwFX4DdCLvDa2gn58JRnUGSpAFO1+YFgAjv1U1YV19RyFqvDyVR1/zDj7
         2yohdb2VtYnXz/0oVFX8ecgi5Ea4clI8HkBvIIa97fpKME49e6X1drSkYtbEbRSW3d
         8DMFnBsNOilGJxCX9wpzP6yi+yUoE0oCuKNe43TM=
Date:   Sat, 21 Nov 2020 15:44:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: humidity: hts221: add vdd voltage regulator
Message-ID: <20201121154434.7723d78a@archlinux>
In-Reply-To: <b2c5ea9dd41cb52eaf484825630bf07ef13510a4.1605777052.git.lorenzo@kernel.org>
References: <cover.1605777052.git.lorenzo@kernel.org>
        <b2c5ea9dd41cb52eaf484825630bf07ef13510a4.1605777052.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 10:13:34 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Like all other ST sensors, hts221 devices have VDD power line.
> Introduce VDD voltage regulator to control it.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Hi Lorenzo,

Minor thing about not printing error message is the deferred case.
Otherwise, looks good to me

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221.h      |  2 ++
>  drivers/iio/humidity/hts221_core.c | 39 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 721359e226cb..cf3d8d2dccd6 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -13,6 +13,7 @@
>  #define HTS221_DEV_NAME		"hts221"
>  
>  #include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
>  
>  enum hts221_sensor_type {
>  	HTS221_SENSOR_H,
> @@ -29,6 +30,7 @@ struct hts221_hw {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct regulator *vdd;
>  
>  	struct iio_trigger *trig;
>  	int irq;
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 16657789dc45..e1aa99dcf142 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -547,6 +547,37 @@ static const struct iio_info hts221_info = {
>  
>  static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
>  
> +static int hts221_init_regulators(struct device *dev)
> +{
> +	struct iio_dev *iio_dev = dev_get_drvdata(dev);
> +	struct hts221_hw *hw = iio_priv(iio_dev);
> +	int err;
> +
> +	hw->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(hw->vdd)) {
> +		dev_err(dev, "failed to get vdd regulator: %ld\n",
> +			PTR_ERR(hw->vdd));

dev_err_probe on this as I would assume we want to not print the message
on deferred response.

> +		return PTR_ERR(hw->vdd);
> +	}
> +
> +	err = regulator_enable(hw->vdd);
> +	if (err) {
> +		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
> +		return err;
> +	}
> +
> +	msleep(50);
> +
> +	return 0;
> +}
> +
> +static void hts221_chip_uninit(void *data)
> +{
> +	struct hts221_hw *hw = data;
> +
> +	regulator_disable(hw->vdd);
> +}
> +
>  int hts221_probe(struct device *dev, int irq, const char *name,
>  		 struct regmap *regmap)
>  {
> @@ -567,6 +598,14 @@ int hts221_probe(struct device *dev, int irq, const char *name,
>  	hw->irq = irq;
>  	hw->regmap = regmap;
>  
> +	err = hts221_init_regulators(dev);
> +	if (err)
> +		return err;
> +
> +	err = devm_add_action_or_reset(dev, hts221_chip_uninit, hw);
> +	if (err)
> +		return err;
> +
>  	err = hts221_check_whoami(hw);
>  	if (err < 0)
>  		return err;

