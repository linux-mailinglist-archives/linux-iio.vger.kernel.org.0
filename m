Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C971F0736
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgFFPNE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 11:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFFPNE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 11:13:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323572073E;
        Sat,  6 Jun 2020 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591456383;
        bh=yw1R8hsp7uFM58J1K/Vd5IWGmoqQ1p7Bcgwbu0B9E3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j2rrAzD0CWobFE0w5a7qiZVAG6DfRTL4AdpL+yIaESjoUAmlXS6vRmebV/dWskS/G
         wuFO3nbntLLZ5nhD/DX3HbzlaF/Y322UCUPyrQEYoM1QEdDgA1gLn05BVWWULdOQGg
         px9BV1/SwCrkrrhlIOksrbXxsZfkbDVWC/ccYVxg=
Date:   Sat, 6 Jun 2020 16:12:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "hslester96@gmail.com" <hslester96@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.cercueil@analog.com" <paul.cercueil@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v3] iio: amplifiers: ad8366: Change devm_gpiod_get() to
 optional and add the missed check
Message-ID: <20200606161259.146eb221@archlinux>
In-Reply-To: <36f033adf9b53adb289e7569ea5fca647c0dbb7a.camel@analog.com>
References: <20200603092610.1424489-1-hslester96@gmail.com>
        <36f033adf9b53adb289e7569ea5fca647c0dbb7a.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jun 2020 10:19:12 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-06-03 at 17:26 +0800, Chuhong Yuan wrote:
> > Since if there is no GPIO, nothing happens, replace devm_gpiod_get()
> > with devm_gpiod_get_optional().
> > Also add IS_ERR() to fix the missing-check bug.
> >   
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied with layout tweaked a bit as per Markus' comment which made
sense in this particular case.

I also tweaked the description to say "missing-check" warning given
as we've established the failure to check for an error wasn't a problem
as such.  On that basis I thought about dropping the fixes tag, but
it's 'sort' of a fix so I'll leave it there.  Not sending this the
fast path however as is not urgent (shout if you disagree!)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > Fixes: cee211f4e5a0 ("iio: amplifiers: ad8366: Add support for the ADA4961
> > DGA")
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v3:
> >   - Change devm_gpiod_get() to optional.
> >   - Modify description.
> > 
> >  drivers/iio/amplifiers/ad8366.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> > index 62167b87caea..8819e8997f76 100644
> > --- a/drivers/iio/amplifiers/ad8366.c
> > +++ b/drivers/iio/amplifiers/ad8366.c
> > @@ -262,8 +262,12 @@ static int ad8366_probe(struct spi_device *spi)
> >  	case ID_ADA4961:
> >  	case ID_ADL5240:
> >  	case ID_HMC1119:
> > -		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
> > +		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> >  			GPIOD_OUT_HIGH);
> > +		if (IS_ERR(st->reset_gpio)) {
> > +			ret = PTR_ERR(st->reset_gpio);
> > +			goto error_disable_reg;
> > +		}
> >  		indio_dev->channels = ada4961_channels;
> >  		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
> >  		break;  

