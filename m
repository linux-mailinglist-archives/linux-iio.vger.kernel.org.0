Return-Path: <linux-iio+bounces-27354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D0CDFB61
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7C413002692
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30081DF73A;
	Sat, 27 Dec 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGg3Ajgi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E81D5ACE;
	Sat, 27 Dec 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766839189; cv=none; b=GK9tnXx7O5kNiC/0XQ8xuV0p5l+BsERxON5l21VlSucRfW0LrWoX2Rlgqhk9fnwNjwAVCPLueT0U0RvZUQiNKtITujIBdTfyT/6MUVajOvePlSGMagWH3IwWoUkjjynF+P7tpveKUMVFiduIEtzk2V4pCoKcoCrAlOd/EoL8aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766839189; c=relaxed/simple;
	bh=mcgLFnNec2gvNBvcHHGRVUD7x1safwibidE/qBISwHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmjcclFiIBNjteukD4+2TuVjj87Rw2hBzovoDkzSN/aV+ZjZhHQDoRYI35iXZL+5UKWpZdMd3x908G4OMKVUSFC6voiZ8eqt42H9nNfnQTsbzLM1nA11zJthTyKspISnFqcT5k+boHclvSMx0/p1nzaeT3HBr9OvgcwSM7m7+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGg3Ajgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C06C4CEF1;
	Sat, 27 Dec 2025 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766839187;
	bh=mcgLFnNec2gvNBvcHHGRVUD7x1safwibidE/qBISwHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGg3AjgiHjKthRjvtHR4E9yr8UTGIFpQldiby84lHJ/OQsBgao0PLYLwdJ+zxsC0d
	 k2p1wqfNRdViNsz2wmGNyrMI/v2NhfxkPzDFovJyu//Kbw1CasbtIwcfb3MvlXlxuU
	 8LG+ZebYgdW3QPbeTS4cwAZ4qG7UjgmVFEwTP3ZbFt49lz94PR4O03XQvYBA5qAdSu
	 A4Af/Svk11TVkzwAvSh7lsItMbMpt4NzLk8rnSqJoqgBDdAQGQ4xvQ0V34l2xWrVOb
	 TrIIxnPHTu7NlFCVkoDRbPurjUvldyzxVBLX4Eu1Z7FgSeJxehWJSA92O61AjG4qjM
	 gkqQp3DOJkq0A==
Date: Sat, 27 Dec 2025 13:39:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
Message-ID: <20251227-chubby-tomato-finch-24fecf@quoll>
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
 <20251224-add_ltc2305_driver-v2-1-061f78cf45a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251224-add_ltc2305_driver-v2-1-061f78cf45a3@gmail.com>

On Wed, Dec 24, 2025 at 01:37:14PM +0800, Kyle Hsieh wrote:
> Add documentation for the 2-channel LTC2305 ADC in the
> existing ltc2497 binding.
> This enables automatic device tree matching for LTC2305
> while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),

Not relevant sentence. And if I disable automatic matching in the
kernel, does that invalidate binding? What about BSD?

> since both ADCs share the same I2C interface and 12-bit SAR architecture.
> The main difference is the number of channels (LTC2305: 2, LTC2309: 8).

These two are fine. Just describe the hardware.

Best regards,
Krzysztof


