Return-Path: <linux-iio+bounces-24351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC9B92402
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929D12A4E8C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651433126A4;
	Mon, 22 Sep 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZ/+qC3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EF311C2C;
	Mon, 22 Sep 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559091; cv=none; b=bXJfWyhrOrdGiSD4h7PRUo/pxj1yF/b2kAScpKepddwkGPkvvnZCEKwii1YhOdZTLhVo2R7eAHDiH9xjbmxJ/Be/4khInWxdsnMEEd7ERhLewrBPo0GSWiXXr1mndpd32jpkRwg/QYMAiQSRBHvh77g6T4dq8W1FZEx4oxhRkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559091; c=relaxed/simple;
	bh=K2AHAOsCHrPVmkffGGFO0G7K+aQn6w79l0lzLivUip0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=eXICZT52tevE03Wt42eJxdrlezPYvH4xA05Gy8rnwmNjeULoDgEO5VA7+8e/ZMIDKneG6DvVD3DU33ohM494+3+53upPFNDFgGmXOlfgoiqIT/0qDm5ERZjlOnINRNCU0WgZcrEX56YY8ISF8aC3jk6r0IeN4tMGAUuowZv59tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZ/+qC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8B1C4CEF0;
	Mon, 22 Sep 2025 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559090;
	bh=K2AHAOsCHrPVmkffGGFO0G7K+aQn6w79l0lzLivUip0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PXZ/+qC3tayDVxVs6qcosI/Cup8bQbBUtDcmCiS7N+yuJL8emHG+1dkAI+5rZHiy/
	 teS/M6cWWzG4rjZliike5jJfp8JNL9icfYbj/dqNDVLpdYjBV9IU8wO498tdrIDobG
	 nOuK9FAnhTMc8dXgwZJmItD+iLlPADBilG5WKkl4KigL8WJXEBCfIXXhNctyM/XrDf
	 sbnWWHZBwp0hj5HQ7mn+bwo7olAAgyL01CaYzEMW8bofyDf7s7Ydru/GWCN7Ph06gQ
	 S3Z8TXQuJhjpdCayBQf7AFDMTGilvNROX/lCYF2krtsLzry1LP3Z1wtVehc9Agt14D
	 wapNVCSMELkdw==
Date: Mon, 22 Sep 2025 11:38:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
To: Ariana Lazar <ariana.lazar@microchip.com>
In-Reply-To: <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
 <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
Message-Id: <175855908971.350343.6210710721753306803.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: adding support for
 Microchip MCP47FEB02


On Mon, 22 Sep 2025 14:30:53 +0300, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and
> MCP47F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 305 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 311 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:199:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:200:9: [warning] wrong indentation: expected 9 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:201:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:202:11: [warning] wrong indentation: expected 11 but found 10 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:225:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:226:9: [warning] wrong indentation: expected 9 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:227:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:228:11: [warning] wrong indentation: expected 11 but found 10 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:257:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:258:9: [warning] wrong indentation: expected 9 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:259:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
./Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml:260:11: [warning] wrong indentation: expected 11 but found 10 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml: allOf:0:then:patternProperties:^channel@[1]$: 'anyOf' conditional failed, one must be fixed:
	'^channel@[2-7]$' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml: allOf:1:then:patternProperties:^channel@[1-2]$: 'anyOf' conditional failed, one must be fixed:
	'^channel@[3-7]$' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.example.dtb: dac@0 (microchip,mcp47feb02): channel@0:reg:0:0: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/schemas/iio/dac/microchip,mcp47feb02.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


