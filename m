Return-Path: <linux-iio+bounces-27233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5340CD1EA7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C3503043909
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EAC33DEDF;
	Fri, 19 Dec 2025 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfMs3aZS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422E1E520C;
	Fri, 19 Dec 2025 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766178300; cv=none; b=O2SQdtyq3pTs/BqmjiIawahC8MJqR8++TB0GKbJDO5jNRrMTiIcLaxSHQcspDb0ysi0H78wIWZPSsejOK7Ghtxu2Yc1QWqUNSctEUtPtkuGHdGc1svj/b+Rtrb1fXykiqKgLJR5myWamJDJacDMGX8b1Sa1JMMQTdRYKxKjC54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766178300; c=relaxed/simple;
	bh=4sgIqEwPXXLAOBFYR/9KviOsCVn5w5BeCFeoELqc7Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS2dZVoLRIb2NKqXz6GKK6lFZFon46Ps4V2ExsUdfcIR9Ih5CxrLQHjBlduqd7qKowOXEmgJi9Lfq5zfpjz1RC6WaJNwcl1dRdT6TKLlygg9dJrUyMoPaE5eYbPfYV1cm4oDd/ZE/kF6rIxwNLpMDmKmYLaIhPOtUem52qQwpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfMs3aZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA953C4CEF1;
	Fri, 19 Dec 2025 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766178300;
	bh=4sgIqEwPXXLAOBFYR/9KviOsCVn5w5BeCFeoELqc7Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfMs3aZSNNfkQ9MoZuxxd+vbw82OrHIh/AKb8fyfm5jNcaTraQayNloRHtyjaM//P
	 DgvdFLVvl+4P7NnH6m8tVhw6DNodUcsXCoziLQBwP0Frp8Amb6aMFcC0DdUo3Ub7T0
	 YPCCRnXBXU1why3bYJiVEy/IWpIJtCrQ81Mppt46NvONPRycpVbBBtjjm606fxz0cJ
	 /tMBHJnntONP3QhGxeGthJHUCCmJ/R+YMPxAzXl6RwFR37g95To62VMbZRVvjr4Kyi
	 TKFVctjpumN1YCUFUsIJu9P3En05rUJWXMJ4IAj2yNS0igWUrA/jsamySjwgdGFvpO
	 LzZX2mYwJiQEg==
Date: Fri, 19 Dec 2025 15:04:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-gpio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko <andy@kernel.org>,
	linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 1/9] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <176617829657.3934846.6702160905493410565.robh@kernel.org>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
 <20251217-staging-ad4062-v4-1-7890a2951a8f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217-staging-ad4062-v4-1-7890a2951a8f@analog.com>


On Wed, 17 Dec 2025 13:13:24 +0100, Jorge Marques wrote:
> Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> monitor capabilities SAR ADCs. Each variant of the family differs in
> resolution. The device contains two outputs (gp0, gp1). The outputs can
> be configured for range of options, such as threshold and data ready.
> The device uses a 2-wire I3C interface.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 120 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 ++
>  2 files changed, 126 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


