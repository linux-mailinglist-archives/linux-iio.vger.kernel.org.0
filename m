Return-Path: <linux-iio+bounces-27151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89880CC889F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F9530BF82D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09937C0E9;
	Wed, 17 Dec 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4Kf/q84"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD737A3EB
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985333; cv=none; b=HxgNgKagtCqpN8pZI0WSwrbfnNJqrTm54+O88QGZyl9mOhMAPSTQANr7ANd+dEspyf692A79Pb8Jeo49B5fn1/dCLqWf3AdpOOaHKrdKReD/znmFhIup7x3QioMYg9TYTxA2uY7ZbT+oqjqQdGjOIPeTAtwZQMBdlh7c8GSTLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985333; c=relaxed/simple;
	bh=g2GBN3njSzISEBsyHXvbwpMCDA/0jrfTyD+Ehz7ZsM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qw+Z/PlkR6pW+QLxxjs22NgOuRdZNsqkdJbo1rx9+0e1JuC+u4zQz3PkkKs+RioIZLz+PgGKjuVkvWzJuK30Jg8eQHbdxqOlFJBF0rz6o0K1BQFfPZNmxuZkSYGEDyYKJiT2qqrlJVeViM+fNTHgXorCJX3cfVsaEhI4Fv4yfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4Kf/q84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F37C19421
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765985333;
	bh=g2GBN3njSzISEBsyHXvbwpMCDA/0jrfTyD+Ehz7ZsM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k4Kf/q84Ays23eHaSOpgsQjrbt3sCf1ABQeRmFMST0zqpaLKqxEIAzoxc1Skq3zcX
	 wwUbrPtFJuiWy0r5ehThItRlySTgiMjS+vQ0ug1RfTeaWRzKTZpxTQ/91kn62VJc1K
	 6RN7rg5bvQb/n50je4j8FV9qIesN8o3hUQsG6mzwapbHbNlJ/olfEjY2LoZWczWpFh
	 8rDyczzT7cU9EmjzfSAtm4xLGRvMmDAKfi5VOWNMcbOwFYTS+OAFjclIsxjhwpQqud
	 8CrfY+uI391DE+1yrLohV0COTaTkcDewU3mWQ66yVRxDYGp10DO63puiwbpYxLEYg+
	 nITRrJjJ4XENg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59581e32163so6909099e87.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 07:28:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN3vckeICy7BwuqTkwJO34+r0RZOsfihP5dYhvvfxouPgzbwkyxDG0Byns0PiAPm1TNUv8cf/FCYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvyPSLRiCkvnvdMQ9eiZdiTffkhJeVBb9neS5HuegKI0itDb21
	Xd7cctKWMBBW0IRfPH4DX+/Rd4QW4GKXa3D11GAbFNAT1fnrQUMVkCgsKUkII6c82LxnpN6t6j7
	NIfJK4OH0TyDzZjprv0NG3ewF/DZhDj+sjVpxSE3GJA==
X-Google-Smtp-Source: AGHT+IHLFGulb3z/eo2szi6786N8kGEmVFIwSvl4dUMvlzw1VLQQUCCeWzohDS2Sm0Bl5s7XXHCH8EBa2sM93x2lPWA=
X-Received: by 2002:a05:6512:1096:b0:595:9d6b:1174 with SMTP id
 2adb3069b0e04-598faa86c0bmr5281960e87.35.1765985332003; Wed, 17 Dec 2025
 07:28:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com> <20251217-staging-ad4062-v4-9-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-9-7890a2951a8f@analog.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 17 Dec 2025 16:28:40 +0100
X-Gmail-Original-Message-ID: <CAMRc=McPAORcG2hiLO35q5UgXpTvbzAhdoprgE_9xSCJG=QPoA@mail.gmail.com>
X-Gm-Features: AQt7F2oNHCsrRoHfSHESys1l2uJDHi95XvDyM4YYcEDD4aTW-_SzkbJW2Zj6aGg
Message-ID: <CAMRc=McPAORcG2hiLO35q5UgXpTvbzAhdoprgE_9xSCJG=QPoA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] iio: adc: ad4062: Add GPIO Controller support
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:14=E2=80=AFPM Jorge Marques <jorge.marques@analog=
.com> wrote:
>
> When gp0 or gp1 is not taken as an interrupt, expose them as GPO if
> gpio-contoller is set in the devicetree. gpio-regmap is not used
> because the GPO static low is 'b101 and static high is 0b110; low state
> requires setting bit 0, not fitting the abstraction of low=3D0 and
> high=3Dmask.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

