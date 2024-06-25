Return-Path: <linux-iio+bounces-6867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD6915D73
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 05:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00D41F2241F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 03:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFE3E49E;
	Tue, 25 Jun 2024 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnMCE6Nx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40A2F56;
	Tue, 25 Jun 2024 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287334; cv=none; b=hQ3THr1zb80hfKegmGbjOPsOHLRRrzI9TYbW5P1FyC7aKaVIr/nG1mNiexfMM8x4y7WhhqdWZMdi9LyIcAKI22vqez+LLVLeHJA0KYHrUrVXzW0BdfLfsmsk0p1ps8ZKjd0CBl5K6JcXfXQnbx5YE+z71NgzGdOnesYM7KgkeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287334; c=relaxed/simple;
	bh=1rAqPupj9al+l6A81vCVuV+IcaeTM8ju1SU09vBEH+E=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Mshx+0OKMiOcj5wOM1+1udTrF6+zdKTBLMBV0oW6iJ2Na0Yo0zgvjWiquU94mpeU4AgSOFhNvWVhXJpQuKlpSfPUtcNrYQ3Rvl9honBUk/HLmv11UapSdkAmzj3H1lk9Uiek8CBdDMk9gvIIBpn+zmYHk/6amCqQifsCKcpsP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnMCE6Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC6BC32782;
	Tue, 25 Jun 2024 03:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719287334;
	bh=1rAqPupj9al+l6A81vCVuV+IcaeTM8ju1SU09vBEH+E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PnMCE6NxctdOx6KvknhYU3iF0Q/zgc2clxaYVyIvw4OZ808/cczBwY8+0Wt3PTJtq
	 9Xjj/M7ttFA7Dil3XBDCjWtxShiMcePHB+BmI2XtwCyZBeIIhQ2ZnWUQSEF2z2qyzJ
	 npFo9kdeWrjT75fNvPB3pkF7pal9dJUFQ6Wo29oK4k/kcG8m5RA+U+8b3wSVfqX2R8
	 1QTJ2h4s2KdCvopR2xFYY9em7F0zpaGiXFmQxDoPBO/Hu/PSyPVk4E8/HRy4JJfDUV
	 tjb+tzkYL1aVPednFB51mZ7ordWLGy0mXmSCkoJcfIwTBvope6QT+PwHx4Aul/hl8V
	 V/Ea6wKEaiXWQ==
Date: Mon, 24 Jun 2024 21:48:52 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, yasin.lee.x@outlook.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
Message-Id: <171928733216.1434276.10145662447261263501.robh@kernel.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S


On Tue, 25 Jun 2024 10:15:11 +0800, Yasin Lee wrote:
> A capacitive proximity sensor
> 
> Acked-by: Conor Dooley <conor@kernel.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reported-by： "Rob Herring (Arm)" <robh@kernel.org>
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 107 +++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml: single-channel: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


