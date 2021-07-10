Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335CF3C35E2
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhGJRsc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhGJRsb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jul 2021 13:48:31 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DDC0613DD;
        Sat, 10 Jul 2021 10:45:44 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id j14so6212095qvu.6;
        Sat, 10 Jul 2021 10:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=sW9hZja3xQYTQGPj+6uAtbSZMYkpOa8syLZTN1hyNWA=;
        b=l+idCI0aRPJOkC41EHdwZME3sL9B2PrRibbecoP3Ug1v4iyVplD6bvnPCWq+JGxJRI
         uN9gVu4ES2JgRqxg+ttzKCyt52xiUJIgHp+b0xfyllHDjB5GQoJydmmFjKRBEOl/sd7N
         NkjVkEaZW/c22jQC/vu/Vdso+3M7jxVF2rJmE6ve55NAaFG5bkPbe2dGjFJZkFfaEqkD
         hnE1PtnYLbv4TSERPW5MKeRhpdfSVJcfABgxQnH/i9IXA7eQDdeqR+m5egjnesr1B4GD
         uwHQ2KcVJ51Rn95rb66KSDYPoM/xAkyHQjf5TtelTaDSucrL7Qiwki6LQ8lTjC9y7gb6
         gDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=sW9hZja3xQYTQGPj+6uAtbSZMYkpOa8syLZTN1hyNWA=;
        b=Q8zZGfFQPzcrwjkCMaDg0JhnrvU52qPLQ79P7G0k8smsUU9dngr5BOG2G0sumno62V
         BjTwRYfvqpU+61Oz2Mjk0QJT3DLjOVM0ghE+YLyC7Bqwe7H9OUvF2HFa/4S9Xem2uaAG
         wR2Kk7Gy8ubLmBRU+jCC0RdExm4wXGDhiWQOLFa+Vg3kxZj6j3NXHpAWvK8fjd8LrTVo
         PLUHe7yaQRQFrS0ApCH8LtDUSYYasVUM5uyBdaxDP9mi/G+/DqoPROBeQi8GAfr/fa/w
         2EvVETWSWTK33+FiMvSKw2XW+Jp3RpZzdbeuHMpAuKCt0905gRFmmDpkkQ7xFXgKvntE
         PXnw==
X-Gm-Message-State: AOAM531QLNFlfU6RvZIPIDd/jUVqYD/Rdr83AYEXd0JLbK/a2Lh938S2
        SE2wraS8IsO7bFY4vrzSkOrgL8O3LxnkyQ==
X-Google-Smtp-Source: ABdhPJwyK/XfRyUOImaBHnO2b1uhIV9hHSRSnLVMKw43iuRXnfmhFBGZ5S0Mx2h7G1/J825AhHTTMw==
X-Received: by 2002:a05:6214:172:: with SMTP id y18mr16067392qvs.14.1625939144124;
        Sat, 10 Jul 2021 10:45:44 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm4167120qkd.79.2021.07.10.10.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 10:45:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Jul 2021 13:45:42 -0400
Message-Id: <CCPNBMAIVJTV.3U5M70O21GDZ4@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v4 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-6-liambeguin@gmail.com>
 <4be51a74-9913-291a-9dac-422ac23da3ea@axentia.se>
 <CCOUX814CQ6U.XY2CIQKFE00V@shaak>
 <353ceae9-ad7a-3175-d764-a9e590d3e8d3@axentia.se>
In-Reply-To: <353ceae9-ad7a-3175-d764-a9e590d3e8d3@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 10, 2021 at 4:14 AM EDT, Peter Rosin wrote:
>
>
> On 2021-07-09 21:30, Liam Beguin wrote:
> > On Fri Jul 9, 2021 at 12:29 PM EDT, Peter Rosin wrote:
> >>
> >>
> >> On 2021-07-06 18:09, Liam Beguin wrote:
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
> >>> Scale the integer part and the decimal parts individually and keep th=
e
> >>> original scaling type.
> >>>
> >>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>> ---
> >>>  drivers/iio/afe/iio-rescale.c | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-resc=
ale.c
> >>> index ba3bdcc69b16..1d0e24145d87 100644
> >>> --- a/drivers/iio/afe/iio-rescale.c
> >>> +++ b/drivers/iio/afe/iio-rescale.c
> >>> @@ -89,7 +89,15 @@ static int rescale_read_raw(struct iio_dev *indio_=
dev,
> >>>  			do_div(tmp, 1000000000LL);
> >>>  			*val =3D tmp;
> >>>  			return ret;
> >>> +		case IIO_VAL_INT_PLUS_NANO:
> >>> +		case IIO_VAL_INT_PLUS_MICRO:
> >>> +			tmp =3D (s64)*val * rescale->numerator;
> >>> +			*val =3D div_s64(tmp, rescale->denominator);
> >>> +			tmp =3D (s64)*val2 * rescale->numerator;
> >>> +			*val2 =3D div_s64(tmp, rescale->denominator);
> >>
> >=20
> > Hi Peter,
> >=20
> >> Hi!
> >>
> >> You are losing precision, and you are not mormalising after the
> >> calculation.
> >=20
> > Can you elaborate a little on what you mean here?
> >=20
> > Do you mean that I should make sure that *val2, the PLUS_{NANO,MICRO}
> > part, doesn't contain an integer part? And if so transfer that part bac=
k
> > to *val?

Hi Peter,

>
> Yes. On 32-bit, you will easily wrap, especially for PLUS_NANO. You'd
> only need a scale factor of 10 or so and a fractional part above .5 to
> hit the roof (10 * 500000000 > 2^32).
>

Right, That makes sense!

> But I also mean that you are losing precision when you are scaling
> the integer part and the fractional part separately. That deserves
> at least a comment, but ideally it should be handled correctly.
>

Oh got it! Apologies, How did I miss that...

All things considered, it might make sense to also implement the
test case Jonathan mentioned [1]. I'll look into it.

[1] https://lore.kernel.org/linux-devicetree/20210704173639.622371bf@jic23-=
huawei/

> >> I think it's better to not even attempt this given that the results ca=
n
> >> be
> >> really poor.
> >=20
> > Unfortunatelly, I'm kinda stuck with this as some of my ADC use these
> > types.
>
> Ok. Crap. :-)

Can't agree more :-)

Thanks,
Liam

>
> Cheers,
> Peter

