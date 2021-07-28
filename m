Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33383D8466
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 02:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhG1AHe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhG1AHd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 20:07:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBBC061757;
        Tue, 27 Jul 2021 17:07:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a19so160240qtx.1;
        Tue, 27 Jul 2021 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=MU3jANlfOxvUewMURaPZ62GKh1ipZIt9uFIBhlPll30=;
        b=e1c9xMABha1AOpEpVa/RWVyGtruwnMZG5L9tgPalyfPFIJTqKk8Df4s1WlS4vNMQSO
         NX1b5gQxDc8kco04lM4otnj6MiILFVqQANvzs0atadHlAlw04CCvsUyjMiJm1S5WJOXS
         VWZ46qlC0nbSJwyPb29TU1e5JSV2TQnM3AUCCbCDt+6NyaRuZ+bEZziyev7RT7B2Nf/4
         f5lv3WH6sexp0mx1x2R7aLhGSDIlr54W+wQScUc6mc4NxcfD2S2HqEvhSvvBeaaFeDti
         vYrzXWUc1wpLpizecfYbgGfFeFElvKhvuhYg2D7v1FovH52m/HjWNhd03rvlwto7Huvn
         jRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=MU3jANlfOxvUewMURaPZ62GKh1ipZIt9uFIBhlPll30=;
        b=oEsOzL9meTxkLas8aUkpspXblyqcpB9/6wsT0XS34S0S6zmehEyjHYEZsCTebQT+wi
         ixZCVY9qwhCiyrhXPl8PAE+JicDigtiCqQSrmtN9vN35BOKJFB0EhXv6HXwMHzlcZF5/
         VhsVveBo+kUPpQHOZBHvhbvs2zTfSMLIqpPeAH1KaoA/V2PduV2yJ/SdIxTkEY6V1uVd
         QAYuGyY5iGeZmszAW882gM94STGhU5frUhPpOhI8j4UoJRcfch4y/LAku3cQVkKmPYPb
         fKUagvgzOJTXDq+KsiWJ7jTZJDfjxZJzKg5VdvEdLCgQXJ9lLlFnHQNYZpdrTpKaGCkf
         lfeA==
X-Gm-Message-State: AOAM5339yXr7HLd0SnW3KW/HwE1y8hARr2Y34VWgLVOjzkiCMd0ugJ9c
        vPlVqtbg+RLN/Sq5PTEr8DE=
X-Google-Smtp-Source: ABdhPJyNrLLnhtMiBV8jOZwmNpTcTfeLCv7VRU7GlYm2LOSTPgXl/kPsaPSRwcnJ8xCryGFgm4GnAQ==
X-Received: by 2002:ac8:74d7:: with SMTP id j23mr22067364qtr.212.1627430852297;
        Tue, 27 Jul 2021 17:07:32 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n25sm2513685qkh.21.2021.07.27.17.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 17:07:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jul 2021 20:07:30 -0400
Message-Id: <CD4C37PEMPOM.91UZ60Q6534Q@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v6 08/13] iio: afe: rescale: reduce risk of integer
 overflow
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-9-liambeguin@gmail.com>
 <9e0e4398-873e-b5c0-0f0c-50a186ed2228@axentia.se>
In-Reply-To: <9e0e4398-873e-b5c0-0f0c-50a186ed2228@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 23, 2021 at 5:17 PM EDT, Peter Rosin wrote:
> On 2021-07-21 05:06, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Reduce the risk of integer overflow by doing the scale calculation with
> > 64bit integers and looking for a Greatest Common Divider for both parts
> > of the fractional value when required.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 6f6a711ae3ae..35fa3b4e53e0 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -21,12 +21,21 @@
> >  int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  			  int *val, int *val2)
> >  {
> > -	unsigned long long tmp;
> > +	s64 tmp, tmp2;
> > +	u32 factor;
> > =20
> >  	switch (scale_type) {
> >  	case IIO_VAL_FRACTIONAL:
> > -		*val *=3D rescale->numerator;
> > -		*val2 *=3D rescale->denominator;
> > +		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> > +		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
> > +			tmp =3D (s64)*val * rescale->numerator;
> > +			tmp2 =3D (s64)*val2 * rescale->denominator;
> > +			factor =3D gcd(tmp, tmp2);

Hi Peter,

>
> Hi!
>
> Reiterating that gcd() only works for unsigned operands, so this is
> broken for
> negative values.

Apologies, I didn't mean to make it seem like I ignored your comments. I
should've added a note. After you pointed out that gcd() only works for
unsigned elements, I added test cases for negative values, and all tests
passed. I'll look into it more.

rescale_voltage_divider_props() seems to also use gcd() with signed
integers.

Thanks,
Liam

>
> Cheers,
> Peter
>
> > +			tmp =3D div_s64(tmp, factor);
> > +			tmp2 =3D div_s64(tmp2, factor);
> > +		}
> > +		*val =3D tmp;
> > +		*val2 =3D tmp2;
> >  		return scale_type;
> >  	case IIO_VAL_INT:
> >  		*val *=3D rescale->numerator;
> >=20

