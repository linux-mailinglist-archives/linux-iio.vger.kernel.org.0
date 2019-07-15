Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6050683D5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 09:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfGOHCI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 03:02:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbfGOHCI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 03:02:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6F6uSio030992;
        Mon, 15 Jul 2019 09:01:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Zl4deGZbQ+vwkjKjMySHruoNEZ/Tdqr9qboU+Ck4czs=;
 b=mNuPpWJUbgOtsdKvOrrjxjRe5FJn4yQ5m9gUfKCWt4Az42LPaH/qFaD6E5SKi5Sr3khE
 P4urEGi0kp9oYCLif+cM3vFABuf0kmRFrSqlwBQD56IM5MGYxFfrAl/VM4NkZMqU5Ka0
 W6bFfGJwZwgrRb8bYKCpUNvf98urVDrhNGBKdGuUSfvc/LqWGob3Pt3N+ltZTwN7Xknz
 vaOPqmF5MasW0iGCW68hvqF4OpaWz0OHHcb8TAsHDMVJbVqFoA2byGwYpVN+3LZQJEec
 bVWGt9WrvuwTOkuLPH63oj6+iboOzdKlQCi4yNn0bcqY4RqPsvilzISC+CYcZL1gGvY4 cQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq52u3xy5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jul 2019 09:01:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6839A38;
        Mon, 15 Jul 2019 07:01:08 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FEA515AB;
        Mon, 15 Jul 2019 07:01:08 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 15 Jul
 2019 09:01:07 +0200
Received: from [10.48.0.167] (10.48.0.167) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 15 Jul 2019 09:01:07
 +0200
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: add syscfg to ADC on stm32mp157c
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
 <1562148496-26789-4-git-send-email-fabrice.gasnier@st.com>
 <20190714171310.1816afe3@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <c69cff23-b67e-2aed-f250-c237e9cd4a3d@st.com>
Date:   Mon, 15 Jul 2019 09:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714171310.1816afe3@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.167]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_02:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/14/19 6:13 PM, Jonathan Cameron wrote:
> On Wed, 3 Jul 2019 12:08:16 +0200
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> On stm32mp157c, the ADC inputs are multiplexed with analog switches which
>> have reduced performances when their supply is below 2.7V (vdda by
>> default).
>> Add syscfg registers that can be used on stm32mp157c, to get full ADC
>> analog performances.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I've applied the patches using this on the assumption this will go via
> the usual SoC route.
> 
> Thanks,

Hi Jonathan,

Many thanks,
Fabrice

> 
> Jonathan
> 
>> ---
>>  arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
>> index 2dd5162..b9a5b58 100644
>> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
>> @@ -862,6 +862,7 @@
>>  			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
>>  			clock-names = "bus", "adc";
>>  			interrupt-controller;
>> +			st,syscfg = <&syscfg>;
>>  			#interrupt-cells = <1>;
>>  			#address-cells = <1>;
>>  			#size-cells = <0>;
> 
