Return-Path: <linux-iio+bounces-25866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8BC306E7
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4375B3BA530
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74253090FB;
	Tue,  4 Nov 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6lVN0C3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9E2D541E;
	Tue,  4 Nov 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250899; cv=none; b=jt2WXh7xD8Bv+Ja1ZstlpWfhWauX3YODe3NdukrEgMnCDDrpei81bx+3ek4SWwAA1UGW0CoK16F5SuI30s1Rgn2108OOtg5ZxzcW86ZvTDPB7JpWgb8Yh6HhVu+5ZUhfMyyT9ZkUceYekpHtMqFaJOOoXIE7FGokMD8rX5JsgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250899; c=relaxed/simple;
	bh=qO3WBVAPbxP4+oRxYAr9CsbFrExWM8O4nijZWjABxME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTLbspIQc5DhALLqDNnARpxhcL7dLzBSpj6pBAJD7EuIga0m02tcY4VqS76EjzthmMMCnakhbOUxwODdG0qDr07v8eduB3swEQHhefOanCRwyuMDhsxR6Er5jES0HCiPiVClaQ/gQqWznxHQw+b3DgXLHiNy/tHF9d+IV+1Lypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6lVN0C3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37DBC4CEF7;
	Tue,  4 Nov 2025 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762250899;
	bh=qO3WBVAPbxP4+oRxYAr9CsbFrExWM8O4nijZWjABxME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6lVN0C3JfLA+t8d+cw2jvUcx4IUtu2rer97kxIxwOGMSLifiMZaYjQTCecyvc0n3
	 P3cH8j4yB1SFDCHLuuABNfDtunGs6hi/F5VI+Afjbe5LajAtRHAHLsYkvz7WfLpQvF
	 nX2tMp2UuoS1ZMVQWe8xnywDIGLlkPjdd5W9q9wrBwuES3mLonzP4oXyWsacWa1DDS
	 MYnBWEhRe9nTQ8Bt/X3lFg4cOoXx3snKeiq6n6KgBXeaQ3cMl4Z6+wc5lACf/uF8Sr
	 Be3Xw4HON5okRjC2sFcic33cOiePOLkMGi91bPWw16VxNeGYTAfjxI7r5b9fboj1C6
	 qgl2Nc4iOAXQg==
Date: Tue, 4 Nov 2025 11:08:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add AST2700 ADC compatible
 strings
Message-ID: <20251104-enthusiastic-cinnamon-urchin-da480a@kuoka>
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>

On Mon, Nov 03, 2025 at 06:52:16PM +0800, Billy Tsai wrote:
> Add the compatible strings "aspeed,ast2700-adc0" and "aspeed,ast2700-adc1"
> to the binding for the Aspeed ADC. These new compatibles represent the
> ADC instances found on the AST2700 SoC, which are similar to the AST2600
> but have their trimming data located at different SCU offset.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


