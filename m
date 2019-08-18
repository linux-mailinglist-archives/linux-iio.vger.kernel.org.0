Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C327991936
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 21:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfHRTN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 15:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRTN5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 15:13:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970592184E;
        Sun, 18 Aug 2019 19:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566155636;
        bh=cx09dZ53SV60ZZEaD7lshSO/Q3ktfWm45yk+k4iQzc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nxBG3zF1PDXZwLKq9WFDEx+fpwnhWJTRldJzxCK2sizv8mx4uJYvwyAhoem8rERZi
         5KaweEQflko+bBjNYA34wtMYENDZdwJxaEllq9xcwojhNcKJSehMvSOye/dY+DxuC4
         y8rHw3BOJMnA9zeTgvPbyVMQzgg802JDlwcdsQgk=
Date:   Sun, 18 Aug 2019 20:13:51 +0100
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] staging: iio: accel: adis16240: Improve readability
 on write_raw function
Message-ID: <20190818201351.10ea83a2@archlinux>
In-Reply-To: <28dda97db73c56fbaf746aa52eb63faaf02b15d7.camel@analog.com>
References: <20190813193101.26867-1-rodrigorsdc@gmail.com>
        <28dda97db73c56fbaf746aa52eb63faaf02b15d7.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Aug 2019 06:56:18 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-08-13 at 16:31 -0300, Rodrigo Ribeiro wrote:
> > [External]
> > 
> > Replace shift and minus operation by GENMASK macro and remove the local
> > variables used to store intermediate data.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> > Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
> > ---
> > v2:
> >    - Leave switch statement instead of replace by if statement
> >  drivers/staging/iio/accel/adis16240.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> > index 62f4b3b1b457..82099db4bf0c 100644
> > --- a/drivers/staging/iio/accel/adis16240.c
> > +++ b/drivers/staging/iio/accel/adis16240.c
> > @@ -309,15 +309,12 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
> >  			       long mask)
> >  {
> >  	struct adis *st = iio_priv(indio_dev);
> > -	int bits = 10;
> > -	s16 val16;
> >  	u8 addr;
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_CALIBBIAS:
> > -		val16 = val & ((1 << bits) - 1);
> >  		addr = adis16240_addresses[chan->scan_index][0];
> > -		return adis_write_reg_16(st, addr, val16);
> > +		return adis_write_reg_16(st, addr, val & GENMASK(9, 0));
> >  	}
> >  	return -EINVAL;
> >  }  

