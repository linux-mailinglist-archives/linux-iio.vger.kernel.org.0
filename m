Return-Path: <linux-iio+bounces-27388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB1CE00E3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D86E3020683
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC732573F;
	Sat, 27 Dec 2025 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbNptJd1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C9283FF9;
	Sat, 27 Dec 2025 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858881; cv=none; b=PSvL7CjxzT8xcJIwFxoq5OJrwQPFPRQcuAYOgwkb2ICtqiD70OMdBhAGC6O00laqvPcE4LSnhoqO0EjMIeAX+Ezn3KaORQWyal4Wi3E+iFcJ/Wqz02vqq78USLpeuimqERz1ZBKDtQYGQbFBJaRF1wnOmJ/ii6pe6Kms14lkrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858881; c=relaxed/simple;
	bh=0mr9k/inP6CvH0kP2jx1FkfnoUiXRzqbFromlFZgnh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSNRyY8Q3u07Cj2/M592UW5tcJOIXOqlro5EEGF1XyhV6qgUPiscCZzrtqeOTwajVBo8EgVbsWH9p29j9GFviO2P9WTSPeyhNzGpN60tbD4xnaHYYr+O/WdVE958ALHEIg3r/HZXo+rxdYPRFQrdbyI2pcDH8J/B9mmPIwcuhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbNptJd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F627C4CEF1;
	Sat, 27 Dec 2025 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766858880;
	bh=0mr9k/inP6CvH0kP2jx1FkfnoUiXRzqbFromlFZgnh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbNptJd1ur0y0vNUwM+A9mUX9I12BZ8iaEqUjmKHcU7k+4a7LZrhvB1GMG/fxwcPY
	 dr0/vaIB6T0I1q+MLrLq3zSH8h7i3VFzinmfnlg2MlUAaGQCy7Bp2kP94iRaC2g603
	 /Rnza4YWIQ0vbXSkiWcYu8AR5kKqarGFkNAfXlY0saUg1Jt1NEqBlcXx3tTuYA6bu2
	 5d/Sd7MScR7U7toCC9JIuDBCIUQEEgnPZ0pZ3dBgGB5vFoOUvRcUYKC2BdXWtkNQYx
	 oc/XL7j0i+dKFmyoJEY5/FoHONdxFevSRb0t+5dItzHMFrr3Yum0kpxYhtkOOvfnyf
	 LBcfjDCYAS/bg==
Date: Sat, 27 Dec 2025 18:07:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: ltc2309: add support driver for
 ltc2305
Message-ID: <20251227180750.1e7fd7d9@jic23-huawei>
In-Reply-To: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Dec 2025 13:37:13 +0800
Kyle Hsieh <kylehsieh1995@gmail.com> wrote:

> The series add support for ltc2305 controller from 
> Linear Technology Corporation(lltc).
> This is low noise, low power, 2 channels 12-bit successive
> approximation ADCs.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
> Changes in v2:
> - Reordered chip descriptions and code from low to high order.
> - Renamed chip info structure to use ltc2309 driver prefix.
> - Switched to i2c_get_match_data().
> - Removed unused variables.
> - Added chip info to i2c_device_id table.
> - Link to v1: https://lore.kernel.org/r/20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com
> 
Hi Kyle,

Welcome to IIO.

General best practice is to always wait at least a few days (I'd typically
go with a week) between first few versions of a patch so that there is
time for multiple reviewers to take a look.  That's particularly true
when holidays are occurring in some parts of the world! 

Jonathan



> ---
> Kyle Hsieh (2):
>       dt-bindings: adc: ltc2497: add support for ltc2305
>       iio: adc: ltc2309: add support for ltc2305
> 
>  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  7 +++
>  drivers/iio/adc/ltc2309.c                          | 51 +++++++++++++++++++---
>  2 files changed, 53 insertions(+), 5 deletions(-)
> ---
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> change-id: 20251223-add_ltc2305_driver-728fa9161bc7
> 
> Best regards,


