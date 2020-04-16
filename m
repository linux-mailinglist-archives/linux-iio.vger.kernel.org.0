Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD391ACEA9
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392900AbgDPRZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 13:25:25 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:58535 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbgDPRZZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Apr 2020 13:25:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4935hc6w8SzCQ;
        Thu, 16 Apr 2020 19:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1587057921; bh=w+DOpJkm1eTb8fGWDv4DMIgUZmT1kX4wykxyB8SU8AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gf2Vg80h7TNObdRH2Ych+OTiPiG+VV6t0NZdAM73ZZPqeK/G7KZtJo/2+2NqB/1Km
         J0F42fQ9e8UECxlKnOk3ViIFV5zY6Q2A3YNplydCsVyp/WU//TqLEg2FKkEspUFMDb
         MAfhhwpX5hj6GZuAboaBkbRHz9gllN2s8uEvpEbX8x1SoMKkKd/slSOxlCjTCFcvbb
         hnqRNmMdKAgxI+Vhn+/fM3Ntflv4UwNARPe/OVfPjBPpcB6/tLMwGZuyzGVVFn78hW
         7JspTDHJs4rXUCt4aXZ/agqbB7dzG4mVGtrekJeCUWLb0W1jgoh4gDBD0co5io25jX
         zT9BkB/F6yPrQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 16 Apr 2020 19:25:16 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/2 v2] iio: magnetometer: ak8974: Break out measurement
Message-ID: <20200416172516.GA372@qmqm.qmqm.pl>
References: <20200416140917.8087-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416140917.8087-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 16, 2020 at 04:09:16PM +0200, Linus Walleij wrote:
> This breaks out the measurement code to its own function
> so we can handle this without swirling it up with the
> bis switch() statement inside ak8974_read_raw().
> 
> Use an intermediary s16* variable since we read s16 but
> the external API required an int* so this way we get
> explicit casting.
> 
> Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Break out as a separate patch.
> ---
>  drivers/iio/magnetometer/ak8974.c | 51 +++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index ade4ed8f67d2..5361647b9054 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -554,46 +554,57 @@ static int ak8974_detect(struct ak8974 *ak8974)
>  	return 0;
>  }
>  
> +static int ak8974_measure(struct ak8974 *ak8974, unsigned long address, s16 *val)
> +{
> +	__le16 hw_values[3];
> +	int ret;
> +
> +	pm_runtime_get_sync(&ak8974->i2c->dev);
> +	mutex_lock(&ak8974->lock);
> +
> +	ret = ak8974_trigmeas(ak8974);
> +	if (ret)
> +		goto out_unlock;
> +	ret = ak8974_getresult(ak8974, hw_values);
> +	if (ret)
> +		goto out_unlock;
> +	*val = (s16)le16_to_cpu(hw_values[address]);

This will still work if the 'val' argument was 'int *'. And it would make
'outval' in the caller redundant.

> +out_unlock:
> +	mutex_unlock(&ak8974->lock);
> +	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
> +	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
> +
> +	return ret;
> +}
> +
>  static int ak8974_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2,
>  			   long mask)
>  {
>  	struct ak8974 *ak8974 = iio_priv(indio_dev);
> -	__le16 hw_values[3];
>  	int ret = -EINVAL;
> -
> -	pm_runtime_get_sync(&ak8974->i2c->dev);
> -	mutex_lock(&ak8974->lock);
> +	s16 outval;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (chan->address > 2) {
>  			dev_err(&ak8974->i2c->dev, "faulty channel address\n");
>  			ret = -EIO;
> -			goto out_unlock;
> +			goto out_err_read;

You could get rid of the gotos to shorten and clear up the code.

>  		}
> -		ret = ak8974_trigmeas(ak8974);
> -		if (ret)
> -			goto out_unlock;
> -		ret = ak8974_getresult(ak8974, hw_values);
> -		if (ret)
> -			goto out_unlock;
> -
>  		/*
>  		 * We read all axes and discard all but one, for optimized
>  		 * reading, use the triggered buffer.
>  		 */
> -		*val = (s16)le16_to_cpu(hw_values[chan->address]);
> -
> +		ret = ak8974_measure(ak8974, chan->address, &outval);
> +		if (ret)
> +			goto out_err_read;
> +		*val = outval;
>  		ret = IIO_VAL_INT;
> +		break;
>  	}
> -
> - out_unlock:
> -	mutex_unlock(&ak8974->lock);
> -	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
> -	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
> -
> +out_err_read:
>  	return ret;
>  }
[...]

Best Regards,
Micha³ Miros³aw
