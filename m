Return-Path: <linux-iio+bounces-22067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6810BB131BD
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 22:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A004516491B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565E230BFD;
	Sun, 27 Jul 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTiJubrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDA22FF35;
	Sun, 27 Jul 2025 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648060; cv=none; b=nkNV/vcposjGu8JHBMh0oMcrotwD5JtOPDgxdAA0BM2o3I4ssy03z0cZBjWkuSwqAlX0C5Qc5haPOhQM9HMZFHdtC3PWKd2GTB7gR3+TVmq8rdJ2ZS6JyjOHldy5zJWSumPoOYOoHVce3RCRUrS0zKZEx7lFs2PfxXViKzWwbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648060; c=relaxed/simple;
	bh=g1P1yFObg4U9ZW04eI4Xh89eKDpgOVFGbj/DQtG5dqE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PEFvqcqDqN7OOsKMitiAkvwl6Tw1pKhYCeOGlZnWy6z5AlnKjMpztxxEBtQaDOKQBxVM/ngkKhrVvxI4SUR6ij7+kBBxSZs2FZmOkGIfQVx5YVjCKjfw8Abq57qa5+EJRlx2ZYCdVm/CuOQLNXZSimYoKnmQcu7BFdmz0cayqL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTiJubrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C6C4CEEB;
	Sun, 27 Jul 2025 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753648060;
	bh=g1P1yFObg4U9ZW04eI4Xh89eKDpgOVFGbj/DQtG5dqE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mTiJubrNsMntDPFY0xWRDR/l59lwilPZorgrp0bu2XJPInBIyfhHzqK17ORYWhMME
	 ClL5IBFv6tKooUff0U0fUHKd7ED9n0YZCYm5WEbSXRSDTsnPe0ZX+jWFlcjkomSKZk
	 0C5wQswGc7XinCD6ZBdQ06wjkEZtvubCAvAq20uowpfty0LTqHXsfdh+8p9ZsTmN+X
	 8PhFflLUM4k8n5ZfEJE/dZddHyRFQ0iFnfu8e8w1pyYbg5BNbhpDSubgLjkmdBHZZa
	 1Jq8wXDXquR/R4XUhLJNXlk6RO7o9VU6lgBUOvdxa50XsK4PI6Uz+d0uWf+TirVR53
	 AALp02OSZCBng==
Date: Sun, 27 Jul 2025 15:27:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org
To: Dixit Parmar <dixitparmar19@gmail.com>
In-Reply-To: <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com>
Message-Id: <175364805544.3130.15364114273761890479.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor


On Sat, 26 Jul 2025 15:07:02 +0530, Dixit Parmar wrote:
> Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> controlled by I2C interface. Main applications includes joysticks, control
> elements (white goods, multifunction knops), or electric meters (anti
> tampering).
> 
> The device can be configured in to different operating modes by optional
> device-tree "mode" property. Also, the temperature sensing part requires
> raw offset captured at 25°C and that can be specified by "temp-offset"
> optional device-tree property.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  .../iio/magnetometer/infineon,tlv493d.yaml         | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "infineon,tlv493d-a1b6" found in schemas matching "$id":
	http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d.yaml#
	http://devicetree.org/schemas/trivial-devices.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml: 'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250726-tlv493d-sensor-v6_16-rc5-v1-2-deac027e6f32@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


