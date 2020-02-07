Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334F3154FDA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 01:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgBGAx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 19:53:28 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33605 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBGAx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 19:53:28 -0500
Received: by mail-il1-f194.google.com with SMTP id s18so340621iln.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 16:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rcFYnJkfI2MGGVEqTLqp5tNEgJl+onMkilv3HWa7c18=;
        b=hLgkCHkjtwVMs5ucy5lVahLy/O51OPGmRAb9A8UmxVoDUacfa/TW8G9FHDcErPWMZU
         ut4P0aFEhSUQNZSPB8bAzxwIG9kjxL8MFLQyorSBjWMFKiDuO3LXLTt+47Q76BzAPolr
         eN3Iipl+Xq+MWhDWp9+vJzt4/5E5x2nqTX8OGW0sKkxIz2vhJoQvGnBTCoUbl7eedeFH
         Getx/XOSEgeNoEDppElfo03YoRknlVnu2kombZNDCAsLr1Q7I0brItDD3PCOowUrgVXU
         AvrsJIf91MFLPOjr7/ZKgD8fpelA+A3UJvk+07z/RicJ0sd0JK1yW1C11u1CbDZT+Rdp
         XYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rcFYnJkfI2MGGVEqTLqp5tNEgJl+onMkilv3HWa7c18=;
        b=CF9F98vPrb1SVUOk8KoOO4aeuLa78MmlwjEv3EY1F6pYEx3mbWqJ4H34BmaeQ1xg6v
         m7ntC5iQEcnCTWkLzuE6M6xV7KdrjfCfnvPWz8m1dSxxkjrmVhU1IWs39M7FacJd4Gx6
         zEoezo/7WTZRQ0N/XGcoTVXzRByyhPGPpyQSqKHTwMM16rv4Tfx5uodErOt/X2jCrP4l
         V1OI4rcTWeNjp9S9X3LN15cSbsxiPpj7rvmZiZyBi40+xGR2pQQoyqCqb5eRaN9rWIpG
         yNy9DpR2i5baWoFW+KIKEqLUzp67RTZD6fO2KQ3xmaGB/vS0bB59yjBEtRSJj27yuK/d
         hgUQ==
X-Gm-Message-State: APjAAAXWoyxtvq9iY01WvyjZJFSf1aHmzm2iXno5oHYmF1blkwOrpQVV
        akyJ0XiVg6gpdrfnIODOtJE=
X-Google-Smtp-Source: APXvYqwYdirVhmx9i8cBsA70X5kjiCKyA1VqzwkGKBwhR2EyyXf1eh8LKcFkCPbF4VmrT2U0x8lhXQ==
X-Received: by 2002:a92:c848:: with SMTP id b8mr7128026ilq.168.1581036807401;
        Thu, 06 Feb 2020 16:53:27 -0800 (PST)
Received: from r2700x.localdomain (c-67-190-64-15.hsd1.co.comcast.net. [67.190.64.15])
        by smtp.gmail.com with ESMTPSA id y11sm579593ilm.22.2020.02.06.16.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 16:53:26 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:53:20 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v4 1/3] iio: chemical: atlas-sensor: allow probe without
 interrupt line
Message-ID: <20200207005320.GA3589@r2700x.localdomain>
References: <20200206061332.20427-1-matt.ranostay@konsulko.com>
 <20200206061332.20427-2-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206061332.20427-2-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 05, 2020 at 10:13:30PM -0800, Matt Ranostay wrote:
> Sensors don't actually need a interrupt line to give valid readings,
> and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
> the required check for interrupt, and continue along in the probe
> function.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 2f0a6fed2589..2e34c82cb65d 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	if (client->irq <= 0) {
> -		dev_err(&client->dev, "no valid irq defined\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = chip->calibration(data);
>  	if (ret)
>  		return ret;
> @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
>  
>  	init_irq_work(&data->work, atlas_work_handler);
>  
> -	/* interrupt pin toggles on new conversion */
> -	ret = devm_request_threaded_irq(&client->dev, client->irq,
> -					NULL, atlas_interrupt_handler,
> -					IRQF_TRIGGER_RISING |
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					"atlas_irq",
> -					indio_dev);
> -	if (ret) {
> -		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
> -		goto unregister_buffer;
> +	if (client->irq <= 0) {

Should this be > 0 ?

Jeremy

> +		/* interrupt pin toggles on new conversion */
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +				NULL, atlas_interrupt_handler,
> +				IRQF_TRIGGER_RISING |
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				"atlas_irq",
> +				indio_dev);
> +
> +		if (ret)
> +			dev_warn(&client->dev,
> +				"request irq (%d) failed\n", client->irq);
>  	}
>  
>  	ret = atlas_set_powermode(data, 1);
> -- 
> 2.20.1
> 
