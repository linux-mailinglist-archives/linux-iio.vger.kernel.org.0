Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854E3DCF00
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439950AbfJRTFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 15:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729632AbfJRTFH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Oct 2019 15:05:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB262070B;
        Fri, 18 Oct 2019 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425506;
        bh=c/HX1CuX3Upg++SGEQmiNoSxkbx9YNXSWSSLqbeRNM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RAzjX1pQIjjjEategswHNbr91b5eJxtPBEs7eK4SUHLXZqfaF/JmGiNQuMe5BndNr
         6nnHUEoQEwmCPbFyHvLFGvG2+DlpswM1CbPZKsvnvCl2MDTkJq38h0xcyB2F0Dt+Zo
         uaJxQRy0G9o1brXH2T9QgTaixAlmufl2/FPBkY0Y=
Date:   Fri, 18 Oct 2019 20:04:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: temp: maxim thermocouple: Drop unneeded semi
 colon.
Message-ID: <20191018200459.4ff4d84a@archlinux>
In-Reply-To: <CAJCx=g=EABNtJ8FBda0ty4cM+HstuQda_ChTf0vEajdW7opLoQ@mail.gmail.com>
References: <20191013181013.2399842-1-jic23@kernel.org>
        <CAJCx=g=EABNtJ8FBda0ty4cM+HstuQda_ChTf0vEajdW7opLoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Oct 2019 22:12:40 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Oct 13, 2019 at 9:12 PM <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Identified by coccinelle
> >
> > CHECK   drivers/iio/temperature/maxim_thermocouple.c
> > drivers/iio/temperature/maxim_thermocouple.c:197:3-4: Unneeded semicolon
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/temperature/maxim_thermocouple.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> > index 2ab68282d0b6..d1360605209c 100644
> > --- a/drivers/iio/temperature/maxim_thermocouple.c
> > +++ b/drivers/iio/temperature/maxim_thermocouple.c
> > @@ -194,7 +194,7 @@ static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
> >                 default:
> >                         *val = 250; /* 1000 * 0.25 */
> >                         ret = IIO_VAL_INT;
> > -               };
> > +               }
> >                 break;
> >         }
> >
> > --
> > 2.23.0
> >  

