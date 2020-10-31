Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820CB2A1566
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgJaLKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 07:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgJaLKI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 07:10:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404D2206E5;
        Sat, 31 Oct 2020 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604142607;
        bh=hkzEJUaBNUIIhzqu5SpbfUySyKicS5nTmpJjPg4g8ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oMhFeuoiz6y/py4aJtruc8WUCabyz5uMV3F4wOO8o+FvQKlVS4gHVV/N3mIlaRjBD
         /cMQ0V+G8RfzpF2f4GtpDkG+6Cn0TsX1F1wRFNwFAdVjAU2B10iVCvrbhQlAujyjE9
         7VhZFhjgCW127opGjkZJ63lsYiRaEzErG0zAy8nw=
Date:   Sat, 31 Oct 2020 11:10:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 4/5] iio: adc: xilinx: use devres for irq handling
Message-ID: <20201031111003.75a4f6d0@archlinux>
In-Reply-To: <CAMRc=Mfun85W+ZfJqaXohCQ8tNGDxjxmvdFuwsQ07jMhG+vU7w@mail.gmail.com>
References: <20201026133609.24262-1-brgl@bgdev.pl>
        <20201026133609.24262-5-brgl@bgdev.pl>
        <20201029154118.12fd6c23@archlinux>
        <CAMRc=Mfun85W+ZfJqaXohCQ8tNGDxjxmvdFuwsQ07jMhG+vU7w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Oct 2020 11:52:00 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Thu, Oct 29, 2020 at 4:41 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 26 Oct 2020 14:36:08 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Further simplify the remove() callback and error paths in probe() by
> > > using the managed variant of request_irq() as well as using a devm action
> > > for cancelling the delayed work at driver detach.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>  
> >
> > Again, this is potentially fine but I'd rather you cleaned up the ordering first
> > rather than doing things in this order.
> >
> > The end result of the whole series looks like it will be correct, but that isn't
> > so obvious for the intermediate patches on their own.
> >
> > Also, you end up with a lot of noise renaming gotos that then go away at the
> > end.
> >
> > Jonathan
> >  
> 
> Hi Jonathan,
> 
> My two priorities for the ordering of this series were: correct
> end-result and not breaking anything on the way. The latter
> unfortunately gets in the way of cleaner looking intermediate patches.
> 
> I tried to not alter the ordering in which the resources are freed at
> any step. As devres release callbacks are called *after* remove() and
> in a reverse order to how they were registered, I needed to start from
> the bottom of the remove() callback and convert the last operation,
> then go upwards from there.
> 
> If I tried to do it from the top - I probably could remove labels
> earlier and in a cleaner manner but it wouldn't guarantee
> bisectability.
> 

Maybe best plan is to squash last 3 patches into one?

I suspect that's going to be easier to review.

Jonathan


> Bartosz

