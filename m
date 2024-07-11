Return-Path: <linux-iio+bounces-7524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776492F202
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 00:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A357B21179
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD527157495;
	Thu, 11 Jul 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W33l/AZu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A785956;
	Thu, 11 Jul 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737184; cv=none; b=QFlFtePlfthe4zUaqP/pUMrPDTdRBoThFNfwhySG2yKI70JgMD5tleDQxUcL2Hgqz74+B0dkgMnJTLRE+mKeePCfRS7IPTpcUD++OEv6qnEb6Xe1Ba8o0FJuOFS8jCTeYlIZ7xLV07ME2yA6fHAlCDDHHLvtLWFCnfMBD03/5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737184; c=relaxed/simple;
	bh=rWlMlimoIMORzwfk+6OfDOR9e4O5PSEarjfgOlav5vc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SwNTxN3gkmssJnk2KUL1PO1DZiNUDNDd1pc0Hjb5tvYnU6uup6j61A7jdafnep9lcSJt9Cr/BAMOs6MFoi0jMRirG0hnMTo0k64H4i9imAqK28J2qnfY2iOV+BjkJqqZPGOxnNqpLIi1LUNKsIIQ81pS3se8Alp/uwKZTS3we2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W33l/AZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D842BC116B1;
	Thu, 11 Jul 2024 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720737184;
	bh=rWlMlimoIMORzwfk+6OfDOR9e4O5PSEarjfgOlav5vc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=W33l/AZu0rd/8HL1MNBxZzV2JG6Re+FNC2kGh0U+hlmGrrygpVoZKR/UTbPBwGV5f
	 e6zUgbS0ztElrWza/6sXtjmjdkUyRBZ90qIQKzNgvY9EFiTRjxOfPKFkemAmdUhOzz
	 3e9aOHQqliMcNZjiDLyu+zIOIQce0jMHiMI6vkqs0vd3UBDEvzwS/GRMGlikdZYz9t
	 gJPZYNe3rOaPIdr0/VjebI+N46OeyPir0EZj1fNtxrmfcMluSL94rcer7+BN2usW77
	 v0QXwIizFZ91Hf7YdptzyOd+VE4vy/y1HlG/It0vTLBIRppcMUbxf8l2wNfW73s06Z
	 QsjAxQiw3pgqg==
Date: Thu, 11 Jul 2024 16:33:02 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, semen.protsenko@linaro.org, 
 biju.das.jz@bp.renesas.com, jic23@kernel.org, linux-kernel@vger.kernel.org, 
 579lpy@gmail.com, linux-iio@vger.kernel.org, ak@it-klinger.de, 
 ang.iglesiasg@gmail.com, conor+dt@kernel.org, linus.walleij@linaro.org, 
 devicetree@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
 andriy.shevchenko@linux.intel.com
In-Reply-To: <20240711211558.106327-9-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
 <20240711211558.106327-9-vassilisamir@gmail.com>
Message-Id: <172073718282.3242385.12442927643356451827.robh@kernel.org>
Subject: Re: [PATCH v1 08/10] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices


On Thu, 11 Jul 2024 23:15:56 +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../devicetree/bindings/iio/pressure/bmp085.yaml    | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml: properties:int-open-drain: 'anyOf' conditional failed, one must be fixed:
	'desription' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml: properties:interrupt-names:items: {'enum': ['DRDY']} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml: int-open-drain: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240711211558.106327-9-vassilisamir@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


