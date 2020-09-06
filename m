Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F425EE36
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgIFOX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbgIFOXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:23:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 384F6207BC;
        Sun,  6 Sep 2020 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402201;
        bh=y8V2jSt6CHxIrgaBPb6382mI9eUqYemE/PcSqWP3Htw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oFjVqqd0fqkLqVozMTV3rNEAwf/TTMmfk5bebpDgAaj54u9wiZxt4e7M0qcX2xcqA
         Z+geGQYd8oEGwrBkJQMJShnQDVYS5yz1HAA0XBNxFCvj/oItZKvz3/KJrJFQb11p34
         0fZIN86SjsSaRiQdmoaw6Ki3gIMhxkzXGvBs/ZoQ=
Date:   Sun, 6 Sep 2020 15:23:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/9] iio: adc: qcom-vadc-common: use
 fixp_linear_interpolate
Message-ID: <20200906152315.53065c49@archlinux>
In-Reply-To: <20200903132109.1914011-5-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
        <20200903132109.1914011-5-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 16:21:04 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> Use new function fixp_linear_interpolate() instead of hand-coding the
> linar interpolation.

linear

Note I'm not sure who will pick these up hence I'm giving reviewed-by's.

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/qcom-vadc-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index d11f3343ad52..40d77b3af1bb 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -2,6 +2,7 @@
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
>  #include <linux/bitops.h>
> +#include <linux/fixp-arith.h>
>  #include <linux/math64.h>
>  #include <linux/log2.h>
>  #include <linux/err.h>
> @@ -368,10 +369,9 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>  	} else {
>  		/* result is between search_index and search_index-1 */
>  		/* interpolate linearly */
> -		*output = (((s32)((pts[i].y - pts[i - 1].y) *
> -			(input - pts[i - 1].x)) /
> -			(pts[i].x - pts[i - 1].x)) +
> -			pts[i - 1].y);
> +		*output = fixp_linear_interpolate(pts[i - 1].x, pts[i - 1].y,
> +						  pts[i].x, pts[i].y,
> +						  input);
>  	}
>  
>  	return 0;

