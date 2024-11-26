Return-Path: <linux-iio+bounces-12697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1A9D9D0A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F51162B75
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42DC1DC184;
	Tue, 26 Nov 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzTY7WiW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A128BA3F;
	Tue, 26 Nov 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644046; cv=none; b=pHjs7zfPQ0olQVVMqTjDdSzReB+51KtzCCYFaH+QP2Rr81xGgWtuROLSTMryHj+8q3cZyhSh1xN4ge2BDbyaWYh/0DkzZWUj5r1gElGPIsvHiDNCRsNS19aAHmEQO9nwjjlP8yBS9o19bYiRI3yW5WKTDHsR/6I42JWr9wYodOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644046; c=relaxed/simple;
	bh=G8Ue2YK7XyQ4L5ZvfEYu5UVIaIPbpJF33cbai+gBe8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOyWI0UUeknMvcF+BmSgjxlG420FvMoH1hDRamLccqeGj1HbHHEQwlydCpMQQG8fptmUgrAQlYMwgrcgyYM8h9574ZZcGiUS2FOiUuqsiScrStF/Ygc9ON/gSmYQovpUgi7eZ4FPC7bx0tBiGtAMPn7jEcS2XifIKhip0t3yYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzTY7WiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8754C4CECF;
	Tue, 26 Nov 2024 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732644046;
	bh=G8Ue2YK7XyQ4L5ZvfEYu5UVIaIPbpJF33cbai+gBe8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzTY7WiW6agFtu1F9rj3T0NU74qthQblOg/IUQc0WeDagJTIFEDPv3M3HdS65PzP2
	 rYZsSXDWF//Nz3Bi5AiuP40qkSwjwaxG4G6cPAalOcMWY4mU7G6KU65amdxslHENDB
	 ERxsiPCJ75CHZg4CBdVXokuwtIzw9F9VhKgp0+k8USTzPyFVyuitfegIZ7qFBZz81V
	 8LiFBQEDXUEZYp+jqJ40rtwJ6Ldy9FNfWHgJXDR/QvxC2KYyZSwFB/ZcgO9R+mBy0C
	 GmWufpQMv+2ytlRnxviUtvrdDyBewmCw8UnLnob5QrruFBAb0jHzxY4QJIMsJAvGFT
	 wBeqoAAzXfrVQ==
Date: Tue, 26 Nov 2024 18:00:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 0/9] Add support for Software mode on AD7606's iio
 backend driver
Message-ID: <20241126180035.4a2afb01@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:22 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This series adds the support for software mode when the ADC is used in
> iio_backend mode.

I'm not sure form this description what "software mode" means.

Perhaps some more info on that for v2?

> The bus access is based on Angelo's ad3552 implementation, that is we
> have a particular compatible for the backend (here axi-adc) version
> supporting the ad7606's register writing, and the ad7606 is defined as a
> child node of the backend in the devicetree.
> Small changes are added to make the code a bit more straightforward to
> understand, and more compact.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
> Guillaume Stols (9):
>       iio: adc: ad7606: Fix hardcoded offset in the ADC channels
>       dt-bindings: iio: dac: adi-axi-adc: Add ad7606 variant
>       iio:adc: ad7606: Move the software mode configuration
>       iio: adc: ad7606: Move software functions into common file
>       iio: adc: adi-axi-adc: Add platform children support
>       iio: adc: adi-axi-adc: Add support for AD7606 register writing
>       iio: adc: ad7606: change r/w_register signature
>       iio: adc: ad7606: Simplify channel macros
>       iio: adc: ad7606: Add support for writing registers when using backend
> 
>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   7 +
>  drivers/iio/adc/ad7606.c                           | 202 +++++++++++++++++----
>  drivers/iio/adc/ad7606.h                           | 113 ++++++++----
>  drivers/iio/adc/ad7606_bi.h                        |  16 ++
>  drivers/iio/adc/ad7606_par.c                       |  58 +++++-
>  drivers/iio/adc/ad7606_spi.c                       | 141 +-------------
>  drivers/iio/adc/adi-axi-adc.c                      | 178 +++++++++++++++++-
>  7 files changed, 500 insertions(+), 215 deletions(-)
> ---
> base-commit: 33d38f912d5ca05501c9bbfe14e0150da9ca85b6
> change-id: 20241009-ad7606_add_iio_backend_software_mode-567d9c392243
> 
> Best regards,
> --
> Guillaume Stols <gstols@baylibre.com>
> 
> 


