Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3421DFEC3
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgEXL7c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 07:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXL7c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 07:59:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F64207FB;
        Sun, 24 May 2020 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590321571;
        bh=oomN50U4TtPd+8MHxnNDcOvRgha71PqDvUKwekeearw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xhwlk2FGzBIduKDxIBDeJCVxm6wCwiJjxzjLc5u+rJq50kJptN3w7FpuxVsQzRGqs
         kiUpt6UzDg8SlyUn3Y6lSSnNG+IwI9qLUo0pJcBx43jS/RIM9iRJq7TJUcRFxktYvQ
         n8YAO6x8QQYP9tw64BYcRYj9G0ACI7m8qPpd/X3g=
Date:   Sun, 24 May 2020 12:59:25 +0100
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
Subject: Re: [PATCH V5 3/5] iio: adc: Add support for PMIC7 ADC
Message-ID: <20200524125925.41102b3b@archlinux>
In-Reply-To: <1590157452-27179-4-git-send-email-jprakash@codeaurora.org>
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
        <1590157452-27179-4-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 19:54:10 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c   | 231 ++++++++++++++++++++++++++++++--
>  drivers/iio/adc/qcom-vadc-common.c | 260 +++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/qcom-vadc-common.h |  14 ++
>  3 files changed, 496 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 21fdcde..e1482fd 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved.
...
> @@ -110,6 +120,7 @@ struct adc5_channel_prop {
>  	enum adc5_cal_method	cal_method;
>  	enum adc5_cal_val	cal_val;
>  	unsigned int		decimation;
> +	unsigned int		sid;
>  	unsigned int		prescale;
>  	unsigned int		hw_settle_time;
>  	unsigned int		avg_samples;
> @@ -140,6 +151,7 @@ struct adc5_chip {
>  	bool			poll_eoc;
>  	struct completion	complete;
>  	struct mutex		lock;
> +	int			irq_eoc;

This is introduced but doesn't seem to be used...

>  	const struct adc5_data	*data;
>  };
>  
> @@ -155,6 +167,8 @@ static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
>  	{.num =  1, .den = 16}
>  };
>  
...

>  static int adc5_prescaling_from_dt(u32 num, u32 den)
>  {
>  	unsigned int pre;
> @@ -285,7 +304,7 @@ static int adc5_configure(struct adc5_chip *adc,
>  
>  	/* Read registers 0x42 through 0x46 */
>  	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> -	if (ret < 0)
> +	if (ret)
>  		return ret;

As Andy mentioned, this is better in a separate patch. It's just adding
noise to this patch which is actually doing things...

>  
>  	/* Digital param selection */
> @@ -314,6 +333,47 @@ static int adc5_configure(struct adc5_chip *adc,
>  	return adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>  }
>  

Thanks,

Jonathan
