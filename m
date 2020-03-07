Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8846917CE89
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgCGNuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 08:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGNuz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 08:50:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8024206D5;
        Sat,  7 Mar 2020 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583589054;
        bh=NLqA8Wd3AdiunvU1Q56tZuX96WYSPm1HPGLmNRfFZks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bx6znF43oYs5L0z7muoUZ8pmh3eZfIq7ep3LGvFaIKG3WIm8oMjyXnb/QJTkrj4nK
         4ofYdf3pRNYOQf7MsCPkoSid4jtPNFW+lgjlCbfqR2Lue8DCpCHWaavIuZNA0VGglm
         Tg2nzKZn7O3z0TFbCwNPJB1XPm4m/bPDD3o5K3zM=
Date:   Sat, 7 Mar 2020 13:50:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     519965df20014e135acc9cc9c4674bbba8d76f1a.camel@analog.com,
        linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com
Subject: Re: [PATCH v2] iio: adc: max1363: replace mlock with own lock
Message-ID: <20200307135050.425ebda7@archlinux>
In-Reply-To: <5e595c91.1c69fb81.6beb1.f7b0@mx.google.com>
References: <5e595c91.1c69fb81.6beb1.f7b0@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Feb 2020 00:01:37 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> This change replaces indio_dev's mlock with the drivers own lock. In
> each case the lock is needed to protect the driver's own state.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
So this deals with the simpler cases where we want to change the lock.
Makes sense to separate the two.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to have a poke at it. I'll do a pull request in the
next few days and when that gets taken by Greg KH these will then show
up in next and be queued up by him for the merge window that will open
in perhaps 3 weeks time.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1363.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..198094ad79a1 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -169,6 +169,7 @@ struct max1363_state {
>  	const struct max1363_mode	*current_mode;
>  	u32				requestedmask;
>  	struct regulator		*reg;
> +	struct mutex			lock;
>  
>  	/* Using monitor modes and buffer at the same time is
>  	   currently not supported */
> @@ -364,7 +365,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -405,7 +406,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	}
>  	*val = data;
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  
>  }
> @@ -705,9 +706,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
>  	if (!found)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->mlock);
>  	st->monitor_speed = i;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->mlock);
>  
>  	return 0;
>  }
> @@ -810,12 +811,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
>  	int val;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->mlock);
>  	if (dir == IIO_EV_DIR_FALLING)
>  		val = (1 << number) & st->mask_low;
>  	else
>  		val = (1 << number) & st->mask_high;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->mlock);
>  
>  	return val;
>  }
> @@ -1587,6 +1588,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> +	mutex_init(&st->lock);
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(st->reg)) {
>  		ret = PTR_ERR(st->reg);

