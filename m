Return-Path: <linux-iio+bounces-22187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BFB18E1D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E47E7B16F1
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8FD221723;
	Sat,  2 Aug 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkEl6n1a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8171F09A8;
	Sat,  2 Aug 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754132372; cv=none; b=UHk4HOE5TyHi6R3/lHlW0jUXtmgsKxph9Wadm/AIyrAqG6hKXrqTyLm65BBwhlHkb+E9tXXP6XVKofBcZPSqesQ4lUT9MPJJ6zTsrhKLj9PjwME4XQ642ETUedbgeHqSQA8PWk+LrLhDbm8w1R7u+44T1RPRnC2g0v32Vm0r52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754132372; c=relaxed/simple;
	bh=RrtQQ6UwHwagO32oz6DthVPaQLtuB22k5y7kjV/vClI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3JNeJtDUAo5vLbZQB37pJRexe/CB5Yn+HciOMQadk2aqo103PtNE3XyCQH9lKLp4evL3bdRozB6zjig7k0V/U1PbSMnKrSSV7wegiR8CV6LOo/SZgcux+gKpKH6xCzVnk0/NHvJScW/zF5Y8IAhn1EtMqX/co4e0mc/dK9jaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkEl6n1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B3FC4CEEF;
	Sat,  2 Aug 2025 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754132371;
	bh=RrtQQ6UwHwagO32oz6DthVPaQLtuB22k5y7kjV/vClI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkEl6n1aqgSl5u4POZiYLef0IxjILnZtiyUi2MUq+7y5KATrbe0mhXDKRyAk7tjHy
	 lIrn1ST7GC0gqSBZ0ca153MMT46AImMkP5aQYEC310+4dhmectqxN5qijqRm69DUWO
	 27QPHQ7sL7uWXy+gXOYlUPYMsyO4uOUQUCPRVkaEloRULSli43/ObDi0xkQsfORIO7
	 Q0dM9tj3DcWeZgmon2gL+r8U0qxtk5rZEyJ0yVVdyewVR6D6XdDXpaVscS+PYaaUVL
	 XAbOet5IyCNkTQM45nXr9rMIgVfPOL8t0ZWaS2xTcXCyesAlfyXaH311u2+j/hkH52
	 MeV149issU2Hg==
Date: Sat, 2 Aug 2025 11:59:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iio: adc: ad7476: Simplifications
Message-ID: <20250802115923.4521fa9d@jic23-huawei>
In-Reply-To: <cover.1754041258.git.mazziesaccount@gmail.com>
References: <cover.1754041258.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Aug 2025 13:06:46 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> This series suggests some simplifications to the ad7476 ADC. It is
> currently 100% untested, and shouldn't be merged as is. I'd like to hear
> opinions on these changes before adding support to the ROHM BD79105 ADC.
> 
> Intention of the patch 1 is pretty trivial. I'd just like to hear if
> people think the enum + ID table approach is preferred over direct
> pointers to IC specific structs in SPI device's driver_data.

Definitely prefer direct pointers as you have here.

> 
> Real reason for the RFC version is the patch 2. It aims to clear the
> supply handling logic. I did also an alternate version which requires
> the names of the regulators to be provided in the chip_data:
> https://github.com/M-Vaittinen/linux/commit/cf5b3078
> 
> I believe the version in the link --^
> is clearer, but it can potentially help people to add issues with supply
> enable ordering.
> 
> I can't still say if the patch 2 contained in this series is better, or
> if the one behind the link is better way to go. So, RFC it is :)

I missed this (who reads cover letters?) in first look.  Anyhow, having
taken a quick look at that alternative I slightly prefer the one you have here.

Even if we have supply ordering issues, it seems like they are unlikely to
vary randomly across supported parts so should be easy to incorporate those
rules with the approach here if needed.

Jonathan


> 
> Matti Vaittinen (2):
>   iio: adc: ad7476: Simplify chip type detection
>   iio: adc: ad7476: Simplify scale handling
> 
>  drivers/iio/adc/ad7476.c | 376 +++++++++++++++++----------------------
>  1 file changed, 164 insertions(+), 212 deletions(-)
> 


