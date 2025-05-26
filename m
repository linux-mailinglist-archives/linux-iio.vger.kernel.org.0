Return-Path: <linux-iio+bounces-19957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70D7AC458C
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 01:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6E31897C77
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B051A8412;
	Mon, 26 May 2025 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLLSifDI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A4189F5C
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748302441; cv=none; b=Jyx39CI/WjtH8nmTEDvfg+3PpmYJvv5tBmTCjzX0Bz8v/giaXSpQpZTpRH0sWhx03FynY8JG8cc+wymTNwiUNiTqMb+iDOqddqJelnf/DBTB/QCwZosGXorbv5rRXXG3jiSLZfjtE2r61GZwjv3rWNuZbUZ1Z6WIleUWv9Tdq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748302441; c=relaxed/simple;
	bh=nHZrcBzkZJEDn6Zi+e8JAjrzOGOeKqmF3xJsSAD0z9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niGQ+E+4BzWyiyqx7uTmraJWPWvTYyPiG5lh4tAEPL6DPeVRQXNfgzVA5nOuQuGFqELentzxr1LE0se2yDSSrtALD/Ako49c+onT5GmElNHD9a611n5Z4LBQGjNTaLjrB6cAtBcf57OcNTdcc04JfWm1tSLqp6A7JEMuHdFOjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLLSifDI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acae7e7587dso347769666b.2
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748302438; x=1748907238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lac+FdAY3KiBltEEEow5TInPKl0xdlSVDqOAr8z4jjc=;
        b=lLLSifDI7pY7lc5iBNn3FBnQENb6lESNAcUQPT4nkNzzkrisl6K6ZNg7sctNlfRPI0
         U9NmXXjW8syOoA0BFkvQF5uaNNiofLRgiK/WmfbRec1Qjo9JOFBNxNUCOiq4b9mSNW/u
         om5p09bogy7mii60VSSRBDbltUCIhxYudVP2vuN2ybQcVerEIcyyOyxE9idlXMz6MzFe
         KDanmJiWOO4FpbKXa9jTu3D+EyaEg7ZmleLWj3hnLrTdnHDJQC9JnW2bvSM2LYapKotN
         w3ivE4ftwf6Z6WngQz1r95OXFwMIrbjlBvE0L8maXes3blzUIGKQlITMe7pjV93OyLAf
         ByPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748302438; x=1748907238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lac+FdAY3KiBltEEEow5TInPKl0xdlSVDqOAr8z4jjc=;
        b=KB9fSXMMWyuWoKJWu21iGKuOUaB+HK6dYV9t5qDH6NvEoR93mEO2xLt1lIdqll5h6Q
         HwpLpSQdtkIgbTiWek02vbaEJ15cTBlZpqkEIGcFwEX9QOVvamFInnQpI0Vswj4uvYRb
         nhgdf2xd01fTWSpyjv9655fFUVGR1GXNmt9ctxU6grTbW+r799uYi9MXaDbtgvIguQFC
         fPQgj2hx0vxq8lmDE2ErsDWjG0PzeXBj0Na8Wsx2kYIDNgacE1yoBOR/5u30duoycrEh
         gQU/HBqUlVslZxZLQJ42lm8FhFymO5RIWlNTLK5VbSJsjseWiiPKt58By+MCPbGExroA
         PmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXwl9789umt9A6R2iSvb8CqZ1png/wfw8pzyjhRZ6zU8KFVcU9OsNBIqZ9fkN26UTfChMlsN0uGWtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fxkDmS92C3Ehq0zyF4PYVZ5geSpp9JGzLa+s9W3mOSXTeKBj
	F07WNZf8U1xxWxXkzXcO29vYnPN+bwtp5iLWGArxapG30fwo2HMS2h7opvfzWyEVrDCsxcuxCvR
	+VwuesKSdELD5zQlVb55MPZnUzPyNmi0=
X-Gm-Gg: ASbGnct9tEGgkbldgcNF2l73GX/MbqWyHFrnRVvpcr490F/uInaBTMR4Qhft5jccsHO
	VcfUPvsEmmqgCGnavVQ+zyt7eSOXHpqtZp+sol2n3TRsY7KvIlrDMQAgl1Avjq73oLMwAJvDmNR
	t3j/7C0qXHYYhPEnSt4ZtT4jj3ewyauRyhOw==
X-Google-Smtp-Source: AGHT+IEQr8erVZF8rQUK1QgYG6v4PuD4CTfmm39vFtuO3hka/Z+m4Bh0YLd2iG19w0s2D/1Y1qfSokMpogziEDANpDM=
X-Received: by 2002:a17:907:7252:b0:ad2:4d69:6da5 with SMTP id
 a640c23a62f3a-ad85b213577mr834295366b.57.1748302438014; Mon, 26 May 2025
 16:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422191114.32832-1-nattanferreira58@gmail.com> <222efff5-38d6-483f-8e5b-b0f07cb98130@tweaklogic.com>
In-Reply-To: <222efff5-38d6-483f-8e5b-b0f07cb98130@tweaklogic.com>
From: Nattan Ferreira <nattanferreira58@gmail.com>
Date: Mon, 26 May 2025 20:33:46 -0300
X-Gm-Features: AX0GCFs896RXK5FcBSkFaT-uFshaPf2wmEUkP0XsM2XVXVwXsQak3UQKUl37YTg
Message-ID: <CAKj1jXo2nYWBeUFr62h+Y4C=hfebaMP3gxVWkH-eaVpCi=JYng@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: apds9306: Refactor threshold get/set
 functions to use helper
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: jic23@kernel.org, lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Subhajit,

Thanks for the feedback.

I=E2=80=99ll send a new version with an updated commit message to better
reflect the intent of the change, focusing on clarity and code
consistency rather than line count reduction.

Best regards,
Nattan

On Thu, Apr 24, 2025 at 10:03=E2=80=AFAM Subhajit Ghosh
<subhajit.ghosh@tweaklogic.com> wrote:
>
> Hi Nattan, Lucas,
>
> > Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set
> > functions to use a helper function (apds9306_get_thresh_reg) for obtain=
ing the
> > correct register based on the direction of the event. This improves cod=
e
> > readability,minimize the number of lines  and maintains consistency
> It actually adds four more lines to the driver file. Rephrase maybe.
>
> >   drivers/iio/light/apds9306.c | 36 ++++++++++++++++++++---------------=
-
> >   1 file changed, 20 insertions(+), 16 deletions(-)
> 20 additions and 16 deletions.
>
> > @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9=
306_data *data, int dir,
> >   static int apds9306_event_thresh_set(struct apds9306_data *data, int =
dir,
> >                                    int val)
> >   {
> > -     int var;
> > +     int reg;
> I like the name changed from 'var' to reg', makes much more sense.
> >       u8 buff[3];
> >
> There is always a balance/trade-off between modularity and execution spee=
d.
> I agree with Marcelo's reply in the first patch and I also think that sep=
arate function for this does not add much value.
>
> Overall the patch looks good to me.
>
> With the above:
> Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>
> Regards,
> Subhajit Ghosh

