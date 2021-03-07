Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29032FFEC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 10:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCGJkx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 04:40:53 -0500
Received: from www381.your-server.de ([78.46.137.84]:57640 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCGJkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 04:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nt1z8J1eyUreZczP2ZHWxD13PjSsywQ2GvQ43UP5PK4=; b=ffFR2BU/nJgrOmtiG6OnCcPrrG
        eCXR1aW/Qxg6UA1paZdo+HTLcdI9/4oswxpZcXcCFLWxZQzht5BhKXg2VtDEGU06LUNxiLJUmgDPC
        AO9REryhQmS5KIDW2InwhqJUuHEtp2xFLPk9a5DaiClbFi3kczMLpsLI4u5zUJdblazt1gOjPgDuU
        x0cCT/BI72k/q+XbbGaABRB47zCnPLlH6DGT91ePPXan+vFDm7PC2cxGgHJsCRdKzQiP3TSel52ST
        cIjndaPEpiFhMPLeMTJwobi9lDKDMfKWBvWrjvt3WzFnnCS1YaS0LK/NP41AirWW7d4jgHbQWV9Zq
        eD6Sx6Jw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lIpta-0005YT-P7; Sun, 07 Mar 2021 10:40:18 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lIpta-000MXE-JY; Sun, 07 Mar 2021 10:40:18 +0100
Subject: Re: [RFC PATCH 2/7] iio:ABI docs: Avoid repitition of
 triggerX/sampling_frequency
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20210117153816.696693-1-jic23@kernel.org>
 <20210117153816.696693-3-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c6fb25c0-1292-f5fa-c5c9-8e47d1061874@metafoo.de>
Date:   Sun, 7 Mar 2021 10:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210117153816.696693-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26100/Sat Mar  6 13:05:22 2021)
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
>   Documentation/ABI/testing/sysfs-bus-iio             | 2 ++
>   Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
>   2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d2dd9cc280f9..9b5ceb22363d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -55,6 +55,8 @@ Description:
>   		direct access interfaces, it may be found in any of the
>   		relevant directories.  If it affects all of the above
>   		then it is to be found in the base device directory.
> +		Note a value 0 where supported, will correspond to sampling
> +		stopping.

Hm, I don't like this. 0 should be an invalid value for the standard 
ABI. Enabling/disabling of the trigger should be controlled by whether 
there are any active trigger consumers.

The stm32-timer-trigger implements a non-standard ABI and I think we 
need to document this explicitly. The driver does not have a set_state 
callback. So the frequency property is used to enable/disable the 
trigger, but as said above, for standard compliant triggers that should 
not be the case.

