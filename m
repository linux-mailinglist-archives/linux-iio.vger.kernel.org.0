Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FB36E7E4
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhD2JZQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 05:25:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2951 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhD2JZP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 05:25:15 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FW8yJ0PPdz6xhSt;
        Thu, 29 Apr 2021 17:16:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 29 Apr 2021 11:24:28 +0200
Received: from localhost (10.52.122.22) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 29 Apr
 2021 10:24:27 +0100
Date:   Thu, 29 Apr 2021 10:22:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Olivier MOYSAN" <olivier.moysan@foss.st.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: Fix docs wrongly marked as
 kernel-doc
Message-ID: <20210429102253.00004100@Huawei.com>
In-Reply-To: <03045348-8edd-7a93-cdb4-2cb412ff5cd9@foss.st.com>
References: <20210428192612.147524-1-jic23@kernel.org>
        <03045348-8edd-7a93-cdb4-2cb412ff5cd9@foss.st.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.22]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Apr 2021 10:16:00 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 4/28/21 9:26 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > W=1 highlights these two cases that are obviously not in kernel-doc
> > format.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>  
> 
> Hi Jonathan,
> 
> I've been a bit surprised but I finally found out the checks have
> evolved [1].
> [1] https://lore.kernel.org/linux-next/87pmzlvi0y.fsf@meer.lwn.net/T/
> 
> It seems it's exposed by commit:
> 52042e2db452 ("scripts: kernel-doc: validate kernel-doc markup with the
> actual names")

Good detective work.  I wondered why this one hadn't appeared before
yesterday but was too lazy to check :)

> 
> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,

Jonathan

> 
> Thanks,
> Fabrice
> 
> > ---
> >  drivers/iio/adc/stm32-adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index 922af2d75c1e..5088de835bb1 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -449,7 +449,7 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
> >  	.smp_bits = stm32h7_smp_bits,
> >  };
> >  
> > -/**
> > +/*
> >   * STM32 ADC registers access routines
> >   * @adc: stm32 adc instance
> >   * @reg: reg offset in adc instance
> > @@ -851,7 +851,7 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
> >  	return 0;
> >  }
> >  
> > -/**
> > +/*
> >   * Fixed timeout value for ADC calibration.
> >   * worst cases:
> >   * - low clock frequency
> >   

