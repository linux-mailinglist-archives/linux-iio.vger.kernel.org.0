Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267FE479C8C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 21:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhLRUW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 15:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhLRUW4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 15:22:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4BC061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:22:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d21so5669075qkl.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tphuIPUnm9ulxjGUmnkCnZxhBBuHFYnJl48fBWacsjs=;
        b=TFH951VM+3k7/vi+BErqhwo6eLOqpu/RSe/nd10/S+9J+wmBGDzH2J10JqH9wssF+2
         7nhwfkYo4gTz0LVR5BqGt0HcEJLgSkTtB16sgjEE03ATgkdHRKWRidi2o6J1JMjIoZko
         cB6xR1bJs+TQLDi4raAXpCxrf6jzvrNqb3p3PltcBrlMCxXxPnMFizqv5FOoBgdsJZ5s
         B0R+HJ7lZ6NtZnS8EzZXr9ElN0SDuHHa0Gta3t+jzUnlAnBzXtpsrzHfkdiHhPA9ZBZo
         YtoN/qgmf9+PItWVO58gPOYLLph/93ZU+xfjKRRk/79n/QGtBKWc+5BBnw59IxWJHG4m
         FotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tphuIPUnm9ulxjGUmnkCnZxhBBuHFYnJl48fBWacsjs=;
        b=f8rTKeos2KLOSL6UZfKWiqvQol4VTIMrUDQf0cY0Z3AlmC4iwHpBtZd4JlTqotHVOl
         j/0gDcCmMzqf8jpEKM+Gf11SawlC81hp5la5s1iQErVXbnXBFSLeyeakGmV1yxylNSfh
         3mrgDD1sWo+WyaGnchaKbB8xGEHVPGcgS0MztmEEB2XGfUIGKA0nDTEXiIFwlp0QoT+Z
         /8Z19Ogqz/uQueH+WNT0P6jtF6mdQZB/cYzrw9cnuDkjHAM6Xd5gDBL2WANhNSWlcww2
         6gdTeJXnCVm2EZ1V7XUwv5FhYE6UNbu/CZMgFOmGo2/gl5juBDaXetArhAr1QNKSJcZ/
         bXPQ==
X-Gm-Message-State: AOAM530kFLl2PHhVwuujKtXNPP8CT6NX162CgzkYMNd6KQi71w9iuDM5
        Szm8bsd5jcoayBPPLkDbzxA=
X-Google-Smtp-Source: ABdhPJxSiihU1p4K488nbYzoNI2RAeGl3pcdVWxEBLfsX8hI+Jq+jaK67iK2EKxghnDrQfummr5bVw==
X-Received: by 2002:a05:620a:40c2:: with SMTP id g2mr1233000qko.570.1639858975506;
        Sat, 18 Dec 2021 12:22:55 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id t11sm7452438qkp.56.2021.12.18.12.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:22:55 -0800 (PST)
Date:   Sat, 18 Dec 2021 17:22:51 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/17] staging:iio:adc:ad7280a: Cleanup includes
Message-ID: <Yb5DG1Srf0xNMOJq@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-12-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-12-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Drop used includes, add a few missing ones and reorder.
> The include-what-you-use tool output was considered in making this
> change.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 90241560f5cf..7f9e2276e41a 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -5,21 +5,23 @@
>   * Copyright 2011 Analog Devices Inc.
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/crc8.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
> -#include <linux/bitfield.h>
> -#include <linux/err.h>
> -#include <linux/delay.h>
> -#include <linux/interrupt.h>
> -#include <linux/module.h>
>  
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
>  
>  #include "ad7280a.h"
>  
> -- 
> 2.34.1
> 
