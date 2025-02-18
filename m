Return-Path: <linux-iio+bounces-15722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D82A3949B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6F21716A1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C122B5A1;
	Tue, 18 Feb 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEJ2K1NS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705322B586;
	Tue, 18 Feb 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866326; cv=none; b=nweQkhuU3yXNGz14mzwMSWlAZ4s8V8hgzcp/ZKzdA5wiU5whQrNFnPfh6ZMdp5qag7KWctdOGkRaho69mQt0XtsD8xxr8cFQvGkvuwRio9Wuh/HEpdQiu38EQq0wp0k1t7h9uX1+m+ZdK2IswLFzI+ifDR5sm7AquRBLkgmy2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866326; c=relaxed/simple;
	bh=0S9pjfmZRz2PUUj+HKdqPYrF8EUJ9z8pul6F4UlafVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahw9GUUNxJsBWPUB2N40HCyALlGyn41J0sPaX2Tbm8xpQrQO+58tHzuHE6J5qdo/fMoOzqiMuee/EoPi/VApRwJYzBOkJP9ItIo2zzKzIGIfL4qZDTUh7BC33wIqeI/DdW1Nh/SBvRpVwH5pZAXtW6K9g9f5Y/3EVT/qWCbqAiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEJ2K1NS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BDCC4CEE9;
	Tue, 18 Feb 2025 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739866325;
	bh=0S9pjfmZRz2PUUj+HKdqPYrF8EUJ9z8pul6F4UlafVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEJ2K1NS1AMoQ1boOZkuPFTxcg5vfdt2ZAxl5BFbOiA12zOuTdv7tYrnJzsczKLFH
	 EcrvkKg2ONY6OJSmsJ6rnbbQZVWMvzchQWoDkb00zHXc/ihHTJfHndFDgY1FEO07Gk
	 yOEb7mM823okMgDDdhR3xnmjbrClWRhhnbyhPncGZE2Rxb5ITma30rM98g3S3Dm2MV
	 QHNZrsPpLg9r7Se5eB+An3jMvDCzwqxeXwYBTSydSA1xMgMeYSux3GoVQLrguLE3ht
	 IvAE4x2YiFGWap8xXXfsUd8q/N+TCDaBjV2MY+Po5O1twc1B3vJz/g+PxNx39oRtW/
	 uRzsOCDxn4Xmg==
Date: Tue, 18 Feb 2025 09:12:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: light: al3010: add al3000a
 support
Message-ID: <20250218-rainbow-holistic-locust-8f3615@krzk-bin>
References: <20250217140336.107476-1-clamor95@gmail.com>
 <20250217140336.107476-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217140336.107476-2-clamor95@gmail.com>

On Mon, Feb 17, 2025 at 04:03:34PM +0200, Svyatoslav Ryhel wrote:
> AL3000a is an ambient light sensor quite closely related to
> exising AL3010 and can reuse exising schema for AL3010.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


