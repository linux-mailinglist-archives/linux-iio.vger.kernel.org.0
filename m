Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35A71E970C
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgEaKtP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 06:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaKtO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 06:49:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C3DE2074A;
        Sun, 31 May 2020 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590922154;
        bh=HQBjc0HN0JGQjbIvdSLMnyVxmEFb8nZnCa4Dgg0s05Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ak+zy/gRNNoAq2/87WGmX7H7upM9nu/Qx5Tpfyh2PXn0DFq2Hv88Hg/OOK+nsiYV+
         4+HPb/EeiRF+hjCs+JGWzkRAL6x5dLnmJcW0qDmO8BXIObFNiBMm5WYBiLszdyTZBe
         h5BZZyF6Lmdvnf1TdcceeVUUaRuRoXMh9gRKj5jQ=
Date:   Sun, 31 May 2020 11:49:08 +0100
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
Subject: Re: [PATCH V6 5/7] iio: adc: Update return value checks
Message-ID: <20200531114908.004ad79a@archlinux>
In-Reply-To: <1590684869-15400-6-git-send-email-jprakash@codeaurora.org>
References: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
        <1590684869-15400-6-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 22:24:27 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Clean up some return value checks to make code more compact.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>

Applied.

Thanks,

J
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index dcc7599..3022313 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -301,7 +301,7 @@ static int adc5_configure(struct adc5_chip *adc,
>  
>  	/* Read registers 0x42 through 0x46 */
>  	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/* Digital param selection */
> @@ -388,7 +388,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>  
>  	if (adc->poll_eoc) {
>  		ret = adc5_poll_wait_eoc(adc);
> -		if (ret < 0) {
> +		if (ret) {
>  			pr_err("EOC bit not set\n");
>  			goto unlock;
>  		}
> @@ -398,7 +398,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>  		if (!ret) {
>  			pr_debug("Did not get completion timeout.\n");
>  			ret = adc5_poll_wait_eoc(adc);
> -			if (ret < 0) {
> +			if (ret) {
>  				pr_err("EOC bit not set\n");
>  				goto unlock;
>  			}
> @@ -516,8 +516,6 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>  	default:
>  		return -EINVAL;
>  	}
> -
> -	return 0;
>  }
>  
>  static int adc7_read_raw(struct iio_dev *indio_dev,
> @@ -761,7 +759,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  		ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
>  							sizeof(dig_version));
> -		if (ret < 0) {
> +		if (ret) {
>  			dev_err(dev, "Invalid dig version read %d\n", ret);
>  			return ret;
>  		}

