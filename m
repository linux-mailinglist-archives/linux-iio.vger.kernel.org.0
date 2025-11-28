Return-Path: <linux-iio+bounces-26550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080A2C92E54
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B637F3A9FC0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0432F74A;
	Fri, 28 Nov 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYF+x+fi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F30233704;
	Fri, 28 Nov 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764353989; cv=none; b=lIfYIcVwvuXinnwjeVic4JBR/wtBsBafJtbh1d4P9XhMj/pYqNPCeIcxITGmEgzaSi56x3a8vsa9Rugglx531k2YoO4/twoGOvNtmacivF1Mn+cNiHS0YoZLkflCtmBruauzP/+sKSTUe8ZmEbGWgDnyFLmwLJ/UjydlNeSAJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764353989; c=relaxed/simple;
	bh=TQacgkZQcsvptdNv9G3fP+zzJTK8GgNwUEialm8Ojz8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KkLGdQBMl+2ozCmyJVc2mg8QYlsrUgFdmDqSNwGB66LMMCH6cVWMY3vF/Hw06vmu9UIgXupvUgEevMx8rNy9O2YUSkx3MpSMLtpaC+TtvQduagQfFrf9cMdGBJEl/dN2zXa7WWqljiNuf364lZKRu1a7Jo9hNGEdV5Ehl2AKjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYF+x+fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612DAC4CEF1;
	Fri, 28 Nov 2025 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764353987;
	bh=TQacgkZQcsvptdNv9G3fP+zzJTK8GgNwUEialm8Ojz8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bYF+x+fiaHuy3l7Qi37uyk/kpp2VFq7w5F+psb5GqMBNHMs6ES9UAU3zlvkWGRUO6
	 nbRZgjBmN9v/uiJeWOnmEpJpOYQCh0gevEOVgSOnMIzJXy2mnYAEEq80kFrHQH+PCV
	 SjaHqGmYKNz1i7HQIAKIVL+sJPB7K6q6UbfNjPTZKsVCBh7+jsFeO5I+cwfW4gEBsG
	 qZNbBEtkomzmpqYzNURmREoYPXk7MCXs5ITWoP881CvNh22F1m1V4yG4DjHlWnEdxA
	 9S5KypnEoeS0ggrToNDCs0AmyB1Nkyo98XI8sGIUM70eyD6FtZq79+Xkj97Cv7/fXZ
	 AbJBPnrv30NhQ==
Date: Fri, 28 Nov 2025 12:19:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Conor Dooley <conor+dt@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
In-Reply-To: <20251128144428.24450-2-antoniu.miclaus@analog.com>
References: <20251128144428.24450-1-antoniu.miclaus@analog.com>
 <20251128144428.24450-2-antoniu.miclaus@analog.com>
Message-Id: <176435398575.2319875.11190556309787903382.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: amplifiers: add adl8113


On Fri, 28 Nov 2025 16:44:10 +0200, Antoniu Miclaus wrote:
> Add devicetree bindings for adl8113.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v5:
> - Replace separate va-gpios and vb-gpios properties with single ctrl-gpios array
> - Remove second example, keep only one with external bypass configuration
> - Add comments to external bypass gains in example
> 
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 428, in get_or_retrieve
    resource = registry._retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 426, in retrieve
    return DRAFT201909.create_resource(self.schemas[uri])
                                       ~~~~~~~~~~~~^^^^^
KeyError: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 435, in get_or_retrieve
    raise exceptions.Unretrievable(ref=uri) from error
referencing.exceptions.Unretrievable: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 463, in _validate_reference
    resolved = self._resolver.lookup(ref)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 686, in lookup
    raise exceptions.Unresolvable(ref=ref) from error
referencing.exceptions.Unresolvable: /schemas/thermal/qcom-tsens.yaml#

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 158, in main
    sg.check_dtb(filename)
    ~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 95, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 83, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 34, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file,
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                            compatible_match=compatible_match):
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 448, in iter_errors
    for error in self.DtValidator(schema, registry=self.registry).iter_errors(instance):
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 384, in iter_errors
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 296, in properties
    yield from validator.descend(
    ...<4 lines>...
    )
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 432, in descend
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 275, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 465, in _validate_reference
    raise exceptions._WrappedReferencingError(err) from err
jsonschema.exceptions._WrappedReferencingError: Unresolvable: /schemas/thermal/qcom-tsens.yaml#
Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 428, in get_or_retrieve
    resource = registry._retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 426, in retrieve
    return DRAFT201909.create_resource(self.schemas[uri])
                                       ~~~~~~~~~~~~^^^^^
KeyError: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 435, in get_or_retrieve
    raise exceptions.Unretrievable(ref=uri) from error
referencing.exceptions.Unretrievable: 'http://devicetree.org/schemas/thermal/qcom-tsens.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 463, in _validate_reference
    resolved = self._resolver.lookup(ref)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 686, in lookup
    raise exceptions.Unresolvable(ref=ref) from error
referencing.exceptions.Unresolvable: /schemas/thermal/qcom-tsens.yaml#

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 158, in main
    sg.check_dtb(filename)
    ~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 95, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 88, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
    ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 83, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 34, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file,
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                            compatible_match=compatible_match):
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 448, in iter_errors
    for error in self.DtValidator(schema, registry=self.registry).iter_errors(instance):
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 384, in iter_errors
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 296, in properties
    yield from validator.descend(
    ...<4 lines>...
    )
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 432, in descend
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 334, in allOf
    yield from validator.descend(instance, subschema, schema_path=index)
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 432, in descend
    for error in errors:
                 ^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/_keywords.py", line 275, in ref
    yield from validator._validate_reference(ref=ref, instance=instance)
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/jsonschema/validators.py", line 465, in _validate_reference
    raise exceptions._WrappedReferencingError(err) from err
jsonschema.exceptions._WrappedReferencingError: Unresolvable: /schemas/thermal/qcom-tsens.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251128144428.24450-2-antoniu.miclaus@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


