Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BDA3DA8C0
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhG2QTR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhG2QTR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 12:19:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F17C0613C1;
        Thu, 29 Jul 2021 09:19:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 190so6469183qkk.12;
        Thu, 29 Jul 2021 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=+KrPCSnHKZvHsetzaaVnpnXvX+hBEhmIj6HrXqly/yw=;
        b=hbn/daSt/1s1i1oc3sjUwYCXyQaDW0+Mlwv2Pysfhzvc/OXs2haCgtHEO5EdaCK6Ve
         eGapBu0EK0vdaYskUIGMEy00N0x7IYD4Sl1DTYo7S3DYzRSMufUWfzoJtT/yy9fzG3VI
         i4txpMPImlvJevkt/snlTeKEleeDR30pnqiis2YWhxCJ63xV3BPOyJ7bF6RCCmJxK27Q
         HvIJVkZzM7gx0m0mvush8FurK6KhFzhkht8U0TY3yWxB6btlNaqSWa0hQrPq9ER9owAU
         iWj3h0Hqi73o5ahu0FRTYwB/zsMBWz6450p2bj/kbKfSHzMv7cw80+FwF6wj+u39bClq
         L3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=+KrPCSnHKZvHsetzaaVnpnXvX+hBEhmIj6HrXqly/yw=;
        b=EMILTMtkYJ1fme0hJsx8ZdD73pDHE7pdt57KtgmPtGSpuA3l50gscMIZOSs6m7FZhZ
         0MY1WGPrLQoXwbjBMQ7QBRaOs9NNcGXcXv05Vsee7cZXCegerSBdxxX3kJJpk1IvQ6Ik
         gNWHDIWVx/bxByr1D74Im8fPDS+hb8/ZL3YEqc16yRGMHhmx/5ygNjdvq7tR2udvyYBi
         ZsA2gfx5/MX6vi+P/uESiYNq8ILBhpXLK6cMJ3MZmvRSkL2HEU5dQPys+e/R8GHjhqkv
         zVW5mIchZOWGGCCNxuT33W/TqEwoYrHjLCj9uGgBmwzTg/KUwfZBvV6W8SgfzBGOU4UA
         UXDQ==
X-Gm-Message-State: AOAM532f6Ds1+qknEZcfl+Q0ppnTVZXoFzhF8Bc84G6BBuWrdRrIk3wZ
        UKe+LUxgsahdaTSs1xNPCfY=
X-Google-Smtp-Source: ABdhPJz661BdOVblk6GTu7tyQvsCsBpmmzdhPBejYOF/1uRwvlaEFJRUZav+5KfZAaRYNY6k2OwE2w==
X-Received: by 2002:a05:620a:124e:: with SMTP id a14mr5958489qkl.356.1627575552888;
        Thu, 29 Jul 2021 09:19:12 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g26sm1930311qkm.122.2021.07.29.09.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:19:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 29 Jul 2021 12:19:11 -0400
Message-Id: <CD5RDQA6H2AZ.3R2031X2O3BWK@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v6 09/13] iio: afe: rescale: fix precision on fractional
 log scale
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-10-liambeguin@gmail.com>
 <d2dea8ea-5a31-0428-4eac-4e4315d07a42@axentia.se>
 <CD4CHX6R9QRI.2Q76MYJGTXNWK@shaak>
 <4e477a42-1cae-06f8-2778-fc734359d6f3@axentia.se>
In-Reply-To: <4e477a42-1cae-06f8-2778-fc734359d6f3@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed Jul 28, 2021 at 3:58 AM EDT, Peter Rosin wrote:
> On 2021-07-28 02:26, Liam Beguin wrote:
> > On Fri Jul 23, 2021 at 5:20 PM EDT, Peter Rosin wrote:
> >> On 2021-07-21 05:06, Liam Beguin wrote:
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
> >>> scale. Update the case so that the rescaler returns a fractional type
> >>> and a more precise scale.
> >>>
> >>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> >>> ---
> >>>  drivers/iio/afe/iio-rescale.c | 9 +++------
> >>>  1 file changed, 3 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-resc=
ale.c
> >>> index 35fa3b4e53e0..47cd4a6d9aca 100644
> >>> --- a/drivers/iio/afe/iio-rescale.c
> >>> +++ b/drivers/iio/afe/iio-rescale.c
> >>> @@ -44,12 +44,9 @@ int rescale_process_scale(struct rescale *rescale,=
 int scale_type,
> >>>  		*val2 =3D rescale->denominator;
> >>>  		return IIO_VAL_FRACTIONAL;
> >>>  	case IIO_VAL_FRACTIONAL_LOG2:
> >>> -		tmp =3D *val * 1000000000LL;
> >>> -		do_div(tmp, rescale->denominator);
> >>> -		tmp *=3D rescale->numerator;
> >>> -		do_div(tmp, 1000000000LL);
> >>> -		*val =3D tmp;
> >>> -		return scale_type;
> >>> +		*val =3D rescale->numerator * *val;
> >>> +		*val2 =3D rescale->denominator * (1 << *val2);
> >>> +		return IIO_VAL_FRACTIONAL;
> >>
> >> Hi!
> >=20
> > Hi Peter,
> >=20
> >>
> >> I do not think this is an uncontested improvement. You have broken the
> >> case
> >> where *val2 is "large" before the scale factor is applied.
> >=20
> > I was a little reluctant to add this change as I keep increasing the
> > scope of this series, but since I added tests for all cases, I didn't
> > want to leave this one out.
>
> > Would you rather I drop this patch and the test cases associated to it?
>
> Why drop the tests? Are they doing any harm? Or are they testing exactly
> the problem situation that fail without this patch?

They are testing this problem and fail without the patch.

>
> In that case, I guess fix the tests to pass and preferably add tests
> for the *val2 is "large" situation (that this patch breaks) so that the
> next person trying to improve precision is made aware of the overflow
> problem. Does that make sense?

To handle large values of *val2, I could use the same logic as in
IIO_VAL_FRACTIONAL with check_mul_overflow() and gcd().

would that be okay?

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
> >>>  	case IIO_VAL_INT_PLUS_NANO:
> >>>  		tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> >>>  		tmp =3D div_s64(tmp, rescale->denominator);
> >>>
> >=20

