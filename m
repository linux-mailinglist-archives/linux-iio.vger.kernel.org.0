Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596DB25EE7A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgIFPRr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgIFPRq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:17:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21D420714;
        Sun,  6 Sep 2020 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599405466;
        bh=lbjXajpDwp46rCIbmdhYv2vqZL2+1OeF2q40klnYeLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vp9++8NngrPkXT2V7R0jX5vrQ7yyyFx+ADzDOUTtYUgNyoi1HZMYtoqjSOqP0apkw
         9UmjeTFocipI+zcNuOMgK3QxOEUwn4C/UkNb64LLgXE3scjUv14jDUYkY0E7XSNU5i
         EtETG2ykzgOPoTDUqiV+vpQYg8043olr8dGYoSJc=
Date:   Sun, 6 Sep 2020 16:17:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: Fix typo in device name
Message-ID: <20200906161741.383dfce0@archlinux>
In-Reply-To: <CAHp75VcYVsFtiHYfy4pzsZdDWOEToU1mf2KmQ2BaEtrVbPy8kA@mail.gmail.com>
References: <20200902134222.28357-1-mircea.caprioru@analog.com>
        <CAHp75VcYVsFtiHYfy4pzsZdDWOEToU1mf2KmQ2BaEtrVbPy8kA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Sep 2020 21:05:56 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 2, 2020 at 4:45 PM Mircea Caprioru
> <mircea.caprioru@analog.com> wrote:
> >
> > This patch fixes the device name typo.
> >  
> 
> Luckily it's part of v5.9-rcX, so if Jonathan sends this within v5.9
> time frame, we are good.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Should be plenty of time. :) (famous last words)

Jonathan

> 
> 
> > Fixes: 951ad4700313 ("iio: adc: ad7124: move chip ID & name on the chip_info table")
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > ---
> >  drivers/iio/adc/ad7124.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 8dce06e9e69c..766c73333604 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -177,12 +177,12 @@ static const struct iio_chan_spec ad7124_channel_template = {
> >
> >  static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
> >         [ID_AD7124_4] = {
> > -               .name = "ad7127-4",
> > +               .name = "ad7124-4",
> >                 .chip_id = CHIPID_AD7124_4,
> >                 .num_inputs = 8,
> >         },
> >         [ID_AD7124_8] = {
> > -               .name = "ad7127-8",
> > +               .name = "ad7124-8",
> >                 .chip_id = CHIPID_AD7124_8,
> >                 .num_inputs = 16,
> >         },
> > --
> > 2.25.1
> >  
> 
> 

