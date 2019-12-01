Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2923C10E1B7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 12:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLALmS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 06:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLALmS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 06:42:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD5E20833;
        Sun,  1 Dec 2019 11:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575200537;
        bh=kszPCwKwRkGgz8VWT8Gr1cfkhsnDvbBxXBsC7fR5klM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rY9Q1SSJejMbemXU90YSUx4gFV5SCAmusUXAs/KPEQeDcQCpbgmY3e6SaSzEnaPIr
         2YvTAOa3wTB/13IbN0q3ChrX3G91U2ofep3GcsO4PDmx+3s5WWKLVfVwsyHBR/us/+
         xR6O+WnAIPshGjNtfNIcdYJJrInDs6VOq+hezvHA=
Date:   Sun, 1 Dec 2019 11:42:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] staging: iio: accel: adis16240: enforce SPI mode
 on probe function
Message-ID: <20191201114212.08a068fc@archlinux>
In-Reply-To: <2e62b4fa3ee93909bfcdc4d9b60015e7c22d510c.camel@analog.com>
References: <20191123233510.4890-1-rodrigorsdc@gmail.com>
        <2e62b4fa3ee93909bfcdc4d9b60015e7c22d510c.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Nov 2019 07:55:39 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sat, 2019-11-23 at 20:35 -0300, Rodrigo Carvalho wrote:
> > [External]
> > 
> > According to the datasheet, this driver supports only SPI mode 3,
> > so we should enforce it and call spi_setup() on probe function.
> > 
> > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > ---
> > V5:
> >   - Add this patch to the patchset
> > 
> >  drivers/staging/iio/accel/adis16240.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16240.c
> > b/drivers/staging/iio/accel/adis16240.c
> > index 82099db4bf0c..77b6b81767b9 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -400,6 +400,13 @@ static int adis16240_probe(struct spi_device *spi)
> >  	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> > +	spi->mode = SPI_MODE_3;  
> 
> A generic question from me here, since I am not sure.
> 
> Would this limit the configurations of this chip on the board?
> In case there is some level-inverter [for various weird reasons] on the
> board, this may not work, because the SPI controller would need CPOL to be
> 0.
> 
> Not sure if this question is valid, or whether we need to care about such
> configurations.

It's a good question as this sort of trick is used sometimes. Let's see
what responses we get to the other branch of this thread before moving forwards
with this.

Jonathan


> 
> Thanks
> Alex
> 
> > +	ret = spi_setup(spi);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "spi_setup failed!\n");
> > +		return ret;
> > +	}
> > +
> >  	ret = adis_init(st, indio_dev, spi, &adis16240_data);
> >  	if (ret)
> >  		return ret;  

