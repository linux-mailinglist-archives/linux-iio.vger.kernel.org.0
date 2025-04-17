Return-Path: <linux-iio+bounces-18185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC51A913F0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 08:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082FC444F8B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456F51F9A89;
	Thu, 17 Apr 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcMtRcyP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16121E5B75;
	Thu, 17 Apr 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744870853; cv=none; b=Q840N8J3kGq6V2LFlrsQYn6UcaewANZQUNktNNwmPKg4pdl6al1/47ULUS6LmU1dlziFjBSjGaQZo5EweXKK6BNS5Ld4Jw5zVdrAI0Y1o89vSsOcVj1G8MUXGbIyWYJCWccd8yYZKq/8okV8+2bTh6y74rLPWrNccwJVu7uTO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744870853; c=relaxed/simple;
	bh=x/rr7Zz2xfD3RvRsd0FGGIq1TtjiOPDKWjaQ3aD9bIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXCVKjMm0tDG4SwmNS2YyLJ7ECWMeZVqUa36OZGYbP69qDJu2wXjWvHkbD2NxEFPSzL1tfhk/6wS9Ra4pGCALi6X5P23AbH0JOiUvYqQnfYslJ3oaxp4eAAzudtpHtL7DZ792RiQia6LzsKK84MGgiTXSXZGmUsV2SWGBYMlmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcMtRcyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFAFC4CEE4;
	Thu, 17 Apr 2025 06:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744870852;
	bh=x/rr7Zz2xfD3RvRsd0FGGIq1TtjiOPDKWjaQ3aD9bIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcMtRcyPQiZlivoPspWmnOvXBu+ifzrM6kpIWEA+E0xeoWP77NRv8qnBezfBXsczx
	 jm7bn94t8yf1L0qth7MVQEnWCpdiZi8w6AIz1q3a4ru5VrgORatKOPkxsKw0Inpqo8
	 YYvEa8BgqkIZBF15ZYpcIvb7O1hXGyDW46iKLaUNgmRSaPm1FI+iXJZdyd/0pRfNy/
	 bgF4zAaKagzx4LWom4M6//jJq5Iq0MvElxSw2iDHsoRaxRK3dFlh4tFdEZemyevCck
	 Jew08Fh4WbZOfoLwyQiWDhWoCawXXTDDeZiKLq48xW8f98/TPs2Wi01JjDoLQGA532
	 2W+EfYCf8k+2g==
Date: Thu, 17 Apr 2025 08:20:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com, alisadariana@gmail.com, 
	tgamblin@baylibre.com, olivier.moysan@foss.st.com, antoniu.miclaus@analog.com, 
	eblanc@baylibre.com, andriy.shevchenko@linux.intel.com, joao.goncalves@toradex.com, 
	tobias.sperling@softing.com, marcelo.schmitt@analog.com, 
	angelogioacchino.delregno@collabora.com, thomas.bonnefille@bootlin.com, herve.codina@bootlin.com, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Message-ID: <20250417-acoustic-ambrosial-mosquito-9d75f4@shite>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
 <20250416081734.563111-2-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416081734.563111-2-j2anfernee@gmail.com>

On Wed, Apr 16, 2025 at 04:17:33PM GMT, Eason Yang wrote:
> Add a binding specification for the Nuvoton NCT7201/NCT7202 up to 12-bit
> ADCs with I2C interface.
> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>

Did you read the message you got from me last time?

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


