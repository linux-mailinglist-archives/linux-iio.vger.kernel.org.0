Return-Path: <linux-iio+bounces-23029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1288EB2D4DD
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77F5170EA2
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06A2D6E4E;
	Wed, 20 Aug 2025 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7n+gtjQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA327602C;
	Wed, 20 Aug 2025 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674959; cv=none; b=AEcQObfkzZvCtg5LlwlIvhYcdui4sdCoBqMyLCH5oi8PkmMiRpDcnLGUwTJ2wXu9bEovQ3thbwjXODuo/UIDF+yTUKVFKECB05mXDAkdNa0M8l7SQOMNwwuQuP4e9jiy+0Bk8YXy4k6KLe7oH/Z9ADdZ6rVVPM+Nqcqv+LLjHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674959; c=relaxed/simple;
	bh=NsOQ7u4Ri3uHrs1JNzzjbET6t1f2VJVojKuLxLJC/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTwtv8pycOVSBttkCrCIK9iLRFViQoE+Ep7dLLFeMkskssRO/buWhTRVyUt2wEdqKbV/pUrXupkwX6pBQyxXq7oTUCpM/XuIZN1pb+AeHniCd3fv7IwKLPihCUewT8HzX3a3leU4v+cIinHkaboQEOWRPJrss+xtRsFIkGZtpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7n+gtjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B06C4CEEB;
	Wed, 20 Aug 2025 07:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755674958;
	bh=NsOQ7u4Ri3uHrs1JNzzjbET6t1f2VJVojKuLxLJC/mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7n+gtjQ7rjdtYxWk5uhwwkmsWosSCfmycms3s92t/K3XHyixQzgfLRCu5oYSUtOL
	 iVIRSUqS+Jkmhu2eeQovxCu2MsOYIhyyZMFrTKZv0fhhvatt2Vi5lX45HB4WcSeFH/
	 zKLQPx8OpGg62O2V4Ibir3VISFk3iH8rqI8NiSFrm/FPa+BshilOGMA3/DkC3R9vwk
	 MTGvd7+RCbfJoPjGpOgZZZEs7KE7Nq0SgGSSQFzjZSC6NSQ5oM9RwlaRR+iOdfrS+L
	 cNedLm1XkxSnJtvoI2Fs9/baV8L7AFw6gNwqo3S82EZDiMNjv72AFT9TDO0Zn7L60t
	 vTkJfJif9FTUQ==
Date: Wed, 20 Aug 2025 09:29:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
Message-ID: <20250820-free-nano-kittiwake-05308c@kuoka>
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
 <20250819-upstream-changes-v7-2-88a33aa78f6a@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819-upstream-changes-v7-2-88a33aa78f6a@watter.com>

On Tue, Aug 19, 2025 at 07:44:43PM -0400, Ben Collins wrote:
> +  - |
> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@62 {
> +            compatible = "microchip,mcp9601",
> +                         "microchip,mcp9600";

One line.

> +            microchip,vsense;
> +            reg = <0x62>;

reg is always the second property. microchip,vsense goes to the end as
vendor property, see DTS coding style.

> +            interrupt-parent = <&gpio>;
> +            interrupts = <22 IRQ_TYPE_EDGE_RISING
> +                          23 IRQ_TYPE_EDGE_RISING>;

Two tuples <>, not one. It also looks like it fits in 80-char limit/

With above changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


