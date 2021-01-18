Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4812F9BB5
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 10:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbhARJDh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 04:03:37 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36468 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388251AbhARJD3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 04:03:29 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10I90acw018127;
        Mon, 18 Jan 2021 10:02:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=XVqcBJ1/aC3pTbN7m9Y9/ws7Y5V/4/XE7uZRGJIjjpw=;
 b=sYTKo/FfZBbc2CJ97C5klIeVMgUZ0Z0GPkYwlBshKmDEtxsASTIYdr10Y/fAbOIfSOKp
 aThlb/VcoWF7dMqQJIccCnbgr+BBuCzj4DSHPl/EBi90GdKKhNkfU9ZmuvCEhcC/RM5c
 wwn6c0hYMdoE6r9rWbHvI/+oH93dEhfCk33pzBc/wNIE89PDPno64oTRTzArtq6x6wNM
 3mv1GwSfGdqB3ufS7lAep/K9nAMWe/FI4vmQ9KFJ4EdzLl/16/KDCfSRdRcn2C8nSt8J
 sMokebeCBa0ZvqoplXLxhJRn6ZAj+5ySxZPmUPftja/AB2vFtXeNcYVp6Rdl4D/B2Gq9 kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 363rc507pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 10:02:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DAD20100034;
        Mon, 18 Jan 2021 10:02:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C72CD221796;
        Mon, 18 Jan 2021 10:02:08 +0100 (CET)
Received: from [10.211.13.252] (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 10:02:07 +0100
Subject: Re: [RFC PATCH 2/7] iio:ABI docs: Avoid repitition of
 triggerX/sampling_frequency
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210117153816.696693-1-jic23@kernel.org>
 <20210117153816.696693-3-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <59ecf96d-6a20-fec7-95ba-fe2561338f1e@foss.st.com>
Date:   Mon, 18 Jan 2021 10:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210117153816.696693-3-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_07:2021-01-15,2021-01-18 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/17/21 4:38 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The timer-stm32 provided a little more specific information than the main
> docs about the value of 0 corresponding to stopping sampling.  Given that
> this makes sense in general, move that statement over to the main docs
> and drop the version in sysfs-bus-iio-timer-stm32
>
> Fixes
> $ scripts/get_abi.pl validate
> /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45
>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio             | 2 ++
>  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
>  2 files changed, 2 insertions(+), 8 deletions(-)

Hi Jonathan,

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,

Fabrice

>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d2dd9cc280f9..9b5ceb22363d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -55,6 +55,8 @@ Description:
>  		direct access interfaces, it may be found in any of the
>  		relevant directories.  If it affects all of the above
>  		then it is to be found in the base device directory.
> +		Note a value 0 where supported, will correspond to sampling
> +		stopping.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> index c4a4497c249a..05074c4a65e2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> @@ -90,14 +90,6 @@ Description:
>  		Reading returns the current master modes.
>  		Writing set the master mode
>  
> -What:		/sys/bus/iio/devices/triggerX/sampling_frequency
> -KernelVersion:	4.11
> -Contact:	benjamin.gaignard@st.com
> -Description:
> -		Reading returns the current sampling frequency.
> -		Writing an value different of 0 set and start sampling.
> -		Writing 0 stop sampling.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
>  KernelVersion:	4.12
>  Contact:	benjamin.gaignard@st.com
