Return-Path: <linux-iio+bounces-7146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BE92426E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B874FB242EB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D21BC06F;
	Tue,  2 Jul 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+6pQ5aw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366521BA081;
	Tue,  2 Jul 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934234; cv=none; b=MmOZtOsMImWUgrr5gKs/9kGjSUU8AiuVVT9hsaGLUxDgEbn7k0mc6BpGpwkgFAIJG9Ucrh2brNj5XDTmva2ecwq+uxivVEwt6RrAO5aWSOsqHeujDBcuz53LPzhtXQ/S9HoNdWWRiRc5vMw3OOWmI4Mr/JkMoRIcykdTOp7OBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934234; c=relaxed/simple;
	bh=1WfIcRGptFoZsf/Eke2g+70uUIv3MS8w+QRVo//psMU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Xkl/8BhtS/b3IyYrCOH5hf96j5QSMOOI8Asqz9cS62WJ6INaga+zqIsM4ygtOrRbHG/+C4sZ9ZzjGfu11PD42dI8ElGbnlvKDr7Kwt7r9tnCEZT25O3urT+dXPdU063RGmJ538MoMKvkmDj9ZmPtag7PzdMx++M/UNaJTElREhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+6pQ5aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B110AC116B1;
	Tue,  2 Jul 2024 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719934233;
	bh=1WfIcRGptFoZsf/Eke2g+70uUIv3MS8w+QRVo//psMU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q+6pQ5awOFoL3CIdIVlyoeVUirEzWX7wHchaTxh7xHk2msCNMKvAp8NFGw+rRC5eN
	 xqow+KJKRlhyzvk2bssDxGiYWD9/JvaMmUfs2tE5hzAVGsGbxdeNlwKtFrD3DSPiZ0
	 LUGvZpOzkDpSlKSkyYVPFd9sr8VDSfrA7C7yP9mANgtWqm3HnTCh7qTxibz+7cMtwj
	 twA4rNrx1XBVXZktajaDcVKTfaJKEmPrYp0zh9sBmHtanccxAsvXRs5EiU1JfmLuPR
	 SxrPdnLGX1evilP21aEHLOrBiiZG1sCXAgqUwswH7re89HMxzMOCG7Fcd1a9f4jGY6
	 JIQT2qBIhGuaA==
Date: Tue, 02 Jul 2024 09:30:32 -0600
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
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>, Conor Dooley <conor+dt@kernel.org>, 
 yasin.lee.x@outlook.com
In-Reply-To: <20240702-add-tyhx-hx9023s-sensor-driver-v9-2-c030f1801d9b@gmail.com>
References: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
 <20240702-add-tyhx-hx9023s-sensor-driver-v9-2-c030f1801d9b@gmail.com>
Message-Id: <171993423274.3453558.2041154529413644852.robh@kernel.org>
Subject: Re: [PATCH v9 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S


On Tue, 02 Jul 2024 22:12:33 +0800, Yasin Lee wrote:
> A capacitive proximity sensor
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@0: Unevaluated properties are not allowed ('single-channel' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@1: Unevaluated properties are not allowed ('single-channel' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@2: Unevaluated properties are not allowed ('single-channel' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240702-add-tyhx-hx9023s-sensor-driver-v9-2-c030f1801d9b@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


