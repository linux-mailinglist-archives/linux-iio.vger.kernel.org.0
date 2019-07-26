Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3670E76E6A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGZQBB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 12:01:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16842 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbfGZQBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 12:01:01 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QFuGIF006272;
        Fri, 26 Jul 2019 18:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Y75BNG+ZG7vXH0PyAhO98l9SHQ/zPoys4fP5bNxiSws=;
 b=xElqh+q7EgccAjNQffkCsqWxvs1nv14CqX4moJ8gnskKJjhmcurLrp+L6KGCmIbqUU+8
 idG0GWPq5KfFQxUHs/pA/fE6LLVPbe7a//MWkqB3C3kuTz85tjREBD/c7kMCXbmU+VDB
 ZC6tyHrW+L6KDVBw1ohv2H7vYRBm05IizZ0hIoVNFb6M+jS+aiJjfX0TQTpcih7j9TTW
 qgnLb3PZdzbMD0Y+9EHvhA/SBUIzrbd4I2DDFeb7ifE2VD2+/+uonT2CbxWm710JcTWu
 +AeFXe3AmdqjLHxLmPQtNZeRXVbkrVWIvDieTT/1KAwarNxxemk09vbJe5BS4jHwJvG7 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tx60abn3e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Jul 2019 18:00:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A40D634;
        Fri, 26 Jul 2019 16:00:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4EF254F17;
        Fri, 26 Jul 2019 16:00:07 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Jul
 2019 18:00:06 +0200
Subject: Re: [PATCH 0/5] Add missing vdda-supply to STM32 ADC
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b91163f5-ad6f-0a22-eb8a-ceb0b0c056c6@st.com>
Date:   Fri, 26 Jul 2019 18:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1560947398-11592-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabrice

On 6/19/19 2:29 PM, Fabrice Gasnier wrote:
> Add missing vdda-supply, analog power supply, to STM32 ADC. When vdda is
> an independent supply, it needs to be properly turned on or off to supply
> the ADC.
> This series proposes fixes for the dt-bindings, IIO driver and relevant
> device tree files.
> 
> Fabrice Gasnier (5):
>    dt-bindings: iio: adc: stm32: add missing vdda supply
>    iio: adc: stm32-adc: add missing vdda-supply
>    ARM: dts: stm32: remove fixed regulator unit address on stm32429i-eval
>    ARM: dts: stm32: add missing vdda-supply to adc on stm32429i-eval
>    ARM: dts: stm32: add missing vdda-supply to adc on stm32h743i-eval
> 
>   .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  1 +
>   arch/arm/boot/dts/stm32429i-eval.dts               | 25 +++++++++++-----------
>   arch/arm/boot/dts/stm32h743i-eval.dts              |  1 +
>   drivers/iio/adc/stm32-adc-core.c                   | 21 +++++++++++++++++-
>   4 files changed, 35 insertions(+), 13 deletions(-)
> 

DT patches applied on stm32-next. I plan to add them in my PR for v5.4.
However those patches are marked as "fixes", do you see an issue to only 
send it for v5.4 ?

Regards
alex
