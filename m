Return-Path: <linux-iio+bounces-16904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37027A63597
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7823AFAE3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04361A3142;
	Sun, 16 Mar 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNVZaGZc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401718B47C;
	Sun, 16 Mar 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127550; cv=none; b=onesSbxZ5NlFXQDPdHmafLqe5VEUonVyI4ts0hAD6xUVZm708VLs0VOEdDbvH7alnrJiD/RnXCopy1hywX72MPMNhfHqPha3vYsPHJba3On939wZ84LIluPO8uf/unE1ZZf09G8KSj1n6DBGBgIzf8MTPtq70RFLY0N4+0Epw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127550; c=relaxed/simple;
	bh=WDOxL/RE2tl9pVb3nTkLv25ewYOD88rCDJFDv51Rt60=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=arIKmrpB6oAte5LL1kBg2rnUTExTRvPrSaqqlnul33ncIn4cJnDDsbKbIefjpwJnL2K+JYlE2/FeF0VCDiLdMyJHG3er+PedTVMM1wolQPpGCny6wYU0TGbzikCkMzBkJqh4CjdzBo8mkrWfy3OgWErvC5E9pBE7gsO0n4UCUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNVZaGZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF0C4CEDD;
	Sun, 16 Mar 2025 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742127549;
	bh=WDOxL/RE2tl9pVb3nTkLv25ewYOD88rCDJFDv51Rt60=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lNVZaGZcnDmKWO0/IM62w4eJ9ac/Bx23UxURPi0RwrfgtlIbCL6/iDUqHTbnSKAYa
	 4oCXzcIqnXy6HCYJV6CQC9jVemEys/C9HDMCXewSTFwFJUYKAzhpGhE+eaGYX3QvPg
	 OF3JH4JZhnu1DgvevbtrrbAObUjKSRTC8dAXcmkDhZtY0c7Ik5hsujsUWZp9YKlxxk
	 PEPRNbjARhbpKGeEuAPmR1ZSWzT+EDOCw041838kZmUxHgy2FbES8tQxrKbQM901Xi
	 HQHnvabhDfd4Iho/oRE5G3sKo+1lIidJl+MLXYPdkoO5xru9pS/fExQbxJ+Uwt0MSf
	 qG8ZpNqXzL2yA==
Date: Sun, 16 Mar 2025 07:19:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mazziesaccount@gmail.com, arthur.becker@sentec.com, 
 subhajit.ghosh@tweaklogic.com, linux-iio@vger.kernel.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 javier.carrasco.cruz@gmail.com, muditsharma.info@gmail.com, 
 devicetree@vger.kernel.org, ivan.orlov0322@gmail.com, lars@metafoo.de, 
 jic23@kernel.org, krzk+dt@kernel.org
To: Andreas Klinger <ak@it-klinger.de>
In-Reply-To: <20250316113131.62884-2-ak@it-klinger.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
 <20250316113131.62884-2-ak@it-klinger.de>
Message-Id: <174212754864.1517319.13796050097130379689.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: light: veml6046x00: add color
 sensor


On Sun, 16 Mar 2025 12:31:29 +0100, Andreas Klinger wrote:
> Add a new compatible for Vishay high accuracy RGBIR color sensor
> veml6046x00.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/light/vishay,veml6046x00.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.example.dts:33.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1518: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250316113131.62884-2-ak@it-klinger.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


