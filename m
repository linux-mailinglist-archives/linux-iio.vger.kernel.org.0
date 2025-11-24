Return-Path: <linux-iio+bounces-26414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C00C7FBB8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E43A152B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F212F90E0;
	Mon, 24 Nov 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYSQdkYO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB02F692F
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977923; cv=none; b=ljs35SWIpqdHB74oHggdbAeLYTOC8T3iz7ctAdBYHC4ZZyJbPVzSNf6ebbQjqKMk8cVRGyyERiolt7Vv9dHCtvVCbA57eoX63voPnxQRs6vhl17KoYG/DYgxM4IQ277WrY+BchmyoLoBheI+49hMK8+zSOO695Cd4RnOQ7PsQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977923; c=relaxed/simple;
	bh=f8IzbZqTMCeb/MOC5nwDIM5PFvIpVV0LTFnqn+Wk2Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcwiekBmcWfCfNeckP6aEsTBomfOqXDRz1qMcnCogEAkPThMBH7+jlweb/+KBi/7JHg40i4RUgJ7iRVh40igOi7oM7KMP/wy8N98sScaKor4fzRiTyxD9I5dbwXPf+Sy5IKM1rWTvjkzQJ4U5hfeHEfCeomjwAx2tuyrTudVgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYSQdkYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291BAC2BC86
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977923;
	bh=f8IzbZqTMCeb/MOC5nwDIM5PFvIpVV0LTFnqn+Wk2Pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eYSQdkYOHyyx/c/Yu3wSutJrFDcJTgM16ycSFZbtHmxJNQxMGEvPwl1c9WVEAg/yk
	 Kb4H8zo1Sk63eCSk8kN+eQl21EQhQIY7KVQvUNMpH9MDqZn5bjjd4jUWHktM089dqx
	 /KjDck/44yPo0BV7OTD4lsna24jkFnrSiLZ/WGHqtdB/DYNpf2HR5of0is4Mt6Na/5
	 LGxN66R0XgF6ivIF6ImAyRYr1hT1Hsbkk1QMZUNL8Yey93pT0Vvs6Wi5iZe0UB0lpr
	 cue875jcnDBToYyBR7EPduCkCbGuUKbgpd+uwSWSs5znbaFkmLNfEI/63V6spI66K+
	 zQTv+HeDusNlQ==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6420c0cf4abso3457905d50.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 01:52:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNeZAHTA80vDauq2AFfyVIn17RTdJSK8ppUgQd6KD8A0ZHTJuvH3Y1JM4p3d/oVocnNNj0X5sbJ5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Uhb8aVcHhqU17ZRdr18QtQpsRKB4yqXdvMVtAT8wPmQBUanl
	04u7ixsQZ74ik2ZKazxh09WNdYmEkN0I/jPlzrgxvX8PtfxQlUceCR0KElFVWAthQYo9owFKe3k
	YRggoFOmgExuNe53MOMGlZF4zuFcEpMw=
X-Google-Smtp-Source: AGHT+IFoCWzua4d1h8HPXHaHqQJlmJYLHD9RIgw/SyJw9vEkucpSZIOkMOpRjURGkLzo6FVhZaxStxOM3tH52OqYiiA=
X-Received: by 2002:a05:690e:1904:b0:640:fabf:565d with SMTP id
 956f58d0204a3-64302b102a7mr6921804d50.43.1763977922443; Mon, 24 Nov 2025
 01:52:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com> <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
In-Reply-To: <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Nov 2025 10:51:50 +0100
X-Gmail-Original-Message-ID: <CAD++jLmU4F3DBrwm66_ttfENn5N5FOV7JwedBkxVWTpmjD3i8A@mail.gmail.com>
X-Gm-Features: AWmQ_bkME9bvVabS8y13XZ0UVUDiRQpdihW9D32F9i8Ppba0nUS0lW7F38rMSzc
Message-ID: <CAD++jLmU4F3DBrwm66_ttfENn5N5FOV7JwedBkxVWTpmjD3i8A@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
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

On Mon, Nov 24, 2025 at 10:19=E2=80=AFAM Jorge Marques <jorge.marques@analo=
g.com> wrote:

> When gp0 or gp1 is not taken as an interrupt, expose them as gpo if
> gpio-contoller is set in the devicetree.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

It looks to me like it will work!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

