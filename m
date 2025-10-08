Return-Path: <linux-iio+bounces-24848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA5BC5085
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF6FC4F2E2E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BE1261B70;
	Wed,  8 Oct 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWPnkPHQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52542255F24;
	Wed,  8 Oct 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928152; cv=none; b=GX7jj3gWKmZxL1kEtdiRorLgIKlYBTkGPv7AhVdm/fYYwcksVBVIoSWDHPsWBJC6S5q++kSo3wrWsRZFqPpamaU9nGykOoUcH4sO5KEDG6WkUM0pEnKBORZ+CriLYKWqUEdRmrFK2Vhtpzz/YvwE4CKGerytcRGYTzpQSB543GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928152; c=relaxed/simple;
	bh=DMgCM8Rc0kLgkamSZaom9HUWXV9UAxoJPBdKB7RHH7c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=h5XIhIkP5gW/NQHoVbchlScy4HjP3JqE6yxkaHRommw5vbAnWL38H1l769/OtJtR+CmqjPRL0vnELknhYpo7jzXTTcUHpAjjvy4yC0QQFCWFXdxsdjk5NZIz4vxwK5ydmBkTRfRu2+d1K8nvU3Vy95mqs3bFgKMv1se+bvw9Fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWPnkPHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C8AC4CEF4;
	Wed,  8 Oct 2025 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759928151;
	bh=DMgCM8Rc0kLgkamSZaom9HUWXV9UAxoJPBdKB7RHH7c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rWPnkPHQV206SdcqMZFz1M4eR5sCKi1C97lbi02WtRxGi2zU2PPvFUlvZMY8slS7x
	 3Sg3ut8GsOZ/txVaCUngXdp63QDJscf/aZ39cJBkTunbowzP+uvuzdJZJGJGMmGm50
	 M7yvSBaKoHvEVdUhu3LRMO6EtWJda4dC2kKzwoOYqxZLhgAGEQiwlkOxE/erwyqYmc
	 v/w7hBWTWqKaA4NIXILd0QGnSN0YR5jofh0bgvXRyi216iA+0rMYlcP1XJT3Nb8ekc
	 qH0YylMsUNW3Nbz4pDvcfvYpxkqlUu6qWQ4YUzhH0K1sEK19aLrJrwd9slB2pR8z4H
	 gbEC/yuzme5RA==
Date: Wed, 08 Oct 2025 07:55:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nuno.sa@analog.com, dlechner@baylibre.com, linux-kernel@vger.kernel.org, 
 andy@kernel.org, linux-iio@vger.kernel.org, matt@ranostay.sg, 
 linux-kernel-mentees@lists.linux.dev, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, skhan@linuxfoundation.org, jic23@kernel.org, 
 conor+dt@kernel.org, david.hunter.linux@gmail.com
To: Shrikant Raskar <raskar.shree97@gmail.com>
In-Reply-To: <20251008031737.7321-2-raskar.shree97@gmail.com>
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com>
Message-Id: <175992812188.3371104.5716471946724146308.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width
 property


On Wed, 08 Oct 2025 08:47:36 +0530, Shrikant Raskar wrote:
> The appropriate LED pulse width for the MAX30100 depends on
> board-specific optical and mechanical design (lens, enclosure,
> LED-to-sensor distance) and the trade-off between measurement
> resolution and power consumption. Encoding it in Device Tree
> documents these platform choices and ensures consistent behavior.
> 
> Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> Changes since v1:
> Add unit suffix.
> Drop redundant description.
> 
> Link to v1:
> https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.com/
> ---
>  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml: properties:maxim,pulse-width-us: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml: properties:maxim,pulse-width-us: 'anyOf' conditional failed, one must be fixed:
	'enum' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('enum' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251008031737.7321-2-raskar.shree97@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


