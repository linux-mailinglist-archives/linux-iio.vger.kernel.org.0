Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E255E41995C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhI0QmQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 12:42:16 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35632 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235463AbhI0QmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Sep 2021 12:42:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RAccN9016754;
        Mon, 27 Sep 2021 18:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3cUaM13ESIaimd9wicHJ6CmL5u8o5wVuRy7GsckzHkI=;
 b=Rhe/st5cXpwbNhNGonO107ZDod1wya4ZWYrLBd8zipZ+F2FziOwCzcQig9+UISeRbx5d
 WobWAtYSh2LuYPH1Pu44iF74wWu2wo6jgEF0+lI11hcyXG2iP1C9Rb49KVw0lbvZsCiY
 o8/UIHflStKEqe2ljuvHeWYYiyElaLj+baJxTei7unOBUemah7aqJhCJKMQrxdWlzaIY
 mp6rBTzs6gpH/p+LlkFmLv9xKt2WXzU/7AHD/XEYo6B5zIuCILYO3uOIi5jnB6ftOnOo
 RNWx1ynxmlg7pNnvItwXYGJ3UXU3C2ITywlsItNXTKXWA43V7sGCUroJNU8509DGPgkd 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bbau5294a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 18:40:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D73BD10002A;
        Mon, 27 Sep 2021 18:40:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE4782C4213;
        Mon, 27 Sep 2021 18:40:17 +0200 (CEST)
Received: from [10.211.13.71] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 27 Sep
 2021 18:40:16 +0200
Subject: Re: [PATCH v3 0/7] iio: adc: stm32-adc: add internal channels support
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210924083410.12332-1-olivier.moysan@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <6948e726-1a1c-7143-dd36-710e8396c63b@foss.st.com>
Date:   Mon, 27 Sep 2021 18:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210924083410.12332-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/24/21 10:34 AM, Olivier Moysan wrote:
> This patchset adds support of ADC2 internal channels VDDCORE, VREFINT and VBAT
> on STM32MP15x SoCs. The generic IIO channel bindings is also introduced here
> to provide this feature. The legacy channel binding is kept for backward compatibility.
> 
> Changes in v2:
> - Add 'deprecated' to channels legacy properties in ADC bindings
> - Add set/clr service for common registers, to make code more generic in
>   internal channels enable/disable services.
> - Expose vrefint channel as a processed channel to return
>   the actual value of vrefp.
> - Minor code improvements
> 
> Changes in v3:
> - fix vrefint sampling time check.
> 
> Olivier Moysan (7):
>   dt-bindings: iio: stm32-adc: add generic channel binding
>   dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal
>     channel
>   iio: adc: stm32-adc: split channel init into several routines
>   iio: adc: stm32-adc: add support of generic channels binding
>   iio: adc: stm32-adc: add support of internal channels


Hi Olivier,

I've one remark on patch "... add support of internal channels".

For the other patches, you can add my
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks!
Fabrice

>   iio: adc: stm32-adc: add vrefint calibration support
>   iio: adc: stm32-adc: use generic binding for sample-time>
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 108 ++++-
>  drivers/iio/adc/stm32-adc-core.h              |   8 +
>  drivers/iio/adc/stm32-adc.c                   | 426 ++++++++++++++++--
>  3 files changed, 487 insertions(+), 55 deletions(-)
> 
