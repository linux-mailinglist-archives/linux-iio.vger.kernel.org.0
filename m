Return-Path: <linux-iio+bounces-6739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6D913970
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 12:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70067B2290F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B138614D;
	Sun, 23 Jun 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYC3YrP1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB32F2D;
	Sun, 23 Jun 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137578; cv=none; b=tvbXam9EqCAHZ2WcfoAG0UzYV9vspKvrgBZmIwReW3E74u9JltYRIFzhE6/ogyOdRz2nCKZezJPMIDtZZrG+jzi5VAAlohvlidKiK6vrhkcfSyqbAEC+2s/dQYjBJ1V7F5C7ZCDBqjFe5rnvN9rs0sUdXJqCfM/ATMQH0GW+xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137578; c=relaxed/simple;
	bh=s3jp8zh5u3y1JESPzwVac2JNeSuI2Llrbi+/y+WuucY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYXz+3A1xym/8pP09kJz6nwDr/u22Yxxt95DWx0j3AFcvBcCqF2/UnRge1Z2KDas8FrnzAuzANA2OhbtspM9PEnkDvaU/Xse7ahbxdeSVhbyrC9JemMhnRKHoIbnVSR8n+Jf22qQnEpky/znUc2u3JdxAODq8Vxvl8Qzs+JBG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYC3YrP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DDBC2BD10;
	Sun, 23 Jun 2024 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719137577;
	bh=s3jp8zh5u3y1JESPzwVac2JNeSuI2Llrbi+/y+WuucY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NYC3YrP1gZnq036U9jv9mfQXcGC30x2y36w2BJnv8VWxiKrtcBthVuELstjgNHGBf
	 g0eO4KPs/mvekXEA4q5E0JEa5XQNgu4tAggzruSwDGVVS7JdMlUU3eUh4DZL0Dp96l
	 8l6IMRpnrq5z+Kd7qUfLxisyvDLus9GRQV0bh4/fnD8AhRdxY+rLEUwiPHsKZ+RE6j
	 AfwBs3ovHpvYDMNCp/em5cDWZtg57c16bSP0Zf0akAh/K4roGWos4TcwGaqo5D+Hk6
	 eVu4gaUH0ue6cjWs8su1J6m4S2LP/8qh04jTrqz3gqn2rDUYhjjzUH78ciN9pNImtv
	 k0bIKGudVb52Q==
Date: Sun, 23 Jun 2024 11:12:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] iio: use devm_regulator_get_enable_read_voltage
 round 2
Message-ID: <20240623111247.1c4a5e2a@jic23-huawei>
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 17:11:47 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is the second round of patches making use of the new helper
> devm_regulator_get_enable_read_voltage() to simplify drivers.
> 
> All of the changes in this round should be fairly straight forward.
> And as a bonus, there are a few patches to get rid of driver .remove
> callbacks.

LGTM.  Obviously only been on list for a short time though and
some of these have active maintainers so I won't pick them up just yet.

Jonathan

> 
> ---
> David Lechner (10):
>       iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
>       iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
>       iio: adc: hx711: remove hx711_remove()
>       iio: adc: hx711: use dev_err_probe()
>       iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
>       iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
>       iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
>       iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
>       iio: adc: ti-ads8688: drop ads8688_remove()
>       iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
> 
>  drivers/iio/adc/aspeed_adc.c    | 30 +++++-----------
>  drivers/iio/adc/hx711.c         | 78 ++++++++++-------------------------------
>  drivers/iio/adc/ltc2309.c       | 43 ++++-------------------
>  drivers/iio/adc/max1363.c       | 28 +++------------
>  drivers/iio/adc/ti-adc108s102.c | 28 ++-------------
>  drivers/iio/adc/ti-ads8688.c    | 59 ++++++-------------------------
>  drivers/iio/dac/ad3552r.c       | 28 +++------------
>  7 files changed, 53 insertions(+), 241 deletions(-)
> ---
> base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
> change-id: 20240621-iio-regulator-refactor-round-2-28a1e129a42d


