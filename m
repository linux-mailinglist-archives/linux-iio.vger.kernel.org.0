Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB67BD26
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGaJ25 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 05:28:57 -0400
Received: from onstation.org ([52.200.56.107]:45234 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfGaJ24 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Jul 2019 05:28:56 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 608933E910;
        Wed, 31 Jul 2019 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564565335;
        bh=u/qIdrUUjq1FaYIdEEDKhkEXHmOBKALGw9ffBDa0lkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RA4VY+hyr3qzD6yMvR7wssWRi28SHeHBC7t26nv2NbPOD7GH5QCyHx6h4se+vYRKO
         w/TU5JH7IGc2PWeIlZ2QsSnq57tKmEbFpvHjQtMNntRMW0iSGB9AzhW6Q5dwiJ1Om/
         sMmA4tiuqWG7T3AtLMpOZUdKWpvADzYZb6wkLuqY=
Date:   Wed, 31 Jul 2019 05:28:54 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: tsl2772: Use device-managed API
Message-ID: <20190731092854.GA19501@onstation.org>
References: <20190731030415.8062-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731030415.8062-1-hslester96@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Chuhong,

On Wed, Jul 31, 2019 at 11:04:15AM +0800, Chuhong Yuan wrote:
> Use devm_() APIs to simplify the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

There needs to be more of a changelog associated with this patch since
this doesn't describe what all is done below. I see the following
distinct three things that are done with this patch:

- Use devm_add_action_or_reset to remove the call to
  tsl2772_disable_regulators_action to simplify the error path.

- Use devm_add_action_or_reset to call tsl2772_chip_off
  when the device is removed. The changelog should also mention that
  this fixes an issue where the chip is turned off before the device is
  unregistered from the IIO subsystem. There should also be a Fixes tag
  and you can reference my patch that moved the driver out of staging as
  the commit that was fixed to make it easier for the folks that
  maintain the stable kernels. This issue most likely has been present
  since the driver was first introduced into mainline in 2012, however
  there were a large number commits that were needed in order to get this
  out of staging.

- Use devm_iio_device_register, which removes the tsl2772_remove
  function.

I would break this up further into three patches that are described
above. The patches will be small but it makes it much easier on the
maintainers who see a large number of patches come through. It helps
to keep the git history in the kernel clean, which is very helpful to
other developers.

Brian


> ---
> Changes in v3:
>   - Split v2 into two patches.
> 
>  drivers/iio/light/tsl2772.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 83cece921843..f1134f183be7 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -860,6 +860,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
>  	return tsl2772_write_control_reg(chip, 0x00);
>  }
>  
> +static void tsl2772_chip_off_action(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +
> +	tsl2772_chip_off(indio_dev);
> +}
> +
>  /**
>   * tsl2772_invoke_change - power cycle the device to implement the user
>   *                         parameters
> @@ -1807,10 +1814,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  		return PTR_ERR(chip->vdd_supply);
>  	}
>  
> -	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
> +	ret = devm_add_action_or_reset(&clientp->dev,
> +				tsl2772_disable_regulators_action,
>  			      chip);
>  	if (ret < 0) {
> -		tsl2772_disable_regulators_action(chip);
>  		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
>  			ret);
>  		return ret;
> @@ -1877,15 +1884,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		tsl2772_chip_off(indio_dev);
> -		dev_err(&clientp->dev,
> -			"%s: iio registration failed\n", __func__);
> +	ret = devm_add_action_or_reset(&clientp->dev,
> +					tsl2772_chip_off_action,
> +					indio_dev);
> +
> +	if (ret < 0)
>  		return ret;
> -	}
>  
> -	return 0;
> +	return devm_iio_device_register(&clientp->dev, indio_dev);
>  }
>  
>  static int tsl2772_suspend(struct device *dev)
> @@ -1922,17 +1928,6 @@ static int tsl2772_resume(struct device *dev)
>  	return tsl2772_chip_on(indio_dev);
>  }
>  
> -static int tsl2772_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	tsl2772_chip_off(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct i2c_device_id tsl2772_idtable[] = {
>  	{ "tsl2571", tsl2571 },
>  	{ "tsl2671", tsl2671 },
> @@ -1979,7 +1974,6 @@ static struct i2c_driver tsl2772_driver = {
>  	},
>  	.id_table = tsl2772_idtable,
>  	.probe = tsl2772_probe,
> -	.remove = tsl2772_remove,
>  };
>  
>  module_i2c_driver(tsl2772_driver);
> -- 
> 2.20.1
