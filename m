Return-Path: <linux-iio+bounces-14633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE46A1DA9D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C80163D66
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8171662E7;
	Mon, 27 Jan 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK7ujKOW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44759152E12;
	Mon, 27 Jan 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995456; cv=none; b=kE93E9/BHpxyTueAQS4sjW9QjeYbBpUpXaOItCbI5q0T9ZbwxNkS0pK4+QmJxOIVQ03Jz1vbOzxc32HrEhyWZ8fRRPuPFIAwwjUuhyQZpLchhrJBE5JpCCbhZZ5SZ7ih3NQbjwawKqQGyv7fmk6TY99b2P8jFBVeDX99w8iYbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995456; c=relaxed/simple;
	bh=kZkhqARoVsyBjHtBGuGv/ZqCUXvG5xn8aRSC5rD1YQs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jnkkyyQ1v2Fxhf2L1ANcHGph0sCLtthI5UvxxHnvtSCN61vgONx2LJaT+cRdBAd3QyK5Wy4guMH+dE3VO9HSvaFfditGQbJfbAyGqo60gnf5lkyDEEvBhSyEL2+Uo5fRt5pk+5eADYC6cjfcxSpt6FyN/QvsLl3X93sEdcTFrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK7ujKOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3693C4CED2;
	Mon, 27 Jan 2025 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737995455;
	bh=kZkhqARoVsyBjHtBGuGv/ZqCUXvG5xn8aRSC5rD1YQs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EK7ujKOWtOGA6IyAp5QvLiO83VBMA3TITeirCTMyM4o/2veoEIddAqXBX/hZrEHFs
	 kpCs0pj65pyPOGW1dPRXXwe6as7Tl4ULRDAdbTTvPLrmcbNTFbbsRUODuu39a2wPLa
	 JLaymhIAh5QJtkx61MAsf9DtMzwlPBdGYgBnd5wMifPtXUnz/93KEJAe5igjPALj3v
	 +9/RlLlNVAJIkwLf3zS9vdG5DXCsmKqc+CD3cXhRDJjCoi5w3NwKUZrRYp/V8zBv6u
	 yN/pTs5O65IHln4ZYRtIa9eNN3KWMGsa0qMMRy9Gqykt866I7nRCwwUaGpVmsIMC1G
	 o71R33VjdQ7bQ==
Date: Mon, 27 Jan 2025 10:30:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org, jonath4nns@gmail.com, 
 marcelo.schmitt1@gmail.com, jic23@kernel.org, devicetree@vger.kernel.org, 
 krzk+dt@kernel.org, marcelo.schmitt@analog.com, lars@metafoo.de, 
 linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
To: Jonathan Santos <Jonathan.Santos@analog.com>
In-Reply-To: <dc866cb508917828f83242f3438dd1d6ac9d874c.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <dc866cb508917828f83242f3438dd1d6ac9d874c.1737985435.git.Jonathan.Santos@analog.com>
Message-Id: <173799545212.405624.17676890028479160269.robh@kernel.org>
Subject: Re: [PATCH v2 03/16] dt-bindings: iio: adc: ad7768-1: Document
 GPIO controller


On Mon, 27 Jan 2025 12:11:44 -0300, Jonathan Santos wrote:
> The AD7768-1 ADC exports four bidirectional GPIOs accessible
> via register map.
> 
> Document GPIO properties necessary to enable GPIO controller for this
> device.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * New patch in v2.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml:92:6: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/dc866cb508917828f83242f3438dd1d6ac9d874c.1737985435.git.Jonathan.Santos@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


