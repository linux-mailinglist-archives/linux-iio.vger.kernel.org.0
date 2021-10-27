Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1F43D019
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbhJ0RvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 13:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhJ0RvQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 13:51:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF74A6109D;
        Wed, 27 Oct 2021 17:48:44 +0000 (UTC)
Date:   Wed, 27 Oct 2021 18:53:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <Jonathan.Cameron@huawei.com>,
        <amitk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2 2/3] iio: adc: qcom-vadc-common: add reverse scaling
 for PMIC5 Gen2 ADC_TM
Message-ID: <20211027185310.25552207@jic23-huawei>
In-Reply-To: <1635264275-12530-3-git-send-email-quic_jprakash@quicinc.com>
References: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
        <1635264275-12530-3-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Oct 2021 21:34:34 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Add reverse scaling function for PMIC5 Gen2 ADC_TM, to convert
> temperature to raw ADC code, for setting thresholds for
> thermistor channels.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
This little utility function looks fine to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/qcom-vadc-common.c       | 11 +++++++++++
>  include/linux/iio/adc/qcom-vadc-common.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 1472389..194d7c3 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -677,6 +677,17 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
>  }
>  EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
>  
> +u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
> +{
> +	int64_t resistance;
> +
> +	resistance = qcom_vadc_map_temp_voltage(adcmap7_100k,
> +		ARRAY_SIZE(adcmap7_100k), temp);
> +
> +	return div64_s64(resistance * RATIO_MAX_ADC7, resistance + R_PU_100K);
> +}
> +EXPORT_SYMBOL(qcom_adc_tm5_gen2_temp_res_scale);
> +
>  int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  		    unsigned int prescale_ratio,
>  		    const struct adc5_data *data,
> diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
> index 33f60f4..598a5d2 100644
> --- a/include/linux/iio/adc/qcom-vadc-common.h
> +++ b/include/linux/iio/adc/qcom-vadc-common.h
> @@ -161,6 +161,8 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
>  				 u32 full_scale_code_volt, int temp);
>  
> +u16 qcom_adc_tm5_gen2_temp_res_scale(int temp);
> +
>  int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
>  
>  int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);

