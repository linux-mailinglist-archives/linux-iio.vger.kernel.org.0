Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983F1ED309
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 12:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKCLNh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 06:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfKCLNg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 06:13:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26F220842;
        Sun,  3 Nov 2019 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572779615;
        bh=5rXKrFWms57tsDlaloxvuxolTmE2fGPLi6afJVoTdWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WhzUkQi9JZHbgkmSDYOS6dzOEMoa52bTajaVpFq2nJXxFlv+RgEpBsX2tbmFYd1R+
         DBEdRJxu2EbA74EMIrvc3mIilXKdrdAm69i7n4zJ+EWAdBDGw+PggfPXBEYKkG5fcL
         cTJSEPotk+Np4pWw+N8HfD9Ep/iS1YCoIR1ZRAlQ=
Date:   Sun, 3 Nov 2019 11:13:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC] iio: srf04: add parallax ping sensors
Message-ID: <20191103111331.33b80698@archlinux>
In-Reply-To: <20191031121317.vojiwnijmuq5jxap@arbad>
References: <20191031121317.vojiwnijmuq5jxap@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Oct 2019 13:13:19 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Jonathan,
> 
> i added support for parallax ping and laser ping sensors with just one pin
> for trigger and echo signal.
> 
> After implementing it turned out that this one pin sensor requires a lot of
> conditions and special treatment. But the calculation is still the same as
> for srf04.
> 
> Should it be integrated into the existing srf04 driver or should i create a
> new one for those single pin us sensors? Maybe together with a C module for
> the calculations they have in common.

Ultimately it's your choice but I agree this seems like a lot of extra
code on a very small driver.  Might be more maintainable to separate them.

Looking at the code the calculation code seems fairly small. I'd just cut
and paste it to avoid the fiddly nature of a shared module.

Jonathan


> 
> Regards,
> 
> Andreas
> 
> ---
>  drivers/iio/proximity/srf04.c | 151 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 122 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 01eb8cc63076..8bcc77a45965 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -49,7 +49,12 @@
>  #include <linux/iio/sysfs.h>
>  
>  struct srf04_cfg {
> -	unsigned long trigger_pulse_us;
> +	unsigned long	trigger_pulse_us;	/* length of trigger pulse */
> +	int		single_pin_mode;	/* just one pin for trigger */
> +						/*   and echo */
> +	int		laserping_error;	/* support error code in */
> +						/*   pulse width of laser */
> +						/*   ping sensors */
>  };
>  
>  struct srf04_data {
> @@ -67,10 +72,26 @@ struct srf04_data {
>  
>  static const struct srf04_cfg srf04_cfg = {
>  	.trigger_pulse_us = 10,
> +	.single_pin_mode = 0,
> +	.laserping_error = 0,
>  };
>  
>  static const struct srf04_cfg mb_lv_cfg = {
>  	.trigger_pulse_us = 20,
> +	.single_pin_mode = 0,
> +	.laserping_error = 0,
> +};
> +
> +static const struct srf04_cfg pa_ping_cfg = {
> +	.trigger_pulse_us = 5,
> +	.single_pin_mode = 1,
> +	.laserping_error = 0,
> +};
> +
> +static const struct srf04_cfg pa_laser_ping_cfg = {
> +	.trigger_pulse_us = 5,
> +	.single_pin_mode = 1,
> +	.laserping_error = 1,
>  };
>  
>  static irqreturn_t srf04_handle_irq(int irq, void *dev_id)
> @@ -96,6 +117,9 @@ static int srf04_read(struct srf04_data *data)
>  	ktime_t ktime_dt;
>  	u64 dt_ns;
>  	u32 time_ns, distance_mm;
> +	struct platform_device *pdev = container_of(data->dev,
> +						struct platform_device, dev);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(data);
>  
>  	/*
>  	 * just one read-echo-cycle can take place at a time
> @@ -110,30 +134,58 @@ static int srf04_read(struct srf04_data *data)
>  	udelay(data->cfg->trigger_pulse_us);
>  	gpiod_set_value(data->gpiod_trig, 0);
>  
> +	if (data->cfg->single_pin_mode) {
> +		ret = gpiod_direction_input(data->gpiod_trig);
> +		if (ret < 0) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +
> +		data->irqnr = gpiod_to_irq(data->gpiod_echo);
> +		if (data->irqnr < 0) {
> +			dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
> +			return data->irqnr;
> +		}
> +
> +		ret = devm_request_irq(data->dev, data->irqnr, srf04_handle_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				pdev->name, indio_dev);
> +		if (ret < 0) {
> +			dev_err(data->dev, "request_irq: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	/* it should not take more than 20 ms until echo is rising */
>  	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> -		return ret;
> -	} else if (ret == 0) {
> -		mutex_unlock(&data->lock);
> -		return -ETIMEDOUT;
> +	if (ret < 0)
> +		goto err_reset_direction;
> +	else if (ret == 0) {
> +		ret = -ETIMEDOUT;
> +		goto err_reset_direction;
>  	}
>  
>  	/* it cannot take more than 50 ms until echo is falling */
>  	ret = wait_for_completion_killable_timeout(&data->falling, HZ/20);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> -		return ret;
> -	} else if (ret == 0) {
> -		mutex_unlock(&data->lock);
> -		return -ETIMEDOUT;
> +	if (ret < 0)
> +		goto err_reset_direction;
> +	else if (ret == 0) {
> +		ret = -ETIMEDOUT;
> +		goto err_reset_direction;
>  	}
>  
>  	ktime_dt = ktime_sub(data->ts_falling, data->ts_rising);
>  
>  	mutex_unlock(&data->lock);
>  
> +	if (data->cfg->single_pin_mode) {
> +		free_irq(data->irqnr, indio_dev);
> +
> +		ret = gpiod_direction_output(data->gpiod_trig, GPIOD_OUT_LOW);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	dt_ns = ktime_to_ns(ktime_dt);
>  	/*
>  	 * measuring more than 6,45 meters is beyond the capabilities of
> @@ -154,6 +206,25 @@ static int srf04_read(struct srf04_data *data)
>  	time_ns = dt_ns;
>  
>  	/*
> +	 * read error code of laser ping sensor and give users chance to
> +	 * figure out error by using dynamic debuggging
> +	 */
> +	if (data->cfg->laserping_error) {
> +		if ((time_ns >= 12500000) && (time_ns < 13500000)) {
> +			dev_dbg(data->dev, "target too close or to far\n");
> +			return -EIO;
> +		}
> +		if ((time_ns >= 13500000) && (time_ns < 14500000)) {
> +			dev_dbg(data->dev, "internal sensor error\n");
> +			return -EIO;
> +		}
> +		if ((time_ns >= 14500000) && (time_ns < 15500000)) {
> +			dev_dbg(data->dev, "internal sensor timeout\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	/*
>  	 * the speed as function of the temperature is approximately:
>  	 *
>  	 * speed = 331,5 + 0,6 * Temp
> @@ -176,6 +247,16 @@ static int srf04_read(struct srf04_data *data)
>  	distance_mm = time_ns * 106 / 617176;
>  
>  	return distance_mm;
> +
> +err_reset_direction:
> +	mutex_unlock(&data->lock);
> +	if (data->cfg->single_pin_mode) {
> +		free_irq(data->irqnr, indio_dev);
> +
> +		if (gpiod_direction_output(data->gpiod_trig, GPIOD_OUT_LOW))
> +			dev_dbg(data->dev, "error in gpiod_direction_output\n");
> +	}
> +	return ret;
>  }
>  
>  static int srf04_read_raw(struct iio_dev *indio_dev,
> @@ -228,6 +309,8 @@ static const struct of_device_id of_srf04_match[] = {
>  	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg},
>  	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg},
>  	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg},
> +	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
> +	{ .compatible = "parallax,laserping", .data = &pa_ping_cfg},
>  	{},
>  };
>  
> @@ -261,11 +344,19 @@ static int srf04_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->gpiod_trig);
>  	}
>  
> -	data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
> -	if (IS_ERR(data->gpiod_echo)) {
> -		dev_err(dev, "failed to get echo-gpios: err=%ld\n",
> +	/*
> +	 * some sensors come along with just one pin for triggering and the
> +	 * echo
> +	 */
> +	if (data->cfg->single_pin_mode)
> +		data->gpiod_echo = data->gpiod_trig;
> +	else {
> +		data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
> +		if (IS_ERR(data->gpiod_echo)) {
> +			dev_err(dev, "failed to get echo-gpios: err=%ld\n",
>  					PTR_ERR(data->gpiod_echo));
> -		return PTR_ERR(data->gpiod_echo);
> +			return PTR_ERR(data->gpiod_echo);
> +		}
>  	}
>  
>  	if (gpiod_cansleep(data->gpiod_echo)) {
> @@ -273,18 +364,20 @@ static int srf04_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	data->irqnr = gpiod_to_irq(data->gpiod_echo);
> -	if (data->irqnr < 0) {
> -		dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
> -		return data->irqnr;
> -	}
> -
> -	ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
> -			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> -			pdev->name, indio_dev);
> -	if (ret < 0) {
> -		dev_err(data->dev, "request_irq: %d\n", ret);
> -		return ret;
> +	if (!data->cfg->single_pin_mode) {
> +		data->irqnr = gpiod_to_irq(data->gpiod_echo);
> +		if (data->irqnr < 0) {
> +			dev_err(data->dev, "gpiod_to_irq: %d\n", data->irqnr);
> +			return data->irqnr;
> +		}
> +
> +		ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				pdev->name, indio_dev);
> +		if (ret < 0) {
> +			dev_err(data->dev, "request_irq: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, indio_dev);

