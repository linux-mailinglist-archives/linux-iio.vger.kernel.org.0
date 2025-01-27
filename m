Return-Path: <linux-iio+bounces-14634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B7A1DAA0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EB41889198
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368C178CC8;
	Mon, 27 Jan 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so+SN6jH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39083156C76;
	Mon, 27 Jan 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995457; cv=none; b=Zcx/fkQMurc0Wnwm2VJKqrMtqTr4M3RHtbhMy2JySrn5aMKwenFVhRHS5uewB4Cq7o59gHtraGhKGb96iV5gF7OCJjqRuP28tpKevzKe2BicL3xvQeBKHIpJ6exhoNQ7pxCnr2mnvYGju87TPoUr8RCPVg1PBMnNt3gtoD53tIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995457; c=relaxed/simple;
	bh=EOzsobw0dCup/mm1V1SWK598t/wpvmmRb/NcHzpJ+QE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=c48SRsUIlsJ0WDs9p+1ZpMVVkTa3jVrO2nEhp6qFisNajHp82uw6l7SY8jOVCTNTTMg+VfKcjhSS/SXDQB89DBNns17N/MmTpMuusKJBWsOkLEKMPoP1+ARmAovp2V7srHQAtOpC+MJgEIdlLU+bB87LBCXzpj97QUBFfbmsrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so+SN6jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E117FC4CEE3;
	Mon, 27 Jan 2025 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737995457;
	bh=EOzsobw0dCup/mm1V1SWK598t/wpvmmRb/NcHzpJ+QE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=so+SN6jHebOP6I2KOuBtUn3TKAEchOJPyvRAooETXz5zaKuP+Ok7RvYm2jI2rUrQ1
	 ZeUMZrLOC5SuRT25KtH2AAeQpjK+Q7/mBNz/PP4aVDwyMXF9CB8IsFfgXmF0Peg4n1
	 oqPEZeTpf3KjlyzIldpKxWx3F+c4s6//1vPHpanjpPrGNxUiI+KAQu2tibHjMkxyka
	 OyHBrLAbMM9UMmMq6YOCTP/FojL2Sx1/8m5qv1R/WPyS6YofR0AyLpziso/la8pnSl
	 BiTFBxWqwI7XdviGbGhpWXyfO9rc34P0bQLTIAMqDpxbjjrXAeNfd7ACsFjuv/LPW3
	 91wpOegjAV2NQ==
Date: Mon, 27 Jan 2025 10:30:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: marcelo.schmitt1@gmail.com, marcelo.schmitt@analog.com, 
 krzk+dt@kernel.org, conor+dt@kernel.org, jic23@kernel.org, 
 linux-iio@vger.kernel.org, Michael.Hennerich@analog.com, 
 linux-kernel@vger.kernel.org, jonath4nns@gmail.com, 
 devicetree@vger.kernel.org, lars@metafoo.de
To: Jonathan Santos <Jonathan.Santos@analog.com>
In-Reply-To: <e17337bc3b0f2e95d3d4f7b6daa7755881e11fba.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <e17337bc3b0f2e95d3d4f7b6daa7755881e11fba.1737985435.git.Jonathan.Santos@analog.com>
Message-Id: <173799545339.405668.16086159730707197381.robh@kernel.org>
Subject: Re: [PATCH v2 04/16] dt-bindings: iio: adc: ad7768-1: add VMC
 output property


On Mon, 27 Jan 2025 12:12:05 -0300, Jonathan Santos wrote:
> The AD7768-1 provides a buffered common-mode voltage output
> on the VCM pin that can be used to bias analog input signals.
> 
> Add adi,vcm-output to enable the configuration of the VCM output
> circuit.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * New patch in v2.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml           | 10 ++++++++++
>  include/dt-bindings/iio/adc/adi,ad7768-1.h       | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml:69:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml:101:6: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.example.dts:39.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/e17337bc3b0f2e95d3d4f7b6daa7755881e11fba.1737985435.git.Jonathan.Santos@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


