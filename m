Return-Path: <linux-iio+bounces-19384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9F1AB15B6
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D98165060
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1173293444;
	Fri,  9 May 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6lfrPqa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF32918D9;
	Fri,  9 May 2025 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798330; cv=none; b=ZezWkiMqS/w08xjEkZltKLV2SUbox5AsFP7d6LCl5WS/vEyVym9i4JAHTseFKSx8efQOIUzkvvoqh3JR65BpOYHO1ssxEbOtwqy/KFLz26pq0w38tIn5y9NR/c6jAOKv8gZX4Uuxm9N/nRS+FW8y8y8Y3IenlRdNyID37ZV0izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798330; c=relaxed/simple;
	bh=yqGvQe/s0yWZ/zaxW6IrpjE03zU+qFB6abQPXDFaf8s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tr5TDusHMD9wzARw8hr0qr+rfginimTh1Ia74+eenqRftel3Kg8+cvFvXnVEoqbtxMv8CP4tNhyD7dGv0/bJDZdEuQ5DIcczgeGY1Ccr0wXAr2Z3uYLdxhw7UvzFYFfeeZ0n2uWlg1dUChFwYhn8puiQ32MmHXRrqLrxkUtbYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6lfrPqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C555C4CEE4;
	Fri,  9 May 2025 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798329;
	bh=yqGvQe/s0yWZ/zaxW6IrpjE03zU+qFB6abQPXDFaf8s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=l6lfrPqaXuY27lzg4aTHZTyJwcz29HR+dWPrmwiHqjAfcYXMpOyX1hBfdi1jHJOcC
	 JVATvoL9B4hJ6U1Xd0Xu0SH0YX0LJg0+4pcCxOvYFX7lmuASuqKfQNlfEOx0Xw0LQc
	 mhMLD/vmCBR1q0qOdqX5U3NzaF2Thtuyf6pj3S5S6z9iZxAKGrfsD+iuz8lcgHLnXV
	 cCOKyNQCyTEfhMwzEynEBbqLVKPzsKTZdY4E40395BmPqk71aP6Hu170C2Kh59h8Kg
	 oVoYx9vy0/C4ngv5VEALksnbm7hQUNPJjEr2Go8OjKGr0gWEVa0T4szy5dRbY1HCpp
	 SYH9ap8XS6wNw==
Date: Fri, 09 May 2025 08:45:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>, 
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Alisa-Dariana Roman <alisadariana@gmail.com>, 
 Andy Shevchenko <andy@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
In-Reply-To: <20250508123107.3797042-4-pop.ioan-daniel@analog.com>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
 <20250508123107.3797042-4-pop.ioan-daniel@analog.com>
Message-Id: <174679832695.3268142.16005695454216991921.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: add ad7405


On Thu, 08 May 2025 15:30:56 +0300, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - remove  #address-cells and #size-cells
>  - add additionalProperties: false instead of unevaluatedProperties: false
>  - remove #include <dt-bindings/interrupt-controller/irq.h>
>    because it's not used
>  - add new line at the end of the file
>  - add mantainer
>  .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml: properties:clocks: 'anyOf' conditional failed, one must be fixed:
	'maxitems' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml: properties:clocks: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'maxitems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('maxitems' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxitems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250508123107.3797042-4-pop.ioan-daniel@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


