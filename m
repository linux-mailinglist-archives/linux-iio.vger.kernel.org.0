Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25B46F464B
	for <lists+linux-iio@lfdr.de>; Tue,  2 May 2023 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjEBOps (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 May 2023 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEBOpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2023 10:45:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CFD19AE
        for <linux-iio@vger.kernel.org>; Tue,  2 May 2023 07:45:41 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342E2cOp012115;
        Tue, 2 May 2023 16:45:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YS5vkr+l2vozt4CNUN8wgEIGUsDdCE6jmJYOwVg21kM=;
 b=6UUDp5SMU6ug+IDduXtoSnkZLukUjrEVt8yXZNkYDu8OBEOYuDhXd1yNrMDo0lvDxIbG
 bRlHCJuT6Yti2Nc+DNAsOGYYb43P0NquKfPwjlyaciHgw5Q67y/MI6Y8COEKgMkly1+X
 9uq3UHNq9WQw5sx0Gn2uXms3fvQ7/KWstbNihEsIyYP2PuwLnHRVOOuiuNHcWoBlx0e0
 fzxJxwZC/wbQ0ZMm9grqofdchqRETZaB2ANZEo/pH3id57Is0dTueAKKZRoi9w1gBC0Q
 i+1tmkNa2Pr3CD3U8vYBO/UaLhffz4vMaHvgtsRoLoWODtkxnfGREHdaF3mXS8dleLIR Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q8rnmhpn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 16:45:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C23AA10002A;
        Tue,  2 May 2023 16:45:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7290226FAF;
        Tue,  2 May 2023 16:45:18 +0200 (CEST)
Received: from [10.201.20.178] (10.201.20.178) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 2 May
 2023 16:45:18 +0200
Message-ID: <99f7f4e0-e500-d940-d089-32f9185d6232@foss.st.com>
Date:   Tue, 2 May 2023 16:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] iio: adc: stm32-adc: skip adc-channels setup if
 none is present
To:     Sean Nyekjaer <sean@geanix.com>, <jic23@kernel.org>,
        <alexandre.torgue@foss.st.com>, <nuno.sa@analog.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230421113516.2710454-1-sean@geanix.com>
 <20230421113516.2710454-2-sean@geanix.com>
Content-Language: en-US
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20230421113516.2710454-2-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Sean,

Sorry for late answer. I was ooo. Please, find my comment below.

On 4/21/23 13:35, Sean Nyekjaer wrote:
> If only adc differential channels are defined driver will fail with
> stm32-adc: probe of 48003000.adc:adc@0 failed with error -22
> 
> Fix this by skipping the initialization if no channels are defined.
> 
> This applies only to the legacy way of initializing adc channels.
> 
> Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>   - Ignore extra channel for timestamps in PIO mode
>   - Use single ended count in channel creation (Thanks Olivier Moysan)
> 
>   drivers/iio/adc/stm32-adc.c | 40 ++++++++++++++++++-------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 14524c1b5583..99bfe995b6f1 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2038,6 +2038,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>   	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
>   	struct device *dev = &indio_dev->dev;
>   	u32 num_diff = adc->num_diff;
> +	int num_se = nchans - num_diff;
>   	int size = num_diff * sizeof(*diff) / sizeof(u32);
>   	int scan_index = 0, ret, i, c;
>   	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
> @@ -2065,28 +2066,27 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>   		}
>   	}
>   
> -	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
> -					     nchans);
> -	if (ret)
> -		return ret;
> -
> -	for (c = 0; c < nchans; c++) {
> -		if (chans[c] >= adc_info->max_channels) {
> -			dev_err(&indio_dev->dev, "Invalid channel %d\n",
> -				chans[c]);
> -			return -EINVAL;
> -		}
> -
> -		/* Channel can't be configured both as single-ended & diff */
> -		for (i = 0; i < num_diff; i++) {
> -			if (chans[c] == diff[i].vinp) {
> -				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
> +	ret = device_property_read_u32_array(dev, "st,adc-channels", chans, num_se);

I can see a change on device_property_read_u32_array() return check.
 From device_property_read_u32_array() doc, we should avoid calling the 
function with num_se=0 :
"It's recommended to call device_property_count_u32() instead of calling 
this function with @val equals %NULL and @nval equals 0."
Moreover, in case of error we will not return the error status here.

I propose to manage error handling as it is done for 
st,adc-diff-channels property. So, something like this:

	if (num_se > 0) {
		ret = device_property_read_u32_array(dev, "st,adc-channels", chans, 
num_se);
		if (ret) {
			dev_err(&indio_dev->dev, "Failed to get st,adc-channels %d\n", ret);
			return ret;
		}

		for (c = 0; c < num_se; c++) {

> +	if (ret == 0 && num_se > 0) {
> +		for (c = 0; c < num_se; c++) {
> +			if (chans[c] >= adc_info->max_channels) {
> +				dev_err(&indio_dev->dev, "Invalid channel %d\n",
> +					chans[c]);
>   				return -EINVAL;
>   			}
> +
> +			/* Channel can't be configured both as single-ended & diff */
> +			for (i = 0; i < num_diff; i++) {
> +				if (chans[c] == diff[i].vinp) {
> +					dev_err(&indio_dev->dev, "channel %d misconfigured\n",
> +						chans[c]);
> +					return -EINVAL;
> +				}
> +			}
> +			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> +						chans[c], 0, scan_index, false);
> +			scan_index++;
>   		}
> -		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> -					chans[c], 0, scan_index, false);
> -		scan_index++;
>   	}
>   
>   	if (adc->nsmps > 0) {
> @@ -2307,7 +2307,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
>   
>   	if (legacy)
>   		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
> -						 num_channels);
> +						 timestamping ? num_channels - 1 : num_channels);
>   	else
>   		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
>   	if (ret < 0)

BRs
Olivier
