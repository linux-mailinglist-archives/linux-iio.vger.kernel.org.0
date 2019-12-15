Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8436F11F7B2
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfLOM3y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 07:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfLOM3y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Dec 2019 07:29:54 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F14205C9;
        Sun, 15 Dec 2019 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576412993;
        bh=2l6Be057Q7FKP+fhTZ0hbvUe6NBP4LC0WK/+kFX+Qzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nVrMJK9o/bHwLle8h8ijpAz587lP5+UzFmyLzVpLfTk03WtVsGSd0loHEyynmYNq5
         ZO+RG0dI/Kx+fn9QH1NyD5MnPsvXc/87YDMePY13Ank41Tf5vh/jWPNIlaByRYCDFY
         LtYFkKZ5ESKhTJfvAY6m8xnv8KxC7oWcCIvH9fXk=
Date:   Sun, 15 Dec 2019 12:29:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v4 12/12] iio: adc: qcom-vadc-common: use
 <linux/units.h> helpers
Message-ID: <20191215122948.773bbc42@archlinux>
In-Reply-To: <1576386975-7941-13-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
        <1576386975-7941-13-git-send-email-akinobu.mita@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Dec 2019 14:16:15 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This switches the qcom-vadc-common to use milli_kelvin_to_millicelsius()
> in <linux/units.h>.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,


> ---
> * v4
> - add Reviewed-by tag
> 
>  drivers/iio/adc/qcom-vadc-common.c | 6 +++---
>  drivers/iio/adc/qcom-vadc-common.h | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index dcd7fb5..2bb78d1 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -6,6 +6,7 @@
>  #include <linux/log2.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/units.h>
>  
>  #include "qcom-vadc-common.h"
>  
> @@ -236,8 +237,7 @@ static int qcom_vadc_scale_die_temp(const struct vadc_linear_graph *calib_graph,
>  		voltage = 0;
>  	}
>  
> -	voltage -= KELVINMIL_CELSIUSMIL;
> -	*result_mdec = voltage;
> +	*result_mdec = milli_kelvin_to_millicelsius(voltage);
>  
>  	return 0;
>  }
> @@ -325,7 +325,7 @@ static int qcom_vadc_scale_hw_calib_die_temp(
>  {
>  	*result_mdec = qcom_vadc_scale_code_voltage_factor(adc_code,
>  				prescale, data, 2);
> -	*result_mdec -= KELVINMIL_CELSIUSMIL;
> +	*result_mdec = milli_kelvin_to_millicelsius(*result_mdec);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index bbb1fa0..e074902a 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -38,7 +38,6 @@
>  #define VADC_AVG_SAMPLES_MAX			512
>  #define ADC5_AVG_SAMPLES_MAX			16
>  
> -#define KELVINMIL_CELSIUSMIL			273150
>  #define PMIC5_CHG_TEMP_SCALE_FACTOR		377500
>  #define PMIC5_SMB_TEMP_CONSTANT			419400
>  #define PMIC5_SMB_TEMP_SCALE_FACTOR		356

