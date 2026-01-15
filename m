Return-Path: <linux-iio+bounces-27820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EFD23976
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 159513029AF7
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B92D6E70;
	Thu, 15 Jan 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6P7tytG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C8333752;
	Thu, 15 Jan 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469062; cv=none; b=ru7wnCdnW4Jz+7hj/hM1UZTnQdOiuYdUkr5Q2n1NVdHctP95M7h5mBqgpzy5SftAzkQ502BjHsngdGt/xyBfI5uD5sZgvnB1fI+/AFNJvWOz6VYRLRhzXA3eUI0DrDsEQrRL2rsfBhzVvKzlN2FK7UJ9kCfZUprPF82/enpGshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469062; c=relaxed/simple;
	bh=Ll4toEAyxkraVZbt7M57AAYngEDQRW96+rpc5KZiqWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNZu8gGaDvy5uJI7W28cMe8/2/8Y/Ge6KiJ8Bmd+NhA21pKYpyYYi/+PaNOntroHVaDTL6UpdD3kCUhcrDIUIHkBFJ15b9ZXZEw8lfv1Milji46Ma+WSqq4Xw8wsztw8gN68SqEmcjPyqoNw0D6bnDZik42HrttA9WuQKxf9u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6P7tytG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC9FC116D0;
	Thu, 15 Jan 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469062;
	bh=Ll4toEAyxkraVZbt7M57AAYngEDQRW96+rpc5KZiqWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6P7tytGK6M0sLLtLjwMJRKzZbLiUPoUewB6z6tm4dBciOYv67y64NMAGMFtbD2Op
	 zCjHSSLH/5qPFUamHxnmafbH9Y3H1st6hO5vM6PjKBcwCzjclVKGWCpR3NZbDxtB4o
	 E5OoXVrMrCfWysAr898V/2qd4vcfk41xjzkp7pLW9U8M7/jYJaSXczEBtGYFv6JPz1
	 Qi7nlxLWDHRJzVhqH2mjSshKrETXz6XS7OasiTTkFgxOr/e/HfjGsvjaSij+Usg31+
	 YQDmLf+fRRcSmpEzQ8/z1PLWHlfwZ8OXm7gdCMTKW8PgaQtn2b225XrGr5oWjY0Svw
	 B46bfNkRnEZfQ==
Date: Thu, 15 Jan 2026 10:24:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	jan.sun97@gmail.com, gastmaier@gmail.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add max22007
Message-ID: <20260115-elegant-hopping-kangaroo-6cd32b@quoll>
References: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
 <20260114-max22007-patch-v3-1-769298f50b8a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-max22007-patch-v3-1-769298f50b8a@analog.com>

On Wed, Jan 14, 2026 at 05:17:01PM +0100, Janani Sunil wrote:
> Devicetree bindings for MAX22007 4-channel
> 12-bit DAC that drives a voltage or current
> output on each channel

What is happening with this patchset - why are you making somehow
unrelated, different, unexpected and incorrect changes like ones above?

You are supposed to work with Git e.g. on dedicated branch, so you
clearly see what you did. Why doing such changes?


> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++++++++++++++++++
>  MAINTAINERS                                        |  15 +++
>  2 files changed, 131 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
> new file mode 100644
> index 000000000000..c2f65d9e42d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,max22007.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX22007 DAC device driver

Why did you changed this? What else changed?

Nothing about this was mentioned in the changelog.

I finished the review here. Please be concious what you are
changing, do not introduce random changes and then write correct
changelogs describing what you did.

You already received review which you SILENTLY ignored. That is not
acceptable, either. You MUST provide reasons!

Now, that review is invalidated anyway.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..c378d4b8f5ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1594,6 +1594,21 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
>  F:	drivers/iio/dac/ad9739a.c
>  
> +ANALOG DEVICES INC AD8460 DRIVER
> +M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> +F:	drivers/iio/dac/ad8460.c


What?

NAK

