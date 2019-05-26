Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4942AA56
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2019 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfEZOxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 May 2019 10:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfEZOxV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 May 2019 10:53:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39E020815;
        Sun, 26 May 2019 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558882400;
        bh=65oYITCZXkSQPpBpB70/9NzgHpXMWdm94uzquU8fZ/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCh6xJYA6SIzbiUPSW7Hru5Uoii57tRq9u5tvZ2OAgUw0IyhT+1OYPxOFDqhYPLRY
         HETxKnSCbqDqOXS0HlTRnh5fqS0OsKL30PWX8oA4C6NH34DYfSF4gZKDiIB4qLdMKJ
         EfVmJ2TPAxjnyYuG4ncZyesnHtTRDpKO1WiWBEiA=
Date:   Sun, 26 May 2019 15:53:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: iio: adis16240: add of_match_table entry
Message-ID: <20190526155308.5980cb81@archlinux>
In-Reply-To: <11a0315e01b80a3a9eb4e81e1b018a2bff7ae559.camel@analog.com>
References: <20190524032950.2398-1-rodrigorsdc@gmail.com>
        <CA+U=DspqLFBMrRcV6VmypHOpE6Qs7OqmiDzWAd6pxpA7B=4S4g@mail.gmail.com>
        <20190524135034.u2mbtq2jwhp6ent7@smtp.gmail.com>
        <11a0315e01b80a3a9eb4e81e1b018a2bff7ae559.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 May 2019 13:54:49 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2019-05-24 at 10:50 -0300, Marcelo Schmitt wrote:
> > [External]
> > 
> > 
> > Hi Alexandru,
> > 
> > On 05/24, Alexandru Ardelean wrote:  
> > > On Fri, May 24, 2019 at 6:30 AM Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:  
> > > > 
> > > > This patch adds of_match_table entry in device driver in order to
> > > > enable spi fallback probing.
> > > > 
> > > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > > ---
> > > >  drivers/staging/iio/accel/adis16240.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> > > > index 8c6d23604eca..b80c8529784b 100644
> > > > --- a/drivers/staging/iio/accel/adis16240.c
> > > > +++ b/drivers/staging/iio/accel/adis16240.c
> > > > @@ -444,6 +444,7 @@ MODULE_DEVICE_TABLE(of, adis16240_of_match);
> > > >  static struct spi_driver adis16240_driver = {
> > > >         .driver = {
> > > >                 .name = "adis16240",
> > > > +               .of_match_table = adis16240_of_match,  
> > > 
> > > This patch is missing the actual table.  
> > 
> > Struct with compatible devices table was included separately in a
> > previous patch at commit d9e533b6c0a26c7ef8116b7f3477c164c07bb6fb.
> > Yeah, I also thought it was missing the match table the first time I was
> > this patch. It's really confusing when we have two patches, one
> > depending on another, that are not part of the same patch set. We're
> > trying to avoid things like this the most but that slipped out from our
> > internal review. We're sorry about that.  
> 
> No worries.
> 
> It happens to me too.
> 
> Thanks
> Alex
Oops. I should have caught that one in review as well.
Oh well, these things happen.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.  I rebased the tree to pick up on
all the other stuff in staging/staging-next after the mere window.

Thanks,

Jonathan

> 
> >   
> > >   
> > > >         },
> > > >         .probe = adis16240_probe,
> > > >         .remove = adis16240_remove,
> > > > --
> > > > 2.20.1
> > > >   

