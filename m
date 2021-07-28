Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909293D84A6
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 02:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhG1A0r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 20:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhG1A0q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 20:26:46 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C3C061757;
        Tue, 27 Jul 2021 17:26:45 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t68so589816qkf.8;
        Tue, 27 Jul 2021 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=1A91s7Te2XTyl2yRkF2IWoqCfdQ4Me6Q3qE2EpgjHdI=;
        b=LKRG/+wKMTDkesuu00lkfu/zGXKF5+uU2nLHisI/26KcBSO/A/GVA1O8f1fBUJH5rK
         U4MUpVLvOAmO0U5/IfkYi6QrFPl5p113RGat9ncHiSl+kBNW0/6b+bqWK5QqTZmdGHc6
         dqs/jm0IuuEDE0fuzI8csw7yOTfsnT36+MW6+yyJoSGSxwsyXSQHr43OKHVY7d8iKlNw
         VtG5cbBiN8+FZbT+Fe5F6oEwNqdeFGfhCobStdGVoDtPfYUdbuIiJVIra5E1IBYsDbFl
         bdlbPMb9ww1yNFJqVyN61MRSC8puBYGy5dFm8SnuKOiheL2l4akeGXoT8Zrwz3FKRs19
         PHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=1A91s7Te2XTyl2yRkF2IWoqCfdQ4Me6Q3qE2EpgjHdI=;
        b=QlXqm82Vh6kYkgXAKDQOiP+xAo/+cz/KXmEdozif09A/xZfVV/uKq71xC1+ABFhx6r
         DwhHft59QSuQiqMxC8BY6ZcopXxKbQ53pP8vm5Um9K18m705qYX/cZhzWZd2IorU0PpM
         5XbWmxbfYpCXM0M9fEZQ9XhcZzYp1CEMvk8l4Uc1f8vnLMmsIIAAiTagMIEBE+dZnBfm
         PihMRH10Bl1ISUAmd+F+31ubLGliwa/QBCDncB6rlwcxMJYuODrj2vPlcK0YyguGlD0P
         CVMriETAO9dlbbUSn6dGkwZxbRyl8DB/mdcDoOnxQ9uqi5xGCEOlaJovbdnHKNLzpi2Q
         ixWA==
X-Gm-Message-State: AOAM5311He37pnni9LX8IEoApk63/l6j8kWf2E9ZnDaV1s15GVk8TN4X
        YTEX3tlnu8d74klwTffmLjw=
X-Google-Smtp-Source: ABdhPJyMMGFUcvCN6+XwH+nVJAu+SYgqo7VOgdghYiurl+vKYwt63xkYautuodh9DVpATVYo0yj1Kw==
X-Received: by 2002:a37:b645:: with SMTP id g66mr25281110qkf.32.1627432004610;
        Tue, 27 Jul 2021 17:26:44 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h68sm2549762qkf.126.2021.07.27.17.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 17:26:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jul 2021 20:26:43 -0400
Message-Id: <CD4CHX6R9QRI.2Q76MYJGTXNWK@shaak>
Subject: Re: [PATCH v6 09/13] iio: afe: rescale: fix precision on fractional
 log scale
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-10-liambeguin@gmail.com>
 <d2dea8ea-5a31-0428-4eac-4e4315d07a42@axentia.se>
In-Reply-To: <d2dea8ea-5a31-0428-4eac-4e4315d07a42@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 23, 2021 at 5:20 PM EDT, Peter Rosin wrote:
> On 2021-07-21 05:06, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
> > scale. Update the case so that the rescaler returns a fractional type
> > and a more precise scale.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 35fa3b4e53e0..47cd4a6d9aca 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -44,12 +44,9 @@ int rescale_process_scale(struct rescale *rescale, i=
nt scale_type,
> >  		*val2 =3D rescale->denominator;
> >  		return IIO_VAL_FRACTIONAL;
> >  	case IIO_VAL_FRACTIONAL_LOG2:
> > -		tmp =3D *val * 1000000000LL;
> > -		do_div(tmp, rescale->denominator);
> > -		tmp *=3D rescale->numerator;
> > -		do_div(tmp, 1000000000LL);
> > -		*val =3D tmp;
> > -		return scale_type;
> > +		*val =3D rescale->numerator * *val;
> > +		*val2 =3D rescale->denominator * (1 << *val2);
> > +		return IIO_VAL_FRACTIONAL;
>
> Hi!

Hi Peter,

>
> I do not think this is an uncontested improvement. You have broken the
> case
> where *val2 is "large" before the scale factor is applied.

I was a little reluctant to add this change as I keep increasing the
scope of this series, but since I added tests for all cases, I didn't
want to leave this one out.

Would you rather I drop this patch and the test cases associated to it?

Thanks,
Liam

>
> Cheers,
> Peter
>
> >  	case IIO_VAL_INT_PLUS_NANO:
> >  		tmp =3D ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> >  		tmp =3D div_s64(tmp, rescale->denominator);
> >=20

