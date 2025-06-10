Return-Path: <linux-iio+bounces-20348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D50FAD36AE
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBD0189AFE0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3F29AAFE;
	Tue, 10 Jun 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1B5RyP8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C829A9D8
	for <linux-iio@vger.kernel.org>; Tue, 10 Jun 2025 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558828; cv=none; b=fD3/CB1dewMk9LrA1wz4lXO76XtVHvGNwUHhyrf76xRmhcDYXOalZ9PqAuoP/uhr8qknOCE0eK/kks/9d75DWtVL0ApSUTolsQacmhw0F0BKhgg5oAHDE2wuPHcib6ySLq88B8eVSUjg9QkSPsDnfCKg1ELXFIC442uEtfJ7KTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558828; c=relaxed/simple;
	bh=khzqFhuuJvV1VhNta3z1is3dc8F8nVkUGfuPadr2COI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGQeo2CIXGhJI6wFYkjt6bjb6K5XTfUiqbO+RObi+s+bLLW5Yzydr7mNtGwYv1iml8r3kDgJ3182R7M7TCW1X+f1EQTkdcXvIOYcCzotwtTFlJrKEFM0ty4w0uedpqrJ6ocrLwmX21m3KsZpsh4D0hvOIEzhpYkH0kP3LuoVa4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1B5RyP8; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ade3723adso41888881fa.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Jun 2025 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749558824; x=1750163624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EanlmV0cW1dyyqCiFlmm6H2lcoAcchpMNaepjtxFpoc=;
        b=J1B5RyP8UxewZj41wWY/OomhqBRNLWuCoUKfm+LWdDeqlECFWixreM9SY+pPrf+cUM
         fhFPLHZZGGDXmWb2Gt0a+pq7SOkPTu0Njf+PUg1LpBSO7Q01Gg6fMOTY2S1d8TEMMERd
         yh4yMhNBOesIkkuQHra2Nd7/xAnIucSkaFfBo/wigZqzkvI7azUMnXMjKJiIh1l8xmt4
         pBhTUdVNx2uWzWSMDRZNAxipd7Czi+bGYQanfyAH1aPi+KAGPqSPZksffrEa4r4KaZBI
         D5+ApKnbaaNawvfG7KiAGNGOeQTYC3wWIyE3OuaD0sS0vmiB/A2BdrfD0I+TI6rnSD/7
         SdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558824; x=1750163624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EanlmV0cW1dyyqCiFlmm6H2lcoAcchpMNaepjtxFpoc=;
        b=dmKIZo1SK76GvAWSd/rQ1ZNd14HnuCRiM9ysqUz+++Z7MwByLMOYE5HNuCkQOw3Rlp
         +05M81SfV9RQ3PgFr9fTb1WkUTQtErTPMNKB8gfyEKFHaKhP+3FaMVDN0iGTOgR64tID
         rzSzin9+mKmHI2X4d/oH6B766kjUwNsVmCQ5l3jxJMTJdtXZxx3cEt+c7uZWKgTj+vNm
         2sx34FJ2ZfyE20Wb8El1UUMXpGJb12w+QZuuHvcoCPLJnJ3Wv72B1dpK35MCPwyN9w3B
         ZGWDZqR5mQNZdo3TXpNZeF5kx5jwEKfgFfhfa89TzMIrzw11oXkeDjh7a6O0IFXMFlWT
         8wKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaFylz0ZiSQA/U/R72bsbJiwb0dRKk28DB9NFrByrcTga8egcY9RQsDRLwDO1Kj8smjYbbPeVfoiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAf1En8A/b7F0H8prNscAIXjwfmZSkb5uIBNAU26oXiYv9wYK
	iQxlPBEnLzRIPpjTHFuKdnM1HvcOgVbpWqWRISiLaNrqOxdHg5BcM6v/GM7cMY/2lcSYpbtthbR
	EfK3hLHEmewZrzIKl+ngbisZZxivp54hel4/xJesEDA==
X-Gm-Gg: ASbGncvrxs2D6F0zbqQCaCpCw41z8rFfoCdL6gZ2l3bXeGR4ZDaSvYUq9JFm9CVhPUl
	0H3GYvAlHu3LO/BRPZYx4bEYNH3h6vWi1tm0Po7xQE+SY59TkvCuESbrwfHL+eMiC3kBpGABxR+
	gnd3MTxXH7hj4SgixFCb3fqOoTns92QM+lWWibiSkVgZ4=
X-Google-Smtp-Source: AGHT+IHH43p0qPfKtj3D38L9rrb9Pek2M3XXCtDSV7pxtgiYmdZWmLIORASeL7bRJw33PL8fU9QHGGRgHJcEcY5qb6k=
X-Received: by 2002:a05:651c:220a:b0:32a:8591:668f with SMTP id
 38308e7fff4ca-32adfdd88abmr40233771fa.31.1749558824159; Tue, 10 Jun 2025
 05:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com> <20250602-rk3576-pwm-v2-1-a6434b0ce60c@collabora.com>
In-Reply-To: <20250602-rk3576-pwm-v2-1-a6434b0ce60c@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Jun 2025 14:33:32 +0200
X-Gm-Features: AX0GCFuG7EFwJI0ElFjD6xqtEGmZqjqUSDaqvLfaNuSuiPY4NuX3iwrF0xr505A
Message-ID: <CACRpkdZKTo8rOUBDqqS6e5FPHnX83U4PfYQ6vsRxDVGEVNzJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pinctrl: rockchip: increase max
 amount of device functions
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, kernel@collabora.com, 
	Jonas Karlman <jonas@kwiboo.se>, Detlev Casanova <detlev.casanova@collabora.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 6:20=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:

> With the introduction of the RK3576, the maximum device function ID used
> increased to 14, as anyone can easily verify for themselves with:
>
>   rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
>   -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq
>
> Unfortunately, this wasn't caught by dt-validate as those pins are
> omit-if-no-ref and we had no reference to them in any tree so far.
>
> Once again kick the can down the road by increasing the limit to 14.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

This  patch 1/7 applied to the pinctrl git tree for v6.17!

Yours,
Linus Walleij

