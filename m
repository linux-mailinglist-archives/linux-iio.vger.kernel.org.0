Return-Path: <linux-iio+bounces-7903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45393CC0C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 02:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A21C21638
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746F80B;
	Fri, 26 Jul 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8EXQuS/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2963CB;
	Fri, 26 Jul 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953219; cv=none; b=lOYbJAMCIdSgD43w8grvkZIvw45qASZ7HmqQLhQSx/z0WmGIaP+JQ5upmpLYxPmwbufsQwFFoYlDK8MLS1QijSspO6879qpHPbhMGFIQiPf2Oua2cjad2v/D50cc18Pm03kOD4wRvRlYJRz4IzvKuZvJU9v/cRLOaJHUtr7yr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953219; c=relaxed/simple;
	bh=UowxC6Hl+spQMsfymKr1EuDGRGLZbprGrQdNhJkgmLA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=aPXlYi9eR4kMCWjBkuVQf46CAiU0wWAQNReBerHvNeWSbL7ZaBEetZYlHEbdmT0BBwPot5UZ8VmuOGhVWHYJVNMDJ4bpUbaRO5UEuxSkJkGQoH2JwELj6yvjlM3MV0yWofXepXzxK7gCOBSpe5eufLdrt3vI8b9/ICTUmk3Pd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8EXQuS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71C8C116B1;
	Fri, 26 Jul 2024 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721953219;
	bh=UowxC6Hl+spQMsfymKr1EuDGRGLZbprGrQdNhJkgmLA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O8EXQuS/gSxrsau85WQ3IRevrrfeHm2qwMaoGve/DCMCNxja7sZKwetW2XBu+fdp1
	 0X4PEMSDeOJyBSOwq5RkX1+LfNNjLpXX0RMaFplyyW+X5AQJxJJuNOjrz7CcZoA0iX
	 udckSB3vvnC39twkOFv6/SZ1uM44oYUW4SWidpBM6Z3V9HRXm2b2GvzMwoYOyqYN6g
	 Z0f3FKSmoXyvu367ynGLaFB23+C/oLcuvrD/Iodn+jOM6nFe54BglkN6dqdpp2pkZm
	 OScLqGcoOKybs1EA3mod5mzX1fz7uLeJHn8YPDawUBe9D6f2DpRFvIELIHO2I/PXFv
	 QrqgjxaHL2v1A==
Date: Thu, 25 Jul 2024 19:20:17 -0500
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
Cc: krzk+dt@kernel.org, semen.protsenko@linaro.org, 
 linus.walleij@linaro.org, lars@metafoo.de, jic23@kernel.org, 
 conor+dt@kernel.org, 579lpy@gmail.com, ak@it-klinger.de, 
 andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, 
 javier.carrasco.cruz@gmail.com, linux-iio@vger.kernel.org, 
 biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, 
 ang.iglesiasg@gmail.com
In-Reply-To: <20240725231039.614536-6-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
 <20240725231039.614536-6-vassilisamir@gmail.com>
Message-Id: <172195321787.24634.18050300557799081241.robh@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices


On Fri, 26 Jul 2024 01:10:37 +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml: properties:drive-open-drain: 'anyOf' conditional failed, one must be fixed:
	'desription' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240725231039.614536-6-vassilisamir@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


