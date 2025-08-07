Return-Path: <linux-iio+bounces-22415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C065B1DEA6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDD4621A9B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAF234964;
	Thu,  7 Aug 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+ONzbr0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA61D6DDD;
	Thu,  7 Aug 2025 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601189; cv=none; b=jjS7NeVLp1NtEKraTPqp6fgBwCPCWUAxBzuCueeMPXOjNst24ws7HB5+Du5R5rFn1ItjnisLoSgRTNa6kmEKc2aQs6ht1g/pX7ZTtgFifhfJ/bw0dZ8pjIozXa2DJsTPvyV7xHhdN4ZHItcETqASvAqQI3ksakx/ZDd0/utY9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601189; c=relaxed/simple;
	bh=GmFYBr1GcHlNqpxd0OwYMyfM1UeTwsDVBCa24j1LqRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfHJnXKuMsc8992pOQtc6vhW1nwX5NEs/vPH5dHRnQwpRENjsmJVVlE/ICnOSDak3Z7yb3M4E6I63B7+NVqv5mziz0SP7JPMob5VTm5yEkkhbc95pDhAEnfWLsNYAdlWUZyED8nrSMS82+kjT9Y3rFuRu4/Ae9OXJKBYF9Y+UeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+ONzbr0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af98b77d2f0so268019666b.3;
        Thu, 07 Aug 2025 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754601187; x=1755205987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmFYBr1GcHlNqpxd0OwYMyfM1UeTwsDVBCa24j1LqRM=;
        b=Q+ONzbr0TuG1JsJu/OVj6Xr2Vlh31c15MB75DgHH6IdQe0k7s1hNSzQxVNSHocpgw3
         hu+jpangsAIZHI+99AIHb8qqNA2qCEozLpGeoV47sAeheUuibl/dA+tWIL9EkDWi3+9H
         WjRlQiO7js48PEg9Nee+9No45fINt85JmVwkihapp6rqxltABHhke4D3mGGYZhubLCrj
         UIFar1fAbNj6yExh6rZ9RaCKTagmgWg5s7h8U1Xc1lPW8pDiUlDJgeG/sDKNch41oySF
         +VpzUjV6/29PLvTd+2Pru4Ux1oL7Ne3ElJU7SKEIuH3wk6iJkoMXHHQuboW13MEiVn2U
         bQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754601187; x=1755205987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmFYBr1GcHlNqpxd0OwYMyfM1UeTwsDVBCa24j1LqRM=;
        b=lkrnjQqTeplsuXlJmV8EpXVjidGWS5Ol6yIZh9X5Flsaws2V0KRxlom/LmuAssTT2+
         eEA7bHEY32v6if6DuhNfn6srXrF18Rf71TKttO7cNjf/H4m1HbVCD7Ksx59ZNhEQq2D3
         Nwd0Ztil3LVRg95yeYWnuxTu19XBcBqDP95ztA6R253EyK6l2qFK6OEA68LqNvUoBCP6
         PuD89if4HHBMZrHNzqtYEFzz9hvRyQtMJyIHUPjf4N9W7knQpS0AsIHAQ84BJHpxoFSP
         uowQYujS3ScNd109M+1a78l+vDi4ljdhYhWG0X5+lhhS5y/0EgBSEC0ujx8OOpiQaYLt
         vs+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZoyzNO95D45lixqr0Mnsf5Yq4XFKN8Emttnb+c4qM/VPTYuyIK4V3FkIreyxVYf0nRNks5HplXDEmbBh2@vger.kernel.org, AJvYcCXjsMcVaqkyb5b9WG7ZuzG1KNmKFlWjJ6mXe9SDUbvUNtC/nIndat5j+1GkSAmxG2fqonIkvZ+R42kG@vger.kernel.org, AJvYcCXqS2xR0l2g2JeTCG5K8a42u624pPEk34pBEPXpKBR9LU6wY15ZH+YOXzxUugjNMdTnJa3OqesKYVDp@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCobL1eI4kl1gtS5f1rXr69N72boMwrOXctR9Xaso6buw+23h
	gThYTKOndYNNNft95j6D9j6mHiQ/AnarouvXx1c35p+/sSlrN175BPMmqX3109m3Jkn6ZNj71yl
	QUqfjKmUQrLSrxz5o281XkuY4yEmeXJE=
X-Gm-Gg: ASbGncsNiJbBKhwWmbgMLwRh1ZvAnJYdl38cm0ADQOJsCOC325BCegCVsO8iRfnSuBV
	mgScHPiG4Hbz8EYnahQsaY0Gh5UJtw4hcDGWbH2DgX7Orq1QQjUWd3B+pvTpgycycoR49lUQ8Rm
	jpjjEHTm+daH3Zc8pcs1dWBMbZ9Y4FRzHxm8A3Vy43UaYfHvjma1xX0ZrqP8DB6Eepnt1CshzBh
	tjaHSdw1gD24X1lLFgf2PtqyutIHQt1BrRnoCsGYg==
X-Google-Smtp-Source: AGHT+IEuI8VCy1EslHrE+4Z+UUz+p451H0mtrKKDMlq08ml5ds3IkxiZu08zCT7QWRTdtOjc+j8vo57n2RzhNXPHJd4=
X-Received: by 2002:a17:906:7952:b0:af9:1184:68b3 with SMTP id
 a640c23a62f3a-af9c658d4e5mr32875466b.55.1754601186623; Thu, 07 Aug 2025
 14:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754559149.git.mazziesaccount@gmail.com> <b23ac0b287926b87c36c74e9057139c18e3f4c91.1754559149.git.mazziesaccount@gmail.com>
In-Reply-To: <b23ac0b287926b87c36c74e9057139c18e3f4c91.1754559149.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:12:30 +0200
X-Gm-Features: Ac12FXx1tHisvZX6gb317nkX4elI8JGSiIccFpBI9VuhFun0CsU3Ca_UZrGMjq0
Message-ID: <CAHp75VeMwqxU9JaE6vb6xMffCTyAU2tevASduOWdgk3YMikPQA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] iio: adc: ad7476: Limit the scope of the chip_info
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:34=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> The chip_info structure is not required to be accessed after probe.
>
> Remove the chip_info pointer from the driver data to reduce the scope
> and to make driver clearer.

the driver

clearer or cleaner? I think you want the latter...

...

Not sure how the future of the development of this driver will look
like, but it might be this patch will be reverted if one wants
something else from chip_info to have a longer lifetime.

--=20
With Best Regards,
Andy Shevchenko

