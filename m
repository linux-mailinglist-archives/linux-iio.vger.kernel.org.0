Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F903125B1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBGP7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGP7y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:59:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3FEC64DE1;
        Sun,  7 Feb 2021 15:59:12 +0000 (UTC)
Date:   Sun, 7 Feb 2021 15:59:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wilfried Wessner <wilfried.wessner@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH v2] iio: ad7949: fix wrong ADC result due to incorrect
 bit mask
Message-ID: <20210207155909.7075d3ac@archlinux>
In-Reply-To: <CAMwq6HikxYvTPHsyQmWBtQRUgLnPpVeaGjy0mvF_ZQjeAOMkyg@mail.gmail.com>
References: <20210206145258.GA603024@ubuntu>
        <20210206170107.7db71f53@archlinux>
        <CAMwq6HikxYvTPHsyQmWBtQRUgLnPpVeaGjy0mvF_ZQjeAOMkyg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 6 Feb 2021 19:48:26 +0100
Wilfried Wessner <wilfried.wessner@gmail.com> wrote:

> On Sat, Feb 6, 2021 at 6:01 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 6 Feb 2021 15:52:58 +0100
> > Wilfried Wessner <wilfried.wessner@gmail.com> wrote:
> >  
> > > Fixes a wrong bit mask used for the ADC's result, which was caused by an
> > > improper usage of the GENMASK() macro. The bits higher than ADC's
> > > resolution are undefined and if not masked out correctly, a wrong result
> > > can be given. The GENMASK() macro indexing is zero based, so the mask has
> > > to go from [resolution - 1 , 0].  
> >
> > Hi Wilfried,
> >
> > Welcome to IIO and kernel in general!
> >
> > It's useful to add to the description if the error was found by inspection / script
> > or by observing an actual error on hardware?  
> 
> The issue was found in combination of an AD7682 ADC with an ARM based iMX7-CPU.
> The SPI line was analyzed with a logic analyzer and a discrepancy
> between applied
> voltage level and the ADC reported value in user space was observed.
> Digging into
> the driver code revealed the error.

Thanks for the info. 

> 
> >
> > Also, needs a fixes tag so we can work out what kernels to back port it to.  
> 
> Not sure about that, but I found the issue in:
> 
> commit 61556703b610a104de324e4f061dc6cf7b218b46 (HEAD -> master,
> origin/master, origin/HEAD)
> Merge: 3afe9076a7c1 7f3414226b58
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Feb 3 11:56:58 2021 -0800
> 
>     Merge tag 'for-linus-5.11-rc7' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml
> 
Ok, that doesn't tell us anything much so here we need to look back and find
where the bug was introduced by looking at the code.

git blame drivers/iio/adc/ad7949.c 

7f40e0614317f (Charles-Antoine Couret 2018-10-22 23:02:42 +0200  94)    int mask = GENMASK(ad7949_adc->resolution, 0);

git log 7f40e0614317f

commit 7f40e0614317f20ac07b5aa5cec2eb43737e28d6
Author: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Date:   Mon Oct 22 23:02:42 2018 +0200

    iio:adc:ad7949: Add AD7949 ADC driver family
    
    Compatible with AD7682 and AD7689 chips.
    It is a Analog Devices ADC driver 14/16 bits 4/8 channels
    with SPI protocol
    
    Datasheet of the device:
    http://www.analog.com/media/en/technical-documentation/data-sheets/AD7949.pdf
    
    Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

So it goes all the way back to the beginning.  The fixes tag will therefore need to be

Fixes: 7f40e0614317f ("iio:adc:ad7949: Add AD7949 ADC driver family")

Please add that Fixes tag to your v3 with a short statement of how you identified the
issue.

Thanks,

Jonathan

> >
> > +CC Charle-Antoine Couret as the original driver author.  
> 
> done.
> I wrote also an email to Charles-Antoine with the proposed fix, his comment was:
> ------
> [Wilfried:]
> >> since the GENMASK macro uses zero-based indexing?
> >>  
> [Charles-Antoine:]
> >You're right, it's a mistake.
> >It wouldn't be a problem in many cases but it's better to be compliant.  
> [Wilfried:]
> >> Could you pls. comment on that?
> >>  
> [Charles-Antoine:]
> >Good for me.  
> ------
> 
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >
> > > Signed-off-by: Wilfried Wessner <wilfried.wessner@gmail.com>
> > >
> > > ---
> > >  drivers/iio/adc/ad7949.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > > index 5d597e5050f6..1b4b3203e428 100644
> > > --- a/drivers/iio/adc/ad7949.c
> > > +++ b/drivers/iio/adc/ad7949.c
> > > @@ -91,7 +91,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
> > >       int ret;
> > >       int i;
> > >       int bits_per_word = ad7949_adc->resolution;
> > > -     int mask = GENMASK(ad7949_adc->resolution, 0);
> > > +     int mask = GENMASK(ad7949_adc->resolution - 1, 0);
> > >       struct spi_message msg;
> > >       struct spi_transfer tx[] = {
> > >               {  
> >  

