Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6600F2C7559
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgK1VtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732723AbgK1SQ4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:16:56 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E766C246BC;
        Sat, 28 Nov 2020 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606579205;
        bh=tIKRhWls3YzYhbVGldXSkrWMmSCjQfXBQFEelNA1aWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rnm00mPizeX5NU8jciZzzV3em6AJ98QA8A5sG7mzGPah20ZRauHQ6W6P5B05yGeqh
         C0EyTSQjMtntaUCjrRaWhI+gtvOU07+MWkkFUSZnfCKj8G7zBaBgJ5wzIMA09DGmwi
         Cqi36nVkWJEB9aDGNWyJwHlTNVCU+5QquZH7qYBw=
Date:   Sat, 28 Nov 2020 16:00:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] device: provide devm_krealloc_array()
Message-ID: <20201128160000.5ac0ddc6@archlinux>
In-Reply-To: <CAMRc=Mfa2Y65CW8YO_poRgrN9aPjLz=MXYrn7OPUEfwB3mnZvA@mail.gmail.com>
References: <20201102142228.14949-1-brgl@bgdev.pl>
        <20201102142228.14949-2-brgl@bgdev.pl>
        <20201114154641.0258f4ee@archlinux>
        <X7ADFLwEpUHkTiT+@kroah.com>
        <CAMpxmJUHiNqKNVDxaWLeDja6huR78u1Hp7JHF_aP5L_UgjYzbg@mail.gmail.com>
        <CAMRc=Mfa2Y65CW8YO_poRgrN9aPjLz=MXYrn7OPUEfwB3mnZvA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Nov 2020 12:38:26 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Mon, Nov 16, 2020 at 11:18 AM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> >
> > On Sat, Nov 14, 2020 at 5:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:  
> > >
> > > On Sat, Nov 14, 2020 at 03:46:41PM +0000, Jonathan Cameron wrote:  
> > > > On Mon,  2 Nov 2020 15:22:25 +0100
> > > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >  
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > >
> > > > > When allocating an array of elements, users should check for
> > > > > multiplication overflow or preferably use one of the provided helpers
> > > > > like: devm_kmalloc_array().
> > > > >
> > > > > This provides devm_krealloc_array() for users who want to reallocate
> > > > > managed arrays.
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>  
> > > >
> > > > +CC Greg KH.
> > > >
> > > > As this is going into a very generic place I'd like a relevant ack.
> > > > That file is a bit of a wild west for acks, but Greg seems most
> > > > appropriate person.
> > > >
> > > > So Greg, any comments on this one?  
> > >
> > > As there is only 1 user of this function in the patch series, you don't
> > > save any extra code space here, I don't think this is worth it.
> > >  
> >
> > It's worth it in that the overflow check before allocation doesn't
> > seem to belong in a driver IMO but is a general check that should live
> > in common code.
> >  
> > > We are seeing less and less gains from these new devm_* additions, and
> > > only more confusion and problems with them.  So perhaps don't add this?
> > > I don't think it is needed.
> > >  
> >
> > I think you're referring to the discussion on
> > devm_platform_ioremap_resource()? I would argue that consolidation of
> > common operations in helpers is rarely a bad thing but it's a
> > discussion for another thread.
> >
> > I'm not too attached to this patch - if you think this should be
> > dropped then fine, but I don't see how the name devm_krealloc_array()
> > can confuse anyone.
> >  
> 
> Greg: what's the final call on this?

Reroll the series without this patch.  If it turns out to be a good idea
in the long run we can always bring it back, but for now it's blocking
the rest of the series.

Thanks,

Jonathan

> 
> Bartosz

