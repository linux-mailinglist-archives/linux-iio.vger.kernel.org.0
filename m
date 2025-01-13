Return-Path: <linux-iio+bounces-14260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE32A0B182
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB3F1881DF0
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 08:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA37823499D;
	Mon, 13 Jan 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTPsVCJ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4EE234969;
	Mon, 13 Jan 2025 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757818; cv=none; b=lFUcSJV3/w/mInJ8sCkQ4nnA8qYanXAYgBDhwcvyKTQ9vKuzwdxhiCuFWN0in1uFZ0tiQ8ETufLBw97CispTFqeh0+iDuds2HXhfSsVGu3kCQgFKKP2r8vXGbLAvsLd9JfVX77R4QROi8NvqqnkWz4hSEnIXGUrNYR5iTvfWnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757818; c=relaxed/simple;
	bh=smxbd/SANEf1kp4k2E6BeNiiulvveanly3GZ6hrXBAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwitA8yn3kan5CNnbpUsIR7VeRuCYVIsR9nAPrBRZVgSS0I69sOBYvanIsBmlqoe9vhvXnm75c9egWYbf0y64QN30lta3lD9T46Ln2R1B4VhfOeUOc9jM/rujOEEAenxu5XLHv2Wvb/bsJcpws+DdSTi2aMvabAE0ccWVlLRUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTPsVCJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C99C4CED6;
	Mon, 13 Jan 2025 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736757818;
	bh=smxbd/SANEf1kp4k2E6BeNiiulvveanly3GZ6hrXBAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTPsVCJ0/hPVkC0WvOgqhxz+W1khQ4alOOQdF6W2mSkwaatSSzWu9HzuyRuZiYbaA
	 YtA1rm8wOcGDNwNUY1iUZVuKDupPobqfico9m8v9ndOn8B8Itsl1ceJbkDqRbZX57+
	 /32gyp1BjgTgwxlTqEQCfe3C0svSrry9ExlPcBdvefoPIAU1OGZbKOiLPh1pG3gHz8
	 nYIshRhKraD6T2cSWTfO/e5rboyV6zxYwapexY/fznEV2zash3RsPKbQL2DZBE84B7
	 A7YU84jnU0xNX5x9uLWdt4G7sI1S7Urp7FyZw/z2h2phxC5wrAo1NWJ9m7GhYMD2Kq
	 cxUI48lRrN8GA==
Date: Mon, 13 Jan 2025 09:43:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alex Lanzano <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <y54kfnkbuugvsgfzufhk3mmwmmzbko47fg3jxw36sefzxaxcz6@znigvgdcljeq>
References: <20250110074254.38966-1-robert.budai@analog.com>
 <20250110074254.38966-5-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110074254.38966-5-robert.budai@analog.com>

On Fri, Jan 10, 2025 at 09:42:52AM +0200, Robert Budai wrote:
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16550
> +      - adi,adis16550w

Where is the answer for my questions at v1? No responses on email,
nothing improved in the patchset. Go back to my comments and respond to
them or implement them.


> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 15000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      RESET active low pin.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: If not provided, then the internal clock is used.
> +
> +  adi,sync-mode:
> +    description:
> +      Configures the device SYNC pin. The following modes are supported
> +      0 - output_sync
> +      1 - direct_sync
> +      2 - scaled_sync
> +      3 - pulse_sync
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 2

So what does the "3" mean? Why documenting something impossible?

Anyway, use strings for these and drop "_sync" suffixes.

Best regards,
Krzysztof


