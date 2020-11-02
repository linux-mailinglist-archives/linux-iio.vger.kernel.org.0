Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F52A29A3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 12:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgKBLha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 06:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgKBLh1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 06:37:27 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C81C0617A6
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 03:37:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so14228048wrq.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 03:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8UEl3atZi8MUx6nvj42rdC/d5FIT8bNul3drA5C9t4o=;
        b=KSYv2SBjH+Ws6ZE66cEijT7O/44A/LCuajSE2vHr3jGkSmXaqHmm551LnfxdPt/sox
         4WLB14qmWWkWjgQoPRM+KdQBXy4zne/f7s0fSNe7h9Y7eFxTw1mTAxU+fkrOfUF0eZRo
         DXw/GDr+NZ48tXPOWLDAfCVCkXJt2gEHbBTfVHRwwOD086BLpQQQ99l8x4iY58INvbFO
         RrCEagxAxMGLY//E9t2Zf4l52Jsgn0IeZbcpqn3aw8b7x8B4CONDhHmSs1DVKtwyMb7j
         5UVXbbH5S869WvmO53EAt6yz0SpUMrv2foIYNqJsOZARN8Dg6wW5+n0nYJ4aSTPCe5dn
         R2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8UEl3atZi8MUx6nvj42rdC/d5FIT8bNul3drA5C9t4o=;
        b=DzHUUiEz0OSgG3Q3CtQQTPVQznaaV/rBMN9wHfj3VxGedaCFNlBlsGI+3dTuI0xuw5
         JAVo3tQ5Ft6WIcr1abNwxdZIy4cd7lWcD0kVPvmiotyfn2qF1NF4zkKLRAestD7nwlZI
         EZqY7V5Vve24ZCHT2fiOifFFx8JzD5TbmmDyvvH/F4ZYNnTv2dr6X4xcOChkORwXt2YN
         3E92TfK6DFqX4Ry3Be150umC8ql3bI+TNpRjhU5SvMinPYeuxTYfCeH2cV0by/VL0h/q
         r3AMT/v5TPS1S0gUL2x04LKtXqFYazbrwpSOArEusKCKmsRGdud/4hgBBBe0BGTf6e6N
         xTyA==
X-Gm-Message-State: AOAM532BuUMOuNE+OnpYZQaabIi1A3WuChrdL2yqHXqXubFLEz2f4iYE
        zk3uanRxGxkUluMdpZ+XpV9guQ==
X-Google-Smtp-Source: ABdhPJwjpHDRKbBPhhmiy3PdY5LEErVkz2mLP78hjliMe/KtqpvD4IG+8gVlI4H1k7GeLJtxo6TD4Q==
X-Received: by 2002:adf:9184:: with SMTP id 4mr19795099wri.258.1604317045878;
        Mon, 02 Nov 2020 03:37:25 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id i2sm6628290wmc.28.2020.11.02.03.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:37:25 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:37:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     jic23@kernel.org, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: industrialio-trigger: Use 'gnu_printf' format
 notation
Message-ID: <20201102113723.GM4127@dell>
References: <20201102111725.1048562-1-lee.jones@linaro.org>
 <6b5807c1-08af-2633-3352-bd7ae084cbe2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b5807c1-08af-2633-3352-bd7ae084cbe2@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 02 Nov 2020, Lars-Peter Clausen wrote:

> On 11/2/20 12:17 PM, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/iio/industrialio-trigger.c: In function ‘iio_alloc_pollfunc’:
> >   drivers/iio/industrialio-trigger.c:338:2: warning: function ‘iio_alloc_pollfunc’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> Jonathan already sent a similar patch. See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd7798cbd28044a3026619e36993160ba8fa118d
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd7798cbd28044a3026619e36993160ba8fa118d>

So adding this to the prototype also squashes the warning?

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/iio/industrialio-trigger.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index 583bb51f65a75..1d65c83439d84 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -320,6 +320,7 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p)
> >   }
> >   EXPORT_SYMBOL(iio_pollfunc_store_time);
> > +__printf(5, 6)
> >   struct iio_poll_func
> >   *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
> >   		    irqreturn_t (*thread)(int irq, void *p),
> 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
