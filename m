Return-Path: <linux-iio+bounces-21763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E58B09C49
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 09:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FB57B4E63
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC5218AC4;
	Fri, 18 Jul 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoGgGC3Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A6D517;
	Fri, 18 Jul 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823317; cv=none; b=QRkSGLd47zjOlKXTg+RhbCiJ31iL9L5SBRHTND7P9fQFomxJdPBD8eZqRQ0f4gxlu10Y1jPmsTI/XzjpbpMQU/IkoCyrJY4h7OkvWpdhnLqv6V3y9ztsbzxLgvYe3xhLk4IkB/Y0KtMUqbIuYlovgFz95rqic0hkpqtFwJDpRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823317; c=relaxed/simple;
	bh=RAtTqDOWL/XAjaNBY/+86h+M/+JsdXfM7kai5mMTbnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLd2EQwFV5c3C1Al3RrHMPV/dFH2E3i4/WgFQhDe640nAsFtwXFpH3hjh+Y9f16zUrRTSpy7CfZ5HwypWCTbqLTTL4oMtLhyd9mHs+6gS3nAX/e1krFtRUpVp/KmUTO8Nj7onVWNDJwpT/Unvtsu6r2hfa2Ez0Q1gS1EDhJCHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoGgGC3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8E1C4CEED;
	Fri, 18 Jul 2025 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752823316;
	bh=RAtTqDOWL/XAjaNBY/+86h+M/+JsdXfM7kai5mMTbnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoGgGC3QVW4LBVOALUcdkPhsEN+qlgqbHSHFBo8xHwn/RVwmCjos2IVkA3sClQ9WO
	 /QVuHkyjYGBTGE8WEityyVJmEztQhf1xq7CFF4QKQ9Iz+omXlMuFbr0t6gUYFttV+E
	 cE9ZsEcmGm01lju7TLkRUo5wFOHkNVaoqPsQ8m2Qthm2p2010N4/lZbFe4guUunW5R
	 3ykf1n96b1WaxzM5RlrHTFTTjhbCkkcs8l4xgaRTpOzZlswz02IlTYXcdTf136rj6C
	 WvWl1t41u9SwIBPlrAG+7zntw4X9x/Cd8qlOV6LTjb7wH/DJOVrd9j4TispkG0uEpo
	 C6gEHKOyjuFVg==
Date: Fri, 18 Jul 2025 09:21:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: iio: imu: Add inv_icm45600
Message-ID: <20250718-industrious-hysterical-axolotl-b0ef7a@kuoka>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
 <20250717-add_newport_driver-v3-1-c6099e02c562@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250717-add_newport_driver-v3-1-c6099e02c562@tdk.com>

On Thu, Jul 17, 2025 at 01:25:53PM +0000, Remi Buisson wrote:
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +    description: Choose chip interrupt pin to be used as interrupt input.

I don't see any improvements (nor explanations in the changelog)

Best regards,
Krzysztof


