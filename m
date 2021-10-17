Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FED430A6D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbhJQQNC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 12:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242555AbhJQQNA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 12:13:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D05360F24;
        Sun, 17 Oct 2021 16:10:48 +0000 (UTC)
Date:   Sun, 17 Oct 2021 17:15:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3] iio: core: fix double free in
 iio_device_unregister_sysfs()
Message-ID: <20211017171503.095eecad@jic23-huawei>
In-Reply-To: <CAHp75VdH2CkY-e6P6QvMzDXK6F9boxz4Vb5trwmMoPOCTmkjww@mail.gmail.com>
References: <20211013030532.956133-1-yangyingliang@huawei.com>
        <CAHp75VeyQYmKybQwWLmM2QxVQXomrUH0RttRguzRyoWXtc3TFA@mail.gmail.com>
        <CAHp75VdH2CkY-e6P6QvMzDXK6F9boxz4Vb5trwmMoPOCTmkjww@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Oct 2021 08:51:38 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wednesday, October 13, 2021, Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:
> 
> >
> >
> > On Wednesday, October 13, 2021, Yang Yingliang <yangyingliang@huawei.com>
> > wrote:
> >  
> >> I got the double free report:
> >>
> >> BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390  
> >
> >
> >  
> >>  kfree+0xce/0x390  
> >
> >
> >
> > This line also redundant, but no need to resend, I hope Jonathan can do it
> > for you.
> >
> >  
> >>  iio_device_unregister_sysfs+0x108/0x13b [industrialio]
> >>  iio_dev_release+0x9e/0x10e [  
> >
> >  
> >>  
> 
> 
> >  
> >>  device_release+0xa5/0x240
> >>  kobject_put+0x1e5/0x540
> >>  put_device+0x20/0x30
> >>  devm_iio_device_release+0x21/0x30 [industrialio]  
> >
> >  
> >>  
> Actually above lines are also part of the noise
Not sure I'm quite so keen to strip everything back completely (though I do
agree keeping it fairly minimal is good.

Anyhow, tidied it up a bit and applied.  I also added a note that more
radical surgery is needed to clean up the lifetime management but in the
meantime this deals with the symptoms.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 
> 
> >  
> >> If __iio_device_register() fails, iio_dev_opaque->groups will be freed
> >> in error path in iio_device_unregister_sysfs(), then iio_dev_release()
> >> will call iio_device_unregister_sysfs() again, it causes double free.
> >> Set iio_dev_opaque->groups to NULL when it's freed to fix this double
> >> free.
> >>
> >> Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> >> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >> ---
> >> v1 -> v3:
> >>   reduce some backtrace in commit message
> >> ---
> >>  drivers/iio/industrialio-core.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/iio/industrialio-core.c
> >> b/drivers/iio/industrialio-core.c
> >> index 2dbb37e09b8c..2dc837db50f7 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -1600,6 +1600,7 @@ static void iio_device_unregister_sysfs(struct
> >> iio_dev *indio_dev)
> >>         kfree(iio_dev_opaque->chan_attr_group.attrs);
> >>         iio_dev_opaque->chan_attr_group.attrs = NULL;
> >>         kfree(iio_dev_opaque->groups);
> >> +       iio_dev_opaque->groups = NULL;
> >>  }
> >>
> >>  static void iio_dev_release(struct device *device)
> >> --
> >> 2.25.1  
> >
> >  
> 
> 
> 
> 
> 
> 
> 
> 
> >  
> >>
> >>  
> >  
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
> >  
> 

