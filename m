Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C2227C06
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGUJqu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUJqt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 05:46:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59892C061794;
        Tue, 21 Jul 2020 02:46:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k13so2350252lfo.0;
        Tue, 21 Jul 2020 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjGsKNOLfrFLP10m1bYALwDxL+3kb4RKPq53OhKfCAA=;
        b=ZoeL+RbHQ+l5uPKnAsvF3Yhg1/K2gC+LAKj7r6LYeSWfqTkRKRwqhktZhuf99vtb5B
         1BRhNsBA2on1ZXiKsqwlsrN0wTpUBvZAzrHVz6HvXtyaircxRx1CagSzOsat1hUemnJF
         ENzjrALS5f/UERQcZDTUb1BNiArOfslEov7a1+HSnIryEWzb8hjvFia84kCpRUP8pl1o
         RI1I8Jhm8xUKFz2CavHUdaI0IKM/WeWrIW38JgK32LiX7vPBKAxUHNGSlzbf+Rd8Hg4L
         QP7qJ5lUe84SLvCgAFYBDZXO3H5o0yHIKYYufBdjeNLEjV0/ajQffp2utLto43EHBOt5
         q6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjGsKNOLfrFLP10m1bYALwDxL+3kb4RKPq53OhKfCAA=;
        b=ODfI0uVb7TWd5a5S6ZBv+/wxnt27vWSN7lXOcPfYgY4bKeVJc5FHP2L7Zy+rrY6IRK
         08r1y7JOUHgkv0RwFYCuEx4wVRtHNOf4j5V5G/A+NP7KiVqDlQnTYoJh8VnwZt7bBTAD
         IfDNYLcOhYuQcZ2AGQTig12+9c9WhbiXWxkHKZy0+pavHoihqUPDofgCLj8M/gzHLMaN
         gbjD4gncmzVxj3tVM5o0icMjHRhSeT2pdzamSrBW1saE7ibVmCuTvt6D05dr6MK58BnF
         cxAKqIwSBDanJihAQgB8Z1X9szj7EflZ7kiF3pCN12m8/zvWoFtRJKJk38nTp5j70k8p
         B2JQ==
X-Gm-Message-State: AOAM531rghT+e8FDqJYf9MWVELgVjnQFhAtOPCsE5TqeyeTmWVX3jsnw
        5lULPAxqASHLTGmK+xmT44w=
X-Google-Smtp-Source: ABdhPJx5RrovH2l4sGyVnfsyAH4WGWGxwtE1xBqiTHiqXtQkG7+jKW6+Fk8g21iySVigSRx5u0lkbQ==
X-Received: by 2002:a19:c7d0:: with SMTP id x199mr7849459lff.205.1595324807710;
        Tue, 21 Jul 2020 02:46:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([94.25.229.9])
        by smtp.gmail.com with ESMTPSA id m18sm4998998lfr.53.2020.07.21.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 02:46:46 -0700 (PDT)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <lumag@eriador.lumag.spb.ru>
Date:   Tue, 21 Jul 2020 12:46:43 +0300
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/7] iio: core: wrap IIO device into an iio_dev_opaque
 object
Message-ID: <20200721094643.GA1598380@eriador.lumag.spb.ru>
References: <20200630045708.14166-1-alexandru.ardelean@analog.com>
 <20200630045708.14166-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630045708.14166-3-alexandru.ardelean@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Tue, Jun 30, 2020 at 07:57:03AM +0300, Alexandru Ardelean wrote:
> There are plenty of bad designs we want to discourage or not have to review
> manually usually about accessing private (marked as [INTERN]) fields of
> 'struct iio_dev'.
> 
> Sometimes users copy drivers that are not always the best examples.
> 
> A better idea is to hide those fields into the framework.
> For 'struct iio_dev' this is a 'struct iio_dev_opaque' which wraps a public
> 'struct iio_dev' object.
> 
> In the next series, some fields will be moved to this new struct, each with
> it's own rework.

[skipped]

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 19 +++++++++++++------
>  include/linux/iio/iio-opaque.h  | 17 +++++++++++++++++
>  include/linux/iio/iio.h         |  6 +++++-
>  3 files changed, 35 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/iio/iio-opaque.h
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 75661661aaba..33e2953cf021 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c

[skipped]

> @@ -1506,11 +1510,14 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  	/* ensure 32-byte alignment of whole construct ? */
>  	alloc_size += IIO_ALIGN - 1;
>  
> -	dev = kzalloc(alloc_size, GFP_KERNEL);
> -	if (!dev)
> +	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!iio_dev_opaque)
>  		return NULL;
>  
> -	dev->dev.parent = parent;

This chunk (together with 8cb631ccbb1952b6422917f2ed16f760d84a762e and
d3be83244c7dfe686d23f1c0bac75915587fc044) break devicetree bindings of
IIO clients. After these changes there are no links between devicetree
nodes and corresponding IIO channels. I'd kindly ask to restore this
dev->dev.parent assignment (which restores of node binding).

> +	dev = &iio_dev_opaque->indio_dev;
> +	dev->priv = (char *)iio_dev_opaque +
> +		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
> +
>  	dev->dev.groups = dev->groups;
>  	dev->dev.type = &iio_device_type;
>  	dev->dev.bus = &iio_bus_type;

-- 
With best wishes
Dmitry
