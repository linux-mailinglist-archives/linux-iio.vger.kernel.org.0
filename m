Return-Path: <linux-iio+bounces-21002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE6AEBD82
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE27170EBC
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820042E8E02;
	Fri, 27 Jun 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QNBLUm4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2C293C63
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042025; cv=none; b=HQdH/phmJnE9P+1nMSBKaOAxLZbUMMylN+jOP3+cLL7SQcsMsNgXpDew0kwacB/4j2rjsxObX3zd5kANwecL9ZeaP4Ltv9LL7f5gcmAJQxXXfFwLZcP/kR+cCpj+L+6woS+uzOMtHDxQHL0f7cQEewUqQch2jOg1F0SjVfGVu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042025; c=relaxed/simple;
	bh=dXpLHx9bw5vHEwTl6YxNtXihrgpgrvwSzKzcW4eOMZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l20b9EbCjqTdvhrF2cuD+IuzZ5DzrKYXfWBpijhY0z4/eXEQkETBi7jbZ+Uuxq5YwDGbUKCISy8SxL8umArUNqbggSKs2NIkIf6AnwoCmMOis4WIBJT/Q2NqlGRjFgpWzvs1ohOmCfWMmhqMkovGc89KPSNCJS28axX9pth0N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QNBLUm4o; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2ef60dbaefbso58817fac.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751042022; x=1751646822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmp7ryV5xjFvyB+Tl1aiIRJO+LGmYWq5ipUqtE2nDIk=;
        b=QNBLUm4o1dAn/I4+sFGYz0LNxVxmrGf3w9+z0HVb6ed3LkpKV7C9zk0iQVRO1Y42GF
         jTzJb4axom+2E95Jjuo1bEgLcJYEVlSwmsx3VjnHcqg4i4CX4ynW1n5jlxxSfKtN3IbQ
         bcbG57EeIJfMbTSx8DDHV4+UxW7r4gtvnFy1z7qKIEj1WUE2KHyEhh2THQdNAfpDiAHc
         HCz1nE0wSdsFHbajU9lrHY7k9EFHhGUDD4pAgNU84zaENxdGC0dM9RgJxM4gdTX6RAJU
         Y2o6JA1f2t/DIdhG6n+uBav6eo8Z6R89+3qt5MkFzZzimct9bC3Cn44YSwSPn/J2hxWN
         9rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042022; x=1751646822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmp7ryV5xjFvyB+Tl1aiIRJO+LGmYWq5ipUqtE2nDIk=;
        b=DTOeBnEmPJle1K3VmKj7mma3PsDKQFZbbcO4wf32yyQLEUY/CXR0cxZgcqG0JSDbq0
         HBWcnlSoqbq8PKQVyRvDPcdrbTwfZkuTw0R7J/4r7P2Yg4cY2BVnvVFERJuvTXjPz6aS
         FCU9IXzjhZyab7sKCv4AiPJFuqWRSs5uWHLu7UquTUBWcxQOwM1epyg796IYchE4kjJG
         heEb0N+og2UZnEbIJn/Glr4zwXH3UwKas9Oz5uWoZWPI1xH1IVPDJ5y7FmOepj3UPY7V
         XZQPKALPQ89NqRAUUZPfjdADqXIWgINEjATj8eZq1LF9TiXEFnSjOFX/HlnjpojxNm2d
         wWnw==
X-Gm-Message-State: AOJu0Yy0CYaVbJR6eH+Aa4WETGMfdF098M7I9g6TBZFoRl5n88D5IYuw
	8JG1I+69yNAzUSSoFM2wgexBKySdpWpAe2XDhqfGsFvdQ3z4EVWgT5jFV6UspOxBRnp09zkjDZQ
	ddxQU9BU=
X-Gm-Gg: ASbGncvv6gLB1FSBRO/3+jMZcYCyVisN1LLhvH4pLYt9OivdtdtVtHD314Jq9E8sv/c
	QxNdJqglK7PeXFqw9meUE3RZbu3y1CvmXr0ZN4rmb7mUNhKg9ze+8MP57kMGK2ibJxCHfWiem1W
	pVGWQ+fSGc9dY+A82u1yqpoTDRN+jvC7HFBRayGFvYLmGhmroA/1gUE92YWYZ7ukDz9LqdIUKoz
	cmH1Im3qeE4An3beDXOWFDHRWV9MJKzqPbJZoMKzG3gNSERumlrHow20nEztiTLBmve6kbnykus
	7lBi2NPpVK+m75r+t4/Bcgkx5WWtVfZMtOG56e57JvW03RW0TOuvsVGWZs2K/BPP3hKiqpLNXqI
	lAZewgjcoUo+X3gmes4eK+2xsECDgyVCRAeDh
X-Google-Smtp-Source: AGHT+IG9PvaUabFgVJrthR0i8DVI9WzDhHa//CNFrdsvKRueO/M97DcW61/F3jaCSrG4SYNr0EfeAg==
X-Received: by 2002:a05:6870:9450:b0:2e9:9e9:d94b with SMTP id 586e51a60fabf-2efed8eff8cmr2582939fac.39.1751042022103;
        Fri, 27 Jun 2025 09:33:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ea5a35sm946883fac.2.2025.06.27.09.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:33:41 -0700 (PDT)
Message-ID: <1a8dc586-6f22-4583-8692-084813f2df7d@baylibre.com>
Date: Fri, 27 Jun 2025 11:33:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
To: Lothar Rubusch <l.rubusch@gmail.com>, mazziesaccount@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-2-l.rubusch@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250625170218.545654-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 12:02 PM, Lothar Rubusch wrote:
> Add support for the single channel variant(s) of this ADC.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 1b46a8155803..cf271c39e663 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,7 @@
>   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + * https://www.ti.com/lit/ds/symlink/adc121s021.pdf
>   */
>  
>  #include <linux/cleanup.h>
> @@ -110,6 +111,10 @@ static const struct iio_chan_spec adc128s052_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(7),
>  };
>  
> +static const struct iio_chan_spec adc121s021_channels[] = {
> +	ADC128_VOLTAGE_CHANNEL(0),
> +};
> +
>  static const struct iio_chan_spec adc122s021_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(0),
>  	ADC128_VOLTAGE_CHANNEL(1),
> @@ -143,6 +148,10 @@ static const struct adc128_configuration adc128_config[] = {
>  		.refname = "vdd",
>  		.other_regulators = &bd79104_regulators,
>  		.num_other_regulators = 1,
> +	}, {
> +		.channels = adc121s021_channels,
> +		.num_channels = ARRAY_SIZE(adc121s021_channels),
> +		.refname = "vref",
>  	},


Let's try to keep these sorted rather than having rohm in the middle
of ti chips.

Same applies to the rest of the changes in this patch as well (other
than adc121s021_channels[] which look to be in a logical order already).


>  };
>  
> @@ -207,7 +216,10 @@ static const struct of_device_id adc128_of_match[] = {
>  	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
>  	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
>  	{ .compatible = "rohm,bd79104", .data = &adc128_config[3] },
> -	{ }
> +	{ .compatible = "ti,adc121s021", .data = &adc128_config[4] },
> +	{ .compatible = "ti,adc121s051", .data = &adc128_config[4] },
> +	{ .compatible = "ti,adc121s101", .data = &adc128_config[4] },

We'll need another patch to add these compatible strings to
Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml

> +	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
>  
> @@ -220,6 +232,9 @@ static const struct spi_device_id adc128_id[] = {
>  	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
>  	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
>  	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
> +	{ "adc121s021", (kernel_ulong_t)&adc128_config[4] },
> +	{ "adc121s051", (kernel_ulong_t)&adc128_config[4] },
> +	{ "adc121s101", (kernel_ulong_t)&adc128_config[4] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);


