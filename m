Return-Path: <linux-iio+bounces-27370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C04CDFF54
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C26C3021E4B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7032548D;
	Sat, 27 Dec 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1xyhjSB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B822652D;
	Sat, 27 Dec 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853318; cv=none; b=JRTDdxhCPaJ+yVOymZHOuJ7kUVT+XPQdhfzLj8GajpS83DfXUvjw1VcvIjy2UJzBD5eTya1LXHU1sJgcZr6arVyfaQqdg6iGFFJstFhlnSgt7sGmsaMCwT44G9Gkmf1hBqrmTO8Z3LGNoyn+iMlLzyfIFzdmSJwxsIvU9StkQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853318; c=relaxed/simple;
	bh=hICSu6Vxrj2xniWAka5RE0nDT7nVND62Yrkq1RNJuCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/MEa6+MBRjL4DFGHt1rYq3UZHHRWjBYWmUmbo7eQrUSLMffCiYw3il1Ui4WXqAN6tulbmXaTzZTjsAPiHwpfY40jpiY4GYehuc829WPlkD+lRkc4GE9q/MZf4r2CBeHYkkyDEQyES3xqc6njlnIvepDjj41Gsu2pyq7XZLIPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1xyhjSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2949DC4CEF1;
	Sat, 27 Dec 2025 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766853317;
	bh=hICSu6Vxrj2xniWAka5RE0nDT7nVND62Yrkq1RNJuCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k1xyhjSBtGy8Fk7eM7dfl7B33FD8UlrlJJwAdGxf/lyQUVQCB3f1YPQXHNZ7ap2d2
	 YBFTsQntiWNvdnXbSwHKrc8TtJUF2Ah3TvqmbUhSfpumYWqnd8MzLU+glKiSQjGrWP
	 mGt5ayrxU6vp8C0byzuNeofh9cmIribWZNiR8QVUnKTkJORi+dgypZcptvZR0XDtQg
	 JDdsFBaSsndF1zLxb2kDAurp+WERnYkbH4NHJklljJoUNOnFaBxoq2m1qpRr5ez8Rh
	 /u0ruAxQbi0vF8b7a9PxqkSjasJiaF3TaxIMFwvWa3TIyyOdrBDl6wLuFyDeFT6ezA
	 Bb5ajQOt3HAwA==
Date: Sat, 27 Dec 2025 16:35:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v4 0/9] Add support for AD4062 device family
Message-ID: <20251227163506.2fb90815@jic23-huawei>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 13:13:23 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
> register (SAR) analog-to-digital converter (ADC).
> 
> The device uses a 2-wire I3C interface. The device simplifies acquisition
> by providing 4-bytes in the register map, signal-extending the sample
> reading accordingly.
> 
> The device has autonomous monitoring capabilities, that are exposed as
> IIO events. Since register access requires leaving the monitoring state
> and returning, any device access exits monitoring mode, disabling the
> IIO event.
> 
Applied to the togreg branch of iio.git, though initially only pushed out as
testing to give 0-day a first opportunity to poke at it.

Thanks,

Jonathan

