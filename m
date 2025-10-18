Return-Path: <linux-iio+bounces-25227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42421BED21A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94EC44EB700
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6BF221544;
	Sat, 18 Oct 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnVJyCmD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6651E9915;
	Sat, 18 Oct 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800311; cv=none; b=KKw9UQRhb15P3PIUUG4PYi/JGK6CHkW5cO+AXclSSHjHteDHiBWCKUVu/Y+684+NA51R1CY8ShrwB6+nlHkE8ZE6h0JrU569nluOOr9tECzXFSiQgGis+hkBxJDvNqgrXUtCyat3XAiLRM0tQKQvPz/EWudFd0Dh8ffKEFfkakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800311; c=relaxed/simple;
	bh=NcMUVSP+fxinMuOIMSQ26N9mzwAwXGigQE60prdyrmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoHRe2V5p2JR3w1xYepum+PaEscgEO8jTrigLj0K+aqAAScWY6sXskpRRaFBPDv5HCyxO5hoo2jLf2gZCE6b3rMUnJzIHnRi+NnQWsJ/7ZfAXYIm+un2VXNbg8RteZxMtURJPzm55/szh7cymwPrS8XKo0kWo6+cSoOEJtrinEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnVJyCmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988C1C4CEF8;
	Sat, 18 Oct 2025 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760800311;
	bh=NcMUVSP+fxinMuOIMSQ26N9mzwAwXGigQE60prdyrmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JnVJyCmDhsDkNB2cAK2zQsaPE9mLJh7c3bsVzOLvRB9rE0I544YAQ1g5rXHdJdh0L
	 M6AdA9FBeY23p24lQgGs2EqPgnFNeBXuzXdcMPkukbrMHtSLK1S/wYW8vX9j1wEM+E
	 8Os4wDdz/fw6f5mzYpvgnQk+4F7TmsQuHjzql2JeESVkNcqlHcyV7JHQJ74OCkAMm0
	 tvB8bLItSFgDKopwgvCA1cNVRnSrGuxRnlgSbjOP9AV8H6Ih1vV3Lcqng/jiBtqi/0
	 6ZcIbYdy7fYC+9AteGvblh9TG7ZwMoWSYelrwR+V21ykU1X8VP3y9hMlxlr3PoAwVt
	 s0U7uVeesLs8g==
Date: Sat, 18 Oct 2025 16:11:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <20251018161143.0a89495b@jic23-huawei>
In-Reply-To: <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 09:27:59 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> monitor capabilities SAR ADCs. Each variant of the family differs in
> granuality.

Resolution?  I'm not sure what granularity means for an ADC.

> The device contains two outputs (gp0, gp1). The outputs can
> be configured for range of options, such as threshold and data ready.
> The device uses a 2-wire I3C interface.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Otherwise nice simple binding. Nothing to add to Conor's review.

