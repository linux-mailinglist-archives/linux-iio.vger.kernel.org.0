Return-Path: <linux-iio+bounces-15159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85EA2D62F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 14:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604417A34D4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94A24635E;
	Sat,  8 Feb 2025 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPSiYF/G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F941A3157;
	Sat,  8 Feb 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020277; cv=none; b=U1CRgdMDJqYR1ZIYMxw+G7uEUT6U3MHAYfBH5bIKBv+mzSNRi18V8vYJY/dzdHzTNPgZSA+XbZ7TffKDWpHKZ73pzXC4XVz0rXs5OGKeSD7O8Y+LqaeA0FUFgTKwR0TRRsEhdwnsJ1lZeUpA316Qqej/XuVcc2jX2bZB4DXBdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020277; c=relaxed/simple;
	bh=n5BuwU7uYtKvDB0Fk84TTCx9il8023N4ggMSK5Wt3Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=At9mjuStAv1Febbz6iBEcXb37sIocD44S9msaCqTbVLi74n2e/B8tF+MJww2zrma/AISJhk3MFhreC9fdz32+sHj/FySVVQKhGR1a9Y1hu/e9PaOkTDMjm+aSf26jDfa7lAOQtqoSCgnxKxVFddMRVm95xYIBbTruQu2qHmATD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPSiYF/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1AC4CED6;
	Sat,  8 Feb 2025 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739020277;
	bh=n5BuwU7uYtKvDB0Fk84TTCx9il8023N4ggMSK5Wt3Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPSiYF/GgGtAi4CdflkHyKdkuTvLKxF0yAtZwxinY8ohE8BND7zR0geK/5dAzRA3W
	 Z++LkTQXDhNhj+Tby0fCEAGrRm0szgVZ/6bF42hn4nvjzADQc3W5MkCpo9MuC5ZXJn
	 d/9HrX++8ylWOpcl4/9DqAoK5cvPXXBm0RJNKr+oCAnNuhhY+Hs47WeKIN9FawOqOe
	 vHyA7BdpqVOJ6ZPZW1DHouLbTsF2U3o/2/xf7mmG4S64iGkvA0XrTtG8NKgVwrSBBA
	 +dYZb9v4v/HoFrmC91wP0EdeequICLGnkYTr6/cUPjQvRJMNEYp8XirPzAlu6AbYVS
	 KLGZ5I+rL0/Sg==
Date: Sat, 8 Feb 2025 13:11:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 14/17] iio: adc: ad4695: Add support for SPI offload
Message-ID: <20250208131106.70d72ac4@jic23-huawei>
In-Reply-To: <11b7f0fd-88ae-46c3-93b5-f7a0166e82be@sirena.org.uk>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
	<20250207-dlech-mainline-spi-engine-offload-2-v8-14-e48a489be48c@baylibre.com>
	<11b7f0fd-88ae-46c3-93b5-f7a0166e82be@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 20:20:27 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Feb 07, 2025 at 02:09:11PM -0600, David Lechner wrote:
> 
> > Add support for SPI offload to the ad4695 driver. SPI offload allows
> > sampling data at the max sample rate (500kSPS or 1MSPS).  
> 
> This doesn't apply (against -rc1) so I'll skip all the IIO stuff.

We are pretty churn heavy for IIO in some of these drivers, so
probably needs an immutable branch with just the SPI parts
and I'll unwind the mess on top of that (or request rebases
as needed!)

Thanks,

Jonathan

