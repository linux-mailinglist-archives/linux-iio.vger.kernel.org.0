Return-Path: <linux-iio+bounces-13548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853119F35D2
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5766188E3AE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CD176ADE;
	Mon, 16 Dec 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRc+sn+r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA5146A71;
	Mon, 16 Dec 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366030; cv=none; b=HOT32iuBz0fT1mrZrwVvAlPDLSBBhBvZQuaEfsF6BBJjyMvb4DSRrfqzHGCviiK9So8qe796L3kUu736awt6pdNKM8D5Lw8ZINc0Knqsjopy/qQpCujh0FM7vfwbBRGuqWF42VKjKmaLQgvSdEIJqCXMSUUyS3ryCrkmgb45cKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366030; c=relaxed/simple;
	bh=FRE0tnmdPZcvIgR7EVR87njVhzKUC6TYSG3OdJHFNMw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ne4W9pE4MASlbBdRaYs7GIRT5psevh4+VBFMr23KM6LBn8l4Ea4YQRBTwNBs2HzyXkHgFViIhIjiE7GLC9D2WYzDG25eANp0aFYw0jyKUvipTenxhBmtJsNNuXpk1ssLknvuI2+iRnBusPaqSmgCxFlswS49OLWkB6jstlSy4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRc+sn+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46085C4CED0;
	Mon, 16 Dec 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366025;
	bh=FRE0tnmdPZcvIgR7EVR87njVhzKUC6TYSG3OdJHFNMw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=dRc+sn+reUTf5Ng2RmTvjGbDyUqn6S5cWeO793fM9stsagGakiZchfqarwDyJj1Or
	 CMmq5/mqbOjLbYs7FmpZTMmZXV116uTW3V3aJbdc7NmjqjZAvKIiJ3t5ZcdtyDWGwj
	 hf75Qp5jGLqCwDrZ/YnGf1dPh64zkLvE1mOAsKfYq9N8yibUH0K25QH19Ya1NPdlh4
	 0wyQUnBaFsApborre6WqrcDbIBcrTmLIOQa1xj+YmLRq4WSCzBJ1xcepclIHBgr4Qo
	 uk031+KLsErzEpKQ/t5yBhH2qpUM7ZdKZDI7Pijxzh/QbpXpnL5Khc/M0o6NsNkVWw
	 e0FV5ta9Qs0ZA==
Date: Mon, 16 Dec 2024 10:20:18 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Shen Jianping <Jianping.Shen@de.bosch.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, robi_budai@yahoo.com, 
 Michael Hennerich <Michael.Hennerich@analog.com>
To: Robert Budai <robert.budai@analog.com>
In-Reply-To: <20241216144818.25344-6-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
 <20241216144818.25344-6-robert.budai@analog.com>
Message-Id: <173436601809.266177.9235347510017778523.robh@kernel.org>
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: Add adis16550 bindings


On Mon, 16 Dec 2024 16:48:11 +0200, Robert Budai wrote:
> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> v3:
> - changed sync type to integer
> - conditioned clock only on scaled-sync
> - added: unevaluatedProperties false
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 93 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml:45:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml: ignoring, error in schema: allOf: 0: if: properties: adi,sync-mode
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml: allOf:0:if:properties:adi,sync-mode: 1 is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml: allOf:0:if:properties:adi,sync-mode: 1 is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml: properties:clocks: 'anyOf' conditional failed, one must be fixed:
	'adi,sync-mode' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml: properties:clocks: 'anyOf' conditional failed, one must be fixed:
		'adi,sync-mode' is not one of ['maxItems', 'description', 'deprecated']
			hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
		Additional properties are not allowed ('adi,sync-mode' was unexpected)
			hint: Arrays must be described with a combination of minItems/maxItems/items
		'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
		'adi,sync-mode' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
		1 is less than the minimum of 2
			hint: Arrays must be described with a combination of minItems/maxItems/items
		hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
		from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
	'maxItems' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	'adi,sync-mode' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	'type' is a required property
		hint: DT nodes ("object" type in schemas) can only use a subset of json-schema keywords
	from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
Documentation/devicetree/bindings/iio/imu/adi,adis16550.example.dtb: /example-0/spi/imu@0: failed to match any schema with compatible: ['adi,adis16550']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241216144818.25344-6-robert.budai@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


