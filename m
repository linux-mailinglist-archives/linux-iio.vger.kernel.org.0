Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452E01C2AD2
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgECJEV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgECJEU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 05:04:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD8620721;
        Sun,  3 May 2020 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588496660;
        bh=joQmbCHiX4MsrLvWUn3TCqGJil+H1POp5Wj9MvFemrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qNCfQ6rpgX7z2rhV1f1A6x13Wl/egMCdnTFcR5zByONc+eV8e+5YcceGJ69ZpiCaT
         OfmANZm7294flumn7dMwyjkse8CImPMxg9LXhCYhLhoOIfQzXMeCjVqIIoQAoAbb/d
         rezLoZtq7GUddnoF2teEWIGHf6x7K7ALrdy4RGis=
Date:   Sun, 3 May 2020 10:04:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V3 4/4] iio: adc: Update error checks and debug prints
Message-ID: <20200503100414.6e5602e7@archlinux>
In-Reply-To: <1587993846-30773-5-git-send-email-jprakash@codeaurora.org>
References: <1587993846-30773-1-git-send-email-jprakash@codeaurora.org>
        <1587993846-30773-5-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 18:54:05 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Change pr_err/pr_debug statements to dev_err/dev_dbg for
> increased clarity. Also clean up some return value checks.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
I'm happy with the whole series.  Just need a devicetree review before
applying. 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index a66eeb7..7e951a0 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -249,11 +249,11 @@ static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
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
> @@ -304,7 +304,7 @@ static int adc5_configure(struct adc5_chip *adc,
>  
>  	/* Read registers 0x42 through 0x46 */
>  	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/* Digital param selection */
> @@ -344,7 +344,7 @@ static int adc7_configure(struct adc5_chip *adc,
>  		return ret;
>  
>  	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/* Digital param selection */
> @@ -385,24 +385,24 @@ static int adc5_do_conversion(struct adc5_chip *adc,
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
>  		if (ret < 0) {
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
>  			if (ret < 0) {
> -				pr_err("EOC bit not set\n");
> +				dev_err(adc->dev, "EOC bit not set\n");
>  				goto unlock;
>  			}
>  		}
> @@ -435,7 +435,7 @@ static int adc7_do_conversion(struct adc5_chip *adc,
>  	wait_for_completion_timeout(&adc->complete, ADC7_CONV_TIMEOUT);
>  
>  	ret = adc5_read(adc, ADC5_USR_STATUS1, &status, 1);
> -	if (ret < 0)
> +	if (ret)
>  		goto unlock;
>  
>  	if (status & ADC5_USR_STATUS1_CONV_FAULT) {
> @@ -481,8 +481,8 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
>  	int i, v_channel;
>  
>  	for (i = 0; i < adc->nchannels; i++) {
> -		v_channel = (adc->chan_props[i].sid << ADC_CHANNEL_OFFSET |
> -			adc->chan_props[i].channel);
> +		v_channel = (adc->chan_props[i].sid << ADC_CHANNEL_OFFSET) |
> +			adc->chan_props[i].channel;
>  		if (v_channel == iiospec->args[0])
>  			return i;
>  	}
> @@ -728,7 +728,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  	channel_name = of_get_property(node,
>  				"label", NULL) ? : node->name;
>  	if (!channel_name) {
> -		pr_err("Invalid channel name\n");
> +		dev_err(dev, "Invalid channel name\n");
>  		return -EINVAL;
>  	}
>  	prop->datasheet_name = channel_name;
> @@ -766,12 +766,12 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  		ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
>  							sizeof(dig_version));
> -		if (ret < 0) {
> +		if (ret) {
>  			dev_err(dev, "Invalid dig version read %d\n", ret);
>  			return ret;
>  		}
>  
> -		pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
> +		dev_dbg(dev, "dig_ver:minor:%d, major:%d\n", dig_version[0],
>  						dig_version[1]);
>  		/* Digital controller >= 5.3 have hw_settle_2 option */
>  		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
> @@ -975,7 +975,7 @@ static int adc5_probe(struct platform_device *pdev)
>  
>  	ret = adc5_get_dt_data(adc, node);
>  	if (ret) {
> -		pr_err("adc get dt data failed\n");
> +		dev_err(dev, "adc get dt data failed\n");
>  		return ret;
>  	}
>  

