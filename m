Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906C5285415
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 23:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJFVu4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 17:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJFVuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2020 17:50:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E8C061755;
        Tue,  6 Oct 2020 14:50:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so131686pfk.2;
        Tue, 06 Oct 2020 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8giwswfBxqLnHEu2oqSUvRPSaZxU1liNSS/lZSVFxsk=;
        b=L9D8l+DMD8b3gpfHokXBq6EnkBSsCoHa1ex5FiK3YDyqD9csTKGz5X6SPG+z0pYZ9g
         AbRmxL5SB6rspiy/0WAzZJfNasge3QsaBJGTV4YKmjIsuHhP39w+9vLx6keiMlSJ6JQL
         2Y2Kgt35dkNonS79FVXRe7EhquAgADW7twnDV36+Zg4ijiZxd3xerE1StTwg9iqZGvpu
         ZAulY4bu3xkIOKoqXMjO5PJmzoTDZLgWTm2aKfhhZhXERKk8wAgTYmbbrX6tKkxd0xYN
         gj25QWgEvJ/bi5DQLZGRRI1AvXN9oCc8HFUkgn1WurUHQLdA0oAzErqubfOwCILMiDrO
         cs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8giwswfBxqLnHEu2oqSUvRPSaZxU1liNSS/lZSVFxsk=;
        b=A+DHaiGxYzxATCvbqgigcm13YkZH54GOwfvFq8MhXAjOREoASwdOwBGDzu78fGSQww
         lMX0Z4cN+13q/aUGPGSpqekekL1vCbRrz6BF3K6aDMX2Q6642eaS1Oi7Bt/VN8K4x/Vd
         mMj2UjIJomoHAQKhgjMhdhy9OjfNEYspJD1n/qvA3EF1pJ7e0eN2LNSLWAs3v6EQCEOp
         7eNH37tU3ioWGGdJu76kjuVILFvtU3vOJu3FQkUO6KhWty+DWDsacwzrH28hbmdMsXyA
         t/Wx1HY9Hpui+Xe5JRJfQE02uG3ybhoGMRljo4s43UMUaI0RSlACgSZJAmpwgc4LMuXl
         KbTA==
X-Gm-Message-State: AOAM531UtPm+WJ/4NzmyHEZthEG1ul4hXkEAVN86pIKgM5Iw+y31vXyy
        sWPrcKpms5yv/5sf8US/Y/o=
X-Google-Smtp-Source: ABdhPJwZXFCK7tR/WRwAo960dzSlCK448GLKlYwVEJgpkwoOHU+Z6gdCqRzzRgnOSPzys+LCmVCKug==
X-Received: by 2002:a63:d905:: with SMTP id r5mr202517pgg.300.1602021055063;
        Tue, 06 Oct 2020 14:50:55 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id mw11sm3594019pjb.57.2020.10.06.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:50:54 -0700 (PDT)
Date:   Tue, 6 Oct 2020 14:50:51 -0700
From:   dmitry.torokhov@gmail.com
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: exynos: do not rely on 'users' counter in
 ISR
Message-ID: <20201006215051.GO1009802@dtor-ws>
References: <20201006041214.GA4145870@dtor-ws>
 <20201006193907.GA30199@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201006193907.GA30199@qmqm.qmqm.pl>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 06, 2020 at 09:39:07PM +0200, Michał Mirosław wrote:
> On Mon, Oct 05, 2020 at 09:12:14PM -0700, dmitry.torokhov@gmail.com wrote:
> > The order in which 'users' counter is decremented vs calling drivers'
> > close() method is implementation specific, and we should not rely on
> > it. Let's introduce driver private flag and use it to signal ISR
> > to exit when device is being closed.
> > 
> > This has a side-effect of fixing issue of accessing inut->users
> > outside of input->mutex protection.
> [...]
> 
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> (after with a fix mentioned below)
> 
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> [...]
> > @@ -712,6 +715,7 @@ static int exynos_adc_ts_open(struct input_dev *dev)
> >  {
> >  	struct exynos_adc *info = input_get_drvdata(dev);
> >  
> > +	WRITE_ONCE(info->ts_enabled, true);
> >  	enable_irq(info->tsirq);
> >  
> >  	return 0;
> > @@ -721,6 +725,7 @@ static void exynos_adc_ts_close(struct input_dev *dev)
> >  {
> >  	struct exynos_adc *info = input_get_drvdata(dev);
> >  
> > +	WRITE_ONCE(info->ts_enabled, true);
> >  	disable_irq(info->tsirq);
> 
> Shouldn't 'true' be 'false' here?

I swear if we disable cut-n-paste functionality there will be markable
reduction in bug rates...

Thanks for noticing this!

-- 
Dmitry
