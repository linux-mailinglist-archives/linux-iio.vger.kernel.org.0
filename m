Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA113C29B6
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGITdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGITdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 15:33:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF9C0613DD;
        Fri,  9 Jul 2021 12:30:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x6so5081708qvx.4;
        Fri, 09 Jul 2021 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=ka0EYaX/8sYKpgYqTC2W9F71XAv6lfSFEDivZvKcKm4=;
        b=ueCDPZwDb58qafDGK/oiMJ+U2GkuM/j6USTqAXp1IWndU15dsCcnKWoqexQ5MLY1Bc
         fj6QQL2n7NUCXmzD7WyZJhjOFuH/+6s9+2KUopsjbMdqpoQJiDNVcm3sv7B8srJMfDor
         wHYbE+RWl66KUIlSog8YZjO3/c8BSKk9gRVfxjEXw3olRnIlNSY+h5Tf/4fOtGJvHWTu
         v6osPMntfJTmwL5uA/sEIFCWf0bM7QLcQibbrhT6kJBtsMJdZligzYGUYlvxqel73hwU
         2CajPRGdykoaGEGZEd1fsMjVINHbJUP1+tNXfEYDjz+xnHwYJE76eZTSb99bbZsLBYvs
         A1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=ka0EYaX/8sYKpgYqTC2W9F71XAv6lfSFEDivZvKcKm4=;
        b=WsVD5kWgo6Xp2b1OBVTSv4HjQxArftcXIbMg8+QuCIq1PvQxk5BShNvL3q3mIWr4L+
         /O1U2MFmQqv6k9KrfLyrIb8HV3uZI556aJz670a3WMQlf64C5ibqTLozoHkz+t65eAm8
         GsUAp9vHY6BIL/cQpK8Qr9Kj4pchRIfe20ACGFUXj8RUPWNFdpywxAhzngPXe9xIDT2L
         Ay1Hc+m+Whazx+kQwgju2AHjxpNqJi2aSiytQbxXEqkrXeCSo8ag9b0y33VweOf/vL9e
         fLkhOOWR30TjQKlReL+obikMoenli9Uc2HDjYn2d6inlW1b3XXzxvgkmAQYHbW2vDoGk
         m/ug==
X-Gm-Message-State: AOAM530i8vDofvjMHMLWBJ4EuZhfeSs/OHgcZJeVAfljjzyBwvieDsxi
        C6jDN+m5Jak3qQU4HpD85Dw=
X-Google-Smtp-Source: ABdhPJw/rKyYQnlDM/8zNrY43rEmbXzeOrbxZhKMC72Y4mWTvgzK+uGa9kxilaWUlQLp9Z/6XJsdZw==
X-Received: by 2002:a0c:f682:: with SMTP id p2mr37700010qvn.17.1625859024306;
        Fri, 09 Jul 2021 12:30:24 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id c2sm330034qtw.72.2021.07.09.12.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 12:30:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jul 2021 15:30:23 -0400
Message-Id: <CCOUX814CQ6U.XY2CIQKFE00V@shaak>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v4 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-6-liambeguin@gmail.com>
 <4be51a74-9913-291a-9dac-422ac23da3ea@axentia.se>
In-Reply-To: <4be51a74-9913-291a-9dac-422ac23da3ea@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 9, 2021 at 12:29 PM EDT, Peter Rosin wrote:
>
>
> On 2021-07-06 18:09, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
> > Scale the integer part and the decimal parts individually and keep the
> > original scaling type.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index ba3bdcc69b16..1d0e24145d87 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -89,7 +89,15 @@ static int rescale_read_raw(struct iio_dev *indio_de=
v,
> >  			do_div(tmp, 1000000000LL);
> >  			*val =3D tmp;
> >  			return ret;
> > +		case IIO_VAL_INT_PLUS_NANO:
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +			tmp =3D (s64)*val * rescale->numerator;
> > +			*val =3D div_s64(tmp, rescale->denominator);
> > +			tmp =3D (s64)*val2 * rescale->numerator;
> > +			*val2 =3D div_s64(tmp, rescale->denominator);
>

Hi Peter,

> Hi!
>
> You are losing precision, and you are not mormalising after the
> calculation.

Can you elaborate a little on what you mean here?

Do you mean that I should make sure that *val2, the PLUS_{NANO,MICRO}
part, doesn't contain an integer part? And if so transfer that part back
to *val?

> I think it's better to not even attempt this given that the results can
> be
> really poor.

Unfortunatelly, I'm kinda stuck with this as some of my ADC use these
types.

Thanks,
Liam

>
> Cheers,
> Peter
>
> > +			return ret;
> >  		default:
> > +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> >  			return -EOPNOTSUPP;
> >  		}
> >  	default:
> >=20

