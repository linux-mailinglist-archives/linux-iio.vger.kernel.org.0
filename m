Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A895F34CDCE
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhC2KP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 29 Mar 2021 06:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC2KP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 06:15:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759BF6157F;
        Mon, 29 Mar 2021 10:15:28 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:15:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] iio:accel:adis16201: Fix wrong axis assignment that
 prevents loading
Message-ID: <20210329111534.532e08da@jic23-huawei>
In-Reply-To: <CA+U=DsqiYC7Gq3N_htgAmLrRXBvJtfV1urFoG2aYVf=G15hB9Q@mail.gmail.com>
References: <20210321182956.844652-1-jic23@kernel.org>
        <CA+U=DsqiYC7Gq3N_htgAmLrRXBvJtfV1urFoG2aYVf=G15hB9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Mar 2021 09:43:57 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Mar 21, 2021 at 8:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst running some basic tests as part of writing up the dt-bindings for
> > this driver (to follow), it became clear it doesn't actually load
> > currently.
> >
> > iio iio:device1: tried to double register : in_incli_x_index
> > adis16201 spi0.0: Failed to create buffer sysfs interfaces
> > adis16201: probe of spi0.0 failed with error -16
> >
> > Looks like a cut and paste / update bug.  Fixes tag obviously not accurate
> > but we don't want to bother carry thing back to before the driver moved
> > out of staging.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Give this has been broken a while I'm not going to rush it it as a
fix.  Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> > Fixes: 591298e54cea ("Staging: iio: accel: adis16201: Move adis16201 driver out of staging")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Himanshu Jha <himanshujha199640@gmail.com>
> > Cc: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/iio/accel/adis16201.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> > index 3633a4e302c6..fe225990de24 100644
> > --- a/drivers/iio/accel/adis16201.c
> > +++ b/drivers/iio/accel/adis16201.c
> > @@ -215,7 +215,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
> >         ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> >         ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
> >                         BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> > -       ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> > +       ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> >                         BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> >         IIO_CHAN_SOFT_TIMESTAMP(7)
> >  };
> > --
> > 2.31.0
> >  

