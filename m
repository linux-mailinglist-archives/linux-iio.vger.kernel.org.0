Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2707864C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 09:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfG2HXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 03:23:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38988 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbfG2HXm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 03:23:42 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T7GbUO017808;
        Mon, 29 Jul 2019 09:23:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=knB1CFf+dV5YYBti2FACI1fBFDRzZJ7xPVnkJzKHsnw=;
 b=vF21dSF/PU8U7f7SbGvtjtdeSN+ptbef8kPnk+134RREY8U9s9kwdEFIauzD3qkRPYJf
 aLJwaGsAOlR+vL0bzGOfOK4VgPqFFCsOlbar4SxW9kC5XJSsm4KMRy0pM0S7vmzXke4h
 +r0cazmiUUD0kKVceMGb+QKcsgOWIYN9vGTQ+WwRwJNmkRhBR8pEdQVxTx8LYzhUMxrh
 Gz9W+F+cEgtAfmFWV8ozPzQbAAM8UkQ/cVpdRzUEf3gJztwKlxGEqzHy2vtvKMp+MpUZ
 q8iXCUU0wUVlODhzGr+Rq5US6v/ycIAZ1xPn1U2+PL0oi/Gacod75c1gFnNLC9jOrSW8 Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0dggtn0k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Jul 2019 09:23:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 376CD34;
        Mon, 29 Jul 2019 07:23:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F2CD456C5;
        Mon, 29 Jul 2019 07:23:07 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Jul
 2019 09:23:07 +0200
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: add syscfg to ADC on stm32mp157c
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
 <1562148496-26789-4-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0687ec4c-0930-058d-4a55-c4cf712ab83c@st.com>
Date:   Mon, 29 Jul 2019 09:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562148496-26789-4-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_04:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi fabrice

On 7/3/19 12:08 PM, Fabrice Gasnier wrote:
> On stm32mp157c, the ADC inputs are multiplexed with analog switches which
> have reduced performances when their supply is below 2.7V (vdda by
> default).
> Add syscfg registers that can be used on stm32mp157c, to get full ADC
> analog performances.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 2dd5162..b9a5b58 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -862,6 +862,7 @@
>   			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
>   			clock-names = "bus", "adc";
>   			interrupt-controller;
> +			st,syscfg = <&syscfg>;
>   			#interrupt-cells = <1>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> 


Applied on stm32-next.

Thanks.
Alex
