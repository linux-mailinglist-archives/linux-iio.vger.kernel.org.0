Return-Path: <linux-iio+bounces-17225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E077A6D5E6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8C47A47A6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D825C70F;
	Mon, 24 Mar 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjOSF9Id"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B382505C3;
	Mon, 24 Mar 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803719; cv=none; b=TFGZmy9Or2A72ql9nstWdpgc7elcLw+q6AYBYihqr+799bGGX43ZdYYz7smbGFrDMyeI5tlMLozKhoEGRoJqcD4IFKDiX5xiqD7CB/BJYyQT9yvlZV1wQpLi0jgdXqJAABh54bRPb9tSQ7vinFXosPeXPJlzSlc8QveO4QWzSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803719; c=relaxed/simple;
	bh=XQaE6rjkOH/E76NaiDGoVIFy4iawccC3XvnuHWOp+vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgMs6fT5p6ZgFzJpQ/y8hp8U3p9daJjabN985g7CVj2HaqVipSGCCEMjvgqiFvLeICYCwwOWSF2ymV7ykigDursqnuz/X5Enn8HSK5vH9uTDRytYy714crwZ5zxfBBW5RXF46BqcMXWGjpfA2PrLT8T5jvYMB0J9WllEzqlUlZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjOSF9Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5864C4CEDD;
	Mon, 24 Mar 2025 08:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742803718;
	bh=XQaE6rjkOH/E76NaiDGoVIFy4iawccC3XvnuHWOp+vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjOSF9IdWrkOwNvNnwBkaqJi/a0+B9YPlAU5R2+N9Jt5Z+/sf+vxnSmXELwohrUuW
	 /zVXSoFYM1GelnurfQfJWS2QJY8HE/wW+7R8ZiA80+se90X8TFWmsPhci4ISoHPuKo
	 DeMrYlfyQR2mdzWi3lW0uh4c7hfJK7zN5rrjPeNuawlh7papOmbYwNBBuYNx0sus7M
	 Hz2w82AmgVQXEawmO/4GbU5RV8pc5/T2O955PYMRujE83qQdHuB03wJ5Ab2puotM1N
	 j3aBSvIndcz8pS29Hd6xoJ9K72TLoLqEs7gbcjrfBAdNegv8K8qnw0WHDDFVuiuEMs
	 tXK2k8sIpb4CA==
Date: Mon, 24 Mar 2025 09:08:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sergio Perez <sergio@pereznus.es>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
Message-ID: <20250324-massive-dancing-sidewinder-bd51b3@krzk-bin>
References: <20250321161609.3662-1-sergio@pereznus.es>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321161609.3662-1-sergio@pereznus.es>

On Fri, Mar 21, 2025 at 05:16:08PM +0100, Sergio Perez wrote:
> +  reset-gpios:
> +    description: GPIO connected to the DVI reset pin (active low)
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -36,9 +40,12 @@ examples:
>        #address-cells = <1>;
>        #size-cells = <0>;
>  
> +      #include <dt-bindings/gpio/gpio.h>

This goes upper. Please open any other bindings to see how it is done.

With fixed placement:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


