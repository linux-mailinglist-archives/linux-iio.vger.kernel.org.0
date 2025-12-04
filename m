Return-Path: <linux-iio+bounces-26739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2C1CA42E3
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD440318DE72
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E254F2D3A69;
	Thu,  4 Dec 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnQ5pwOW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE12D0C95
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860769; cv=none; b=GccliuqzFqrD1GwkGynhIyDI257ZesOY2Qay14SJJSZvAGWluEyTxx7BdKvHZQF1J9hCLrVPKdPcPgPIXxweB39BOVk1P5nhzWpQPnSPxpoWCDI/F6MZlf+NsDy9W9Use/pqXIh1unnWM8HHabayfqr/wUtL4aSIZrp946NmAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860769; c=relaxed/simple;
	bh=hFqO6XHrjSFGl0jcBtxfzmKc1hL5nO7fIAsuruPYZW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLUlzgXwh/XXzz5GMQ6zizJqwrnwvjp0QX0jpmCKnT1/pLhaOgcrxg3NZKUDIOZ4RybIfHKZyGsrlg+LWh7kceefGW0/hchPZa1iag6Lqk9SB1ir9CipBYhl6fxEZFaTOEwlDyziJvCM795zv/PweAhO3q5BHGrThRcHkdzhUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnQ5pwOW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f98adea4so59393966b.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 07:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860766; x=1765465566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFqO6XHrjSFGl0jcBtxfzmKc1hL5nO7fIAsuruPYZW0=;
        b=YnQ5pwOWU97kJC5ZlSCq0pNuUJ68Tv0sZOYghQD19T4yGvHA/VCOFZtZ84FeBh0K1g
         U1jAwN2tQXA67DgU/CVkO/u01N818ZTJiSIe9K2T6rAumEgrCC3V0v9X6+7KYynoLaF5
         88GG/K+RG02whky2hGuzXgAgkIZmmRPElgTIB5j+HFF1LA/l1ybu9RC+VMXypw7I4GYz
         avIbijUpXN55r8KbVt3GT7mX7JeIebrX/WSGFVqHRDCy+v8SjC5zyHkmUf/pCFwBsJgw
         H0D3hzNswAsEkRu0szPiuIMT8NsSth8//nRZyCaGmA41Rtj/m+T/QuJk1D76Izee9d3i
         q2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860766; x=1765465566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFqO6XHrjSFGl0jcBtxfzmKc1hL5nO7fIAsuruPYZW0=;
        b=SSZvbYyy+pZZKWX9eQZXJAYLtsnfUBnjLRtMFWve0WfHUicNegOmvRWALRo8ByBSt0
         Go4qE5G+JvjtTeA3JfNWG9WN4o95XzewHxXXoWkw63AHGcRw2eqr+4x/GGQctr/xBtO4
         DFy9jOkdQ9eRImZPcHfntZ1aewXPrn8W/X0TLYEoTy6S8LpUhzfEPZhB5aV38wV3BWoN
         46nr6bUiNKRO0xpDHDm5auAmCkPtUo8N0/79Wm/gtYI99M0njLqO4wUj8XEN9WNcRwzE
         D3mJypnaB56JQ7IzmqD82B5Q3VeHCWluITdzXmDONfuZzKc2Q0gz5AxbGYeVhYjCJA0P
         4TQg==
X-Forwarded-Encrypted: i=1; AJvYcCUdW5N4kh3yHAuiZCB1USMkv7tpNOy6H77f815R//uOGpJRgqwBJLOdb0XkgHECYgLoJyGrdDzlMMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCq/sQwXVDw21bhFaqeYdNsZrWhdz3ymmIsCMZitEI6OosYhl
	77PxM4QBwFJSTufzKfwTWWdAa2l0bbSzYHbhJV0RAdiLJwKOtXDlRgjAfixoMVgH2HkRqkj9bMx
	VqTyHLfdzRMJOntsoveDTPwBfqmVItB8=
X-Gm-Gg: ASbGncv9ovsc02R23z94NFlrxTIfjrr2OJjugBiQQJcK864BOH32zDEeFyKBuc06Snh
	jFrPOj3ThEZLeCCfx+le1S2oJdk50zORBkLqfdyyjUTCl1KftzZvsQUlS2xFpjQ6AYBk2lvmaUt
	rxlMxYNdJYDDvlqXNEPRpIV0BG8T5m9zInobRzG3v3E7tUBBC32R/zV1A1hQC7ptOHUDZrqQgzA
	IkGvVOP/1QknGnvJab2GECqrGbsW9yxYkaX0++IjD26orE8kB+0auRA4K/VksX0rkFMt2SvWj41
	2lTw99UBvuX1OyO8yWOmIssvcCArQQvnKwyQ6ySwcpeM34fYlh4NTv14DgDqwis5MoK8w5M=
X-Google-Smtp-Source: AGHT+IEsIHi5AAyYHsYb+1id4Y7bouRrkpL0pgoTUjdg/klJNiuzZs0555iyiXeYZPtCteRrxlasCr65nCQD/rIGNlQ=
X-Received: by 2002:a17:907:9803:b0:b73:7d96:5c97 with SMTP id
 a640c23a62f3a-b79dc73ccccmr671810666b.34.1764860766031; Thu, 04 Dec 2025
 07:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-1-b4a1fd639423@gmail.com> <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
In-Reply-To: <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 17:05:29 +0200
X-Gm-Features: AWmQ_blGRDM7MVTXB5gFlZZg3yPo51cK-pjKGPxgtiikcQ6KAiNmodUFfEJCy1M
Message-ID: <CAHp75VerpV6u8DgQH53a=2eAPQGk4KgFobXTueh90EBnFL=BTg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return semantics
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
	Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:22=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
> > In order to improve API consistency with conditional locks, use
> > true/false return semantics in iio_device_claim_buffer_mode().
> >
> > This also matches iio_device_claim_direct() return semantics.

> Even if the rest gets a NACK, I think at least this patch makes sense. In=
 fact I
> would even extend it so that we have the same inline API with proper anno=
tations:
>
> https://elixir.bootlin.com/linux/v6.18/source/include/linux/iio/iio.h#L67=
9
>
> So it really has the same semantics as iio_device_claim_direct()

I remember I looked into this when Jonathan provided an API, but I
have no memory of why we have the -EBUSY which is not used in the
callers.

--=20
With Best Regards,
Andy Shevchenko

