Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3A32FC37
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCFRS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:18:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhCFRSh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:18:37 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDDC65005;
        Sat,  6 Mar 2021 17:18:35 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:18:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix error handling in vadc_do_conversion
Message-ID: <20210306171831.0033fec7@archlinux>
In-Reply-To: <20210301081622.15696-1-dinghao.liu@zju.edu.cn>
References: <20210301081622.15696-1-dinghao.liu@zju.edu.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Mar 2021 16:16:22 +0800
Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> There is one vadc_poll_wait_eoc() call in vadc_do_conversion
> that we have caught its return value but lack further handling.
> Check and jump to err_disable label just like the other
> vadc_poll_wait_eoc() in this function.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Looks good to me, but will leave this a little longer for others to review.
If it looks like I have forgotten it in 2 weeks time, feel free to remind
me!

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 05ff948372b3..fe36b0ba8273 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -324,6 +324,8 @@ static int vadc_do_conversion(struct vadc_priv *vadc,
>  
>  	if (vadc->poll_eoc) {
>  		ret = vadc_poll_wait_eoc(vadc, timeout);
> +		if (ret)
> +			goto err_disable;
>  	} else {
>  		ret = wait_for_completion_timeout(&vadc->complete, timeout);
>  		if (!ret) {

