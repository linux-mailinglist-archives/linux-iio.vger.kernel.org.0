Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A808E369C8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 04:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFFCG2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 22:06:28 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:57972 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFFCG2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 22:06:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 22:06:28 EDT
Received: (qmail 20477 invoked by uid 5089); 6 Jun 2019 01:59:46 -0000
Received: by simscan 1.2.0 ppid: 20389, pid: 20390, t: 0.0556s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.128?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 6 Jun 2019 01:59:46 -0000
Subject: Re: [PATCH] staging: iio: adt7316: Fix build errors when GPIOLIB is
 not set
To:     Fabio Estevam <festevam@gmail.com>, jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        rdunlap@infradead.org, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
References: <20190606014246.1850-1-festevam@gmail.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <81b33d1f-0129-5fe4-9883-a9c30feafd9d@electromag.com.au>
Date:   Thu, 6 Jun 2019 09:59:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606014246.1850-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

G'day Fabio,

On 6/06/2019 09:42, Fabio Estevam wrote:
> On x86_64 when GPIOLIB is not set the following build errors
> are seen:
> 
> drivers/staging/iio/addac/adt7316.c:947:3: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
> drivers/staging/iio/addac/adt7316.c:1805:2: error: implicit declaration of function 'irqd_get_trigger_type' [-Werror=implicit-function-declaration]
> 
> These functions are provided by the <linux/gpio/consumer.h>
> and <linux/irq.h> headers, so include them to fix these
> build errors.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>   drivers/staging/iio/addac/adt7316.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 37ce563cb0e1..5470a9c3f872 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -7,6 +7,8 @@
>   
>   #include <linux/interrupt.h>
>   #include <linux/gpio.h>
This should be removed as well.
See comment at top of linux/gpio.h



> +#include <linux/gpio/consumer.h>
> +#include <linux/irq.h>
>   #include <linux/workqueue.h>
>   #include <linux/device.h>
>   #include <linux/kernel.h>
> 


-- 
Regards
Phil Reid
