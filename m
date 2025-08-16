Return-Path: <linux-iio+bounces-22784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E53B28CAA
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E545E4589
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929828CF5E;
	Sat, 16 Aug 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF4fnMTE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0C28C84C;
	Sat, 16 Aug 2025 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338877; cv=none; b=kf81VbUVFJ5osHyjll5gxctYlZ2Jvq9BwlZsSyyU30OEoiHAmW+35PI/Jow2w5YRsV9cNLccvlHjZ9gfXTYuLyoDTdzgSJFBv3/8514VTH8AI4mhWMfPN++7sANRPwpZMuVFyMsiwyrJJUXlOELSsRdw9s+xAQeO3iDgWNFQxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338877; c=relaxed/simple;
	bh=xp1P+sO93gQPXTaxhlBCl+TFlpWpJwY0dgXxIiAZxfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByNV3gL7DOsVPBQVGld19NHWqpwV7FyJWkoTJxDyn3HQoK5eUhZdoTT+/aX5Nbu4qDLl2dLwGIYdlB89HbebrDIOoG6P6c4aWDgMoZA6DPDDPov0HCGo2kJuMCOhu3Nrje8TQL2FbC6aLngL3u8r9kRAVs0Fl6u156rkxQtBK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF4fnMTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05F8C4CEEF;
	Sat, 16 Aug 2025 10:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338876;
	bh=xp1P+sO93gQPXTaxhlBCl+TFlpWpJwY0dgXxIiAZxfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dF4fnMTEROeiItj4LCHCX7fnSbyd86TDZeBSEBXsTteJ6kcckv+34sJhynuq0zzy7
	 FQXHA1/NFkJ3DgPfhucqxTcC5KmmPrnWcXLMHPJh526m6XjQzNCkMhY24VpoV4QOie
	 WNANztHhvUhao2GiJop53pEOdOadTwlQhonRddsYL9aTYYknLrvdbrWNu6SAsWcYuI
	 Dp9i6pSAMpAsbpdy4iubigPbg64EtA1ZYD0OgkEMDLbfhCwwT/PaQgV16ZvgRP9L0f
	 lznqeYC0soSLAF1Jb3wTPsnZ7XUiiC9/pTKP06h/5yh3cHuVDiOOMixxPrd9OBJoQl
	 0rWqhuRLez+iw==
Date: Sat, 16 Aug 2025 11:07:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH 0/5] iio: mcp9600: Features and improvements
Message-ID: <20250816110747.42696c91@jic23-huawei>
In-Reply-To: <20250815164627.22002-1-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 16:46:02 +0000
Ben Collins <bcollins@watter.com> wrote:

> From: Ben Collins <bcollins@kernel.org>

See submitting patches documentation.  Should have a version number in the [] in the patch title.

Jonathan

> 
> ChangeLog:
> v2 -> v3:
>   - Improve changelogs in each patch
>   - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
>     * Set register offsets to fixed width
>     * Fix typos
>     * Future-proof Kconfig changes
>     * Convert to using chip_info paradigm
>     * Verbiage: dt -> firmware description
>     * Use proper specifiers and drop castings
>     * Fix register offset to be fixed-width
>     * u8 for cfg var
>     * Fix % type for u32 to be %u
>     * Make blank lines consistent between case statements
>     * FIELD_PREP -> FIELD_MODIFY
>     * Remove explicit setting of 0 value in filter_level
>   - Based on feedback from David Lechner <dlechner@baylibre.com>
>     * Rework IIR values exposed to sysfs. Using the ratios, there was no
>       way to represent "disabled" (i.e. infinity). Based on the bmp280
>       driver I went with using the power coefficients (e.g. 1, 2, 4, 8,
>       ...) where 1 is disabled (n=0).
> 
> v1 -> v2:
>   - Break into individual patches
> 
> v1:
>   - Initial patch to enable IIR and thermocouple-type
>   - Recognize mcp9601
> 
> Ben Collins (5):
>   dt-bindings: iio: mcp9600: Add compatible for microchip,mcp9601
>   iio: mcp9600: White space cleanup for tab alignment
>   iio: mcp9600: Recognize chip id for mcp9601
>   iio: mcp9600: Add support for thermocouple-type
>   iio: mcp9600: Add support for IIR filter
> 
>  .../iio/temperature/microchip,mcp9600.yaml    |   6 +-
>  drivers/iio/temperature/Kconfig               |   8 +-
>  drivers/iio/temperature/mcp9600.c             | 209 ++++++++++++++++--
>  3 files changed, 201 insertions(+), 22 deletions(-)
> 


