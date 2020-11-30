Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318BE2C8926
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 17:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgK3QRJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 11:17:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2179 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgK3QRI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 11:17:08 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cl9Kc4bb5z67KjR;
        Tue,  1 Dec 2020 00:14:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 30 Nov 2020 17:16:21 +0100
Received: from localhost (10.47.30.241) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 30 Nov
 2020 16:16:20 +0000
Date:   Mon, 30 Nov 2020 16:16:00 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATH v3 3/3] iio: adc: xilinx: use more devres helpers and
 remove remove()
Message-ID: <20201130161600.00000d66@Huawei.com>
In-Reply-To: <CAMRc=Mcbzpw4o28NA-19dtWzwQz-DUYocNrD+0_RqRkCVq=PiQ@mail.gmail.com>
References: <20201130142759.28216-1-brgl@bgdev.pl>
        <20201130142759.28216-4-brgl@bgdev.pl>
        <CAMRc=Mcbzpw4o28NA-19dtWzwQz-DUYocNrD+0_RqRkCVq=PiQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.241]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Nov 2020 15:30:22 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Mon, Nov 30, 2020 at 3:28 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > In order to simplify resource management and error paths in probe() and
> > entirely drop the remove() callback - use devres helpers wherever
> > possible. Define devm actions for cancelling the delayed work and
> > disabling the clock.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---  
> 
> [snip]
> 
> >
> >         /* Set thresholds to min/max */
> >         for (i = 0; i < 16; i++) {
> > @@ -1334,59 +1353,23 @@ static int xadc_probe(struct platform_device *pdev)
> >                 ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> >                         xadc->threshold[i]);
> >                 if (ret)
> > -                       goto err_free_irq;
> > +                       return ret;
> >         }
> >
> >         /* Go to non-buffered mode */
> >         xadc_postdisable(indio_dev);
> >
> > -       ret = iio_device_register(indio_dev);
> > +       ret = devm_iio_device_register(dev, indio_dev);
> >         if (ret)
> > -               goto err_free_irq;
> > +               return ret;
> >
> >         platform_set_drvdata(pdev, indio_dev);
> >  
> 
> Cr*p I was supposed to drop this line...
> 
> Jonathan: can you drop it when applying?
Sure. 

J

> 
> Bartosz
> 
> [snip]
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

