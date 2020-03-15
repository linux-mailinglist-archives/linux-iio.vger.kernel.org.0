Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48608185C69
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgCOMlD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgCOMlD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:41:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50BF20674;
        Sun, 15 Mar 2020 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584276062;
        bh=8VVQTTInwJ8TvnSYj2kxUXuQo3fb1NJItUbhAdAiMNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BaY8dpbCqgaqPh/uVO+E2+KThpEQyNgHnUc/n74UZvN1PDl65QtNVwnLQBke40YYM
         b9M3tkzMx6pLIoXDAxnv63jiyCrk1YmuDS9t6bPXSe8aYTw0cukr8snMDuK8S67kx8
         tGFGY4Aq36Rq7vdxeY3c3e4G/TrEPucEeJMsTrLA=
Date:   Sun, 15 Mar 2020 12:40:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 5/8] iio: st_sensors: Join string literals back
Message-ID: <20200315124058.36fbef4f@archlinux>
In-Reply-To: <20200313104955.30423-5-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:52 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> For easy grepping on debug purposes join string literals back in
> the messages.
> 
> No functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
> v2: no change
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  3 +--
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 13 ++++---------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 804a9068e687..2e42838ca4f4 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -277,8 +277,7 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
>  	    !sdata->sensor_settings->drdy_irq.int2.addr) {
>  		if (pdata->drdy_int_pin)
>  			dev_info(&indio_dev->dev,
> -				 "DRDY on pin INT%d specified, but sensor "
> -				 "does not support interrupts\n",
> +				 "DRDY on pin INT%d specified, but sensor does not support interrupts\n",
>  				 pdata->drdy_int_pin);
>  		return 0;
>  	}
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index e817537cdfb5..0507283bd4c1 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -44,8 +44,7 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
>  			  &status);
>  	if (ret < 0) {
> -		dev_err(sdata->dev,
> -			"error checking samples available\n");
> +		dev_err(sdata->dev, "error checking samples available\n");
>  		return ret;
>  	}
>  
> @@ -148,9 +147,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	case IRQF_TRIGGER_LOW:
>  		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
>  			dev_err(&indio_dev->dev,
> -				"falling/low specified for IRQ "
> -				"but hardware supports only rising/high: "
> -				"will request rising/high\n");
> +				"falling/low specified for IRQ but hardware supports only rising/high: will request rising/high\n");
>  			if (irq_trig == IRQF_TRIGGER_FALLING)
>  				irq_trig = IRQF_TRIGGER_RISING;
>  			if (irq_trig == IRQF_TRIGGER_LOW)
> @@ -163,8 +160,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  			if (err < 0)
>  				goto iio_trigger_free;
>  			dev_info(&indio_dev->dev,
> -				 "interrupts on the falling edge or "
> -				 "active low level\n");
> +				 "interrupts on the falling edge or active low level\n");
>  		}
>  		break;
>  	case IRQF_TRIGGER_RISING:
> @@ -178,8 +174,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  	default:
>  		/* This is the most preferred mode, if possible */
>  		dev_err(&indio_dev->dev,
> -			"unsupported IRQ trigger specified (%lx), enforce "
> -			"rising edge\n", irq_trig);
> +			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
>  		irq_trig = IRQF_TRIGGER_RISING;
>  	}
>  

