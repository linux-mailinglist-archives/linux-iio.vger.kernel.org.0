Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69C27E70C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 12:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgI3KvI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 06:51:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2931 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbgI3KvI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Sep 2020 06:51:08 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6A07AC01C465DD4C9A9C;
        Wed, 30 Sep 2020 11:51:06 +0100 (IST)
Received: from localhost (10.52.127.162) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 30 Sep
 2020 11:51:05 +0100
Date:   Wed, 30 Sep 2020 11:49:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 4/5] iio: adc: vf610_adc: Replace indio_dev->mlock with
 own device lock
Message-ID: <20200930114923.00001af2@Huawei.com>
In-Reply-To: <CA+U=DsqDymuWht_H1z+TnTvcXbnuJ9tm45w4g_U6g=qWz+fGvQ@mail.gmail.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
        <20200928131333.36646-4-mircea.caprioru@analog.com>
        <20200929171441.5b4ff8c8@archlinux>
        <CA+U=DsqDymuWht_H1z+TnTvcXbnuJ9tm45w4g_U6g=qWz+fGvQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.162]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Sep 2020 08:57:55 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Tue, Sep 29, 2020 at 7:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 28 Sep 2020 16:13:32 +0300
> > Mircea Caprioru <mircea.caprioru@analog.com> wrote:
> >  
> > > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > >
> > > As part of the general cleanup of indio_dev->mlock, this change replaces
> > > it with a local lock on the device's state structure.
> > >
> > > This is part of a bigger cleanup.
> > > Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> > >
> > > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>  
> >
> > There are more problems in the locking in here than just this one.
> > See below.  The taking of mlock like this was what originally motivated
> > the efforts to hide it away from drivers.
> >
> > In this particular case I don't think a local lock is the correct solution.
> >
> > Thanks,
> >
> > Jonathan
> >
> >  
> > > ---
> > >  drivers/iio/adc/vf610_adc.c | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > > index 1d794cf3e3f1..b7d583993f0b 100644
> > > --- a/drivers/iio/adc/vf610_adc.c
> > > +++ b/drivers/iio/adc/vf610_adc.c
> > > @@ -168,6 +168,15 @@ struct vf610_adc {
> > >
> > >       struct completion completion;
> > >       u16 buffer[8];  
> >
> > Side note.  That buffer isn't correctly aligned.  I'll add this one to
> > my next series fixing those.
> >  
> > > +     /*
> > > +      * Lock to protect the device state during a potential concurrent
> > > +      * read access from userspace. Reading a raw value requires a sequence
> > > +      * of register writes, then a wait for a completion callback,
> > > +      * and finally a register read, during which userspace could issue
> > > +      * another read request. This lock protects a read access from
> > > +      * ocurring before another one has finished.
> > > +      */
> > > +     struct mutex lock;
> > >  };
> > >
> > >  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
> > > @@ -464,11 +473,11 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
> > >  {
> > >       struct vf610_adc *info = iio_priv(indio_dev);
> > >
> > > -     mutex_lock(&indio_dev->mlock);
> > > +     mutex_lock(&info->lock);  
> > Hmm. So there is a bit of a question on what the locking here is doing.
> > (see below for a different use of mlock).
> >
> > What it will do currently is to prevent the conversion mode changing whilst
> > we are in buffered mode.  It will also protect against concurrent
> > calls of this function.
> >
> > I would replace this with iio_device_claim_direct_mode() rather than a
> > local lock.  
> 
> This raises a new question: if there's any drivers that we missed [for
> iio_device_claim_direct_mode()].
> While I was aware of iio_device_claim_direct_mode(), I missed this
> fact when pushing the mlock cleanup.
> 
> Oh well, I'll do a quick audit over the current drivers that were converted.
> Hopefully I don't find anything :P

I was keeping an eye out for this, so hopefully I didn't miss any!

Good to check though :)

Jonathan

> 
> >  
> > >       info->adc_feature.conv_mode = mode;
> > >       vf610_adc_calculate_rates(info);
> > >       vf610_adc_hw_init(info);
> > > -     mutex_unlock(&indio_dev->mlock);
> > > +     mutex_unlock(&info->lock);
> > >
> > >       return 0;
> > >  }
> > > @@ -632,9 +641,9 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> > >       switch (mask) {
> > >       case IIO_CHAN_INFO_RAW:
> > >       case IIO_CHAN_INFO_PROCESSED:
> > > -             mutex_lock(&indio_dev->mlock);
> > > +             mutex_lock(&info->lock);
> > >               if (iio_buffer_enabled(indio_dev)) {
> > > -                     mutex_unlock(&indio_dev->mlock);
> > > +                     mutex_unlock(&info->lock);  
> >
> > Should be use iio_device_claim_direct_mode()
> >
> > mlock is being taken here to stop us entering buffered mode.
> >
> > Whilst I'd rather a driver didn't rely on internal details of
> > IIO, it is rather fiddly to get the locking right when there is a completion
> > going on, so I think here you are safe to do so.
> >  
> > >                       return -EBUSY;
> > >               }
> > >
> > > @@ -645,11 +654,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> > >               ret = wait_for_completion_interruptible_timeout
> > >                               (&info->completion, VF610_ADC_TIMEOUT);
> > >               if (ret == 0) {
> > > -                     mutex_unlock(&indio_dev->mlock);
> > > +                     mutex_unlock(&info->lock);
> > >                       return -ETIMEDOUT;
> > >               }
> > >               if (ret < 0) {
> > > -                     mutex_unlock(&indio_dev->mlock);
> > > +                     mutex_unlock(&info->lock);
> > >                       return ret;
> > >               }
> > >
> > > @@ -668,11 +677,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> > >
> > >                       break;
> > >               default:
> > > -                     mutex_unlock(&indio_dev->mlock);
> > > +                     mutex_unlock(&info->lock);
> > >                       return -EINVAL;
> > >               }
> > >
> > > -             mutex_unlock(&indio_dev->mlock);
> > > +             mutex_unlock(&info->lock);
> > >               return IIO_VAL_INT;
> > >
> > >       case IIO_CHAN_INFO_SCALE:
> > > @@ -807,6 +816,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
> > >       }
> > >
> > >       info = iio_priv(indio_dev);
> > > +
> > > +     mutex_init(&info->lock);
> > > +
> > >       info->dev = &pdev->dev;
> > >
> > >       info->regs = devm_platform_ioremap_resource(pdev, 0);  
> >  


