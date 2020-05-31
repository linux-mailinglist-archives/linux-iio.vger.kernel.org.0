Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D8D1E971B
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEaKxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 06:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgEaKxV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:53:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEBE20707;
        Sun, 31 May 2020 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922400;
        bh=+sFzQw1Cf+ykmchVYHbwcgQjHpS4r1zdWT6xMleFwbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h7dNerDH3rXqudMHgA+yAsWu0Ea47R+pkG8lDMSqBHOBk6nNEA6vmRrk+cdgw1sZ2
         2iIl984zGiUOmUTL3iQeQ8pEa6v5dsgWq4wIj4JzA/Y0ShhirdzWXaLdBZy6CbuRqG
         kDYZbWYhlPjgtXMV2lf2BChgHwvVLZwEpOA+u9XA=
Date:   Sun, 31 May 2020 11:53:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V6 6/7] iio: adc: Update debug prints
Message-ID: <20200531115315.4a173e63@archlinux>
In-Reply-To: <1590684869-15400-7-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
        <1590684869-15400-7-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 22:24:28 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Change pr_err/pr_debug statements to dev_err/dev_dbg for
> increased clarity.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied. Thanks, J
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 3022313..0f9af66 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -246,11 +246,11 @@ static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
>  	*data = (rslt_msb << 8) | rslt_lsb;
>  
>  	if (*data == ADC5_USR_DATA_CHECK) {
> -		pr_err("Invalid data:0x%x\n", *data);
> +		dev_err(adc->dev, "Invalid data:0x%x\n", *data);
>  		return -EINVAL;
>  	}
>  
> -	pr_debug("voltage raw code:0x%x\n", *data);
> +	dev_dbg(adc->dev, "voltage raw code:0x%x\n", *data);
>  
>  	return 0;
>  }
> @@ -382,24 +382,24 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>  
>  	ret = adc5_configure(adc, prop);
>  	if (ret) {
> -		pr_err("ADC configure failed with %d\n", ret);
> +		dev_err(adc->dev, "ADC configure failed with %d\n", ret);
>  		goto unlock;
>  	}
>  
>  	if (adc->poll_eoc) {
>  		ret = adc5_poll_wait_eoc(adc);
>  		if (ret) {
> -			pr_err("EOC bit not set\n");
> +			dev_err(adc->dev, "EOC bit not set\n");
>  			goto unlock;
>  		}
>  	} else {
>  		ret = wait_for_completion_timeout(&adc->complete,
>  							ADC5_CONV_TIMEOUT);
>  		if (!ret) {
> -			pr_debug("Did not get completion timeout.\n");
> +			dev_dbg(adc->dev, "Did not get completion timeout.\n");
>  			ret = adc5_poll_wait_eoc(adc);
>  			if (ret) {
> -				pr_err("EOC bit not set\n");
> +				dev_err(adc->dev, "EOC bit not set\n");
>  				goto unlock;
>  			}
>  		}
> @@ -721,7 +721,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  	channel_name = of_get_property(node,
>  				"label", NULL) ? : node->name;
>  	if (!channel_name) {
> -		pr_err("Invalid channel name\n");
> +		dev_err(dev, "Invalid channel name\n");
>  		return -EINVAL;
>  	}
>  	prop->datasheet_name = channel_name;
> @@ -764,7 +764,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  			return ret;
>  		}
>  
> -		pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
> +		dev_dbg(dev, "dig_ver:minor:%d, major:%d\n", dig_version[0],
>  						dig_version[1]);
>  		/* Digital controller >= 5.3 have hw_settle_2 option */
>  		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
> @@ -966,7 +966,7 @@ static int adc5_probe(struct platform_device *pdev)
>  
>  	ret = adc5_get_dt_data(adc, node);
>  	if (ret) {
> -		pr_err("adc get dt data failed\n");
> +		dev_err(dev, "adc get dt data failed\n");
>  		return ret;
>  	}
>  

