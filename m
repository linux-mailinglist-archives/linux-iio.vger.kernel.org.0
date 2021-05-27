Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81808392A17
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhE0Iw3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 04:52:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3095 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhE0IwV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 May 2021 04:52:21 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FrLsJ5wbCz6S1N3;
        Thu, 27 May 2021 16:41:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 10:50:47 +0200
Received: from localhost (10.52.126.22) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 27 May
 2021 09:50:47 +0100
Date:   Thu, 27 May 2021 09:48:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 01/11] iio: adc: at91-sama5d2: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210527094856.00003d70@Huawei.com>
In-Reply-To: <0384e41b-a995-d9aa-c077-b71917eca45c@microchip.com>
References: <20210501171352.512953-1-jic23@kernel.org>
        <20210501171352.512953-2-jic23@kernel.org>
        <0384e41b-a995-d9aa-c077-b71917eca45c@microchip.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.22]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 May 2021 17:23:11 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 5/1/21 8:13 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > To make code more readable, use a structure to express the channel
> > layout and ensure the timestamp is 8 byte aligned.
> > 
> > Found during an audit of all calls of this function.
> > 
> > Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
> >   drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index a7826f097b95..d356b515df09 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -403,7 +403,8 @@ struct at91_adc_state {
> >          struct at91_adc_dma             dma_st;
> >          struct at91_adc_touch           touch_st;
> >          struct iio_dev                  *indio_dev;
> > -       u16                             buffer[AT91_BUFFER_MAX_HWORDS];
> > +       /* Ensure naturally aligned timestamp */
> > +       u16                             buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);  
> 
> Hello Jonathan,
> 
> I am preparing to change this buffer to a dynamically allocated 
> buffer... because we want to support several versions of the ADC with 
> this driver, having an arbitrary number of channels..
> 
> You think it's possible to have this alignment when I move to a 
> devm_kzalloc call ?

Hmm. You should be fine, but looking through the docs, guaranteed alignment for
devm_kmalloc is unsigned long long.  Sounds worryingly vague, but c99 (which kernel
uses) guarantees at least 64 bits so that's fine.

However, unless your maximum size is very large, I'd be cynical and just leave it
where it is.  Chances are it won't actually make any difference to the real amount
of memory allocated for at91_adc_state and it'll make your code simpler.

No one minds a buffer being too big :)

Jonathan

> 
> Thanks,
> Eugen
> 
> >          /*
> >           * lock to prevent concurrent 'single conversion' requests through
> >           * sysfs.
> > --
> > 2.31.1
> >   
> 

