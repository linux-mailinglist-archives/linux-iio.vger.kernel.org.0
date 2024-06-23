Return-Path: <linux-iio+bounces-6780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38069913CD2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D791C21BD6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE7D183092;
	Sun, 23 Jun 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPDmB/95"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1D27453;
	Sun, 23 Jun 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161020; cv=none; b=InM9/qY6oCophqv7BcmcyAbz/jdv8vHLXDevy6CnpUQczzWqwhl/vQY/USMKyPzgBoLpVH1PnbOE8MgAIUFDkGGIx59u/DCySDZM0b3oOwWT0xW4KtyB9hyG71p/UeSXGuaLeUasYT4icx3cQt0taFu73jx7S9C7g0LuqDNrG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161020; c=relaxed/simple;
	bh=1nMqqxlbzqnOaLTzG3lu0kMusS7M47wv0fXB6SIvc0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcyb5GHE4b90/WHf7lUHOkK0miw6sFs44X0AzRENON9pmf4wmsvKYDqeuvI9+kYuge+bc5Omj8zDp0afv5OJ9TVHIxCPOf0t52eKwXkyxVu+epn8u5Sw6jd4hrNZHJcGRnsgxCMxGTuoaP55fmj14U+raAhqBW6CnOJcorE+4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPDmB/95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C7CC4AF09;
	Sun, 23 Jun 2024 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719161020;
	bh=1nMqqxlbzqnOaLTzG3lu0kMusS7M47wv0fXB6SIvc0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPDmB/95FhIXETQ4nb2L5wVxntqtY4sQ5d2FZlw72flAX1/vxt7XGYHG9eait9MZj
	 +SMPg6JSrOCFIXzyDHgCvclWGVNn1tq7Z1K0LsfP7pNqujcD7pXUjI+nVV4s1WYjxM
	 a46VqGVoWz9xkWVM93hEMDbCN4Y7rQhvB5SfaHcwBHTjpmryus1wFzLa1cVGflRsMJ
	 K48FZ+WPI9oxAQJ1UvPYabwVMsITEgaLYi0MYJiWuuDS8zX7ecl0a2rAhaublErLSq
	 1DBMLOAPL69VEjh9IoNCoaKYz3Dx0tJWbciDpxW9EIt5qcZsb/YFgPwTQmTSp/MjDc
	 TyYoJFSrjcqmQ==
Date: Sun, 23 Jun 2024 17:43:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
Message-ID: <20240623174331.07ad2446@jic23-huawei>
In-Reply-To: <20240617-iio-adc-ad4695-v2-3-63ef6583f25d@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
	<20240617-iio-adc-ad4695-v2-3-63ef6583f25d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 14:53:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
> The initial driver supports initializing the chip including configuring
> all possible LDO and reference voltage sources as well as any possible
> voltage input channel wiring configuration.
> 
> Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
> is supported at this time. And reading sample data from the ADC can only
> be done in direct mode for now.
> 
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I only took a quick look as it sounds like some of this will change.
FWIW Looks good to me.

Jonathan

