Return-Path: <linux-iio+bounces-12978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318C9E0E1F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 22:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20B2B31D2F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF61DEFE5;
	Mon,  2 Dec 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXyI7EB6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442261DE892;
	Mon,  2 Dec 2024 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172376; cv=none; b=LGFvXcDBxrfSE4h58fe2bwYcXNi99qxM9/uJYZ7/GrJ6te74wbaQ6JIm/MtvBzjTuFhZpyoIjMgl36o6jdxhyEM69tbAFXHVNyJQYGUDNR4Sm57p+Y0GhD3cX+oZn5yAy/bmrGUGpuykMB/HXnsFnWUD46368tWtlru/AxAkGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172376; c=relaxed/simple;
	bh=J8M2JMvTC3J70a+RNOwGgR1WsUbjnZcmaGtlprtVnCI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ZLfj83ajO/xBN8dN8L7Aokp2sGg3FjSL9F0ha4854wPB2bMlOlxUt722T2wZEZGxdm48a2MUGKkShnbnGc80mIEdybHmVYqRrIdFEpd4pZ2v65ruhD9pyWSUL/Um+lYJJAHeYUqKEiZqVkhW+Tozw2bCqk10Yg3OV+1tSzPlqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXyI7EB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A5EC4CED1;
	Mon,  2 Dec 2024 20:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733172375;
	bh=J8M2JMvTC3J70a+RNOwGgR1WsUbjnZcmaGtlprtVnCI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EXyI7EB6ku1r++cKPPA9ZCtgON42LwaBbj0xGaLcTVu+uLQbzRHqPNB7p1KEe9bHU
	 o7HB4bRq+UqQtHQLPTrLnmVMBvCwPUWDFBlcPIprZjiOzhUMzUuz9VegYC/T5DV4OC
	 Uywn2b54vFO9qOc+yEVSQonFYRMvNZpigU9rjAN6hxwF0ulpOspHciZDk+ITmZ2Qz/
	 b1ASpLKl2ILQUDW5/mhQNSCr7e3WGNmsXYm67dyPF4ibepWt26RD8AikNfBssOhoLs
	 XuBCIJsx6PQtK/xLTF+rlofS8t9zBW8NWJ5uac8OlrmEuZCMCvSLk90przJaQY6YD3
	 zRQqq6I0RIGXQ==
Date: Mon, 02 Dec 2024 14:46:13 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: ak@it-klinger.de, jic23@kernel.org, conor+dt@kernel.org, 
 linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org, andriy.shevchenko@linux.intel.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, ajarizzo@gmail.com
To: Vasileios Amoiridis <vassilisamir@gmail.com>
In-Reply-To: <20241202181907.21471-2-vassilisamir@gmail.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <20241202181907.21471-2-vassilisamir@gmail.com>
Message-Id: <173317237354.3142409.6212368803030680874.robh@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface


On Mon, 02 Dec 2024 19:19:05 +0100, Vasileios Amoiridis wrote:
> The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
> in the device-tree.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.example.dtb: pressure@0: interrupts: False schema does not allow [[25, 1]]
	from schema $id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241202181907.21471-2-vassilisamir@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


