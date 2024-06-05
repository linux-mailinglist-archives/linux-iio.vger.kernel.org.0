Return-Path: <linux-iio+bounces-5816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAFC8FC795
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF631F2432C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D4718FDD7;
	Wed,  5 Jun 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq+W9KoI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4618FC6B;
	Wed,  5 Jun 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579285; cv=none; b=FPGHCIgX3ZjV3Arv3+eR1YxZ3OlS7voqIj3fhQUPylGWjb3s3nRTqA9uGha9rBDZKX5ZoFDOsCuGceq4EB+ofr9OOsTrqzb/Ru4igeV7+mHHA7Ruv1thInLGFVr47w7KFcrGW3aMZq7w+97cz6C+WzOUpnCz/vJE65ekD+PQrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579285; c=relaxed/simple;
	bh=YC1B3wPrxH44Qv3/FzjZDKdMsMYzzw947ljVqmDXmGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6eqFCI2IU2xzXC22f0Snwv0kRY2nbqFwh7INU9R4PatxRvfIpcd9pUmo9B6pK5JOPBFheDidxceh82XS0CmvGDrz03bqWkoNISHf6rBlSdkqPMWjuL2s7Oeq5H8REFhIMadduSf8LCWsMVQGikvTJee/d4mpt9Bi1qYVGDtiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq+W9KoI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68f1017170so215777066b.0;
        Wed, 05 Jun 2024 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579282; x=1718184082; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YC1B3wPrxH44Qv3/FzjZDKdMsMYzzw947ljVqmDXmGE=;
        b=Wq+W9KoIG+xRVQePuiNr4nKN5ubZKwv52J3zAXZKRhQTg6SCipaW9c/IwnTxf/ckdL
         33LgGNCnhbyEoUZE8taIvKydhICbDwbQNtZi1CUUcNGqu47W96eZVj5KLZs54z9UkQuN
         i15GjIBUyXDDb8SL84LJuv9dwYQ7mwAju5+pm/SyvNFo1txPvY86kNF9zkL6J2vqWUmL
         3IjprKe8gxC+lAC4mNKcV9/ZaqMkvKXqXD6NhgUTnt5AefAJU3UMzqX5ZPsAILqKvXjS
         Asg0PBk4HPkD1BqbGxYGEPMQOtjMWEvn3q58wx+FadioFYj6A2zceqtKGy67xyPySdev
         jTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579282; x=1718184082;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YC1B3wPrxH44Qv3/FzjZDKdMsMYzzw947ljVqmDXmGE=;
        b=liS+MhQU78nnS1dt4ksFovoaZHdn1146t92m1J5z2xH/mODUMQ6oWMNCYMMMngN8CU
         rMyUwaZvRog3aWAYiwbUbe658H9fdJq1Ape8YoE2OEuNneYERX4g9KeBQvwdHfIBoBVo
         eAoZJmHwrK073S+CDmyIy4b9AtCDoEzC+WTfYTCg/PVijW2CIxLU17f7Medu5nFzzmfY
         vLF04mzLROCyD11M0nqKF1rA7UcxdevXCzsF1Cszw3HvjTCfIs5iNBNNvtf1rexVO7I9
         1sOV++7FufGsTKhPkWdA62qsDsW69NHlAhbOPgynbUnqYHnrL0K6MRiYntSNvJJ1+4ZI
         gIEw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZ3SKoTmlx33tzpe3zMqsrNHv1pZFHb4ZpwHxzToPemSQgjY63fYpf1qg8nCP61TNiEaTZbfZSRDPlO7wj4tpAC5y6g4WA3jvlo7A0lsyUP+Sh6h/gqRZ1k/N0pTTVRrDtY3aRMIHLk5u0/bVm+ajpLaxHZU+lEk6ekOrp96K3p82dw==
X-Gm-Message-State: AOJu0Yw4WJzMAtzbFvQH9azPwhvp/vPM+lp3F8CBdqoFfUQGC4LIs/0g
	vmj4Ju74ikp9mQrboBEb19kLf7PSVeK0IIaLbOKSzhsTaaxsK+2o
X-Google-Smtp-Source: AGHT+IGjSTBxzg1IcxrQz/2E6TezH4x7x+rmpivUcXztnDUfyYi574dAFjqDOnzL6fgC/zJ37bqzxA==
X-Received: by 2002:a17:906:5f81:b0:a59:a532:ed58 with SMTP id a640c23a62f3a-a699f562146mr116220066b.28.1717579281523;
        Wed, 05 Jun 2024 02:21:21 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm473502066b.129.2024.06.05.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:21:21 -0700 (PDT)
Message-ID: <c4a2344a6530f96ba17a634001d4aee244070978.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 11:25:08 +0200
In-Reply-To: <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 19:43 -0300, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



