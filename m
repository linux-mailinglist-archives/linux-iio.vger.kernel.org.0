Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD83DA848
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhG2QCU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhG2QCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 12:02:10 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A0C06179E;
        Thu, 29 Jul 2021 09:02:04 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jm13so3639348qvb.5;
        Thu, 29 Jul 2021 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=crl+m4xpN2rQpodK9IBboDzgVn58oWozCut4cofRiKA=;
        b=pLGZ1EOkiUZRuQU/Do9j/kxjA/lCZMffc0hvACY1Zge+1zX8hdK1Fx7UsnIGykgq/o
         /G34St8ykVgFj0QntTTbLoIY4Vzw8fNX4mB/0PkWz8oR2G9hmFsWD+6DVTqHWmyPkGvM
         /nGhNNRebpfn0Sbc/BPRmUmmV2HZUQt1R4wXyLbzUywSzvmpoyb7faXyEGzXxAeP5HSz
         SxGU22wVHyxE+q5eqpJbe22P1NWroAS2hd4XGrr2KdVewgaeDbD0chche8p/5O5niCeV
         XdYfwoTz6B2nFOoo1CUF7EBciyUaPcFzmFTyy8aOI5daH3OcFNS/UbfiyWisUIryIDs8
         grLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=crl+m4xpN2rQpodK9IBboDzgVn58oWozCut4cofRiKA=;
        b=s8FLr1HfcLmWSVLoRZ/wKoEyEzZjUytr0uVQVZ25OQ0q0zXrMjqpWgCFtZ1MdAUjFZ
         6j0CJkS/ehb4+sgvuiTTMHBBq+SwcWeocv5IZgbwmL0LPyXB34yn/rjw/uBFq3PUTvog
         dtutsnQmaQzgevLFQNIb86FqDI41SSCUAHpnYgmSSEbIn1Y0qC/JgXVl++VGnE5wCIM0
         u2xCFKs7Pa1NvkOZWyLpgtiuiiOnBdyEKyBTP3QyvyPEfu4WEVuFU8ajhz9pslc0Tcm9
         Y9R8gI08WfNuHGuNKsPMb6GRdZnCoEfs7VoiuYoV9tKajrdoIj74l5GKUcdaYnr59c8s
         qSbg==
X-Gm-Message-State: AOAM531KcgJkb+ui1ZBGWDc53oQB8EfZkW0UneIP2XMKnMZCmLU4Yh2z
        IOXAw7jkKZ6tV2PXaz+Xl3c=
X-Google-Smtp-Source: ABdhPJzx2LYBdpKuzt3oweT6Zevzoqq/lpFIJVehrZQ8vtNlnak8IOgeE5kiL2TxoEiusQxeGMMG4A==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr5969024qvi.44.1627574523531;
        Thu, 29 Jul 2021 09:02:03 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id 6sm1983547qkv.115.2021.07.29.09.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:02:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 29 Jul 2021 12:02:01 -0400
Message-Id: <CD5R0LBMZ65W.29NU0NCABDJT7@shaak>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v6 08/13] iio: afe: rescale: reduce risk of integer
 overflow
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-9-liambeguin@gmail.com>
 <9e0e4398-873e-b5c0-0f0c-50a186ed2228@axentia.se>
 <CD4C37PEMPOM.91UZ60Q6534Q@shaak>
 <1a6e4851-9119-f524-76ff-a31ef0db8988@axentia.se>
In-Reply-To: <1a6e4851-9119-f524-76ff-a31ef0db8988@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed Jul 28, 2021 at 3:47 AM EDT, Peter Rosin wrote:
> On 2021-07-28 02:07, Liam Beguin wrote:
> > On Fri Jul 23, 2021 at 5:17 PM EDT, Peter Rosin wrote:
> >> On 2021-07-21 05:06, Liam Beguin wrote:
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> Reduce the risk of integer overflow by doing the scale calculation wi=
th
> >>> 64bit integers and looking for a Greatest Common Divider for both par=
ts
> >>> of the fractional value when required.
> >>>
> >>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>> ---
> >>>  drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
> >>>  1 file changed, 12 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-resc=
ale.c
> >>> index 6f6a711ae3ae..35fa3b4e53e0 100644
> >>> --- a/drivers/iio/afe/iio-rescale.c
> >>> +++ b/drivers/iio/afe/iio-rescale.c
> >>> @@ -21,12 +21,21 @@
> >>>  int rescale_process_scale(struct rescale *rescale, int scale_type,
> >>>  			  int *val, int *val2)
> >>>  {
> >>> -	unsigned long long tmp;
> >>> +	s64 tmp, tmp2;
> >>> +	u32 factor;
> >>> =20
> >>>  	switch (scale_type) {
> >>>  	case IIO_VAL_FRACTIONAL:
> >>> -		*val *=3D rescale->numerator;
> >>> -		*val2 *=3D rescale->denominator;
> >>> +		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> >>> +		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2))=
 {
> >>> +			tmp =3D (s64)*val * rescale->numerator;
> >>> +			tmp2 =3D (s64)*val2 * rescale->denominator;
> >>> +			factor =3D gcd(tmp, tmp2);
> >=20
> > Hi Peter,
> >=20
> >>
> >> Hi!
> >>
> >> Reiterating that gcd() only works for unsigned operands, so this is
> >> broken for
> >> negative values.
> >=20
> > Apologies, I didn't mean to make it seem like I ignored your comments. =
I
> > should've added a note. After you pointed out that gcd() only works for
> > unsigned elements, I added test cases for negative values, and all test=
s
> > passed. I'll look into it more.
>
> Maybe I've misread the code and gcd is in fact working for negative
> numbers? However, I imagine it might be arch specific, so testing on
> a single arch feels insufficient and deeper analysis is required.
>
> However, looking at lib/math/gcd.c it certainly still looks like
> negative values will work very poorly, and there is no macro magic
> in include/linux/gcd.h to handle it by wrapping the core C routine.

I agree that looking at lib/math/gcd.c odd things might happen with
negative values. I'll use the the absolute values to calculate the GCD
as it shouldn't affect the value of factor.

>
> > rescale_voltage_divider_props() seems to also use gcd() with signed
> > integers.
>
> The type of the operands may be s32, but if you look at how those values
> are populated, and with what they are populated, I think you will find
> that
> only positive scale factors are sensible for a voltage divider. Using
> resistors with so high resistance that s32 is not enough is simply not
> supported.

That makes sense!

Thanks,
Liam

>
> Cheers,
> Peter
>
> > Thanks,
> > Liam
> >=20
> >>
> >> Cheers,
> >> Peter
> >>
> >>> +			tmp =3D div_s64(tmp, factor);
> >>> +			tmp2 =3D div_s64(tmp2, factor);
> >>> +		}
> >>> +		*val =3D tmp;
> >>> +		*val2 =3D tmp2;
> >>>  		return scale_type;
> >>>  	case IIO_VAL_INT:
> >>>  		*val *=3D rescale->numerator;
> >>>
> >=20

