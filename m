Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5336C0BE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 10:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhD0IYu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 04:24:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2919 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhD0IXz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 04:23:55 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FTvdM1s66z73dSB;
        Tue, 27 Apr 2021 16:12:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 10:23:11 +0200
Received: from localhost (10.52.123.122) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Apr
 2021 09:23:10 +0100
Date:   Tue, 27 Apr 2021 09:21:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH 4/8] iio: adc: mt6360: Drop duplicate setting of
 iio_dev.dev.parent
Message-ID: <20210427092137.0000663b@Huawei.com>
In-Reply-To: <CA+U=DsqEkmwz6nV7-uqO7+dLQS-Ezyw2P4fCxmSz-YZQ7kWZog@mail.gmail.com>
References: <20210426170251.351957-1-jic23@kernel.org>
        <20210426170251.351957-5-jic23@kernel.org>
        <CA+U=DsqEkmwz6nV7-uqO7+dLQS-Ezyw2P4fCxmSz-YZQ7kWZog@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.122]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 10:25:05 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Apr 26, 2021 at 8:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Already set to the same value in devm_iio_device_alloc()
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/iio/adc/mt6360-adc.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> > index 6b39a139ce28..07c0e6768391 100644
> > --- a/drivers/iio/adc/mt6360-adc.c
> > +++ b/drivers/iio/adc/mt6360-adc.c
> > @@ -337,7 +337,6 @@ static int mt6360_adc_probe(struct platform_device *pdev)
> >         }
> >
> >         indio_dev->name = dev_name(&pdev->dev);  
> 
> unrelated to this series, this dev_name(&pdev->dev) looks a bit weird;
> this should resolve to the driver name AFAICT; which is "mt6360-adc"
> it feels a bit off with respect to ABI; but maybe it's too late to change it?
Yup. We have some historical ones of these unfortunately when I wasn't
paying attention properly.  They are ABI for those parts now so
we can't fix them without significant risk of breaking someones platform.

Jonathan

> 
> > -       indio_dev->dev.parent = &pdev->dev;
> >         indio_dev->info = &mt6360_adc_iio_info;
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >         indio_dev->channels = mt6360_adc_channels;
> > --
> > 2.31.1
> >  

