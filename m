Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B944A3BB621
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 06:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGEE0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 00:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEE0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 00:26:39 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89EC061574;
        Sun,  4 Jul 2021 21:24:01 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c13so11417369qtb.12;
        Sun, 04 Jul 2021 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=4xLD0xnPHmSCI5wig2OoEO1eCTmstt0nYltLi+2xt6Y=;
        b=Tbq9KuFAIF0eI7BVFPWJgct0akp9rsfmNjtohh1Lg/p/9/+os5CFrGeeMubE+GmFV+
         U9eLXwS7Fioqge4JL9rWmONyxZ1thvgl4D4pes6FgigtubxFu+k0xjzDf9mmgMRKiN41
         YKVNOULitCXnSIkhIQ6rQE2arsI4KfAMH+fUnVVpK/uQYjG1SnGtN2XAcC9zFj+b2FGI
         HQVW8UnaR21o7GrzlHkFvs+vHCYp/ls6MRIuduuWGMolRmGhsskHVO+R80cCDGNFDYrN
         kJgnz4Opacy0jiXVL/ErHg4YXSsl6ZxhC73MxNuzmVQ+hSWbW28Q379b6brzw8J/VDFW
         DmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=4xLD0xnPHmSCI5wig2OoEO1eCTmstt0nYltLi+2xt6Y=;
        b=J03F/feyPviyq35zoKkVS88VtWzRENDOJeeceNBiW3GqDS4AZUTgBUBVTN6O0djEcK
         HxBKBdbs6IgS1TIknNZsOUx74Ll41uk2QvtKh2bXPVYZ2o/zbVk2APWZEEPmuSQMgi3A
         SgfK/iOXgqcpR1qMBHYwaEia1ichG+Mk6nyMZC9+aZy/OrUddA1Fwv9oUrKi8IISWnEi
         np9V6agRT+SGmbccqGwMN7a1dmnsTebK9lbw28QSxMZHWAe9s+bDeDuuTkT5oUHnx6Nc
         SFx7dj47amX3gecCD0QvdKXd8YMPgDUMW5KQ9frFKqVxOsH5fD7w/92SoT4ZxpPptzQZ
         SkhQ==
X-Gm-Message-State: AOAM530yd26xPb28J3J3DcI2pR9/YUTydiwxIKo0lNzcjfVuqAKKlVkX
        BgSiXeros9u7PQQDPYD8zcA=
X-Google-Smtp-Source: ABdhPJwAfFo0gp++mPNwF026WIrfqwNzFA7FAsBvdRi1szO2vw/QZRoQOkzF0C+2bl/IgpBYbRcPuQ==
X-Received: by 2002:a05:622a:c2:: with SMTP id p2mr11225550qtw.83.1625459041011;
        Sun, 04 Jul 2021 21:24:01 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j3sm4164784qth.63.2021.07.04.21.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 21:24:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 05 Jul 2021 00:23:59 -0400
Message-Id: <CCKX5239AEWI.3T3JF9PXHIESQ@shaak>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 04/10] iio: afe: rescale: reduce risk of integer
 overflow
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210701010034.303088-1-liambeguin@gmail.com>
 <20210701010034.303088-5-liambeguin@gmail.com>
 <20210704173639.622371bf@jic23-huawei>
In-Reply-To: <20210704173639.622371bf@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun Jul 4, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> On Wed, 30 Jun 2021 21:00:28 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Reduce the risk of integer overflow by doing the scale calculation with
> > 64bit integers and looking for a Greatest Common Divider for both parts
> > of the fractional value.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 774eb3044edd..98bcb5d418d6 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev=
,
> >  			    int *val, int *val2, long mask)
> >  {
> >  	struct rescale *rescale =3D iio_priv(indio_dev);
> > -	unsigned long long tmp;
> > +	s64 tmp, tmp2;
> > +	u32 factor;
> >  	int ret;
> > =20
> >  	switch (mask) {
> > @@ -67,8 +68,11 @@ static int rescale_read_raw(struct iio_dev *indio_de=
v,
> >  		}
> >  		switch (ret) {
> >  		case IIO_VAL_FRACTIONAL:
> > -			*val *=3D rescale->numerator;
> > -			*val2 *=3D rescale->denominator;
> > +			tmp =3D (s64)*val * rescale->numerator;
> > +			tmp2 =3D (s64)*val2 * rescale->denominator;
> > +			factor =3D gcd(tmp, tmp2);
>
> Hmm. I wonder if there are cases where this doesn't work and we end up
> truncating because the gcd is say 1. If all of val, val2,
> rescale->numerator,
> rescale->denominator are primes and the rescale values are moderately
> large
> then that might happen. We probably need a fallback position. Perhaps
> check tmp / factor and temp2/factor will fit in an int. If not, shift
> them until
> they do even if we have to dump some precision to do so.
>

I see what you mean. If we want to do that I guess it would also apply
to other areas of the driver.

> This stuff is getting fiddly enough we might want to figure out some
> self tests
> that exercise the various cases.
>

I never implemented kernel self tests before, I guess it should follow
the example of drivers/iio/test/iio-test-format.c?

Would you be okay to add this in a follow up series?

> > +			*val =3D tmp / factor;
> > +			*val2 =3D tmp2 / factor;
>
> This is doing 64 bit numbers divided by 32 bit ones. Doesn't that
> require
> use of do_div() etc on 32 bit platforms?
>

Apologies for that mistake, will fix.

> >  			return ret;
> >  		case IIO_VAL_INT:
> >  			*val *=3D rescale->numerator;

