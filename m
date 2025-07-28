Return-Path: <linux-iio+bounces-22081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A6B13414
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 07:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1978D18874AC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CE3219A79;
	Mon, 28 Jul 2025 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAU4jnuM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D32E3708;
	Mon, 28 Jul 2025 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679944; cv=none; b=CqGTz+LZGbKk1vo03vlpqTD9ucOWkSQ1V8jpjmtGlVKt6z8hF1fsy6AGxLKYm6QsNkkI51HL/DRXeCWAqW80+OxT+FwwAlCU5rqjwQia2DTZBghbj0XFqgesDpyKW3LWusG9FNmsB/eON+26LYlFElKs5hVganTgHOEPJC2pwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679944; c=relaxed/simple;
	bh=KWCLB5ShRmghHY/hmUPXAF5gevknUvBoBlaPpRZjE0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5OIcq1NCUsJpLcSbQZ6CBPgLCKYXLAA2ZB7/GZhPHY++TPqxn7oauTpiVELI1CtprmXr9HwZtz0ukoMi/RuO7rRdPtYorpuAPUG9J6CLUznm54G1lOW9dsCgAVO2joYc3cDnD6AiVRoxL/trsKn7BrSwwHc8Jtx+7lKGFBV6Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAU4jnuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E1CC4CEE7;
	Mon, 28 Jul 2025 05:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753679944;
	bh=KWCLB5ShRmghHY/hmUPXAF5gevknUvBoBlaPpRZjE0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAU4jnuM4K0Rwfnuj5eJdGSReVV/ySCD2tYpTjIEbPekH0wx9p3b/jMnmAbDoq2AA
	 aj9g0zeLtEZfpNDKLmdpq+ZvIwhBphbsYvyvlQoUgghlYznZXIMzepuIgi+inMuatP
	 EWv0rB0gEuWoGVrZZ/6bbHt8yrbLyAjuxENPF/zD1XjnAN3oCrRco/N+2+79hD7msP
	 9Cr458EittBZ5jjrCBOaZe1rxQCT7lFMMPuTp2c8RRit2iJhoLvi6JxHMmwRd3xC71
	 dRJ9HxoW9DunWmuqmKLYaaEtdp2p33ePxMFUzFCx6km0UgAjckviqVavBxV2mDwjzW
	 i6PUJebl2r3oA==
Date: Mon, 28 Jul 2025 07:19:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
	jean-baptiste.maneyrol@tdk.com, robh@kernel.org, ~lkcamp/patches@lists.sr.ht, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: pressure: add invensense,icp10100
Message-ID: <20250728-outrageous-snobbish-hoatzin-ebdc03@kuoka>
References: <20250728004039.8634-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250728004039.8634-1-rodrigo.gobbi.7@gmail.com>

On Sun, Jul 27, 2025 at 09:32:02PM -0300, Rodrigo Gobbi wrote:
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - invensense,icp10101
> +          - invensense,icp10110
> +          - invensense,icp10111
> +      - const: invensense,icp10100

This does not allow using invensense,icp10100 alone. Try it yourself on
DTS - you will see warnings.

You need oneOf, just takek a peak at some random bindings.

Best regards,
Krzysztof


