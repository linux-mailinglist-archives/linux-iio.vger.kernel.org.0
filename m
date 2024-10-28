Return-Path: <linux-iio+bounces-11525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367639B3C11
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2B3287142
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CA1DFE2F;
	Mon, 28 Oct 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3jN2Fez"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CAF18E03D;
	Mon, 28 Oct 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148191; cv=none; b=lAIXWeu320+hxZ9mNlqW3tmdtSBp1jdpj7xaxCzuv6+Ie0FcP0cKD9VDJUTZ9JLvo3jwvTBsm84P/gQ6YOBWq5GQQIUaIFOk4CAiQbHlPqpYc3NtZwqaY9Nk6c1wW0tj/L+UPr2CJcIhLN3QUhxs+v32tIfZNdjFMgYRnYVel9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148191; c=relaxed/simple;
	bh=s8xdgSpvjF3jVk8zZ7hP09SEqxjKFStind40EgWLYn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRkk8sK25peuZutwj8JHIeUJeznNEYckINCsQ6hK04Nux1tR4FLDzvWZ0WWdmwzaVZRZSbzwGXU/MeOjbGFozZIm3SkV/MRiZp1ky1MrU056JmblH+uc3VicjO2gXQ+l0lwB3hcksgTpfUf2PnZwEL+GJKM0Eb17GPYiLln0PmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3jN2Fez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87CDC4CEC3;
	Mon, 28 Oct 2024 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730148191;
	bh=s8xdgSpvjF3jVk8zZ7hP09SEqxjKFStind40EgWLYn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3jN2Fezr5ARPVhpBrkvWwmHcDMSfrfZMJJvW3edOuFLaXR+77sC3400nfFwb+B8o
	 NH8qUeRShNkoDicUkG361p4T2I7YjGdYL9/KzchATRzg9SEP+BH7Sp9JD4m0mOIL6b
	 rgJRuxuOChTfGDhjpFcZR2koCagwPOABfXlXtblDACiJV9MYYtkVTzi/JogOM13EWj
	 UbIyXbVrlHac+cHP5pxrYBNX8+w0S1oV1gWvKGhy88OBLM/VX451Ip5SdFvnw3P1C5
	 4Dd2UFJIVx2e8UtJ03kWcLCxq9eD1VX/iFdB8wlGajo8TpNpPld/CQeRrm4a95XXlx
	 s4j2NwISfUALA==
Date: Mon, 28 Oct 2024 20:42:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <trabarni@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ondrej Jirman <megi@xff.cz>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Dragan
 Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: light: stk3310: support powering off during
 suspend
Message-ID: <20241028204258.4745e202@jic23-huawei>
In-Reply-To: <20241028142000.1058149-1-aren@peacevolution.org>
References: <20241028142000.1058149-1-aren@peacevolution.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 10:19:54 -0400
Aren Moynihan <aren@peacevolution.org> wrote:

> In the Pine64 PinePhone, the stk3310 chip is powered by a regulator that is
> disabled at system boot and can be shut off during suspend. To ensure that
> the chip properly initializes, both after boot and suspend, we need to
> manage this regulator.
> 
> Additionally if the chip is shut off in suspend, we need to make sure that
> it gets reinitialized with the same parameters after resume.
> 
I took a quick look and nothing to add to Andy's excellent review.

J
> Major changes in v3:
>  - Use bulk regulators instead of two individual ones
>  - Replace stk3310_remove with devm callbacks
>  - Hopefully I haven't missed anything, it's been a while since I worked on this
>    patch, and I didn't take good enough notes
> 
> Major changes in v2:
>  - Add handling of the IR LED. I was hesitant to include this as it is the
>    same as pull-up regulator for the i2c bus on the hardware I have, so I
>    can't test it well. I think leaving it out is more likely to cause
>    issues than including it.
>  - Convert stk3310 to use dev_err_probe for errors.
>  - Always enable / disable regulators and rely on dummy devices if they're
>    not specified.
>  - more listed in individual patches
> 
> Aren Moynihan (5):
>   dt-bindings: iio: light: stk33xx: add vdd and leda regulators
>   iio: light: stk3310: handle all remove logic with devm callbacks
>   iio: light: stk3310: Implement vdd and leda supplies
>   iio: light: stk3310: use dev_err_probe where possible
>   iio: light: stk3310: log error if reading the chip id fails
> 
> Ondrej Jirman (1):
>   arm64: dts: allwinner: pinephone: Add power supplies to stk3311
> 
>  .../bindings/iio/light/stk33xx.yaml           |   4 +
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   |   2 +
>  drivers/iio/light/stk3310.c                   | 156 +++++++++++++-----
>  3 files changed, 118 insertions(+), 44 deletions(-)
> 


