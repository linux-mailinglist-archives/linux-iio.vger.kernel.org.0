Return-Path: <linux-iio+bounces-26857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A8CAAD52
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDA103005782
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69679259CB2;
	Sat,  6 Dec 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwzyjTC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B55CA5A;
	Sat,  6 Dec 2025 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053251; cv=none; b=c4WvoPhAj6WQ+cRz54cptrJlMTHltr7ilReyG1opMTbjENpmScY7g4Q4unkV90rDKbqxOvWhF+NFqj6WJqSEGz2yLIqlfkNY7gDu0DaUMncaoz0k8Cn14e7B0pN//Dos+BefKtFdXPwKYRlM5+RRrBGOsnjzpZj/m3a73qhKjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053251; c=relaxed/simple;
	bh=WAiSX+teukHIO+FT8t79R+QmSN0ZMHQSfgcuj8OtlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGr7aTJjzUp0rmL0dVSYTe8BHZdg0D0PsHbQPYM6DNFxEjWtkfGq1A0jfB8azQ6Q+Qkou7b9Q7RSaVtA1kR6kK9r+Nbli6eFg+LmyRLvEZKCWcEf4Kl44G41boC1R/6zg5JvlvPNUaEY91hhrz+opCwSqk2AXAvi6wnZ/J13204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwzyjTC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87E7C4CEF5;
	Sat,  6 Dec 2025 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765053248;
	bh=WAiSX+teukHIO+FT8t79R+QmSN0ZMHQSfgcuj8OtlVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BwzyjTC6t9Oyn+Ra/XblwcXQZlaN7dMTsPM4HvjEXKcvNJCVzAU4fozmC5d1oUHkJ
	 +lR4mEZgVN+ZvkPv5D3PGX7grw8Uh1yI9Hk3Nwu7rs4WIVF7afWfsyBZ++XheMeAu4
	 tvc70qTCarSjHLAew68KMu7Bm8STqzhFwMqogt4Lv6QqJx3LXXIgrY1ssaipQZG0Bb
	 ygkStQLqgXdaKBUd1ZAwbdeGkiCoStDgtcat7ppmnvghTNM/Kf7Xh1C9OYdjwESBhg
	 kDZjJwY2duvo9TcqmweWKHXfSY6Ppbi2+vyl3E6XhZGZ9rsHLy44AgFVLTEF/k6mcs
	 NycLro5kaIgUA==
Date: Sat, 6 Dec 2025 20:33:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: pressure: add
 honeywell,abp2030pa
Message-ID: <20251206203358.19e66133@jic23-huawei>
In-Reply-To: <20251204-honeywell_abp2_driver-v3-1-ad3275bad35e@subdimension.ro>
References: <20251204-honeywell_abp2_driver-v3-0-ad3275bad35e@subdimension.ro>
	<20251204-honeywell_abp2_driver-v3-1-ad3275bad35e@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 17:12:55 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Adds binding for digital Honeywell ABP2 series pressure and temperature
> sensors.
> The i2c address is hardcoded and depends on the part number.
> There is an optional interrupt that signals the end of conversion.
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre,

One trivial thing that you might want to change if doing a v4 for other reasons.
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.

Not worth a respin, but that description adds no real value over the name.
For simple supplies like this 
  vdd-supply: true

is fine.


