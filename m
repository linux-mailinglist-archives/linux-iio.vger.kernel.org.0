Return-Path: <linux-iio+bounces-22302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5CDB1AEE3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CD9189C821
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9DC238143;
	Tue,  5 Aug 2025 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNmagF1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7D221726;
	Tue,  5 Aug 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376878; cv=none; b=far3wEA7MNMGZZbMa4wX1Iem3UdKfXB9pxiEqoOSheE0fzjVgKZMrT3nouG8qC8cuJ1uZoGevJJMjLhwnnP4jQ2KP2H9IdaGhOcyDoX7lfFozY8M34bzbQvWKKj56JyHU89DvThZFaGflwOs7QCY9OH5YQ/xXRm8CVElDgPKRRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376878; c=relaxed/simple;
	bh=qUORQQgTe7at1SmLU8t2KsBAWogkXqUGJJcAm265+rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw0qXXbwzfYNXfOo3w2PirjwlR5Rz1ONZ0SN0N+wfOOwTuvLciDafA894ZuXd5uBCQHfIWMo/GKPpjG2iY9HcAd0DPvfYHvLOGJePsZkuLljLu8dhlCnm/cXa9gtOE35njZBwa5yl0lzDoOpDvnfpA/H0XyY4jmzN/UkPCTpQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNmagF1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36335C4CEF4;
	Tue,  5 Aug 2025 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376873;
	bh=qUORQQgTe7at1SmLU8t2KsBAWogkXqUGJJcAm265+rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNmagF1Q1SJb7ewdJruKJnvQ/LSjCeCTnubSWGHk9vp5q13YCUorVRXxDRsxl3ZD5
	 OkhdVeG8i6Rtxf6lFw/GGZRYhZUWrZQTdlH/5rrqq4VPkfoqcO7UQLjCImtCaOJe0K
	 iiN4LwAC11u2hSbfOkjxC41/w4SvwryBzjPg9BaWIe/bKGZI2zSYjwBDVmCv8VbiMn
	 nAa9a4X/dTl5FEDYnID7dvBEnkFLnyJIJVOzgl9Vlw7iqsnyQvjk81vM27fQFsIt/Q
	 pGHjMJ0K87VK3anNKis15yaDFj1TFNcMoBl7TTrTDWVNCp1mOZhW44l2y8KBWUfPix
	 G8cOHoZtGAPFg==
Date: Tue, 5 Aug 2025 08:54:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, srini@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] dt-bindings: nvmem: microchip-otpc: remove stride
 details
Message-ID: <20250805-magic-shrewd-caracara-95dfb8@kuoka>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-7-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-7-varshini.rajendran@microchip.com>

On Mon, Aug 04, 2025 at 03:32:10PM +0530, Varshini Rajendran wrote:
> Removed stride details from the bindings header as they are not relevant
> anymore since the access method of OTP packets is changed to TAG
> approach. Update the example binding according to the new changes.

Where?

This was supposed to be one commit.

Best regards,
Krzysztof


