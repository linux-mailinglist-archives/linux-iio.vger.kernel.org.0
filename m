Return-Path: <linux-iio+bounces-21828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E7B0C62D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1347F1AA635B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF42DA756;
	Mon, 21 Jul 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp4tc4v/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809B2D8DCA;
	Mon, 21 Jul 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107833; cv=none; b=sxhxXPQDMfPdmCXbNGBmB4HLFuhXTx9hBbdMq6K0vvCGRkcoafUB289FF6Ty0Sfpc0LTjs/T3QCai3LojXv0BmElh1rsUQx2XjhCcPdQOq0hGAMRpXoTOwTixUwhb+X+2uYDx1wZm1R7Bq3IbvKczlWXL9Cu8hLvJzD+qpCmlow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107833; c=relaxed/simple;
	bh=LFCoSZD4NWrIChMOUuVxocYbxokpEvpjrJtNREcmERw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=l8phPIOeHvrCp0wQhmse6/mCY4H8l+wbjHAlAtkNIPwDGPa2N8Mz2q0D21mldARaA43BEsHffzL3Q9VoVK+GdRDJYTjCZqTBl2GtN0TQjTXKkWnTP/2qUc5sss5OVC4VkyBmPW+f9Ic/LMe0gb+QA0WgDCTPzyO2CBKIWKo6TLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp4tc4v/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBE5C4CEED;
	Mon, 21 Jul 2025 14:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753107833;
	bh=LFCoSZD4NWrIChMOUuVxocYbxokpEvpjrJtNREcmERw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=jp4tc4v/1WABJZWDeN1oV5PMzXYQNfy0HMlNuwhGzRliNL3gmpung6F19zOA1VRVj
	 bTPqrlRa6HPPoGQmt1Q12K1d7eqnxiTWu64JIvH0Br1FSSYdHXr4kp/i/X50xa95UD
	 ts0OrGBCs8sSrchua7LJ1OGfCD9pzaMAHIKeXJrXRAFbTa5MctcVFVlw5tlMNVoBsX
	 grwYgbNjJ6e3mfi5x7AWMB8m3zphmQqGoLjZxnG8pjpty2b+TejYHoxE4XCjAg+vSj
	 oE8HvAlcXKVLI7wZTiauz4JBMYlF3p4YdhGM/yxOj5Qc6OdZUSIbDPVO3DdOo310YO
	 Q0wn/XwZFhJ+Q==
Date: Mon, 21 Jul 2025 09:23:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
In-Reply-To: <20250721112455.23948-2-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
 <20250721112455.23948-2-antoniu.miclaus@analog.com>
Message-Id: <175310783209.583289.11600965085224467710.robh@kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: iio: adc: add ade9000


On Mon, 21 Jul 2025 14:24:42 +0300, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - move interrup-names near interrupts
>  - remove properties related to the waveform buffer and make them runtime attributes
>  - remove egy-time property and make it a runtime attribute.
>  - remove wf-src and use filter_type in the driver.
>  - add vref, vdd support.
>  - use adc standard channels instead of phase channels.
>  .../bindings/iio/adc/adi,ade9000.yaml         | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml:
	Error in referenced schema matching $id: http://devicetree.org/schemas/spi/spi-peripheral-props.yaml
	Tried these paths (check schema $id if path is wrong):
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/spi/spi-peripheral-props.yaml
	/usr/local/lib/python3.11/dist-packages/dtschema/schemas/spi/spi-peripheral-props.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250721112455.23948-2-antoniu.miclaus@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


