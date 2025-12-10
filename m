Return-Path: <linux-iio+bounces-26999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1CCB44E0
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 00:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D43DA30164DC
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8E21D3CD;
	Wed, 10 Dec 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcGRTMWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2926C3BD
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765410471; cv=none; b=fpsCQQy9I3Gx1PC9vnCridH2uVxh6FZ+MghpEiRuslRRFrauvlLQASHWkMDDFyC35FtjG0jbZwfkUl4VJ3Mi29lZyBNDKk7mBDF9U8ZbT2A+WlMV76cUgMu5zo3eNGk86xSQ6h6GEdJET+/Lm5V0j25uKm6HuWDhHhtNKCTwiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765410471; c=relaxed/simple;
	bh=D5582JugPBlp66RQDPggsMGp1cGTXo8WtJFYKnRINcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVgCc6MPA7wfKw8bMP9B0BlvmJuCUQyFkDKziajYQDlqRnDAzqP2bQkiF+UrqYB2JJwik2+E0fXeU8MzjOsLNOoPYG8hoRSO8bH8CJpdhtQEa7vns53+TQ2n5R7nxfhrOyE0LikCWBYbWUEGscp3l0GTNi7Z+RdUOQpKP6Bnczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcGRTMWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D27C4AF0D
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765410471;
	bh=D5582JugPBlp66RQDPggsMGp1cGTXo8WtJFYKnRINcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZcGRTMWHDa7L/ngSsYmY1iA/BIfYf75JilwsNEk7wFEv/Ns7XpQcyaJhrkEXIyKJH
	 SMCAq0fVaQ+YviEuBXHJjPAs2i8AbDOxo+QVQJ7vhGXJIP3fnikO+dEylRBrfCN4CM
	 TkT32zpt08EATMRErFbHkLGgtvr4dNqsH1631Bq0pJMDd5YM7CpBEP2elk1+Uxsp+G
	 SQ1oUCTyFgrezE1/Mq8D2i6i6dgmctJvc7jya0e6jzi/c/mB7osJgTgt/BXoTDU8sh
	 fRMatPykIaE9JipOkdnUw8odTtmGDEBN6g/Z6r4ILmtpAVcty8Ps4zOH8fK8gD8psf
	 L5vcki88AP+lQ==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6446ba3d337so335603d50.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 15:47:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkuA/2BM8VKJJSxS0FRXV34PXpAIHaU4KVSuZnWB7llMzkEIcK2bXEp5DDEYAQv/KHzKbRcsY43O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbnOe9R6oMAhDQQpfcR6z+C++6rdknfdkwu4p+Ymd07fyprK6
	TmxozVlyL/1PZgOrBET6RdqgtVvW8Db+fPH47n2KNwX4n+WerWOKhEkrRPgV7Zijm+LdocfGfy9
	/ZboYQQXzhjKh66ZX8bZ317wvh2vaH2k=
X-Google-Smtp-Source: AGHT+IF1KvpwvnBSAbEXcJqDsBPJ2yLyLlyJKjNbLzECbn6Yq8+hvb4/xY/PIiY9ykS4N5gVxpwBM5gRmKIx0+1lOvE=
X-Received: by 2002:a05:690e:4007:b0:641:f5bc:6947 with SMTP id
 956f58d0204a3-6446eb26deamr3184861d50.75.1765410470388; Wed, 10 Dec 2025
 15:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com> <20251205-staging-ad4062-v3-8-8761355f9c66@analog.com>
In-Reply-To: <20251205-staging-ad4062-v3-8-8761355f9c66@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 11 Dec 2025 00:47:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLmVNw2BuntXZG8SpS6E+0GPMWBnYZpeP8U79KFZ97tKFw@mail.gmail.com>
X-Gm-Features: AQt7F2qitnJW8osyPLPsKhS1K2bb8B9PYqpW93XkEg-Z_P3jrHd756WouuN5k7M
Message-ID: <CAD++jLmVNw2BuntXZG8SpS6E+0GPMWBnYZpeP8U79KFZ97tKFw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] docs: iio: ad4062: Add GPIO Controller support
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

On Fri, Dec 5, 2025 at 4:13=E2=80=AFPM Jorge Marques <jorge.marques@analog.=
com> wrote:

> Explains the GPIO controller support with emphasis on the mask
> depending on which GPs are exposed.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

