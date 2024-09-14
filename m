Return-Path: <linux-iio+bounces-9587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995259792AB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593472843A7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF71D1316;
	Sat, 14 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e56duIMx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C41D12EB;
	Sat, 14 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726334939; cv=none; b=JG/DmdV4sh8oTty4xr8f3lSpaUSnBrMciT8Dcono7GWrWHREZWqPrFjFjOMIdLsaies/lGWFYbIEUU/RsXaDsLVP0TP2Wr8XPa4H1waX/K6cXFY9JpfirMGpnDNaG1NhOZbo/NZpN3eANnYJVrPoXZ5qfln2j5J/x0fliOHo7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726334939; c=relaxed/simple;
	bh=NXf7e01hl3GO0CQZRAffBRyDuc6rntgFk96UeBSOmaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=say1gQitbP2HuA7FuKP989savLY19VlU27UpCqSnebFIVl+TU9PAh6tElaaH9AHotcZIU9h0WYGqC4mNTEtWzkT6peAPTt5cwlD7DvAQj4eEw+bQZnB0Q6pyR9dzrGNlSu7JniB5KOqHIWnCwkv793wicCwGYTiAH54JA8wuMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e56duIMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B5EC4CEC0;
	Sat, 14 Sep 2024 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726334939;
	bh=NXf7e01hl3GO0CQZRAffBRyDuc6rntgFk96UeBSOmaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e56duIMxJb49lnihZT+U4kBjmaOg51PqwNPQ71sZHpGmuDYThT5CvbDKs+8hjSOZY
	 BzV9s0h6z8GIWoVFFQV6Xd8JtQAl6KFB8n8SLDdZNg+2duzurx7y35z5JKPC7/ytlE
	 K1nrJoZotWHuY+jNLiGtJYR/JIMebUo7XA/IndRR6Hm6C+VvEfh12Irg1o6fLC6Uly
	 p6StNaJjiFxXYe3qzWtS7H4PZd1HzGogZKN77ClrToTVJMH52inY0y9JPKyKt+9VjN
	 U4Cvx0FRvMe7CpNV9wU/7CAZUhGujbZs8BlF52Ij3UuWL5AgsIPl/RRaWbgyzXcrLH
	 6CkbEu9fbd93w==
Date: Sat, 14 Sep 2024 18:28:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/3] iio: adc: add new ad7625 driver
Message-ID: <20240914182848.34edc5e3@jic23-huawei>
In-Reply-To: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
References: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 10:30:46 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> This series adds a new driver for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961. These chips are part of a family of
> LVDS-based SAR ADCs. The initial driver implementation does not support
> the devices' self-clocked mode, although that can be added later.
> 
> The devices make use of two offset PWM signals, one to trigger
> conversions and the other as a burst signal for transferring data to the
> host. These rely on the new PWM waveform functionality being
> reviewed in [1] and also available at [2].
> 
> This work is being done by BayLibre and on behalf of Analog Devices
> Inc., hence the maintainers are @analog.com.
> 
> Special thanks to David Lechner for his guidance and reviews.
> 
> [1]: https://lore.kernel.org/linux-pwm/cover.1722261050.git.u.kleine-koenig@baylibre.com
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/chardev
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Hi Trevor, 

This driver looks good to me. 

Uwe: From a quick look at [1], looks like you plan to queue that lot up
after the merge window.  Would you mind doing an immutable branch for
me to pull into IIO?

No rush though - we can figure this out next cycle.

Thanks,

Jonathan

