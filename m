Return-Path: <linux-iio+bounces-18358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F1A94651
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2351899038
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95219BBA;
	Sun, 20 Apr 2025 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgGXLwHP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29763B9;
	Sun, 20 Apr 2025 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745111582; cv=none; b=aE7Vw82wvvqrYS6kvIC0qLnUg3bnhiNwczKY5LLIBoYYEA6vSW08qzbdDJP/q/RzvtvF+yCu6aqPxhFvXFVMLkueKxU4c8986EhRMkWEnExGQ7dl8TnJbjcteH6QGG35XiknqSjXUwuQ24SITObj6OwbxlUnq3ToQbj5w7l/H/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745111582; c=relaxed/simple;
	bh=6G44rOBDOpX3K4dAYqiZRKu6NlpsI8kYJwv4t94PWfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLmMLexkzn+MKVhzCGvwgbpiCiSUwn6hqqc6FTJObyQCJ4V9zS7B7Ls5Ypm8bThOocXzBGfvE+wJr63XW8PcA+0pPI0JsqeCT/8uDYNgVKtpOx6aOSeSHiSDXbewQ/hht6WBGkQUqS0lJ84RdwcNSJJokNfBOrIpf3l8pgR9Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgGXLwHP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4774193fdffso42019301cf.1;
        Sat, 19 Apr 2025 18:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745111580; x=1745716380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thDcOLdPkfwcZEXoGMprWBcv7sRiqWfZZa3+HhTK2aY=;
        b=hgGXLwHP5CuMo9gdrBfaF7/WKxbKCNPscjVScxVFYQWiueoRvUNQxP04AcKv5CCBqD
         wXeDmjKoM0MriAZhW3gay5e1jEEd0GelCFtyCwguN+0L+dygfj1zaye1twlVV/kJAyBH
         UP4TSzWzsFrJE3ei10fhMwOld2+hjPTbO0e1U4YweR9L9OqPRHJ1EGQHOpTUodqG0mhI
         5HSWnsv0v83SWMlIO1tbvudgFHqkP04qH8GfHoAARxUj+QiTQrYcBSNNcFF8ZU4Ega9L
         ciHscloWbvePVAqJjmxRUAu10forgCy8hQd5oPkcINXi7SghQzi7QwnORWbeHaGfLqQd
         vppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745111580; x=1745716380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thDcOLdPkfwcZEXoGMprWBcv7sRiqWfZZa3+HhTK2aY=;
        b=k/DageeOp85XlFZtD0mE55f2Gd7brMuWRdm13oNcNk8rLS07fZvMOOOtnhOAzsw6sy
         k4Sa27aHthlsInGEw46X4u0yBs0HPe40/ODod0hJXg2ce9+uoj6UH7ckBJO4FSfz7oBS
         rJolYPXUv5fDrE9MylHaNLJiwMekYqJ3O0Fg91m62JgrNtHroCXab8UpUM7rhYLTNAJ7
         +Tx54TlbuVsrzWzMfFo2DJu/kItv+396GZSL4BDm7g4nxq5ZpvJauenyLVgleG2DXQSh
         RqadsgC4XmLWJx49Wyuoi712lKvhRrHdi4UkqBSfpyqt93izILKquGU9Igh0w4uOdgku
         RYVA==
X-Forwarded-Encrypted: i=1; AJvYcCVrQhUIwxMhEq0dnfFt+s16Gg0ZGaeaD65+/pf8fXl6ClzWcuRckoSAgF+6TV4EbVpWeiQpd43N@vger.kernel.org, AJvYcCWiltG40NK32muFR3DH0nwHNY9xwA+ouIpRv5xXExWos59Bb4BOn8MK1QsRT8AflLOpr+JPwPTXq4Wg4QIr@vger.kernel.org, AJvYcCXLpveCU3H17+kMEa4twrywIZwHu73L7tmfcu4fdmyh98a8At9+eqLVkXeSFjcGifLXOEn9mmgfP84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+ouBJmDac6Wk9jR/xnehfn95dfq4BYOImVRTUV3ekk2ZBO+T
	opHaGEB+GxjSnIPef1ju9ocCCJyveBcZCzOYqO+SZ0tgQ97Q9pCbTTHXMS7R7XpCLSbKnBfSHi7
	62En1p6D4QdKU2QMhftToxoCMTg4=
X-Gm-Gg: ASbGncuMnEBjJGubXKicPoIFDWujr7xP4gykVY27ArSCKDMxzp5HaW7a/fcIrKvmGTT
	xwOl6spv6mTB+umdwG47Pxca1YmxMZL5jrKwVFzD3dVo2H3spAxX+pNn1h8O1ojshY2oyIGZvE4
	sRV6o2UxLHMHYJhufeRm9uNNKb0g7XkfDJ0sJjCK6QK5lnxQIHassdvg==
X-Google-Smtp-Source: AGHT+IHEJ7vE4gi5RgLqomFtoI5GERYeArL9FKjlt/33MJezcaz4LvqnHBrczqzMF0c7tY7ke3BUtbN25Hbq0WYgaG0=
X-Received: by 2002:a05:622a:19a5:b0:47a:e70c:e1ac with SMTP id
 d75a77b69052e-47aec36591bmr112062821cf.9.1745111580039; Sat, 19 Apr 2025
 18:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416142219.554938-1-gshahrouzi@gmail.com> <aAPEUUAHsG2CvFbr@debian-BULLSEYE-live-builder-AMD64>
 <CAKUZ0zJoV6pLEFh6mEjz5awousn4o8Mq2D9AL8CfvqqW620X4A@mail.gmail.com> <aAREYg1uAc8NSVKY@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAREYg1uAc8NSVKY@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Sat, 19 Apr 2025 21:12:49 -0400
X-Gm-Features: ATxdqUExlWtyU2bbnRz5E1qlm3t9KbBZuxxYHLjhSGsEHuHTdMVaw2WyNWhZT0k
Message-ID: <CAKUZ0z+1JZs3ky3Yo4FNev8fow4bNvH_089=PvwEd-Rpvpj6Xg@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5933: Correct settling cycles encoding per datasheet
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 8:47=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> ...
> > > > @@ -411,14 +417,15 @@ static ssize_t ad5933_store(struct device *de=
v,
> > > >               ret =3D ad5933_cmd(st, 0);
> > > >               break;
> > > >       case AD5933_OUT_SETTLING_CYCLES:
> > > > -             val =3D clamp(val, (u16)0, (u16)0x7FF);
> > > > +             val =3D clamp(val, (u16)0, (u16)AD5933_MAX_SETTLING_C=
YCLES);
> > > >               st->settling_cycles =3D val;
> > > >
> > > > -             /* 2x, 4x handling, see datasheet */
> > > > +             /* Encode value for register: D10..D0 */
> > > > +             /* Datasheet Table 13: If cycles > 1022 -> val/4, set=
 bits D10=3D1, D9=3D1 */
> > > >               if (val > 1022)
> > > > -                     val =3D (val >> 2) | (3 << 9);
> > > > -             else if (val > 511)
> > > > -                     val =3D (val >> 1) | BIT(9);
> > > > +                     val =3D (val >> 2) | AD5933_SETTLE_MUL_4X;
> > > then this would become something like
> > >
> > >                 reg_data &=3D ~AD5933_SETTLE_MUL_MSK;
> > >                 reg_data |=3D FIELD_PREP(AD5933_SETTLE_MUL_MSK, AD593=
3_SETTLE_MUL_4X);
> > >                 reg_data &=3D ~AD5933_SETTLING_TIME_CYCLES_MSK;
> > >                 reg_data |=3D FIELD_PREP(AD5933_SETTLING_TIME_CYCLES_=
MSK, val >> 2);
> > I currently have:
> >                         val >>=3D 2;
> >                         val |=3D FIELD_PREP(AD5933_SETTLING_MULTIPLIER_=
MASK,
> >                                         AD5933_SETTLING_MULTIPLIER_VAL_=
X4);
> > which assumes val only has bits within a certain range which I believe
> > is the case here but not completely sure. Would it be better to clear
> > the bits regardless and then apply said operations?
> Nah, since val is being clamped to max settling time value, I think this =
is good.
Got it.
>
> > > ...
> > >
> > > Though, I guess it would then be preferable to use masks and bitfield=
 macros for
> > > all other places where we handle register data in ad5933 driver. Prob=
ably
> > > something for a different patch (if worth it).
> > I separated the original fix from the refactoring so the patches stay
> > modular. I can apply the use of masks and bitfield macros for other
> > register data. Should the refactoring be all in one patch or spread
> > across multiple?
>
> I believe all mask/bitfield refactoring can be done in one patch.
Sounds good.

