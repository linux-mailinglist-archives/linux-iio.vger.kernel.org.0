Return-Path: <linux-iio+bounces-7169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C2692439D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346DD1C237DD
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE61BD4FD;
	Tue,  2 Jul 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGzfhmoC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F541BC08B;
	Tue,  2 Jul 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937844; cv=none; b=hLZrQ5nUr9sHYn12lP4F1i1hedPOvGtSnDc82+LEpJ5FlS0XS4pDGba/vw/9faDMwv2x37W5MQ/rUyDY4f+p4XCtz9vUwKuuzlkf5nVYvlbAxh4qAATyENzVbta9UH7Q0N1DvA/3NXqb0ECqR2PLYvcgeUU8/e6HhNeEHjxn2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937844; c=relaxed/simple;
	bh=oEbf74yka16937zk2YkPUMNYRWLZTn0q4LUgV8PRn4E=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=m9Zs416zsIGuq5D3R2tGPqOgqNXLYjRV2+W7i5NCBS7KC4O7zImSjn9WdXUm+zxULVi7B0TzT6MFRq6a9aM0GOTUHJp1U84UmGlWjZzgP9186Rgv+niafi/tajU9eVKBv8yv8V19SOPx9xdIRxFPe80t6DidMkwLAOaLl8uZD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGzfhmoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B160AC4AF07;
	Tue,  2 Jul 2024 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937843;
	bh=oEbf74yka16937zk2YkPUMNYRWLZTn0q4LUgV8PRn4E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IGzfhmoC4UrCMZ+AHzmh37RY8SL7XeWYcnke2157T/iS4i9B+R1+IIk2ea4WeEn0l
	 /MuAL1n8BxPKrz0LKvuB22P6DiVVooV0nFwXETIIsShig7moeiP79EPsySxiYTckMb
	 GCK6oD6FH1gddyWtBg8LwS5Ol+xyM+rAMNDp6A2VFbOdFxjaYJCKDCHzubxuSLpDmt
	 BPmQhAKPe77eOkMaiiImvj8T9GyFNBNOMzQS5B9o0IDRulQIdtFqiCz5E/kdaFLDB5
	 LyznCaMSY1CCj3eZOeKjX+Gr1SKrMowuVXccZGXKcWPFM1r/o03I4qxRff/Eb+3xnl
	 fqzIzDvXel9/g==
Date: Tue, 02 Jul 2024 10:30:42 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
 devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
Message-Id: <171993784259.3739500.10383587148467749192.robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion
 SDP500


On Tue, 02 Jul 2024 16:59:08 +0200, Petar Stoykov wrote:
> Sensirion SDP500 is a digital differential pressure sensor. It provides
> a digital I2C output. Add devicetree bindings requiring the compatible
> string and I2C slave address (reg).
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> ---
>  .../bindings/iio/pressure/sensirion,sdp500.yaml    | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.example.dtb: pressure@40: 'vdd-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


