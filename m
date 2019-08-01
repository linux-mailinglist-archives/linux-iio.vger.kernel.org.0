Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4777D8A4
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfHAJf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 05:35:28 -0400
Received: from onstation.org ([52.200.56.107]:49232 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAJf1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Aug 2019 05:35:27 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A93DC3E910;
        Thu,  1 Aug 2019 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564652127;
        bh=kfTmSsHjDSs4XpQs46UTlU71i6LS7tjQuHwr8ZEqdcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8Uvn5dgi2tdehpfsCzTDQaHWI/bMUZB6hJLoMHPKBV0xjuRtAoMou1LCTbM3ULTQ
         kAygZS7rVJuy81oUFCYol4R1YgxBuTIXFGRudYkzjrRXpBiZBqVqxQ7NFSsPSeARYK
         +4Kb6IOdV8xl/BwaMCBlFryGz3VaB6GtYKUIL1CI=
Date:   Thu, 1 Aug 2019 05:35:26 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: tsl2772: Use devm_add_action_or_reset for
 tsl2772_chip_off
Message-ID: <20190801093526.GB27653@onstation.org>
References: <20190801073605.9635-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801073605.9635-1-hslester96@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 01, 2019 at 03:36:05PM +0800, Chuhong Yuan wrote:
> Use devm_add_action_or_reset to call tsl2772_chip_off
> when the device is removed.
> This also fixes the issue that the chip is turned off
> before the device is unregistered.
> 
> Fixes: 4e24c1719f34 ("staging: iio: tsl2x7x: rename driver to tsl2772")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Let's use this Fixes tag instead:

Fixes: c06c4d793584 ("staging: iio: tsl2x7x/tsl2772: move out of staging")

I'd wait and see if Jonathan wants you to resend out the series if he
has any changes.

Brian


> ---
> Changes in v4:
>   - Split v3 into three patches.
>   - Revise description to make it more precise.
> 
>  drivers/iio/light/tsl2772.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 29cfd8ae2700..e866ae40f157 100644
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
> @@ -1877,9 +1884,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&clientp->dev,
> +					tsl2772_chip_off_action,
> +					indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> -		tsl2772_chip_off(indio_dev);
>  		dev_err(&clientp->dev,
>  			"%s: iio registration failed\n", __func__);
>  		return ret;
> @@ -1926,8 +1938,6 @@ static int tsl2772_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
> -	tsl2772_chip_off(indio_dev);
> -
>  	iio_device_unregister(indio_dev);
>  
>  	return 0;
> -- 
> 2.20.1
