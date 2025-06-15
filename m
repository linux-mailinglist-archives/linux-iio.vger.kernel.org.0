Return-Path: <linux-iio+bounces-20683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033DADA447
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4E416D7C7
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02B264A65;
	Sun, 15 Jun 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE5BuX/z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F418C00;
	Sun, 15 Jun 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750025726; cv=none; b=bsmgmsLiEPWXvldp4BlxMlrBvJSZjCR4Bn5MWgBGhThhzWphvzwZz71KV08n0LjXU0hBbH53xC09tydZM6DhuR37+liXQ8UXcb4yor6AFjIAg3wvM6Qq50cHSRwMmsW4WUmqWdvK/jfrI42cPlkqZosA+0Ca6aMBkmkE2bVysFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750025726; c=relaxed/simple;
	bh=RnQi1rrrJh7qohNZv1ouEYNA0tEHBhppJby0MlFxmVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjHtJC+0yWVTfoj3Z/ZAhkMp9c2MTdyb9+Q1j4+bp6JIX1FRqSFFnp3/bvMpWLNL0o80caBQ+zF9IWOwjWGmbTNAbQlhycy+1IKHiFV24TykxewiOhd8S6JKClUXPj94k7sdCYgA4mSEAfwdIEMUSI3EaE0ANipv6YiAcaZFT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE5BuX/z; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7d74904be7so417488276.2;
        Sun, 15 Jun 2025 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750025723; x=1750630523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iJhAdOIumWHvT5bkZuN513HrL3y3ygny6oKd+Msdng=;
        b=UE5BuX/zPZygUw86kXfeBrT5g+tywR/F4hpgQtR0Lm7U7kyPNUDsS2pEPnOHdvTKpM
         4TB08MexuyxIW84TFFL4p8DFjlivWdZ/J3vZAQEWBprwAHPWwE6QRjLYAVmEni5Ll8sE
         pvyu5SdztsfLR2L0uhGEO2JN/oPrumQ/iZG6TVV8cJIAG/7ZSymQvMgBkCU37Oimk0ox
         f0cpgHmtIbPaTf9cCklVtwL2iNmUL9eDso3ZmKcWz/jkGDy5GrVAU+alu56RLrf7JSCf
         k/nguQsIuu1rk54iQ/SWOCj9W6gp9ac8mJjnKdyJT6iZpxBv11jU6NUfyXlH61iam+Ms
         2JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750025723; x=1750630523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iJhAdOIumWHvT5bkZuN513HrL3y3ygny6oKd+Msdng=;
        b=Avy91nQGsUA6NDQdaP/lNyBs5vSaGWhS0HJt5x2ohQD2k74PInYTw9rqS7HloQIslb
         piz09i5qXw7t5BhnsDLYVj04SXklzVMitC5By+opnPyyy9+F/26ECt+XtSCeVuCwpCdq
         h3JSxetyXS6G+jB51GsudIhJ+kKNglUxmQYgjAoKp58FJ3VogyZICuGKVX9TWbAnF+MX
         nW1YobemZAWvnhoX6YqskSyxi1veS92k4/tyI3PEN4q15BJx8QjgDwZtSpH86Mxduav9
         5kj1LuNUaba0bsCxfglkXTUN5G4YW9Y0FRsrhKYVY3t7P8o1LaB5VJrsGUw/ian3c/0E
         29cA==
X-Forwarded-Encrypted: i=1; AJvYcCU3OBw4YryfmIqBxVm0v8j0DHO2YGX7+hksCrg7S7o7iOugn/q6soXioAteRGcLgUnX4wbdASIA+rAiIDBs@vger.kernel.org, AJvYcCVbZwNWNOkXuupwCxvputB1YI/tsmtplkNaDNVrs2azyn0D0S6XHh9syn58ZB+EuijnnYB47s3fj/nA@vger.kernel.org, AJvYcCXR7jsRQuDqmjquVluRQdrPk49+70qpdkJXh7QDx6tvWgTq2DT4NRu9Z98Kh1nmEtN898f9sLw73KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoH++Lb3wA5tyNEcvv15LeC9xnW1/UoMScG50odpmXzqnPAMRc
	2Wjr9LJP+RdZZcT2dcOQcOHceeJGquXeAvdOO8khJwEcw56MgT2HCFF1sRt2Pguc67kYr/FjsR2
	jyg3lKrjWI3qaspvMQxXijp5HPtLcSMA=
X-Gm-Gg: ASbGncvSQrjJi0qC6w1TicE9ZCgue7trp/jFJkfF5fQy/WvSDXehVHMAOQtGTokgAfA
	D/tRgHwfmhw8UIOWSfxlxgNpKHAMVLL9YQcAvnG3tuVFoMK3x3jjOobpA3Ok4DD2xo6VMurmQHN
	kzfXeuq2VKA/0GZaLsuux6J/RYPUESz+vZawN9wYFF0jQ=
X-Google-Smtp-Source: AGHT+IE9hbKQ4sK/LsuLJL0sEH3IMCJSY+KuPt+L2NqrmriAQFWwzcgCmPqEK3p7iRnN6I6dgibAeyIgMAT9uvB4ugg=
X-Received: by 2002:a05:690c:d8f:b0:710:f401:2fe8 with SMTP id
 00721157ae682-7117549c2d1mr46437667b3.3.1750025723521; Sun, 15 Jun 2025
 15:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-6-l.rubusch@gmail.com>
 <20250614144750.1f1a7a0f@jic23-huawei>
In-Reply-To: <20250614144750.1f1a7a0f@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 16 Jun 2025 00:14:47 +0200
X-Gm-Features: AX0GCFuNXt57daOPDQrwpyv_B-9V5fmEIm0OHdDeKEzZDhrzcyiNZCUA0wf8o7Q
Message-ID: <CAFXKEHaGk5NZ4dT9xLkAfirn974P9miwjs=5N+PTqJ2x00QOiA@mail.gmail.com>
Subject: Re: [PATCH v9 05/11] iio: accel: adxl345: simplify reading the FIFO
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Jun 14, 2025 at 3:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 10 Jun 2025 21:59:27 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Bulk reading from the FIFO can be simplified. Remove unnecessary
> > variables and simplify reading sets of x-, y- and z-axis measurements.
> >
> > This is a refactoring change and should not impact functionality.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 18c625d323ba..dcfbfe4cac0f 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -884,15 +884,13 @@ static int adxl345_get_samples(struct adxl345_sta=
te *st)
> >   */
> >  static int adxl345_fifo_transfer(struct adxl345_state *st, int samples=
)
> >  {
> > -     size_t count;
> >       int i, ret =3D 0;
> >
> > -     /* count is the 3x the fifo_buf element size, hence 6B */
> > -     count =3D sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
> >       for (i =3D 0; i < samples; i++) {
> >               /* read 3x 2 byte elements from base address into next fi=
fo_buf position */
> >               ret =3D regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE=
,
> > -                                    st->fifo_buf + (i * count / 2), co=
unt);
> > +                                    st->fifo_buf + (i * ADXL345_DIRS),
> > +                                    2 * ADXL345_DIRS);
>                                        sizeof(st->fifo_buf[0]) * ADXL345_=
DIRS);
>
> As it's not locally obvious where that 2 comes from.

Hm, I left the comment some lines above: "read 3x 2 byte elements from
base address into next fifo_buf position" - so, the 2 comes from the 2
bytes. 3x because of the 3-axis sensor, so 3 axis times 2 bytes. How
can I improve it? The patch is just a simplification, removing that
unnecessary count variable.

>
> >               if (ret)
> >                       return ret;
> >
>

