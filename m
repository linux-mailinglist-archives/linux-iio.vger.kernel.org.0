Return-Path: <linux-iio+bounces-23281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29AB3565F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEB9161C31
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F1283C90;
	Tue, 26 Aug 2025 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKEQw0dT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21299281378;
	Tue, 26 Aug 2025 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195575; cv=none; b=SBMKach3vgftK9Wid8oXoeUDVweP9F2NCg2PkyRiBwwM9zPqEqMzmCDxCEELC6iuJI5pwhbuMZ3sSUw8va/NZKHvw/gfiu94aZqV4I8c6H9JY0ab4Aqi1r+0LRY3B8I+bqa+I9Y6OSfMcV9OMNi4VBOlZzUzpMxqj2sMosN3D8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195575; c=relaxed/simple;
	bh=McZAuFqJCEkI01Usp8F/y40UxCHUiyXewUgBInoEEF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5sD1/i9cJeGQw3ULbPu/bp5GGnT81DesDQVuZcVKZKEkxcknVQ8E0LwQ3ygalmTx5aPjggebuvHTMtz37GZFjQgii1CvjnCURjgn98eldmPSK6LzOqbVUtceTHzlAOxQD1mPRFD5VG2rpUMlMLvCoPpbLisSN16RkJASVOSdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKEQw0dT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7af30a5so904493666b.3;
        Tue, 26 Aug 2025 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195572; x=1756800372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wjbO+/CzvSzhggdBHtlSBiSOrC+TN4SiqbwtSU008o=;
        b=FKEQw0dTtTi8gzGSRMMHlKkaavQEpUGGoBPUpOhHGHXnPpsjsTBTp1fIG/x0Y0bCay
         c8i3hhzhzkToyvOg5O8VdtVxDAbbWjMTIKtkDsNTD1ziP+EJBLXOOqd56IHJ5Ie+U5GW
         pCBk2z7bWIIqjV6SEGA2aYK7sBVW8XLFxHzCBIfJS/CXZ34d41io3yUHeoOJl+9S2AVX
         2zJvVpqdMwSDqLIh6gBOaObhErFZ2eVGIuWBmobz//43AIyDkLykb6tiFA/CVLAx7Kyg
         15l3YSab4l0/y/RcYHDoqSigbUZ5N1ELCL45j5wWls2MVK1168UQIkjQvS213q2Z653P
         hY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195572; x=1756800372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wjbO+/CzvSzhggdBHtlSBiSOrC+TN4SiqbwtSU008o=;
        b=Et/tOLYD0IVcl2jnPLc1N71BCzAg/7+0/rwSCdNDZH3bLcVBZgF87YRer9dKEXT81c
         kuN9UfRgjBZm4gNP+9BIdQLYQJRrm0nKm45E9IJiBvNk1CkSGN7vihQGZ6gVrF/WvgZH
         Nb3RFhWX+za98AMszCt+yELKyThn5WjRFpoSRut+4QmwsNtxnPuuuplOglqjTsJXC+29
         qLavwAq1NS97nwMpPmcz1zHaZc7Jdmk/drmI4QSH3Ml6JjZQ1BK8CSue8B+ssuS4gTK9
         FoQkIMNg9s7UPw5ERFJPXSHgSLnCdwKBAaW38Cv/jGVInn5dzyPzGKKYicC8L8CAWNZe
         tnZw==
X-Forwarded-Encrypted: i=1; AJvYcCVykzrzOESl0muxcpzTcVHPHOUVioWCV2d2UA0GJSFFfM9xJd0ohMXrVr8NOJ+DG/7vW/RSW30+lSM=@vger.kernel.org, AJvYcCXxze17CSSeOpeNCZu8LER1yXflG1HTvgQcU4gPAoYaqeaGG2xGlf+QiISLq1UxaQlGqpREZT1eAER5OKCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaM2FPtdS764/ZikA+tSL3UjlP7cFDCaMKj+w66UQTJSGeMcmJ
	RKII7Dxwtz6WeHRzHoda14aBKMjmmBrcy0zgH8oIUt5RZwgvZXw/wnR3lhaOQIln3X5xc4dR81Q
	JgUPzgH/HbH0/4m4CjrfoRoyjRVZ0aUU=
X-Gm-Gg: ASbGncvZ4lw/XeEZkSnAeu4sbDV8kXndHLAMmv4HBzhZ1Dgi2ymxtVhDfD0VPjLs58b
	SPxSwrISChhvzvOEfPveCi90MKrD1+W/jECJZf3cyFfx6bxuLmkUHP6ep7QHlX7iI9l0iMR5afN
	UXzgbyjck8TGvCFWlTjXQkcSg9CR2mTva1m6z40dgDWZ7Y7EJ+Ss5gF3bT83Kaja0VCp1RTbjrb
	KSagDU=
X-Google-Smtp-Source: AGHT+IET95gesPsImlWxfCSqXy/xiG2n7VC6emkdon2TKt+AHqmFUOCd9ze1yaM/komtsJdO29Rh9lxV5vuG/ZzJHKo=
X-Received: by 2002:a17:906:ef05:b0:afe:8761:e77a with SMTP id
 a640c23a62f3a-afe8761fad3mr537764766b.19.1756195572104; Tue, 26 Aug 2025
 01:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825205235.1766401-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250825205235.1766401-1-sakari.ailus@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 26 Aug 2025 11:05:35 +0300
X-Gm-Features: Ac12FXwdLHPHoVmXYor1LPriFlV0142umbIIkjkJQym6xu1Er8B2ZfjAPn-xRkY
Message-ID: <CAHp75Vcyr2gQ_Z7BV5nEJCSb1taWnBOfCfTWMQtMG-65Z+D0Dg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] iio: dac: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:53=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Also clean up error handling in stm32_dac_set_enable_state().

TL;DR: I think this change makes it harder to follow (due to complex
conditional).

...

>         ret =3D regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk=
, en);
>         mutex_unlock(&dac->lock);
> -       if (ret < 0) {
> +       if (ret) {
>                 dev_err(&indio_dev->dev, "%s failed\n", str_enable_disabl=
e(en));
> -               goto err_put_pm;
> +               goto err_pm_put;

This is one time use for the label and we know that ret is set here.

Just

  if (enable)
    pm_runtime_put_autosuspend(dev);
  return ret;

should work.

>         }

...

> -       if (!enable) {
> -               pm_runtime_mark_last_busy(dev);
> -               pm_runtime_put_autosuspend(dev);
> -       }
> -
> -       return 0;
> -
> -err_put_pm:
> -       if (enable) {
> -               pm_runtime_mark_last_busy(dev);
> +err_pm_put:
> +       if (!enable || (enable && ret))
>                 pm_runtime_put_autosuspend(dev);
> -       }
>
>         return ret;


And here is as simple as

if (!enable)
  pm_runtime_put_autosuspend(dev);

return 0;

and remove the unneeded label altogether with the error path.

--=20
With Best Regards,
Andy Shevchenko

