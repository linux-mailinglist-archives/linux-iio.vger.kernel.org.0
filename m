Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11690F5ED5
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfKILzZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 06:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfKILzZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 06:55:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A4C5207FF;
        Sat,  9 Nov 2019 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573300524;
        bh=z1soBy9NAqy5/dz3HxjryiA+YZGAJ0h1B0pagTmu464=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uhhq63ibHSgSl5sZkm+gJvHyv1VcRofdyHSqUTdn24ZNAAgQODeVpS/TeJENLcRAl
         UtjcoLZZ8ZWgnCn8u2ZJcCvwM8GpjIL0cOHsIHVU2XMXEPIfvm2KDQpHYFwYbBQJqj
         L7Vf81LSVn+HFxcNaNMgTJPWgzWkyjPARSjxJVnE=
Date:   Sat, 9 Nov 2019 11:55:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Stein <alexander.stein@systec-electronic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iio: core: Fix fractional format generation
Message-ID: <20191109115519.14ba0bdc@archlinux>
In-Reply-To: <4116142.9TFg0imz4M@ws-140106>
References: <20190822060607.25339-1-alexander.stein@systec-electronic.com>
        <4116142.9TFg0imz4M@ws-140106>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 07 Nov 2019 14:54:52 +0100
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> Gentle ping
> 
> On Thursday, August 22, 2019, 8:06:07 AM CET Alexander Stein wrote:
> > In case the result is -0.3252 tmp0 is 0 after the div_s64_rem, so tmp0 is
> > non-negative which results in an output of 0.3252.
> > Fix this by explicitly handling the negative sign ourselves.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Apologies. I'd missed this v2 entirely for some reason.

It looks correct to me, but as Lars had inputs on v1...

Lars, could you take a quick look at this v2 and give an ack if
you are happy with it.

Thanks,

Jonathan

> > ---
> > Changes in v2:
> > * Support vals[0] >= and vals[1] < 0 in IIO_VAL_FRACTIONAL
> > * Note: IIO_VAL_FRACTIONAL is untested, as I lack hardware
> > * Note2: Currently IIO_VAL_FRACTIONAL is only called with vals[1] from
> >          in-kernel drivers AFAICS
> > 
> >  drivers/iio/industrialio-core.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 245b5844028d..247338142c87 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -568,6 +568,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
> >  {
> >  	unsigned long long tmp;
> >  	int tmp0, tmp1;
> > +	char *sign;
> >  	bool scale_db = false;
> >  
> >  	switch (type) {
> > @@ -593,11 +594,17 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
> >  		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> >  		tmp1 = vals[1];
> >  		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> > -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> > +		if (vals[1] < 0) {
> > +			sign = vals[0] >= 0 ? "-" : "";
> > +		} else {
> > +			sign = vals[0] < 0 ? "-" : "";
> > +		}
> > +		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
> >  	case IIO_VAL_FRACTIONAL_LOG2:
> > +		sign = vals[0] < 0 ? "-" : "";
> >  		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
> >  		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> > -		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> > +		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
> >  	case IIO_VAL_INT_MULTIPLE:
> >  	{
> >  		int i;
> >   
> 
> 

