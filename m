Return-Path: <linux-iio+bounces-19016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D624AA8090
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 14:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27D21B6315E
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 12:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEA1EBA07;
	Sat,  3 May 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6i7Id9v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6A17D2;
	Sat,  3 May 2025 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746273793; cv=none; b=YaN3c4i+B5YaVqM8HrQJ+Fadl2lzIIUlQofXCSXdKvqDtdYVHHMPakG+XGyKXhKNQ4ZwtgDp1aN9fa0CofqF4/qTRZEQWAalRiZbKggxsb965GO7Agy9Xp5ye9l2N7O4B3JzfgaaF1yJ/EM8q3ugT7kAO5CQuib+ntXeKTijK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746273793; c=relaxed/simple;
	bh=OEt8G+Ag3SLaqjCFusuKOebFyl29ZIf860tFYCUH7CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAmTixjhNYpAUTJl8xEhmzbtyHRETgjUZNkxPB2ifB+qyZ2Bg1ijrVka4dAnMVG0QjQQs4Kg+ruh2TsSL8HaHIwGkPJ54rMR/tB8bl859TP/d60vk2EdL/3uU1MqPdBGagFz7vS73S2fZ/9gt7Zt9x9NoRxg/Qnm0g7REPl69GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6i7Id9v; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54298ec925bso3619928e87.3;
        Sat, 03 May 2025 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746273790; x=1746878590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKuY6otB9fw2NIqkejaF9kXyx1KrQ9K1xBRP/yPEK6w=;
        b=T6i7Id9vjoVdE5iDWBJFJ8i5SMWu/LHkSB6JrefeR4XTG1KmARdLK5qIkHcrc99bAC
         z13cc9APwqJUaz5rq07gEkgsgs3DVH72JB5mKn5caHiakRPdO/xjr5eF5DLf9LjGOjg+
         nXGUKcOVGXJ4iJEAYeD7p6+h3AltgoN1LiuN7scRrNAdu3B8pNPnuZWV3SmYpSXsk6KI
         x6EKMhmadkKzvmTyI3UCgwnAPACdFvRBAA6XCuxx7foHWtqsYib+NpNWHmBydCfiVpCk
         RmkXGKvAPzMcMoqISg3S0L8GV1PU8VJkBd5wk4i7aKDugcf5GjhYwYgZ3F7ao20Pv0s4
         LIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746273790; x=1746878590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKuY6otB9fw2NIqkejaF9kXyx1KrQ9K1xBRP/yPEK6w=;
        b=jCPGblzB5dZDOc8Yv+QbeJYQpIK2yax0tXuU1p5vkakDTB/NMuLWufvPN1dTVce5n+
         pqb2im86MoCRDhuvs7x7k7TOL96ZR4erqceouYb7A5LOH/DYmo9Hs1zkZyOAXibDJRke
         XmT3Vhyo7lLp4VSvPW5nNaMHMktEsCzONk97LSXSUyPhQx9O0Bx5Z0KezBrj2Bqwwqcq
         m4JYKqPqdYcpJLBM/MOp6UtWTEQXbNd6JzegUipM67X+r++mMiPyxFhYohzjrFmCGqjj
         4XVyo9w8GgNYcA33TETPTcWeqm/JkXtAI4QQPnvw+zMcacJvOj6sr2eZFNtz2n9GASiw
         41Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVWx6kjgDSz664mGaeQjflir8fRFydDhHvmsSz6+oSvagnD/T1t2IWXWzJus61nTwKJEdlrtDwrM8o=@vger.kernel.org, AJvYcCX7JSmH19HQXg77P/4j8udZJvVS3KOcDxl8XXPznJqZDot70hnIXXN4+OKnIUR6a0KTxmhpwkLS@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgl1CBSQjTMzQSbREGFrUV0jX0AbpnOZu5Rdp/wKgLPIg46d7
	ivf07Xwqba4sJ/vi41ji084tlykkCVQm/EckamdVp+Jt0d2Nu2ds8Pf1wCyEmrijTyAABO0X9on
	wWp+GVUi2vQYNPMvSi6EB0R6i8Bg=
X-Gm-Gg: ASbGncv4qfMvR7fmnRQRLMakhtJZAr4yDAwLzrIoBWK/7nx3is9z+JIK/heJLeuquyL
	r/cEwH1FivmRJEJiF0E4p3oLs01MZrSjdZCNGMJrvLvw7r/489cgCmkAxW1+qQHoY9VY/kbifFm
	5RxxEj52RR6vjuFchqmO4iBnF0dXAGxzI4OqgZN7ab2E4xLP6w1bo3HA==
X-Google-Smtp-Source: AGHT+IEb47l323lf49IZoHkMOCIJAgeVO/ifoErruMM5XsHk24ZQ2pxuf1m99cyIv2H4/PInQGdanfm9XZt2KTyGu4I=
X-Received: by 2002:a05:6512:3e27:b0:545:285f:cd7f with SMTP id
 2adb3069b0e04-54f9efd1cebmr279646e87.14.1746273789468; Sat, 03 May 2025
 05:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
 <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
 <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
 <20250430141112.00004bb8@huawei.com> <CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
 <20250430182537.00007eab@huawei.com> <CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
In-Reply-To: <CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 3 May 2025 09:02:58 -0300
X-Gm-Features: ATxdqUFoY8FU2cVEAlI1UsdVnI0UeP_hxCXSFfZk3p4g0C57rd4pxtCho2dRPxQ
Message-ID: <CAOMZO5Bbpiz=xMKxEe93dNOkO2CLT-nhVd1SR_rvjOYNzn4wHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 4:37=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I have applied your suggestion.
>
> Please take a look and let me know your thoughts.
>
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events[]=
 =3D {
>         MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),          \
>         MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),          \
> -       MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),      \
> -       MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),      \
> -       MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),      \
> -       MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),      \
> +       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),     \
> +       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),     \
>         IIO_CHAN_SOFT_TIMESTAMP(8)                                      \

I have also tried changing it like this:

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events[] =
=3D {
        MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),          \
        MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),          \
        MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),          \
-       MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),      \
+       MAX1363_CHAN_B(0, 1, d0m1, 28, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(2, 3, d2m3, 29, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(1, 0, d1m0, 30, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(3, 2, d3m2, 31, bits, ev_spec, num_ev_spec),     \
        IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
        }

In this case, the warnings are gone.

Should the masks be 32-bit?

Thanks

