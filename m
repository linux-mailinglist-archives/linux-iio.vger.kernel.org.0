Return-Path: <linux-iio+bounces-21368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB5AF9E1A
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 05:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187247A66ED
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 03:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11A271444;
	Sat,  5 Jul 2025 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0q82ZqK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDBC3BBF0;
	Sat,  5 Jul 2025 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751685462; cv=none; b=pIQ0cLhoQvS+eZfY3MwkORIOVSIjF/VIdnntvFafFiVXzXMIYVnWlN8CYtq3zaQ9vyHixEbhexswjOqJv4isUcO1o0qEyQNq1eXRk56kWPlSDN8hAlpuH2pHpnCRufq2di66+zG2/ePNmlNC+wxdj1U4COSXewmDKz33bQV/gK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751685462; c=relaxed/simple;
	bh=Hq2bQ3PEoAwFkYXJXEvQ2NC8LYX/H09Gz8ZOBJPcJTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrxzU5slAtULa/JG5wK+TgiUDCRg4FSoM3IXajeB+knx4lUs7J8Z41W/LCCqSDrGRiu9vO1o+k3hTfzYCpee4VyopzcXqoizoi0b8UgXJiUyTmiXYb5fFvHvznTZ0G+AnQ4jq9xhK6ImVxm7xv6iG6/U5pC6bXp0bRCrYQ6zmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0q82ZqK; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e7f367ea11so400175137.3;
        Fri, 04 Jul 2025 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751685460; x=1752290260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB9dYvDKdxfp8Ws2pyfMbgk0mUslRKRqo78pCObwS20=;
        b=R0q82ZqK/UsjHWFM0r8PQakTXmOIBcndHTTyyr5Vs6Ck+7Dz3aeSvUPQORacsqK2m+
         a1eEHz2hqFWnTb4k8ukqL8JVIhG98auxv0ZcS5vrKAI7fhbBXObmEN401+1DeGbTFA0I
         vh83vjpvE5bPSHV/flhN9IsALsomL9IwcoVaYobzBJB1Ixu7mQQDCzXFVibQ2im1Nsir
         Ru0CNFMR/tIyuFp3MCJBz+U/dm4uvsgFbwKnIyX0LlumJXev3cycUxHPq/EmBjQlv+0d
         Vt2q7XpbS72Jj1FA+mF8+SbAMiyisqwU/YpeHidsaWTkPDUgt7laz8CyQtTMOCxZ+QMi
         XcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751685460; x=1752290260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB9dYvDKdxfp8Ws2pyfMbgk0mUslRKRqo78pCObwS20=;
        b=O4OVWrDHun3XKVZQNnbm4H1Yr48sc0etWzpwtEXHbjhmwQnybRvSR1jDS5ssImiEa5
         7tBt9Etn1WGch4Mj/vYYmzitLZIRb9PdYzAlyAKcDtz3fPxGVcEH6D1uWCs9Zv0lXf1m
         J1JG3sT5L+V6xGb18Btqo1JQInFTnR9IxmYyD7dmzGnwpleW6gmG9Pc6Lx7z+cmh3eZJ
         iTOI+94cMitfyaPp/qVgBWT7OKwAlpg/aOb5DqkYhF5B7Vt2uUOze5vIf3KRgasapEZv
         MagDoktDix9B67s/Sk4Usm3QTwES6XMR2JVmXpzuq9QpDje8mUuifNKygTo/LfOGd+5r
         Z0eg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDemShTf4pr4s78bEJF9aQPjcD6Bc86yYcNwKIATgwHs1ZuLcGI5zpwtMUnH6W+zGU7TGv4pD8+1UbbFA@vger.kernel.org, AJvYcCW+jIiLplFTFLkWxZAwJUnFc90zxCVWnAG6yO6k6r9BSYr11tjXavZMnKeAnfz/Q4XvwQaW2e3pZJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTzbPD4Qoq/hWi/uoGgwGuNRGXzt5gcaJk8kDcq+vc8En8FHN
	mXKWOOlDTPHBlJU3xAOThOfc1yl8GsEahGUHxRx+erVfb1GPepXIEcLZQNiFx5Q7K6xY4IKWlGi
	XNrOqoDVK+SnDgemmOu3CyQzMfjfwJM8=
X-Gm-Gg: ASbGncuKBAuSv8U8WbjYzAJ4xPPd7xPfdM87nV0NcGynoI7oSzJe7kXSuuUtcmFCp9f
	uKGZN0WFzgudldw4lULHO7W5KQG1r7TDb0iiQ/FpTOrydaav43xjByohedS4t0lCmPH5eZQ+UBl
	301Slq9m1Sam2TN0fz77syNU95BQiLG4Zyvw3vmAfbGJ8=
X-Google-Smtp-Source: AGHT+IGVsZwcGCVZ403CithjNi9WsUXSRPj+ibRR15jU2kltKiFKmRPF2S6nZAT48+6f9AaYRaxXdu43KwoIllQSeLc=
X-Received: by 2002:a05:6102:38cb:b0:4e9:924f:eea2 with SMTP id
 ada2fe7eead31-4f3059a4ba7mr531779137.4.1751685460041; Fri, 04 Jul 2025
 20:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <20250618031638.26477-2-andrew.lopes@alumni.usp.br> <20250621183843.2f8bcb48@jic23-huawei>
In-Reply-To: <20250621183843.2f8bcb48@jic23-huawei>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 5 Jul 2025 00:17:28 -0300
X-Gm-Features: Ac12FXxKRY65ztMfLC4bP1FDghvoGqd_5L-OKt8hJ4-wFN29KG-j8SnDLWodtFU
Message-ID: <CANZih_QAoSAMzPOq=di9=Wk=WK4+B1Sx80FjfCx41z6dYJQLyA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 2:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Hi. I made two related tweaks.  A few comments inline for further possibl=
e cleanup.
>
> Applied to the togreg branch of iio.git and initially pushed out as testi=
ng
> for 0-day to take a look at it.
>
Thanks. Since there was a problem with my implementation, I'll send a
new version along with your tweaks too.

> >       if (ret < 0)
> >               goto error_ret;
> >       dev_info(&indio_dev->dev,
> >                "sca3000 revision major=3D%lu, minor=3D%lu\n",
> > -              st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
> > -              st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
> > +              ret & SCA3000_REG_REVID_MAJOR_MASK,
> > +              ret & SCA3000_REG_REVID_MINOR_MASK);
> Hmm. doesn't belong in this patch but it is rather odd to not see
> a shift on one of these.
>
> Hmm. Time to miss quote whoever it was who said:
>
> "kernel development is like a murder mystery where you try to solve
>  the crime only to realize you were the murderer."
>
> Below I mention using FIELD_GET() in appropriate places as a possible add=
itional
> cleanup.  Fix this up when you do that (and note it in the patch descript=
ion for
> that patch).
Ok! I'll do that.

> >       /* mask bottom 2 bits - only ones that are relevant */
> > -     st->rx[0] &=3D SCA3000_REG_MODE_MODE_MASK;
> > -     switch (st->rx[0]) {
> > +     ret &=3D SCA3000_REG_MODE_MODE_MASK;
> > +     switch (ret) {
> See discussion below.  This can be simplified as
>         switch (reg & SCA3000_REG_MODE_MASK)
> avoiding the modified 'ret' value in place comment.
>
> This one I'll tweak as it is easy to avoid the ugly pattern.
>
Nice! I'll pay attention to similar cases in the future.

> >
> > -     st->rx[0] &=3D ~SCA3000_REG_MODE_MODE_MASK;
> > -     st->rx[0] |=3D (mode & SCA3000_REG_MODE_MODE_MASK);
> > +     ret &=3D ~SCA3000_REG_MODE_MODE_MASK;
>
> For a further potential cleanup it would be good to use FIELD_GET() and F=
IELD_PREP()
> in appropriate places in this driver. Do that into a separate local varia=
ble
> as using ret for all this is a little confusing as quite a bit of the tim=
e
> it's not a variable we are ever going to return.
>
> As a rule of thumb if we are modifying the ret only a little in a single =
reuse
> (i.e. masking out a bit in a parameter being passed to something else) th=
en
> a local variable is probably overkill. If we are building up a new regist=
er
> value it is not really appropriate to do it into ret.
>
> I'm not asking for changes in this patch though as what you have here
> is the simplest and easiest to review change.  If you add those extra
> local variables as part of using FIELD_GET/ FIELD_PREP though that would
> be great.

That's great! I didn't know about FIELD_GET() and FIELD_PREP() before.
This is really something that would be better in a separate patch, I
could try to do that later.

Thanks,
Andrew

