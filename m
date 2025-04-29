Return-Path: <linux-iio+bounces-18813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C398AA04A9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 09:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF0483084
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1F27A911;
	Tue, 29 Apr 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwbvq8HQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC9E27991F;
	Tue, 29 Apr 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912217; cv=none; b=u4qAQSbnXNrXULIeVFEgm6LY/k4baAjLajMtbEsYKOfO6dL7MPciq5Os3+YkVkmpDCvAYpISlhbhHRXsuTH8yQ6PZGe67xGIkDZmtWt0IurqtfqSy0EpnULjKaaGoKBcIGoDuU+8Y73dFmzhFeK6jRKtod4Rmv0QDNpOJ70WFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912217; c=relaxed/simple;
	bh=/arAgy+mMya1qUnC9q22rUDb6dDI78ZEwALTr9bZUoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWRISIdP/Ivz1BeFX2eH71z1Vo5S/RDyLiIsHlrB4/a3MOr1NK4ZKuYwloPWPFrP33WREWIZbcWBaAVHYHmTfUZbp+t0h6SoVvS4l92PZe74gHh2mlevsN0U9UfUeWqU9E+KLwtibxgpyuoI4Up5q9oWuzx+GG86wvhOI0mX7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwbvq8HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEBCC4CEED;
	Tue, 29 Apr 2025 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745912217;
	bh=/arAgy+mMya1qUnC9q22rUDb6dDI78ZEwALTr9bZUoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwbvq8HQK0zIFFIztCfOVgYWBn0eMcwEuZ9nmB3EsbdcdZyBWFjWTxOFBkGNFZmKk
	 381+AyTqawT6XvCasSoB7sW4qnkdIkFwFjehiyeaBkTqeNFGOC6Vy57gLCAyFaR4gM
	 xAzG932mn4xx93kmL9asWO68SOhYCRWul/L+ldwRoXPEGrTLocl34J3Rrr/UKMAKCL
	 BMU1wwMIfmMtt7Zph+a9/eyHwpb38SBdNhjXCTfqnam4rTlB5e97DSX0YyxSl1Yrjo
	 f1AAQvV1oAgT+5jj3ju1lcHKRaHBJo4BbLmzyOjYxJGIeBNFEFdbT9acMB9kZfAGG6
	 LO8HqVo9UqKaw==
Date: Tue, 29 Apr 2025 09:36:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	javier.carrasco.cruz@gmail.com, tgamblin@baylibre.com, olivier.moysan@foss.st.com, 
	alisadariana@gmail.com, gstols@baylibre.com, antoniu.miclaus@analog.com, 
	eblanc@baylibre.com, andriy.shevchenko@linux.intel.com, matteomartelli3@gmail.com, 
	marcelo.schmitt@analog.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: adc: add NCT7201 ADCs
Message-ID: <20250429-sensible-subtle-cobra-badedb@kuoka>
References: <20250429025505.3278016-1-j2anfernee@gmail.com>
 <20250429025505.3278016-2-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429025505.3278016-2-j2anfernee@gmail.com>

On Tue, Apr 29, 2025 at 10:55:04AM GMT, Eason Yang wrote:
> Add a binding specification for the Nuvoton NCT7201/NCT7202 up to 12-bit
> ADCs with I2C interface.
> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk+dt@kernel.org>

NAK

This never happened. Don't add fake tags.

Best regards,
Krzysztof


