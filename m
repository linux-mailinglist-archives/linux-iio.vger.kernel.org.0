Return-Path: <linux-iio+bounces-16311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAEA4D0B6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 02:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8896718917E5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC482866;
	Tue,  4 Mar 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8LSoMnO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D489273FD;
	Tue,  4 Mar 2025 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051450; cv=none; b=kcQ7PKagwy24UELTZ/jhGmhMnuMad8ZHJncmhqJXKnMA/0tTO3CHCz1Dhiw2DlZSMiFW+5aY/svfNFkTZ4Y61qgqGFz/Vd8OwEjDANYXEb15XZ17IvEO+oCv/0aZlberJ00ZQaS9mGpdxSvKXnYxTPKsxyQ9nvn/1Gsfnd2oy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051450; c=relaxed/simple;
	bh=E2F08/o2OSzuu8jrFvRof23F4wF1UTe9v7R9uNKJugM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mcgixihuHdlnr/VQT0vk2+lSM/2qwZGE2nRRqk+fpBESGxY59gR+Lz4XxLTgADvoO+xykhqzbLY+KXVD0ijjtzIRkzlUM9PqFGx0pKukNLGicp1ORQtV3K+aRZP+8jwnxZ1cQpSKyIpbJgx/6ipoQu1A6AkydaDan9vyAzWmCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8LSoMnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ED6C4CEE4;
	Tue,  4 Mar 2025 01:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741051449;
	bh=E2F08/o2OSzuu8jrFvRof23F4wF1UTe9v7R9uNKJugM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=u8LSoMnOcd05kRsUfZGCFaY1x+Gj/801isMvowIZCnI3uz1CUHEK+dU+svd5YHEVm
	 10Ru54utTdmBkSyqfGcfMt9vPuWCtCXQx1ieHg7CuJ22bsTMAXg3thcrZWqtHIUp56
	 5yNxN1JeRyiaWJpla12/uHsY/+sad2oLMDntjPUSTxR5edCA6MIE6YVvLLz/pFdcfU
	 ERmMJdAUWBRpREHjTRQEif16hFvrGg/mP9jkzXEE506Ly/BS+SEPlgEE2cheRab4sL
	 TuoKKFKwBrb33Rt5dzPUt6yPFEPOIRt/FLWj9bkB0wS2EFIXUpzKrFURp6XpAJ6siY
	 6kkR8/vWSfUQw==
Date: Mon, 03 Mar 2025 19:24:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
 jic23@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, conor+dt@kernel.org, 
 krzk+dt@kernel.org, 21cnbao@gmail.com, lars@metafoo.de
To: Saalim Quadri <danascape@gmail.com>
In-Reply-To: <20250303235930.68731-1-danascape@gmail.com>
References: <20250303235930.68731-1-danascape@gmail.com>
Message-Id: <174105144819.171181.14482923503787621828.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: accel: add binding documentation
 for ADIS16203


On Tue, 04 Mar 2025 05:29:30 +0530, Saalim Quadri wrote:
> This patch add device tree binding documentation for ADIS16203.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
> Changes:
> V1 - V2: change compatible property from enum to const
> 
>  .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml: properties:compatible:const: ['adi,adis16203'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml: properties:compatible:const: ['adi,adis16203'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
Documentation/devicetree/bindings/iio/accel/adi,adis16203.example.dtb: /example-0/spi/accelerometer@0: failed to match any schema with compatible: ['adi,adis16203']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250303235930.68731-1-danascape@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


