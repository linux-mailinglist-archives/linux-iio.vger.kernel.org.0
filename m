Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AEC1E97E2
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgEaNoW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgEaNoV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:44:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6EF206F1;
        Sun, 31 May 2020 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590932660;
        bh=NM9N2okioutLDpllhGf5z7K6PUMzC9HYeGbZgFSXQEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JN26xv3fL5fOzCKe1ArDNTUPp1xcx9Haxi1ImD+i2XDp91x+QYg7m+mHpY4AdeP52
         V8jCPwMvG/StlS0sMrtjdvHCgo6HBhW0wEpCHwvndXnMV8BKpL6kDGSPI4CdWXy8rW
         HTBHY8hYVahM4ACLVDodDQPYpR5KUcJb3UhOaw7k=
Date:   Sun, 31 May 2020 14:44:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: dac: ad5380: Constify struct
 iio_chan_spec_ext_info
Message-ID: <20200531144416.33dbff82@archlinux>
In-Reply-To: <dfbaa1863b7bc3f69a184bb4d7b7ee7805f06e88.camel@analog.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
        <20200526210223.1672-3-rikard.falkeborn@gmail.com>
        <dfbaa1863b7bc3f69a184bb4d7b7ee7805f06e88.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 04:22:30 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2020-05-26 at 23:02 +0200, Rikard Falkeborn wrote:
> > [External]
> > 
> > ad5380_ext_info is not modified and can be made const to allow the
> > compiler to put it in read-only memory.
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   12060    3280     192   15532    3cac drivers/iio/dac/ad5380.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   12252    3088     192   15532    3cac drivers/iio/dac/ad5380.o
> >   
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
Applied.
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> >  drivers/iio/dac/ad5380.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> > index b37e5675f716..04c74cc1a4ec 100644
> > --- a/drivers/iio/dac/ad5380.c
> > +++ b/drivers/iio/dac/ad5380.c
> > @@ -240,7 +240,7 @@ static const struct iio_info ad5380_info = {
> >  	.write_raw = ad5380_write_raw,
> >  };
> >  
> > -static struct iio_chan_spec_ext_info ad5380_ext_info[] = {
> > +static const struct iio_chan_spec_ext_info ad5380_ext_info[] = {
> >  	{
> >  		.name = "powerdown",
> >  		.read = ad5380_read_dac_powerdown,  

