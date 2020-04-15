Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37FB1AAC75
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410032AbgDOP61 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 11:58:27 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:50851 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410018AbgDOP6Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Apr 2020 11:58:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 492Rpj3tkWzCQ;
        Wed, 15 Apr 2020 17:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586966302; bh=sPTpapXfr78FujPIIuXzxYq0FrcfINA6LgQokS6Lg8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5wcI7lCacgb85p4hxcKJf/Mb+FF/PRT6WeLeMcvDjLsjxB2nxIazKXeq0QmMH4Q+
         tnqz4yVXdbc2SkjLA2y3ySkERydmBxPFu6M8JuAlFszNX3kjEb48eR5Kkje2q/b3wf
         qHbOp0c74ffAYldJNNNxolqBREx9Bru7Kv+o2AIjGJpqy7J2x5GtrqaM/zmdL5M2X5
         8W0UvekbJTdbFj7Dkt51EPlI+2ZezPLjFD/cIMssQkFbIhGd6L0jRL17sZRriPNPY6
         8HsmRI+oQQiZS0BZOLF5VATAYrRUtMfHaKeN+7wDxYO/5FD+G6MziPQjW16EaOjiJF
         1wNEXsmNVnF0g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 15 Apr 2020 17:58:17 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Provide scaling
Message-ID: <20200415155817.GA19897@qmqm.qmqm.pl>
References: <20200414211717.11472-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414211717.11472-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 11:17:17PM +0200, Linus Walleij wrote:
> The manual for the HSCDTD008A gives us a scaling for the
> three axis as +/- 2.4mT per axis.
> 
> When I implement this the biggest axis indicates 0.59 Gauss
> which is a reasonable measurement for the earths magnetic
> which is in the range of 0.25 to 0.65 Gauss on the surface
> according to Wikipedia.
> 
> Since the raw read function is now also used for scaling
> we need to break out a function that takes the locks and
> runtime PM so we don't get too hairy goto:s.
> 
> Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This patch is based on top of Nick's patches for the
> HSCDTD008A support.
> ---
>  drivers/iio/magnetometer/ak8974.c | 66 +++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index ade4ed8f67d2..effcdd93e650 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -554,46 +554,69 @@ static int ak8974_detect(struct ak8974 *ak8974)
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

You could pass a pointer to int, and avoid later copy in
ak8974_read_raw().

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
[...]
This can be just return -EIO since you've pushed the locks into separate
function.

Can you split the patch into one extracting the code for
ak8974_measure() and second for adding the scale?

Best Regards,
Micha³ Miros³aw
