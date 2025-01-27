Return-Path: <linux-iio+bounces-14636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600DDA1DADE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8711889178
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71915E5B8;
	Mon, 27 Jan 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb0hE2Lz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9275433CB;
	Mon, 27 Jan 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996983; cv=none; b=R+vPBrH0NPGLtKhdO/lVqULXPtndgFs3Y2mBTtKgJdwhYWGQueCi/zesz1LgbERWwxqkGM2TCC9PrVUho8TXePpxLBXCgVR2iMcZFN2flP4jAvFwj9jVXZwKhxtm7YEhyLgdzCU9jhOVWR9T0TKYItMbpJSNChJ9xpEwWdEusXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996983; c=relaxed/simple;
	bh=Icp1z06DcSKJEBEZLh/HqaKK5uWkxBLX4qEKaiKT0g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYy6xsPEPlPiq6EDnH7npS488kQeaQmmUXhHmHnvMa1afZL18MSYyZvw0Vp5ZT27wSM4D9+VkI7mA8Fkc3NAhn8rF/qpSwz4pjvWxSKGhMS9rHxOfWTTZCe470utxe7s0I5EKu8VM5FYq8HcodKrDNSmYFEzQ2rQFB6Ced2Ng6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb0hE2Lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1390BC4CED2;
	Mon, 27 Jan 2025 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737996983;
	bh=Icp1z06DcSKJEBEZLh/HqaKK5uWkxBLX4qEKaiKT0g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fb0hE2LztpT+UF5YgFqYGB8TNmnGCAPb+rs7zq0g4nGT0fJvtx9db3fjQJepVskSV
	 U2Bmo/OUlBUdrp4ehM6amzOM9B0p79EN0eSj3BR0GD9jm80i4hVsFeEfiJNigoCl/K
	 GOzbS1LQAy3CbJjHAbkO5cEcnEFwFBWeAxAq05CQTBiCw/15UVfD/gHRKUqqrjmaRs
	 SIpfcsQSE+EfUrN1cHvu1JogK7KJmuG8Qig0sjSuR0ybRawdVX/hTApJxtyvgalKwx
	 nb8qcvJy9jzDFvn6qX9gB0tix/FfeRZ7e4pB5Bzc31OEPZhDD3A+F/7nmG/OA2zAT4
	 QMSPVwi5bbL9w==
Date: Mon, 27 Jan 2025 10:56:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: marcelo.schmitt@analog.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, jic23@kernel.org, jonath4nns@gmail.com,
	linux-iio@vger.kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	marcelo.schmitt1@gmail.com, krzk+dt@kernel.org
Subject: Re: [PATCH v2 03/16] dt-bindings: iio: adc: ad7768-1: Document GPIO
 controller
Message-ID: <173799698101.443043.276821250672905938.robh@kernel.org>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <dc866cb508917828f83242f3438dd1d6ac9d874c.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc866cb508917828f83242f3438dd1d6ac9d874c.1737985435.git.Jonathan.Santos@analog.com>


On Mon, 27 Jan 2025 12:11:44 -0300, Jonathan Santos wrote:
> The AD7768-1 ADC exports four bidirectional GPIOs accessible
> via register map.
> 
> Document GPIO properties necessary to enable GPIO controller for this
> device.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * New patch in v2.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


