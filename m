Return-Path: <linux-iio+bounces-22303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D61B1AEF0
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 08:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05C27A80B0
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A9239086;
	Tue,  5 Aug 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azlyW3FW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132022576C;
	Tue,  5 Aug 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376947; cv=none; b=IB43jUc6Dkk0grV+VAbwq+yN8/1YSpiZqiFzIR73NStUn8SIB40kdoNbJDeMjL1QdIP+Zu15CQtpYChNMy5MOlW06lYVKXWj47PSJltu1HkJnijQVsAIRRRZ1lucdmmjzj7aq/8+6oJog0d6LMPn5kjBOVq88hcP7Z0hOorhcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376947; c=relaxed/simple;
	bh=zRktS7tLY1en7iXMLnLj6uv8j5ngLB1dqGGyBECiblE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpFTCbvleO5vIWwN1p9AuUPg9gXo6VhYdWJU2HqZI1cxrynw6ZN2B1sbUbCDIddUrfms7lK9eLEoZ7Bi1zxrD4DGIlPBm1d8MFwDU1jktLjJpAUjJRyNV+osVRxNCh2lFO+n0NwJLYuKcFokiuEpDswUhy+nMEpRupnGENEhA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azlyW3FW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F161C4CEF4;
	Tue,  5 Aug 2025 06:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376947;
	bh=zRktS7tLY1en7iXMLnLj6uv8j5ngLB1dqGGyBECiblE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azlyW3FWSEQ2XP3fACoYQZrxXwn21yiJt7+f1wJiHpxnKDni6qVPsrcjO7i65RzAu
	 q4KgLoAudjJjC6o0FSZigmnj2awONCPYrX7uHlPVvYmWJkb8beQbqBAPDCjNx5qQLg
	 TQ+FA2FaeCFo9QaqtJG7SL/04Lw7/RQGBUVeEvT70gDTfPEorDLqTWJzLc57Y3OPdm
	 ZR205NeyUEiKuj4YiC0g2WE+kyTh9tHq+n9T5bGcN0A95UzGOFB93Rt9omaWAyftW+
	 QPg9myMS4CRT5oRb7aB9feZPjQMS8F3/20fLFqKRLnXR3+XOCCpD0DWjzlkd1erJ0w
	 LxDkYZMWvlADQ==
Date: Tue, 5 Aug 2025 08:55:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, srini@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] dt-bindings: iio: adc: at91-sama5d2: document
 sama7d65
Message-ID: <20250805-stylish-elegant-raptor-1ac78e@kuoka>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-9-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804100219.63325-9-varshini.rajendran@microchip.com>

On Mon, Aug 04, 2025 at 03:32:12PM +0530, Varshini Rajendran wrote:
> Add dt-binding documentation for sama7d65 ADC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


