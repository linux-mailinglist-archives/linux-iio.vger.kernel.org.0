Return-Path: <linux-iio+bounces-27000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1CCB450D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 00:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6A23050BB5
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 23:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250232EDD70;
	Wed, 10 Dec 2025 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5PcNG/u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4D2D8DC8
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410541; cv=none; b=lCfHWtP0uYeO+ABjSQdP32L+AM2KtJaGE9bSnFo3JnbreWnjJXwTB4nJ0uST7Y1X+e+AZwF1CgTQdUcqilkEHU33FEB4R+vb+Kb6y4cm+quvqMusSl9cXk38Oh+51glX2smJ3jMuqaCRK7qp1rmkM3qktkx60Wf9K1bd+cDMOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410541; c=relaxed/simple;
	bh=y60yzOXBri/L+USfjESMvBfJsbTzqKzZQxx5cZLYtRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5pVYQ/skqLDjWGFflesZFnUOqD35OD6rdRZSfBv6lp8G5CD32xkccPsiNY2zLRM6H6YPvmT0siuYgmCP11yd6UUs3zopjtf/57bFFcltxRFRqhYom733qzt68epwvRpkEZ8R3l1uj4kAiLbQ4KjZ5tLdB+yrobsLNa+6ESHssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5PcNG/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604E4C4AF0D
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 23:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765410541;
	bh=y60yzOXBri/L+USfjESMvBfJsbTzqKzZQxx5cZLYtRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z5PcNG/uTJVf8ovzG92XbInb4q24y8r41AstnbLrJFLDt5QLKazLsd809WCY3YjRl
	 /Bt5nHS3rEKbwZKpgbeOKdnw45dydjGAzC6HKjUuOQ/1h3Mfgtyu2NTIvVwf+Nd0Sv
	 esbhxLVcghcF16UOxj9Gk/T5NgU4oSVl97S4SrL/St98jJOqXCFAsTnczBHtXwQSVP
	 uYrY4+PHiPgRTyI5rGJSjktcsV27IJ4fSN4LaK/lNjV9aThTFBryjLshyOAqYSGZ70
	 1JC1Uuuc5DcRs9Te9ig5lD144ps/zZnFzaivGSnckFhbIs2+R83w1YBIxbe7dPadcM
	 bUZPGvXr8nwXg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78c6957a327so3881207b3.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 15:49:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBy4x9iJVDWhuU5DZefsTMix8NykP3SdLBgOSfSmKfBZKWiOYkRP8McHQ0BigvRCFMehou3r/eqCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgthXzIbEx3/ihS4UkVSdyTCPjG7gIwv15hvuCNMc7h/DEwBt6
	ps6CzqrZ+q93EDVzFGAO0OvD3wNgOjrl+8WxkSv7V6plo0I9lBM1NRNORk4ivYoev+Ga4ErJG0D
	ieo+I9D2+Cjj4InMhWgDVywpujq03pi4=
X-Google-Smtp-Source: AGHT+IEHXvr05tQprOfY4yuLemAclzGDIykx0DQotGMLD9Gxdxo14Y7Yq0Ns1rtG/7YuZgr9lz1HdVefclNdAjlBPqA=
X-Received: by 2002:a05:690c:45c5:b0:786:a185:13b6 with SMTP id
 00721157ae682-78c9d6fd106mr38184447b3.22.1765410540740; Wed, 10 Dec 2025
 15:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com> <20251205-staging-ad4062-v3-9-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-9-8761355f9c66@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 11 Dec 2025 00:48:49 +0100
X-Gmail-Original-Message-ID: <CAD++jLnAcBv0Lb_e6edAz82UkDZSeb-3y9Xm3m4rsgHiw0kLJg@mail.gmail.com>
X-Gm-Features: AQt7F2rsb8LxbmyiV3W00GvP06QDfHAe-VUxMX5VRApDEsFfkERPeYu_jWokYRY
Message-ID: <CAD++jLnAcBv0Lb_e6edAz82UkDZSeb-3y9Xm3m4rsgHiw0kLJg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] iio: adc: ad4062: Add GPIO Controller support
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 4:19=E2=80=AFPM Jorge Marques <jorge.marques@analog.=
com> wrote:

> When gp0 or gp1 is not taken as an interrupt, expose them as GPO if
> gpio-contoller is set in the devicetree. gpio-regmap is not used
> because the GPO static low is 'b101 and static high is 0b110; low state
> requires setting bit 0, not fitting the abstraction of low=3D0 and
> high=3Dmask.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

