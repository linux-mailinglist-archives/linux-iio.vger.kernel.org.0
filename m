Return-Path: <linux-iio+bounces-9208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7750B96DF9C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 18:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365462860E8
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7543E1A00FA;
	Thu,  5 Sep 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2t4da4P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCF3C099;
	Thu,  5 Sep 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553688; cv=none; b=lvE5jP/ydLrG8refxibtPa5XQLkDNHtK+tIKt/Y788EPEShoxqhnlitYQbjGFo39icl3R58kdcFT8YtxOplFmCQRUK/FaA21EOXhEjK7iW7VIgo9m7FhnC8HvpG1csaIMl+mYl8WyWptKub6YQ6W5jAJko3adx2QaoeBPgST9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553688; c=relaxed/simple;
	bh=qfpyt05VBBFtRpwCjxp29rfQKijUZcZ5AfDCicpVIVw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PpNA//h0jvvndyoo4KwryJSiYoL1K6KViJehZAEsdcS6Eh9RCq+ubyiZjgsOJoSyDpYFqS3GjATf32PHqDrZ5Fbqs+e3MvxiwDhUrkboZl0uHKTKX8v0xP8C9WQHH/US6Xt7ctRpmkueSdJ2Gf9L8pZBvxaUUMxkgXtnbRUGsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2t4da4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB152C4CEC3;
	Thu,  5 Sep 2024 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553687;
	bh=qfpyt05VBBFtRpwCjxp29rfQKijUZcZ5AfDCicpVIVw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T2t4da4P2DLWx1f/vk6RYiXPdTg/0LUt+szWSRdf+G3M5WyISWqHxkByn5OlUYee+
	 mj5Fik14JDkC72RXPxMkj5210VQfOHozI5pHRvAgpMhZypRpckOaPZLHql9xzSBrlR
	 vWHTOap6rc9Nz/BkI+liZeaK91vZ1TftDxYaywkqKXW0qtsqJ1burs/MidgB8TK3Q+
	 QbKUkvLUPtEnpBrtZkaGgYZ8RE93FA9ThubovRmmpTZVu70oW+j2v5fI5CdVhbpSjH
	 numTW+5S/bG9M4XTpew5FDfnI8qiFHcmUKX0OnCgMaXegmK/4kJwDkmBgkrB24mzqN
	 zNlwc2uGnsoaA==
Date: Thu, 05 Sep 2024 11:28:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, devicetree@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
Message-Id: <172555368556.2000291.1962340187875764544.robh@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property


On Thu, 05 Sep 2024 17:17:31 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> There is a version AXI DAC IP block (for FPGAs) that provides
> a physical bus for AD3552R and similar chips. This can be used
> instead of a typical SPI controller to be able to use the chip
> in ways that typical SPI controllers are not capable of.
> 
> The binding is modified so that either the device is a SPI
> peripheral or it uses an io-backend.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dtb: /example-1/axi_dac@44a70000: failed to match any schema with compatible: ['adi,axi-dac-ad3552r']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


