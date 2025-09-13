Return-Path: <linux-iio+bounces-24054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C85B56142
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73BE483D98
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B532EFD8E;
	Sat, 13 Sep 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+2VFjXs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F72EA468;
	Sat, 13 Sep 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771288; cv=none; b=afHJJSuDbLS5Ful+00MGz6IN8rU1e5X/CHCroQVgJZ9VCRuxT4GduYvxgGNYV9a1HbahAQ4zc7zO3oSnMQnAWwkzgyJaiMYn5sK13Txfd1q+ZNzmZ3kMgN22FCHembyYLYNjSP/8eh5wv3IrHfvjA98NIVXU7vyt16J50LqAsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771288; c=relaxed/simple;
	bh=kAb/6Q3HAUctmHWVedyL+l7FRRMhD0STnVCd1l+573o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBeS5jbGOtLzOjH4AdLQalSvytfxNh63LoVjCL6c/MGRU4xGwky7wnlQKNXgo5TEK7OlYDwme3Z6OHkWRibRnwsPieBpPdKUAEMyhV8oQb3/t/2OrxYefnKlb/guOzytIEwZ0HcCOADAvEfaZ5e9drJ975WDBDcIxUEWYE1wQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+2VFjXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C87C4CEEB;
	Sat, 13 Sep 2025 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757771288;
	bh=kAb/6Q3HAUctmHWVedyL+l7FRRMhD0STnVCd1l+573o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j+2VFjXsDTIF3DKC4SqTxcxbvMJIFJITs9ZvWPmOcZrkY30AFypLg53BaVBso8k/j
	 QkvN2VEo0UuU0OdszGVr/KNAwQMopvKHshdLhHMMD3mgJrK/qfeAeqsLllOzsC45Gv
	 IDwHjK4i2EiKonx9qJQT9NWtde41aHl4gMM0eMhqBbyNzxeUfufSJVVBTwhqf1htyJ
	 9VjhYCfH6/uBm6UiCpNbJFU5fs4tBQ8oQJXGmJanXOOySjps8HxkLPo1wRvhWJnLvg
	 Yqned5wlFc3WT2gKdyfQsNvyyyt332Lj5K7czTcDEbgdXJ8jrClg98tjWorEyVH6RE
	 ygLZNFVPs3O7w==
Date: Sat, 13 Sep 2025 14:47:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Karel Balej
 <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/3] Marvell 88PM886 PMIC GPADC driver
Message-ID: <20250913144757.4c8cf0b5@jic23-huawei>
In-Reply-To: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
References: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 14:43:43 +0200
Duje Mihanovi=C4=87 <dujemihanovic32@gmail.com> wrote:

> This series adds a driver for the GPADC found on the Marvell 88PM886
> PMIC. The GPADC monitors various system voltages and is a prerequisite
> for battery monitoring on boards using the PMIC.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
Applied patches 1 and 2. I'm assuming the mfd cell will
patch (3) will go through MFD.

Thanks,

Jonathan

> ---
> Changes in v4:
> - More refactoring
> - Update trailers
> - Rebase on v6.17-rc5
> - Link to v3: https://lore.kernel.org/r/20250905-88pm886-gpadc-v3-0-4601a=
d9ccb51@dujemihanovic.xyz
>=20
> Changes in v3:
> - Refactor driver according to comments
> - Update trailers
> - Rebase on v6.17-rc4
> - Link to v2: https://lore.kernel.org/r/20250831-88pm886-gpadc-v2-0-759c1=
e14d95f@dujemihanovic.xyz
>=20
> Changes in v2:
> - Refactor driver according to comments
> - Add binding patch
> - Link to v1: https://lore.kernel.org/r/20250829-88pm886-gpadc-v1-0-f6026=
2266fea@dujemihanovic.xyz
>=20
> ---
> Duje Mihanovi=C4=87 (3):
>       dt-bindings: mfd: 88pm886: Add #io-channel-cells
>       iio: adc: Add driver for Marvell 88PM886 PMIC ADC
>       mfd: 88pm886: Add GPADC cell
>=20
>  .../bindings/mfd/marvell,88pm886-a1.yaml           |   4 +
>  MAINTAINERS                                        |   5 +
>  drivers/iio/adc/88pm886-gpadc.c                    | 393 +++++++++++++++=
++++++
>  drivers/iio/adc/Kconfig                            |  13 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/mfd/88pm886.c                              |   1 +
>  include/linux/mfd/88pm886.h                        |  58 +++
>  7 files changed, 475 insertions(+)
> ---
> base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
> change-id: 20250827-88pm886-gpadc-81e2ca1d52ce
>=20
> Best regards,


