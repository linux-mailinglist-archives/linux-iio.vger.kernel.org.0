Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A936A77
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 05:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFFDY0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jun 2019 23:24:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58948 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFFDY0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2019 23:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ANLy3Q/E3unt0aMYgl32mxZOvr5sBbpUf7AyjjywVKQ=; b=iEghK4qoZQaADY0SiQN7EkLdZY
        EbUM7WxIlLTyuMPQSgRIyojMDBfY8EtVg4DIQjFOp7jbZmEAVGNEW0q/ETCAigxoEAmlJ/ChuI5hY
        Wox7phb1k5chDjUY9EjJD/XNSL1w6JkV0fdr7lTaTLoh8zXrIBxdMXLogUs0kkMGb6YZcivjE9W1L
        PNUTi81pS5IR4MM1YHOioUOx5tDuSXLoB7uXqEmKQGoPenJs50PalcK+iAs3Lc4OAew3AUeVvMcNN
        mPa0ceMdpW0XycAGqcJKSCr08/WrQNzIAR5DsRhykRgjHUqzr/P9yXy1rMKx34zjDqhzAhADCL2ZQ
        qu17LiYg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYj0d-0004PK-Ax; Thu, 06 Jun 2019 03:24:11 +0000
Subject: Re: [PATCH v2] staging: iio: adt7316: Fix build errors when GPIOLIB
 is not set
To:     Fabio Estevam <festevam@gmail.com>, jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, preid@electromag.com.au
References: <20190606020532.4864-1-festevam@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7edb325e-9af8-8ae8-d26e-da75c0252284@infradead.org>
Date:   Wed, 5 Jun 2019 20:24:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606020532.4864-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/5/19 7:05 PM, Fabio Estevam wrote:
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
> While at it, remove <linux/gpio.h> as this driver is a GPIO
> consumer and not a GPIO driver.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Changes since v1:
> - Remove <linux/gpio.h> - Phil
> 
>  drivers/staging/iio/addac/adt7316.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 37ce563cb0e1..9cb3d0e42c38 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -6,7 +6,8 @@
>   */
>  
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/irq.h>
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> 


-- 
~Randy
