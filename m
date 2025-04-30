Return-Path: <linux-iio+bounces-18914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567EAA540A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 20:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E8416E074
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E424A047;
	Wed, 30 Apr 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DXDdvIMN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0351E5B9C
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038808; cv=none; b=LIrm0ewNWII1G9MMyV/dP9bqgWw6qWy7QFuTgC79a9cS7c06QWwNs/0A+adEhM3vTHbZjdVoqAtnGN8hbZ9v/5vnOCaLKeWtARjnE5OLzq8DmttPNPAHJ+NMt39ksZyCGo3p6+bfwIn9rv9Kl3wwHnW6hef7c0Be+zERv2+KJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038808; c=relaxed/simple;
	bh=Tjt7SVaTlOlpBRH6eoevRK63rsFx7sHHtqzp+HITOvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUf1m1IhpWTfli2hLU5xrKJbSDsqVJcdkPv1DtBaJxs7Nhe052OH+XLxf9bHHtH6YrGPSq3+DIYCDIUGPpQJU34pwZ0llgFZYiYbENoxAu7LrODZPmtgr3mOubq/Ec/so5aTYmOSeqbRFdRYz7SmPlYWd+X+xhyAxg+julnsOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DXDdvIMN; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c77a5747e0so126583fac.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746038805; x=1746643605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXxYKFdvPhnv+i2OQnjVQIRhugvl2GuR0kkHgiv5OW4=;
        b=DXDdvIMNL7KSK9YwgOALkU4pQzb+iWP+LL7DW5mTrJiAVJw0EM6HDgSpmxrl0hxXiU
         NMCy65C6W2EdqMHXGB1PIX+INDdzfTUSKxKWrUz9oaq19SN3caF94BIg3a9r3FepBeVd
         tv+VEuTdsqERsnnPrX4RSKmykOSEx8BcI8wnL1gPEImTvmzK/sF/fFR8RBD1HiUupgDF
         vl/8XDBVESobOrNd9sm8X1zeAJU6ijgUVHud0qgd4uGdxoULauxE2t5d98p6erIq0rhu
         DceZg3xT23Sv39lidSNM4UrkJzheUpqX9yk6udhN1HDKqDA8lDw5RK17b5WyQuAMsjg+
         SDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746038805; x=1746643605;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXxYKFdvPhnv+i2OQnjVQIRhugvl2GuR0kkHgiv5OW4=;
        b=Lp1sbew2LNF2NV/+AFjou/obFeUn85axeXi3zvNeKGKlUqRZPtDKtVYkhwuNc2Mw0j
         Cwxz4dUI8u0zzvyDb7nGRAlBRjzUai2g8cxjMzfcPH6SJEot13vkjOQXk1xfGNNw1rcE
         +81fIq2a8+PQX1XzIw+61xiihk70nMfpDuwmzggJ2+yNXSa3NF24AgCWquBbMNo136fR
         BqEy0Ie1IlK3KfrQoSCweOr+iAumBxwiyib3RaCzSNFOnzDQzcc7VIT8mh7hwqTpLrUH
         Kt04PMh8BhvFG48nBHid0TB9qqtCsfnoSgjKOeTbwtpIuXQZqmuNWAGHnZ5ZkrIErdQ8
         85ow==
X-Forwarded-Encrypted: i=1; AJvYcCU6Cu6+8C3rGSLHsafBUpOpoBeTSmuwFMidsN68vNQ6M22QgHY9K+fw57GMOmCF0fTJXQoRq3Zj250=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcN9BwdFP1b1mvHhAHl7wfmdVS7rDOHkl7TrRh5R5lC3zHnduE
	LkQ6cjNIyjNBksQSQbb9ngLg13cbK6VuPAD0+674FfEn8z7Mh7KmRcpE13aFjuvYg4vgrdW8Knj
	N
X-Gm-Gg: ASbGncsiAwMNPQirJkXRMe6LUPtESkEAZc5Oj0A1pF9pJ+IXguGjjfYgT+88RkZbxlC
	ehArSxSB01Dxtv+H0vq0SIKRytv9Wp8v5kKwpQmoOzVBiYmm7ZHzBXUUHSAe8pZ/GmJD37Z7bej
	COs0LIcRtY1bCkL/kUmlQ5UzxF9vnIbc+5JNKy8pox5mFNn96JsrmXPQn0zf+TGzUqk9GXOSVRZ
	opZY0JvSS4clFqMcvbFlsTotylFrR4YkT4pU0mRyU0FQU8qfJLqlx5goTA/oxDGjYAhpRlUaszG
	ccY377Vbut4BFshtg5i6erC/ifQ3lGytXX9Yex30Pk5tBTXR2Wh3aKaVIzRSaChcwewdtV/xVp+
	fUcehmMrzJOH2exHa+RjOjHW02g==
X-Google-Smtp-Source: AGHT+IFPQcd2cZ+lppyTbrPKR3yE2CUjnINt9qXLSF2VkkLMNJ220iqVNXLIMGAHI/5Kafk9Ar//nQ==
X-Received: by 2002:a05:6870:8315:b0:2c1:9897:dd24 with SMTP id 586e51a60fabf-2da8c82f967mr227133fac.35.1746038805290;
        Wed, 30 Apr 2025 11:46:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2da6e4f7cccsm577231fac.33.2025.04.30.11.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 11:46:44 -0700 (PDT)
Message-ID: <7d93075f-8426-45f1-8c7d-3c3c904a859a@baylibre.com>
Date: Wed, 30 Apr 2025 13:46:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/25 7:12 PM, Jonathan Santos wrote:
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> Introduce the 'trigger-sources' property to enable SPI-based
> synchronization via SYNC_OUT pin, along with additional optional
> entries for GPIO3 and DRDY pins.
> 
> Also create #trigger-source-cells property to differentiate the trigger
> sources provided by the ADC. To improve readability, create a
> adi,ad7768-1.h header with the macros for the cell values.
> 
> While at it, add description to the interrupts property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---


...

> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 31 ++++++++++++++++++-
>  include/dt-bindings/iio/adc/adi,ad7768-1.h    | 10 ++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h

We should add this new file to the MAINTAINERS entry.

Otherwise:

Reviewed-by: David Lechner <dlechner@baylirbe.com>

