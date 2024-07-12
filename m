Return-Path: <linux-iio+bounces-7528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF7492F97B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 13:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D871C2200A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46D15E5CE;
	Fri, 12 Jul 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMi8z5NY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53167EF09;
	Fri, 12 Jul 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782987; cv=none; b=eq3sX5OYdVb5h29djmOedXYz901a4kObA69tZsnsEHi1s43NfdZ0UvpIftCv9D0iKEQ47v3ljuuOlAxaHhjxN19F1+ntqosdHVfYhCM/ILvxxzgD7mMQa+k5JfSYVZNEK1vkT4EjMYy//uFNrvyCR8TzOAV7bEg8MbypQNlFGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782987; c=relaxed/simple;
	bh=4D3VUr5iKTjELUQa9dMeWOYc70Xny/JwIm71cTE/6J0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDw/JcImbXrKAUiS5gyq1a9QST+8AIt6yW37F7LdmE0J/ytx/mrKpsH76IKUHLZ/QaFlxTEHnKvxXXKlioANa5tt5938zg+3Udj0d6XujqjbyT3bsHW8rzsuyrSUUC9EFyJGSDjYsHv0TVsEcnMgi3vylJK0dENIk6LtH51O6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMi8z5NY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so298000566b.0;
        Fri, 12 Jul 2024 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720782984; x=1721387784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4D3VUr5iKTjELUQa9dMeWOYc70Xny/JwIm71cTE/6J0=;
        b=kMi8z5NYNOzS/V45/sgo3CJRY7Non/jtb/Awx63j/rtDfg+zLikUH8YFq3HwCkOXES
         scEvTMNKkiDJxMN9Vlde9WUCQPjjbyN+u+/8gRg5hGC56cqbHxVwX0sCKNZqyth4LLKd
         sOuZl2o1vWHKm4v5NqFacgH+JXHXvLlNHutJCDDiYRO/zi2QRvNYmS+YvoYDLY2QAbg0
         RINGjOhVMrrJSqjyuKok6H/istJpGXI8L5kFi1kcC5YDgCu+jmUicTS7FkvRzo6Q+eJM
         7lTLs9iuQNrr5UV620iPxvzdSCEVVaM1pHal9k1gw3DMrxVHuxRmmK6QhnGdJES2rLxE
         DF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720782984; x=1721387784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4D3VUr5iKTjELUQa9dMeWOYc70Xny/JwIm71cTE/6J0=;
        b=XTOa145f2h6WDXGyRb9Q5Ck7FWZtxmWqFfsG9x51Fb/FKMrCDkWKIPS3af0nwi8yOt
         uj9RzMoJXyJaDlrrEAsfc1tTiACNi73rXhCjp8I5u+7QEWd8KovNqUwu2gQvlBBcQh/z
         tyq/G0vCFO+1Zmn/TA2CdQCk6p43N+KsVjk2Y1d8GS9CF4nhXUwDJsGHVheyEoF0dGw0
         WMiLDmjelmmznQmCkEelrAS7e2T2Y1LpKQ1bdKYB8JaDWdiIPwxiZJbRGNavGLGA/lAJ
         rHUIeiVq1LRytwFxyolEtBiYHE4ZcxUbPTbgzRttopycctDTGiB1YPooCe5s33iTQ1s1
         /wUg==
X-Forwarded-Encrypted: i=1; AJvYcCWYT6IWHBMaEkYQmxo7JtW8rZqDo9WKranUjnF18EECRhctOnkGq9fzLh9vKTQjI4bfOBY4vEG4t1MbMv2zOENv/TJRh5IHRPebsU8SEjaWKrD3ZyDctK8yVKaUoPEamfdAtbEI8qmwOQbA/y4aF+e7YZZu7+9X8FjuTWrvnQ6een1JOruT/Ak2EtNY7ep79xxH8Y4D2CZTc/6oPjp7ZQ==
X-Gm-Message-State: AOJu0Ywz6/apMKhIFVuTkgGEw34HMaJpgpayap+Jy0m/vLaX8yC0Z5/n
	nUSRTlIEYV1s8dw5q0DpF3L969SHLZ8WHxlVIil5US1WqXok0OeR
X-Google-Smtp-Source: AGHT+IHov9UcHLOTIUHHGjZ0+vLxZW+uxcYU1PpSvmr1evSQk0koh0mjZsRSVODNh/gz2dC2iD+rdg==
X-Received: by 2002:a17:906:a047:b0:a77:d4e1:f66e with SMTP id a640c23a62f3a-a799d38065amr170747966b.20.1720782983892;
        Fri, 12 Jul 2024 04:16:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff0a5sm334600766b.117.2024.07.12.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:16:23 -0700 (PDT)
Message-ID: <4423e91156fa708edd2bde728ce861132bda3d6d.camel@gmail.com>
Subject: Re: [PATCH v4 2/3] iio: adc: ad4695: Add driver for AD4695 and
 similar ADCs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ramona Gradinariu
	 <ramona.gradinariu@analog.com>
Date: Fri, 12 Jul 2024 13:20:18 +0200
In-Reply-To: <20240711-iio-adc-ad4695-v4-2-c31621113b57@baylibre.com>
References: <20240711-iio-adc-ad4695-v4-0-c31621113b57@baylibre.com>
	 <20240711-iio-adc-ad4695-v4-2-c31621113b57@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 14:15 -0500, David Lechner wrote:
> This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
> The initial driver supports initializing the chip including configuring
> all possible LDO and reference voltage sources as well as any possible
> voltage input channel wiring configuration.
>=20
> Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
> is supported at this time. And reading sample data from the ADC can only
> be done in direct mode for now.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

- Nuno S=C3=A1



