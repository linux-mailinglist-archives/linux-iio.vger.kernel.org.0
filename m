Return-Path: <linux-iio+bounces-10430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A455999AFF
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 05:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AEE1F24CED
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C611F4FC8;
	Fri, 11 Oct 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8tUypdu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37E1F4FB9;
	Fri, 11 Oct 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616275; cv=none; b=eR2vT5vFj32eUS8ulBfAD6nBf5iSYSi7j/sN8iz9gG/v2C8zqoY8MEzHBQfjYzzow6oo1ciMmHWV9oGMiL9+NYDSNhuXH4T/scAgIDpUTMR4QGPgTjB4daqDaj6de65TXoYNbAJEDM59gxvARuxDWbs4HeloWhUpihHNA1M0A74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616275; c=relaxed/simple;
	bh=N3UykCTaRrTYwxU3/xeGjMWLjrkk12M55Cpmv1W+/1Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gqNNNOzpphzYbAji5amvUDtAY+b3Elnm+LoKKuAKPoY0l48jTz280+uw4ehT0m3SG74AdYjG5JRl3D97Nt5WL70KaqXM7IrdP2FlSIsGhWhcIWIfUw4OLB4nkro0I5RHJMoV4wNgmM8ujLBjHZN2Ph1aNK5UUGQlUb4mCpXWvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8tUypdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539C5C4AF0B;
	Fri, 11 Oct 2024 03:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616275;
	bh=N3UykCTaRrTYwxU3/xeGjMWLjrkk12M55Cpmv1W+/1Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=n8tUypdu5W2IaZxlSRmby87GmktxZxpu5tdQhs4hBNmoAjhQflDBcV/AMI9T0xBx4
	 +YTnkFzuu/VRawfLl8u9ZBUCsS2PgDwcI0ZacQahRCjiMzx3LQuAriAhp8gWfFGIJm
	 ZZrpniOZ/utBo/nx+tGx2yhE24FT9h7BE4WCKSoTTJI4epeEx7yX66CSrkcJr+sjdG
	 S/pYwZ/myLldDuT/aPc8NTErk8y83+4GTJr5QG56iWoNoDfcEnmfvaPgphrd6V+OzZ
	 WTJLWmdhUqoz+2a9sMwxlpIrMzsDpC28WJCQcVRvmeJB+z1TG9D+ae8WGJEuOstbxE
	 3qKI1lz7p9blQ==
Date: Thu, 10 Oct 2024 22:11:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: vamoirid <vassilisamir@gmail.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 andriy.shevchenko@linux.intel.com, lars@metafoo.de, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, anshulusr@gmail.com, jic23@kernel.org, 
 linux-iio@vger.kernel.org, gustavograzs@gmail.com
In-Reply-To: <20241010210030.33309-7-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-7-vassilisamir@gmail.com>
Message-Id: <172861627372.2232837.13116431310317751211.robh@kernel.org>
Subject: Re: [PATCH v1 06/13] dt-bindings: iio: add binding for BME680
 driver


On Thu, 10 Oct 2024 23:00:23 +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add dt-binding for BME680 gas sensor device. The device incorporates as
> well temperature, pressure and relative humidity sensors.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "bosch,bme680" found in schemas matching "$id":
	http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
	http://devicetree.org/schemas/trivial-devices.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.example.dtb: bme680@77: 'vdd-supply', 'vddio-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.example.dtb: bme680@0: 'vdd-supply', 'vddio-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241010210030.33309-7-vassilisamir@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


