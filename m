Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38BDCC9F6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfJEMiw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 08:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbfJEMiv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 08:38:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388612133F;
        Sat,  5 Oct 2019 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570279131;
        bh=VBW8SruB0OHMJ/REwqMINb/g50jgB8SaQW0+O0OXaLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mE9fMdBjUYX5Zkm2V+pu1EOSF3YGBeu+4xcObg6av+nQ8BX/3KO5SsIJpcfvwzrOj
         gBPBguRNvjakBBplxJhAdol+L6bLwFzVMuzwPOz9yfkkl5V2DJzE9eYvdCuT5/ONp6
         rWTorMW6vKzaWZNhrVDcVsY1JY3clkEn5AOPlpPE=
Date:   Sat, 5 Oct 2019 13:38:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ad799x: fix probe error handling
Message-ID: <20191005133846.6de638d6@archlinux>
In-Reply-To: <8405aec02752668bee7563e8c86c225c55f6705b.camel@analog.com>
References: <20190917160925.9791-1-m.felsch@pengutronix.de>
        <20190917160925.9791-2-m.felsch@pengutronix.de>
        <8405aec02752668bee7563e8c86c225c55f6705b.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Sep 2019 06:29:19 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-09-17 at 18:09 +0200, Marco Felsch wrote:
> > [External]
> > 
> > Since commit 0f7ddcc1bff1 ("iio:adc:ad799x: Write default config on probe
> > and reset alert status on probe") the error path is wrong since it
> > leaves the vref regulator on. Fix this by disabling both regulators.
> >   
> 
> Good catch.
> Many thanks :)
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Obviously this may delay the other two patches which will get queued
up for the next merge window, but as we have plenty of time that shouldn't
be an issue.

Thanks,

Jonathan

> 
> > Fixes: 0f7ddcc1bff1 ("iio:adc:ad799x: Write default config on probe and
> > reset alert status on probe")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/iio/adc/ad799x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index 5a3ca5904ded..f658012baad8 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -810,10 +810,10 @@ static int ad799x_probe(struct i2c_client *client,
> >  
> >  	ret = ad799x_write_config(st, st->chip_config->default_config);
> >  	if (ret < 0)
> > -		goto error_disable_reg;
> > +		goto error_disable_vref;
> >  	ret = ad799x_read_config(st);
> >  	if (ret < 0)
> > -		goto error_disable_reg;
> > +		goto error_disable_vref;
> >  	st->config = ret;
> >  
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,  

