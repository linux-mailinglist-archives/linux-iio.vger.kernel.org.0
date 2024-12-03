Return-Path: <linux-iio+bounces-13060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEFE9E2F07
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233C1165CC8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19320898A;
	Tue,  3 Dec 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxxDQ6UQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A71DDA3D;
	Tue,  3 Dec 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264808; cv=none; b=Eb5cKSP0PaAE3WzSJ2Da7g7eWIPYGCpUtuVx6LhMNywYCXOIoVipdaDuVta160mg/0pfLwxagqL7WpsY3BK885RzeAnEFlRrY4oIxdMsKg+z7/bHndiOjLo+1jhFmWV0zQwWwi7IDNQfv28SmIl199YqK1grx3dA1yc+zBD4nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264808; c=relaxed/simple;
	bh=HbdImYXZhZGhTMx1V764qTj9cgvvL6l6RjcqS2+z7hw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jNT86lPxpKvGm3VxM26KXd+iHT+kWJIjQv+Q2MLS2K3DjpP9RX4tDjdEbhuY1tyF2IAw7dUERjB5HG1HRiTrS9gny1nm5rlWHFREmHBAFOuslBA8O0NNJCtc1FmuOPGqu4apEGMReIT6oC/T4qT0fmUyI0Rcagd2tQmHL1JIzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxxDQ6UQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1609C4CEDC;
	Tue,  3 Dec 2024 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733264808;
	bh=HbdImYXZhZGhTMx1V764qTj9cgvvL6l6RjcqS2+z7hw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FxxDQ6UQAYt9psqdF9ZzGyo1bv2Yh4Oo+gCXI+EZeP2pPuTTWgE8AY9yWY7W0ttCW
	 PE7IT80vVTEOv9Il0j216dxIqhmNUs0cfsUxrn2RRewb4UtftohMxEnLR3Yxzdg3Pl
	 m5qlYl2Rm8w5J72NPo1wBBT21Ilo8prDRjEEehrjQt1PdVxDbnmpmsCwf/FQYSzXZ3
	 McIamJ4DnrkzAPtle9NgHHcbzgBFpjj7sXTyC0Ye+fXi+aJqN8S/A+VjtpLrESbrU3
	 orzfU8FtOwVq4k5iahOq/kWxdPL6hs7rxGrzHTXDUGD6BonYfxKqjJpV2fITHHmx4W
	 zJkcvYyM8e16Q==
Date: Tue, 03 Dec 2024 16:26:46 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: eraretuya@gmail.com, jic23@kernel.org, krzk+dt@kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Michael.Hennerich@analog.com
To: Lothar Rubusch <l.rubusch@gmail.com>
In-Reply-To: <20241203205241.48077-7-l.rubusch@gmail.com>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
 <20241203205241.48077-7-l.rubusch@gmail.com>
Message-Id: <173326480618.2553820.17010033909331312411.robh@kernel.org>
Subject: Re: [PATCH v3 06/10] dt-bindings: iio: accel: add interrupt-names


On Tue, 03 Dec 2024 20:52:37 +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor. Only one line will be connected for incoming events. The driver
> needs to be configured accordingly. If no interrupt line is set up, the
> sensor will still measure, but no events are possible.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: ignoring, error in schema: properties: maxItems
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties:minItems: 1 is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties:maxItems: 2 is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties:interrupt-names: 'Data ready is only available on INT1, but events can use either or both pins.  If not specified, first element assumed to correspond to INT1 and second (where present) to INT2.' is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties: 'minItems' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties: 'maxItems' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties: 'items' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties:minItems: 1 is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties:maxItems: 2 is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: properties:interrupt-names: 'Data ready is only available on INT1, but events can use either or both pins.  If not specified, first element assumed to correspond to INT1 and second (where present) to INT2.' is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/iio/accel/adi,adxl345.example.dtb: /example-0/i2c/accelerometer@2a: failed to match any schema with compatible: ['adi,adxl345']
Documentation/devicetree/bindings/iio/accel/adi,adxl345.example.dtb: /example-1/spi/accelerometer@0: failed to match any schema with compatible: ['adi,adxl345']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241203205241.48077-7-l.rubusch@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


