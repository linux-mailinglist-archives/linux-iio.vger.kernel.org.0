Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661BC270DD8
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISMNI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 08:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgISMNI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 08:13:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E994B2100A;
        Sat, 19 Sep 2020 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600517588;
        bh=FdjoHzBqdxfA3CxLo3N6Wg3cZlWs5fLQmVZq3zJiU80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWh1ldn+WsoBN+8yRMJN0egouYZ6EISrWnuLpQLBglW77GaoNRgHa/KBpJJBw3m0W
         0WIbG9CXuILWYyzPXyTDap+Rdw1muUXquPWLxhIHcSedbc7yja6Ej1PQM2HAHiPUfo
         Ps/9BzLGWQg9rDp1pM4r/LdTcUaStBQpc/wuNw9o=
Date:   Sat, 19 Sep 2020 13:13:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] iio:accel:bma180: Fix use of true when should be
 iio_shared_by enum
Message-ID: <20200919131303.3475c7db@archlinux>
In-Reply-To: <9a5b9bf3-28e9-9643-0924-a7b33e339032@metafoo.de>
References: <20200913121227.764626-1-jic23@kernel.org>
        <9a5b9bf3-28e9-9643-0924-a7b33e339032@metafoo.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 15:36:58 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 9/13/20 2:12 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Given a value of 1 corresponds to IIO_SHARE_BY_TYPE I have replaced
> > it with that.  Should cause no functional change.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Jonathan Bakker <xc-racer2@live.ca>  
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks. Applied to the togreg branch of iio.git.
I haven't marked it for stable because it has not material affect.
Not a problem if it gets picked up anyway of course!

Thanks,

Jonathan

> 
> 
> > ---
> >   drivers/iio/accel/bma180.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index 448faed001fd..6b74c2b04c15 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
> >   };
> >   
> >   static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
> > -	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
> > +	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
> >   	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
> >   	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
> >   	{ }  
> 
> 

