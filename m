Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F33C298D
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhGITZg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGITZg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 15:25:36 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66230C0613DD;
        Fri,  9 Jul 2021 12:22:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t19so10400280qkg.7;
        Fri, 09 Jul 2021 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=vQkGzinhkqT/iZv4cDuuh/s29v6DWdWXkPVZxeAxu60=;
        b=Bm0yOPvHvaihbWpTL3H1l+ncNdcvgWc4HLdCWsrd/V09y4anp3ctzRfTDNaMa5yz60
         24ZGQLQVCFbYmj1Qg/jlkTrxjdAzafdpzNMro9XGXCVRNLvjKC5Qs7OOAnaR3W1SczDC
         +Dz4I4u9MJq2FMdkVxcTyj2s+T76og+T6HGuRHxRQWiB6OGMt65syWouXHWFUPnI6kVJ
         MjjSunieobs3Je53tubo1UvhKsCdxH4N3hQMBYM2NfzYja7l3UQ7nMfscgfrgT39rYQl
         BdXCg6mtIjfHLGStXTe+53AD8nk87apX37lrtA2xG2vm5bDP20+e1Yb2GC/ES5JGJ5LK
         CQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=vQkGzinhkqT/iZv4cDuuh/s29v6DWdWXkPVZxeAxu60=;
        b=Yy3IwEclB+MKed7mdt8v/plL6XWY3Gt1DQbt/mteQuWn6MBkZudA3CdDA8zpRexs9W
         DYMyVcDFCeblBDU8r1pIuJNSz4XkfJU87PK7OeZajdbRSPiSRmZPkcCYEZZr4AgzNOZq
         j1O0qKXGOzJW4uAqZCPp22jtkFLYjigQxwXhDO2t7qHHkmhnklnLW2eJx2N4HK13VI6o
         JV3EHMQ1pIWhPGziUzmEKL1SYvmBWOFMhft/nXla1cgbEKNo51F+70eqii6xNu+YyVne
         O+VkW2ob1Vr6vjlY/8CRfGJJNac00QkR7la2VDf1HRV0NsVHldAUPcsusv1t/0cTC9XU
         JhnQ==
X-Gm-Message-State: AOAM5319UQOuiQZ+hlnp6R/HWrIkvCCdNmPcc22PI8aPN5X7DGoRM4li
        8y8oYu72D8RW0cc47IVTpXw=
X-Google-Smtp-Source: ABdhPJwBIyu/zhah/lD711nISLAwXF9sBZyt8KUBqq/nMgK5fMnwp05EBd1Sf3hS8EzBjiqSv7EMlw==
X-Received: by 2002:a37:a402:: with SMTP id n2mr29946484qke.103.1625858570562;
        Fri, 09 Jul 2021 12:22:50 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id a20sm2905063qkg.44.2021.07.09.12.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 12:22:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jul 2021 15:22:48 -0400
Message-Id: <CCOURFCFL6YC.1SGV7KHPWGIEI@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v4 04/10] iio: afe: rescale: reduce risk of integer
 overflow
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-5-liambeguin@gmail.com>
 <13409f37-ecd4-5afb-e1ca-59f1f1f805b8@axentia.se>
In-Reply-To: <13409f37-ecd4-5afb-e1ca-59f1f1f805b8@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 9, 2021 at 12:24 PM EDT, Peter Rosin wrote:
>
> On 2021-07-06 18:09, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Reduce the risk of integer overflow by doing the scale calculation with
> > 64bit integers and looking for a Greatest Common Divider for both parts
> > of the fractional value.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 774eb3044edd..ba3bdcc69b16 100644
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
> > @@ -67,8 +68,13 @@ static int rescale_read_raw(struct iio_dev *indio_de=
v,
> >  		}
> >  		switch (ret) {
> >  		case IIO_VAL_FRACTIONAL:
> > -			*val *=3D rescale->numerator;
> > -			*val2 *=3D rescale->denominator;
> > +			tmp =3D (s64)*val * rescale->numerator;
> > +			tmp2 =3D (s64)*val2 * rescale->denominator;
> > +			factor =3D gcd(tmp, tmp2);

Hi Peter,

>
> Hi!
>
> gcd() isn't exactly free. I do not think it is suitable to call it for
> each
> and every value. So, if you really need it, then it should only be used
> when there is an actual overflow (or if there is a high risk if that's
> somehow easier).

Understood, digging into this a little bit, it seems like
check_mul_overflow() could be used here.

I'll give it a try and will look at implementing Jonathan's suggestion
in case we're dealing with a case where gcd() returns 1.

Thanks,
Liam

>
> Cheers,
> Peter
>
> > +			do_div(tmp, factor);
> > +			*val =3D tmp;
> > +			do_div(tmp2, factor);
> > +			*val2 =3D tmp2;
> >  			return ret;
> >  		case IIO_VAL_INT:
> >  			*val *=3D rescale->numerator;
> >=20

