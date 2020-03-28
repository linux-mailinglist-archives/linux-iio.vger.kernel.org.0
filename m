Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848B01967CD
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1REP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 13:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1REP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 13:04:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F16E20714;
        Sat, 28 Mar 2020 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585415054;
        bh=re7p6j0PGrxKSZZ6Le17eLNOy+JoAmbengRYQrLBe3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K3ktQwAG5vot+NVGaYyusk7AKtEnQPr029KatKl6b1HNTIflnBg5WVmhft5+k9vdQ
         TsPGI+yB1TU6Mk7YqxTHOXXpIG1XFqmZq+TJQwtyvWYIjH5tTUN+GLeQ7lO8BAm9k1
         sGbi7J1KvatH9dr1cljVM7zM03Xg/IRc9zjkJ3qc=
Date:   Sat, 28 Mar 2020 17:04:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
Message-ID: <20200328170407.41d8ed68@archlinux>
In-Reply-To: <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
        <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 21:14:10 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.
> 
> In addition, add definitions for ADC channels and virtual channel
> definitions per PMIC, to be used by ADC clients for PMIC7.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>

A few additions from me.

> ---

...

>  
> +static int adc5_exit(struct platform_device *pdev)
> +{
> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&adc->lock);

Andy raised potential races.  You definitely have some as this
will destroy the mutex before you've removed the userspace interfaces.

> +	return 0;
> +}
> +
>  static struct platform_driver adc5_driver = {
>  	.driver = {
>  		.name = "qcom-spmi-adc5.c",
>  		.of_match_table = adc5_match_table,
>  	},
>  	.probe = adc5_probe,
> +	.remove = adc5_exit,
>  };
>  module_platform_driver(adc5_driver);
>  

...

>  
> +static int qcom_vadc7_scale_hw_calib_die_temp(
> +				const struct vadc_prescale_ratio *prescale,
> +				const struct adc5_data *data,
> +				u16 adc_code, int *result_mdec)
> +{
> +
> +	int voltage, vtemp0, temp, i = 0;
> +
> +	voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
> +				prescale, data, 1);
> +
> +	while (i < ARRAY_SIZE(adcmap7_die_temp)) {
> +		if (adcmap7_die_temp[i].x > voltage)
> +			break;
> +		i++;
> +	}

For loop (I think Andy also raised this one).

> +
> +	if (i == 0) {
> +		*result_mdec = DIE_TEMP_ADC7_SCALE_1;
> +	} else if (i == ARRAY_SIZE(adcmap7_die_temp)) {
> +		*result_mdec = DIE_TEMP_ADC7_MAX;
> +	} else {
> +		vtemp0 = adcmap7_die_temp[i-1].x;

Spaces around the - 
Same elsewhere.

> +		voltage = voltage - vtemp0;
> +		temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
> +			adcmap7_die_temp[i-1].y);
> +		temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i-1));
> +		*result_mdec = temp;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qcom_vadc_scale_hw_smb_temp(
>  				const struct vadc_prescale_ratio *prescale,
>  				const struct adc5_data *data,
...

