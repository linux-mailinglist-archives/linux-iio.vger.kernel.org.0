Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5154C116359
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2019 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLHSK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Dec 2019 13:10:26 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33392 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSK0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Dec 2019 13:10:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BD8129E74D9;
        Sun,  8 Dec 2019 18:10:22 +0000 (GMT)
Date:   Sun, 8 Dec 2019 18:10:20 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        <rwoerle@mibtec.de>
Subject: Re: [PATCH] iio: adc: ad7606: fix reading unnecessary data from
 device
Message-ID: <20191208181020.26c165de@archlinux>
In-Reply-To: <20191110104625.346152de@archlinux>
References: <20191104162634.5394-1-beniamin.bia@analog.com>
        <20191110104625.346152de@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Nov 2019 10:46:25 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 4 Nov 2019 18:26:34 +0200
> Beniamin Bia <beniamin.bia@analog.com> wrote:
> 
> > When a conversion result is being read from ADC, the driver reads the
> > number of channels + 1 because it thinks that IIO_CHAN_SOFT_TIMESTAMP
> > is also a physical channel. This patch fixes this issue.
> > 
> > Fixes: 552a21f35477 ("staging: iio: adc: ad7606: Move out of staging")
> > Reported-by: Robert Wörle <rwoerle@mibtec.de>
> > Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>  
> Applied to the fixes-togreg branch of iio.git and marked for stable.
I was just about to send the pull including this and was checking the
fixes tags.  The commit you have here doesn't seem to exist.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/adc/ad7606.c?id=2985a5d88455a3edd51358fc77f61b684d0e9265
Seems to be the right one.

I've fixed it up.

Jonathan

> 
> We are at that point in the cycle where I 'might' move this into
> the togreg branch for the merge window.  All depends on what Linus
> says in his rc7 email that'll probably be out later today.
> Previously he hinted we'd have an rc8 this time. If that happens
> I'll do one last pull request and hence take the queued up fixes
> in with that for the merge window.  I don't have anything critical
> enough to do a fixes pull this later in the cycle.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ad7606.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index f5ba94c03a8d..e4683a68522a 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -85,7 +85,7 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
> >  
> >  static int ad7606_read_samples(struct ad7606_state *st)
> >  {
> > -	unsigned int num = st->chip_info->num_channels;
> > +	unsigned int num = st->chip_info->num_channels - 1;
> >  	u16 *data = st->data;
> >  	int ret;
> >    
> 

