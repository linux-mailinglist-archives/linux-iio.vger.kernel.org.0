Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771893077B3
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 15:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhA1OJf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 09:09:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhA1OJd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 09:09:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SE7dmn036400;
        Thu, 28 Jan 2021 08:07:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611842859;
        bh=Joh8wbXrLWIP1Hy17P32/2vZurrK6zODo5//hE9WZCw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jeoHl9/r12fK9X7G8YmvcGysHWVV5KWqnfSebw6YbB73I2de8kW9RX3YAvJlT3c95
         Q2xWDnDch6nJ8REwEDwjj15sdF8KSEKoBG6BwQqcbVnOHeK6Tg/OsMF56HEjkM79aV
         Z9rPQlexPOzjsXH5YX1bf25fYNdJJ70r+N+VNf/o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SE7dl7075177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 08:07:39 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 08:07:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 08:07:39 -0600
Received: from [10.250.39.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SE7c12064116;
        Thu, 28 Jan 2021 08:07:38 -0600
Subject: Re: [PATCH 2/2] iio:adc:ti-ads124s08: Fix packet read from the ADC
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>
References: <20210121191431.12057-1-dmurphy@ti.com>
 <20210121191431.12057-2-dmurphy@ti.com> <20210124151242.285ce9c6@archlinux>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <2678d74d-5357-73fc-a152-f493e0e4f80e@ti.com>
Date:   Thu, 28 Jan 2021 08:07:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210124151242.285ce9c6@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan

On 1/24/21 9:12 AM, Jonathan Cameron wrote:
> On Thu, 21 Jan 2021 13:14:31 -0600
> Dan Murphy <dmurphy@ti.com> wrote:
>
>> Fix the spi_transfer array in the reading of the data from the ADC.
>>
>> Fixes: ("e717f8c6dfec iio: adc: Add the TI ads124s08 ADC code")
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> I'm not really following the changes below..

I will have to dig into it deeper our HW team reported this.

Patch 1/2 is relevant and is not dependent on this patch

Dan

