Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358F04BC50
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSPFA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 11:05:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61383 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbfFSPFA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 11:05:00 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JF1doV024433;
        Wed, 19 Jun 2019 17:04:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=pmo1Bv+ES9tIvk0vtUKa8hC+z8yY1GRb510dQ0/+90Q=;
 b=IOlJAYb/oqA9f2QUTJJmwqoMPmAYrRr/f32Fu04/AM4HGOA8va0zctT+WjGZRLaSLcJA
 XKXJXaHQMZLhCwvJkjIYeR6cpMuATUB1G0WCoY+ZiNXXGtpUyAEUPAITiKKpBb2G2iqf
 u5l/Ub/ySXFkSxxdgrI7y1esXOgCgBIKLEhPOxUYr42LluLOY7HoZ9/cBDnuimJj3hJc
 n0XowaEZ1sFiHHRlLj9YZ9AEJyl7JLCnvZ0gYYK6VK+OWIIwZ7LbzvFOfXgOBg/wBC6J
 BrI6ziGDfLc0FWrDgTQQZaGeCo0kx3773cgl6Dzx3wkDEljZ+j6+3y33fB3zBNe822qK mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t781a4jbv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 17:04:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BD9834;
        Wed, 19 Jun 2019 15:04:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1AB4E2AED;
        Wed, 19 Jun 2019 15:04:30 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.48) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 17:04:29 +0200
Subject: Re: [PATCH 0/5] iio: adc: stm32-dfsdm: fix and improve output data
 managementiio: adc: stm32-dfsdm: fix and improve output data management
To:     Olivier Moysan <olivier.moysan@st.com>
References: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
CC:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <5a7c1aed-16fa-d13f-b1b4-7847319f62ec@st.com>
Date:   Wed, 19 Jun 2019 17:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/19/19 3:03 PM, Olivier Moysan wrote:
> This patch-set provides some fixes and improvements regarding output data format
> for STM32 DFSDM.
> - Fix output data resolution and saturation management in continuous mode
> - Fix data type
> - Apply same processing on data in continuous and triggered mode
> - Add fast mode support to get better resolution for output data
> - Add a comment about 16 bits data transfers
> 
> Olivier Moysan (5):
>   iio: adc: stm32-dfsdm: fix output resolution
>   iio: adc: stm32-dfsdm: fix data type
>   iio: adc: stm32-dfsdm: manage data resolution in trigger mode
>   iio: adc: stm32-dfsdm: add fast mode support
>   iio: adc: stm32-dfsdm: add comment for 16 bits record

Hi Olivier,

For the series,
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Best Regards,
Fabrice
> 
>  drivers/iio/adc/stm32-dfsdm-adc.c | 233 +++++++++++++++++++++++++++++++-------
>  drivers/iio/adc/stm32-dfsdm.h     |  24 +++-
>  2 files changed, 208 insertions(+), 49 deletions(-)
> 
