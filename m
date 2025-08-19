Return-Path: <linux-iio+bounces-22963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D5AB2B9FF
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 08:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B2C3B73FC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B72765C9;
	Tue, 19 Aug 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkdTgfHv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D01990C7;
	Tue, 19 Aug 2025 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586683; cv=none; b=DHbFsGpdIRaXmyjucFtMGLij0DCZTFNYwwF/lvqYO6njiQ41/34N19ijkh9UgXir8GXfSSGkmjY6b1HUR2As2dMLfrHLlygERylzUagoE0f9tUbrd2ikuYiWBdyeQt2j/4VWnjhxXH9s9RJSxB8JbtUJpHrOJA0b0jWG1o1G/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586683; c=relaxed/simple;
	bh=NUMFdFjVT0RoEs+Z7iFewD15ed96ByaKOVYPX0vPd5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D49KXT9ZNAPN3QEkDgMP4RdGpGbfmr4g/x2OZy2MzWg3M4R0Y+Jp2xmT/+guS5fI/SLtMH5VGxZ4mN7wGeeKHGLYHF2GG6vbgDcrCL7XK7p72Wr6N3l1b+W5W2i7yyVVNyfNYi32uJQa0KCz62dIWv1v01PID9/+2DD1prY95qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkdTgfHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707BC4CEF1;
	Tue, 19 Aug 2025 06:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755586682;
	bh=NUMFdFjVT0RoEs+Z7iFewD15ed96ByaKOVYPX0vPd5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkdTgfHvMHFvIeVPF7po5ZgakqRkmXtWzUAqISGmD/LNU8SHVQopHsiChjgR7Pzt9
	 nOjqc/ozOV7g6+jggafTnICgqh28R4k0i8tRUpnKbw5hQXq+XMbPREPjJyx70ssWeW
	 6tN0xNyPR7cREaWySJvPfIDdiArIIlYCkbwmjUnmhHWK/XKtJTi/yegX8IIVdhTcMW
	 20G4D5I89qIih8MauxEJ6EFXhT90pCcOLIAd+2R1hhf/qcUorh6qYpRxpa/EmDtOGW
	 qg/1MRPbsQ4vxhMF3bSnLu0+s+Enc2T1cYJnKpSZUgxlaDHIV9dGIKU2BjAl2wCFyE
	 MkaGV/vkYAd6A==
Date: Tue, 19 Aug 2025 08:57:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: iio: mcp9600: Add microchip,mcp9601 and
 add constraints
Message-ID: <20250819-silky-garrulous-mosquito-4caaed@kuoka>
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-3-bcollins@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818183214.380847-3-bcollins@kernel.org>

On Mon, Aug 18, 2025 at 02:32:10PM -0400, Ben Collins wrote:
>  properties:
>    compatible:
> -    const: microchip,mcp9600
> +    oneOf:
> +      - const: microchip,mcp9600
> +      - items:
> +          - const: microchip,mcp9601
> +          - const: microchip,mcp9600
>  
>    reg:
>      maxItems: 1
> @@ -34,6 +38,8 @@ properties:
>          - alert2
>          - alert3
>          - alert4
> +        - open-circuit
> +        - short-circuit

I do not understand this change. And again, if you tested it before
sending, you should see error.

Best regards,
Krzysztof


