Return-Path: <linux-iio+bounces-26835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8BCAAABA
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 18:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751C33072869
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C671E5B88;
	Sat,  6 Dec 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX8Sx2Uw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436E1397;
	Sat,  6 Dec 2025 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765040497; cv=none; b=c+kt9RI+yrg0q1wEHwtnyLQA0U4P55ujfqpi7VWHWWKIolfZuech9/+faSYWComRwzJrPTpHAaSI+SZKza/FzDFUhm0Rx095fqIDIpF05EAzAwTlRNf5F/xR+Ia2e/rLiFibu81BIQegW5IiBYlz9SL75o/TYnD+lzAssX5gWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765040497; c=relaxed/simple;
	bh=Zb2IzJQAh1HqOHiIKKpKwVh/F9KjkfboCtNVF5Xm3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsToMkBOBBWnz3BaSVnEHw70xW1IkqDj0yxjDJbNcwwBgiry3X1O/pdAuN37sXpNqWITucc8Rua/D1cYzJUzMe09rZveIwCaSgxiQWka5EDOtbhZrhgKhfqePUjKKW7qCtgYwKeUqrsBH5w5KswUXa/1pStsiPO7/fmGWxvK1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tX8Sx2Uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DDAC4CEF5;
	Sat,  6 Dec 2025 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765040496;
	bh=Zb2IzJQAh1HqOHiIKKpKwVh/F9KjkfboCtNVF5Xm3/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tX8Sx2UwZ6Yfg8WEuWYkhUFDZIVwSrLCq4SmjsZJAX+PmL8ZQcxzwOtA2nYWMC/LK
	 wqGBrzneJ2crIViv4LZcRAhApL0PHYNTGhCAEvak2+HFGEAIW19q2UUWLM0S3PzXo7
	 Lstn2DoTr1rpgISLAteiaf/qOkGDTLHC4p0Ak5paeAcOQ6jOstvzzUCG8eo4myDyU7
	 WOFEiT6p/Jk3s12stbbynPMHzITEwjKaPbeNsyAIrj7nat3XCpP5lWTKXCIa04qXn/
	 bSNCtDmsNZftDgtla1vs8gx9Axz9s8IqOUWKl2C6Zz+r5hmygqUAMsRapA/xmWg+LV
	 RnRM6Y73Rwm0g==
Date: Sat, 6 Dec 2025 17:01:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] docs: iio: New docs for ad4062 driver
Message-ID: <20251206170125.577101bb@jic23-huawei>
In-Reply-To: <20251205-staging-ad4062-v3-2-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
	<20251205-staging-ad4062-v3-2-8761355f9c66@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 16:12:03 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> This adds a new page to document how to use the ad4062 ADC driver.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
One small thing that I don't really mind either way.

> ---
>  Documentation/iio/ad4062.rst | 94 ++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |  1 +
>  MAINTAINERS                  |  1 +
>  3 files changed, 96 insertions(+)
> 
> diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
> new file mode 100644
> index 0000000000000..e6bcca2bef24b
> --- /dev/null
> +++ b/Documentation/iio/ad4062.rst

> +Unimplemented features
> +======================

I'd be tempted just to not bother with this.  Unimplemented lists
tend to always forget stuff!  + you get rid of some entrees in later
patches anyway. 

> +
> +- Monitor mode
> +- Trigger mode
> +- Averaging mode
> +- General purpose output


