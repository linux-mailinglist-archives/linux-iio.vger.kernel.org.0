Return-Path: <linux-iio+bounces-23779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25EDB45985
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4EA1C873DC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB33570C6;
	Fri,  5 Sep 2025 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0PZ/4Yl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EA3570BD;
	Fri,  5 Sep 2025 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080097; cv=none; b=phenBPf7YgdE1Z1PYXolOnsQTVvmV1RwhGKRYgGUW/Fx/FRHrzy84eV7QQgoIsE1zbz0UvoDQmEeB4W3xszJs7JoJLslYDe6g0hCrjyDYGQqgh15G4e8g609A2WSx+2YwuP8D/Snj5t6v6VzHYdUKPZWf8UqZ12rUpSqMdzVl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080097; c=relaxed/simple;
	bh=IV8EMJd05teUZHrcSKuWc2hysS1Vgf+YP4DckdhISuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4EXqTkd8JaqWlieIoZHPd7ObTHDxUtDEET0bd7wq5STGLMkSCIgZjmYDoTJ8XDE2JRN3QkTZOjFITE18yqEsRFKKqk/p61WwVu42TijYcYarGXtVD0c9U0X89JMDQMr3jom+f+ToRFmG37+rkXN5M0fwGHV6IkbN0VdYgO+ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0PZ/4Yl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b04770a25f2so324177866b.2;
        Fri, 05 Sep 2025 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757080094; x=1757684894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV8EMJd05teUZHrcSKuWc2hysS1Vgf+YP4DckdhISuo=;
        b=g0PZ/4YlLKavSmxjlBGGKXZgLY+XgUJq7wzd6Es9CDpykHwQTQUw+gBtVZmH0fHdBe
         UXEMC95d+yWlKzKjVYbakfRmvTPVGy/f7p7+qmbEyYjpvIyHUcP/5QIjj9z5HFPrYt4V
         PIly1nooWfQFBu6wDuMa7Gw8PVbW9m31tiLz79/85KmV+En4873zeLsPQyu8bQVKCr3V
         2ISuyBcfBfXPRB6FeqtJgQr1gjYGs2uRTFo5Mw0YatM3jRAvCX7MyM2VlwKVRxOvjK+8
         n+NH3RF4dUGwbBrXSkBqiBTlM4wNL8g1WdWEwr1sJnH9ZrZF6PFfoiT4FKNDhEf3JtX9
         UfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080094; x=1757684894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IV8EMJd05teUZHrcSKuWc2hysS1Vgf+YP4DckdhISuo=;
        b=gkgXtaIvq6u1LG4lVIafKt7mDbYADN+hSAglPdigsHxqdqQoqXXgfGTBPPDqkWN19Z
         23cS3Ive6l+WINGSoStzLt0sNv+dqa8NmHoLATJXxX3hvgYBcuxBwQdOcvJ+u99i1ipS
         Y9CHjcwk23ko+SHNadWG2Y0qfxAXvw5ud0Y3VwPxaEr/4Jg2cBfzjl0aRmtHp1HJYNeb
         q/OvkmGRMg6nukm4o3bz1uUvFdjJdluIDmgXPp/bZ204Z2ss7IKsUN7eGzJdriHZsKWM
         Fn1XMO7ouwhdhhuY0uOp9uZAB96iAQk47orhDsJRVoDeRGLHXTc2/wCfNcC7iGII7dy/
         slMA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+/xo9hXDr4Kl11Bgp5k2i6EEf47NQYzKW+Nen4xQ6uzjHMl2I9TqlusKkJPPD8jH45hsoY9IFSap@vger.kernel.org, AJvYcCWAGJNUXqe7UgsT/gnTyDtz/Zl8zDeeX7JnM5LHwm5z2Euue8tJp2xrPx4dnkKrIbm8AcsMojaaPoX/5lku@vger.kernel.org, AJvYcCWp4/3w97xvtQqCdC9hs5KI8iuOK8Lylg+kcf2JPHTbf1QKXlUQwlYyBGk+t4BeWItn3wBAO8gC7mlg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0ARDGeZdi9jXeqNPWIfao/ol+uZI9uMClH4Lx9YNG2GWE36x
	1DYRVq336ez9UUpEYxIwni30iTK0l9qLXhDVxb+RI5q2ihd3CzsJsbtZKYlXtYhXmiOThbdUwus
	ImkQ+AXUlTV59A+EUQFfRJzGNZ+tbi8I=
X-Gm-Gg: ASbGnctK2M6otgER3gbKb3CEEi48+wfAj68kWyrc/0rmFXOfREfsMfugzeZ8TBBlz+n
	w99pbaBWEVYmXFbWmOsnqTmMvkjjMP7vuyQM+/VJ28ymCYNCAf2hU+nmbYK19CZM2ilPVzlWuoi
	vFeqQktz/kPHDJTI2UAkntQsXMuVxpPeofDogMXftJYn8CIQcMjCKcy/9cEj64/kLEBw0zIrV03
	mPgTs+izg==
X-Google-Smtp-Source: AGHT+IG5y2iq2fuH58mOJrA0CbrwSLMv/XFh8u1ZY8Vmzcks1QL1MjI+Hz2gmZQ41wk93y1coHDlkUMv04zBpFSzEWs=
X-Received: by 2002:a17:906:195b:b0:b04:6cf7:75cd with SMTP id
 a640c23a62f3a-b046cf776f2mr885447466b.54.1757080093812; Fri, 05 Sep 2025
 06:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com> <aKbgt_g3FsLMM8-g@smile.fi.intel.com>
 <FR2PPF4571F02BCC073F7740CBA818676388C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
 <aLmRWHZ-fNYjeYll@smile.fi.intel.com> <FR2PPF4571F02BC9E34D445208601939C798C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2PPF4571F02BC9E34D445208601939C798C03A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 16:47:35 +0300
X-Gm-Features: Ac12FXzY6FbBtJwb7pC5-vAxRcjldvKtYOnVokYxJmDbckJD_HWJWpuMCzxPOGQ
Message-ID: <CAHp75Vdi3W5VRfcEi8SOyTT-490_stCTXiKK0RYrgLpJW2JJgw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600 driver
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:43=E2=80=AFPM Remi Buisson <Remi.Buisson@tdk.com> =
wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >Sent: Thursday, September 4, 2025 3:17 PM
> >On Thu, Sep 04, 2025 at 12:58:10PM +0000, Remi Buisson wrote:
> >> >From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> >Sent: Thursday, August 21, 2025 11:03 AM
> >> >On Wed, Aug 20, 2025 at 02:24:20PM +0000, Remi Buisson via B4 Relay w=
rote:

...

> >> >> + /* Wait a little for supply ramp. */
> >> >> + fsleep(3000);
> >> >
> >> >As per above.
> >> Yes.
> >
> >For both cases actually you can leave a comment, but rewrite it in a way=
 that
> >it refers to the datasheet. This will be useful.
> Ok, I'll do it when the delay is actually documented.
> Unfortunately some of them are missing from the released doc.

Then it's good to add something like "this value is empirically chosen
as datasheet doesn't describe it". Or find better as you know more on
the cases.

--=20
With Best Regards,
Andy Shevchenko

