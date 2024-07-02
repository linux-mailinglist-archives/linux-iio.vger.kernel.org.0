Return-Path: <linux-iio+bounces-7131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D384923EFF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A976CB28726
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F015B143;
	Tue,  2 Jul 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBZ6E/Hb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5B26AEC;
	Tue,  2 Jul 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927017; cv=none; b=B3RKGI/JaMEopF/p7TSbteEb0mHLSCklRoo9hANYaIYfMo+CF07J4UM5DuVGjIO1NryJ0VnLibpMhSU+9dPmXbvX+CX2R8P2IbTlAqSA3+U8WrLJzgEetiG4iXuKBjlBODkIKynUOUvHilXDEsoNRFWYd7h/EW5W3Nn3gcYexyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927017; c=relaxed/simple;
	bh=8RJtG0gGC00rT2GsXuQEaindF1W2r+IuO/BdBiyjJLM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=hKeiMOewYVbx9vckV9r4ar9H5tHjovThhuTuzIiwYQm0Pl3a3lhba8If22gl2/HfBAcaFTS6t2QCWQf3laU52RGB+M2rLye9XFVdy0/aicXdVZfpXUUZdc7mhBlL5EPfGjpn9sKCZ6J6Pdci2YCK52hiOu2Pvnn2kLhwr92jcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBZ6E/Hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B8CC4AF07;
	Tue,  2 Jul 2024 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927017;
	bh=8RJtG0gGC00rT2GsXuQEaindF1W2r+IuO/BdBiyjJLM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BBZ6E/HbkuhYaAn15zmd4Nk0PEd9guaspQwFVcD0y6e80jVg/7PGdlUIVTD5PVn3k
	 NsPx7S9Szi1KiWBb73d4X17sSicGlTJrbJcJsBN3X6cDIZPzmJzp62FJuvN8zLsJBe
	 Hh+zOGX6O7abgbci9xYpqh3fBnCUdw4W0S1LVHdMZuQ5ckD/TLMcDm3qFus0R/DkLk
	 yYiJDpxEGqXsUCXBDddiayVBjuIbuZlOsDUy53i7Uc+UWRp2YydUwvASFOadEtiwO/
	 1us5/GPrfCaWreY3ar8CL+Wj25deHBGbYcweqdZJp8SeE89PG2PMgQbnygxZ/RZXEe
	 K6Q1ba13n7p5w==
Date: Tue, 02 Jul 2024 07:30:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-iio@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Chen Wang <unicorn_wang@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
 <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
Message-Id: <171992701607.3218867.8675024539411863214.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation


On Tue, 02 Jul 2024 13:52:21 +0200, Thomas Bonnefille wrote:
> The Sophgo SARADC is a Successive Approximation ADC that can be found in
> the Sophgo SoC.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 51 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 56 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-adc.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
Error: Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.example.dts:24.11-12 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


