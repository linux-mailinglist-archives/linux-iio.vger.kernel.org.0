Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE02916D0
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgJRJ4b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 05:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgJRJ4b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 05:56:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C462137B;
        Sun, 18 Oct 2020 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603014990;
        bh=7DU/A8UYgjPOdoz9469QwKmgVmfAtbL+U/ZCs+im6Mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4Z4+ZG5NfQmXS4ejY2HCM2cLix3YrnLYt8Dks++oMDezeSSB4QWesghYuVnIQizn
         s/UXG/kRvtWgvElY5FfEDbpIR4i1HKgmqVQK5FXu0fE3SVNyHwV9bF4bRd8ZEEaGaJ
         KxHlzv0iiHFaLlt85lWxLDj4/VPqf4NMnS/5n/cw=
Date:   Sun, 18 Oct 2020 10:56:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio:core: In map_array_register() cleanup in case of
 error
Message-ID: <20201018105631.5cb34b1d@archlinux>
In-Reply-To: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
References: <20201011160748.4a47b889@archlinux>
        <1602440546-2376-1-git-send-email-LinoSanfilippo@gmx.de>
        <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Oct 2020 18:09:48 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Oct 11, 2020 at 9:24 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
> >
> > In function map_array_register() properly rewind in case of error.
> > Furthermore remove the now superfluous initialization of "ret" with 0.  
> 
> >  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
> >  {
> > -       int i = 0, ret = 0;
> > +       int i = 0, ret;
> >         struct iio_map_internal *mapi;
> >
> >         if (maps == NULL)
> > @@ -44,7 +44,18 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
> >                 list_add_tail(&mapi->l, &iio_map_list);
> >                 i++;
> >         }
> > +       mutex_unlock(&iio_map_list_lock);
> > +
> > +       return 0;
> > +
> >  error_ret:  
> 
> Wait a bit.
> First of all we linked all successfully added items to the list.
> From this we have two ways to go:
>  - leave with as many maps as we registered
>  - clean up and bail out
> 
> I dunno which one would play better in IIO, but you seem to go with
> the latter one.

Better to cleanup and bail out I think.   It's fairly unlikely
a consumer is going to be ready to cope with getting a partial
set of the channels it's expecting.


> 
> > +       /* undo */
> > +       while (i--) {
> > +               mapi = list_last_entry(&iio_map_list, struct iio_map_internal,
> > +                                      l);
> > +               list_del(&mapi->l);
> > +               kfree(mapi);
> > +       }  
> 
> We have iio_map_array_unregister(). Why not use it?
> 
> >         mutex_unlock(&iio_map_list_lock);  
> 
> I would rather drop a label with replacement goto -> break inside the
> loop and call the following

I argued for the goto, but it is indeed less obviously the right
thing to do once we are using iio_map_array_unregister.

> 
> 
>         mutex_unlock(&iio_map_list_lock);
> if (ret)
>   iio_map_array_unregister();
> return ret;
> 
> Sounds like only a few LOCs are needed.
> 

