Return-Path: <linux-iio+bounces-14632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09500A1DA9A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 17:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C2118891A9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDCC14A630;
	Mon, 27 Jan 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQSB+79M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAF15B54A;
	Mon, 27 Jan 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995455; cv=none; b=fuG5CqqzFA4Sy5sIe8LZ7hWuHVyQcoJawqEPdH9BwuYyjcmmEzNtvK6jpEjM3UCx29pPYQemHyXNU4Fuyu4eHseus5NMI2WQmDWmmNH4yi7tWk3Zmfw4wsYPiSAYiHqySX8vKuZbC44Hh2uB2k7r8qJ063HYXWgNisoUkCttuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995455; c=relaxed/simple;
	bh=xrJgOlMCN20/Iuji9H3bNZecr9/m/kElFt061ei3y7g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XCYN9CVoOoCwm6quBjJfYwKefJteBisjiokc2FUFRWmVa+pMGB6S8LcuUWBlRWudC4SaQ1wGPDLPAJwMEd1nWOvWfezEUn1TCwcZB5/OHHnXO7a4Y5ZyoYtCnIDb7Ma0IxpRnVINsB/U3MBkHkh407F4KQATBf5kLUgy7GAvhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQSB+79M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590E2C4CED2;
	Mon, 27 Jan 2025 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737995454;
	bh=xrJgOlMCN20/Iuji9H3bNZecr9/m/kElFt061ei3y7g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZQSB+79MKd1ByihnwwANgASIHEGLYWUCl/7c+iAhsKxfqBnxJHcT7RYRPOmsErp4z
	 5WFZl2Lwr747ZyoF9HeOrtQsZPCasgUAK4PHM/E67+ZBbrz3PqGe6G9W6MvVaG9+W7
	 NErOX5WhE1HE5HspQAhKIWBvF8Oei7vGS22q6QwPsNvjkDDEcEKaYS/od2RibD49Ef
	 vmmcIhD+aa37TLR1p5yB2ieeS3JwoaEJ8eRDmYSFsNdbf8V201poDZryLYQo17wSJE
	 pH1VnctUHBDhtnZbQQRQMMbcnx/K27Wi9Hu92CtMYQjM19FE1vFlJ1c5XRDTzNDDb0
	 iWH1lpR3D0CAg==
Date: Mon, 27 Jan 2025 10:30:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
 jic23@kernel.org, linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 marcelo.schmitt1@gmail.com, krzk+dt@kernel.org, jonath4nns@gmail.com
To: Jonathan Santos <Jonathan.Santos@analog.com>
In-Reply-To: <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
Message-Id: <173799545085.405574.12986826784688326343.robh@kernel.org>
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property


On Mon, 27 Jan 2025 12:11:30 -0300, Jonathan Santos wrote:
> Add a new trigger-sources property to enable synchronization across
> multiple devices. This property references the main device (or
> trigger provider) responsible for generating the pulse to drive the
> SYNC_IN of all devices in the setup.
> 
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> SPI-based synchronization is enabled in the absence of adi,sync-in-gpios
> property. Since adi,sync-in-gpios is not long the only method, remove it
> from required properties.
> 
> While at it, add description to the interrupt property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml:84:6: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml: ignoring, error in schema: required: 8
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml: required:8: None is not of type 'string'
	from schema $id: http://json-schema.org/draft-07/schema#
Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.example.dtb: /example-0/spi/adc@0: failed to match any schema with compatible: ['adi,ad7768-1']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


