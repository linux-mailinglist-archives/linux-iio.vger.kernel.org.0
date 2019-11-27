Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5710B300
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2019 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0QN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Nov 2019 11:13:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55741 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbfK0QN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Nov 2019 11:13:57 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARGD2Gk022984;
        Wed, 27 Nov 2019 17:13:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=N0R/5k+FQrkEg1dliWlCmRaXaD6fZGnSUrPITJyt5O8=;
 b=xbNrJBvQ3ZXlZPs5VVE6ycWuq5hugyng9abUhyfuQDpbZRhmZnbVhsyTVmUsgXJh5RyJ
 scZ/L/7SXKnbOmj0mxHPiG0LwHhqnPz6A/qncuxwq8CbKY+of7epL69WY9RA2SToyP+m
 Dzt3Zn/Ro8UesSm1j7mHBW+3Wl3u176sPhGETzH6sKT4UKjikvG6ny5iWn92S0A2hXrC
 7b8vOpYXegWERMimUiWKT2e86REc0ayLuGc/sWQb/NixXlQGR3Y3khzkMMDl7/reTMBe
 fzRO1Dp6E9kDhQCwqEUiCEA6DjlGDbValedxYwyP9mnmV+Z2nQCfknjG6rUxVR9ysFrT pA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxj4ktm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 17:13:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4721E100038;
        Wed, 27 Nov 2019 17:13:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36DF92C38D5;
        Wed, 27 Nov 2019 17:13:14 +0100 (CET)
Received: from [10.48.0.192] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 17:13:13 +0100
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: fix single conversion
To:     Olivier Moysan <olivier.moysan@st.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>
References: <20191127130729.18511-1-olivier.moysan@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <114f6002-9577-52b2-0482-5350effda3e4@st.com>
Date:   Wed, 27 Nov 2019 17:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127130729.18511-1-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_04:2019-11-27,2019-11-27 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/27/19 2:07 PM, Olivier Moysan wrote:
> Apply data formatting to single conversion,
> as this is already done in continuous and trigger modes.
> 
> Fixes: 102afde62937 ("iio: adc: stm32-dfsdm: manage data resolution in trigger mode")
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Hi Olivier,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice

> ---
> changes in version 2:
> - correct title
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index e493242c266e..0339ecdd06bd 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1204,6 +1204,8 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
>  
>  	stm32_dfsdm_stop_conv(adc);
>  
> +	stm32_dfsdm_process_data(adc, res);
> +
>  stop_dfsdm:
>  	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
>  
> 
