Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD7189003
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 22:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCQVDv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 17:03:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:55906 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQVDu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 17:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EQiQ0PuqA94yZF/CxYrV9TLsKItGZYdsh1unacm1lpg=; b=ahPO4y3mPq14JZQyOi/nYf8Ug2
        Vkopnh9QAR40iJTlawsKtJ1BVjsW4+ENP4T8T6ebVb1+cDF1wLVc+fE2b8zDCYjsXtFar2qK9HWm7
        U0eEdQRXJ4O0VG1LOPA/yvYX7rQ3qjcIxEjTsMNS/eS/NuBfsoq22Lywv5MM8ZJ5nfrdvZHYVDV3l
        0DVbOUsu5+aG+c8QKgI6s15xloUsI+OKT/kHcyD5kyFns0DqfB9Tgsj368azzWjXmbcu811e2jc2h
        VJGPNc4JskpfW3T1sxR1jFvdlj2IUjWXt7woiHOJ4rCTK4bLkE7yzI7XhWrVVX8KPhDS8GSpR5oIl
        KvBqyWiw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEJNM-0000nu-TV; Tue, 17 Mar 2020 22:03:48 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEJNM-000F3f-KN; Tue, 17 Mar 2020 22:03:48 +0100
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9039134f-5b8d-b864-c76c-3f6b67ede946@metafoo.de>
Date:   Tue, 17 Mar 2020 22:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317201710.23180-2-alazar@startmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 9:17 PM, Alexandru Lazar wrote:

> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -566,6 +566,18 @@ config MAX1118
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called max1118.
>   
> +config MAX1241
> +	tristate "Maxim max1241 ADC driver"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

One more bit.

Your driver currently does not support buffered mode, so the two select 
statements above are not required.

> +	help
> +	  Say yes here to build support for Maxim max1241 12-bit, single-channel
> +          ADC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max1118.
> +
>   config MAX1363
>   	tristate "Maxim max1363 ADC driver"
>   	depends on I2C
