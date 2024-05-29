Return-Path: <linux-iio+bounces-5419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12928D2A0E
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 03:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B62DB2300E
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444315AAB1;
	Wed, 29 May 2024 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psB1Cnph"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13E1B974;
	Wed, 29 May 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716946976; cv=none; b=RRCBab3dfHQNIPiU5+qMTpeC8SBQReDvalIHkyn/tHwjiQRJAgNkBZQIAp8Xv06gKQIAxX24U+HLQmg0I4ZxHhOy3dyn3NmzDLgrRq/QWOqhtBzU4HBnbWXj+OoLHkksynaRfbJUsOjfLRQC9GpzIBW8TB62KzBJyr5b86g8p3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716946976; c=relaxed/simple;
	bh=sE0gJI150ZuuQbrkcwTftnClRrSe8hDjT2tlkzJFjwA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SWYXNL6CKlZ3YxeYDJZt4rgQk+ZdnteKUrGkIHKgFoHuoj2BMJ/BAetOu27b+rua8ptpPLSwjnHeyBGxoUD1aXaZBX3yRJsdD/6emH8T3gCp/amSpAXFkF95WFr3Qkrl/kkflvxHE1Ot33/YanQKDaWLkDApo+Od8C8f0OgyqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psB1Cnph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D698C3277B;
	Wed, 29 May 2024 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716946975;
	bh=sE0gJI150ZuuQbrkcwTftnClRrSe8hDjT2tlkzJFjwA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=psB1CnphOJvhC4iVuMJ5WSTxxJ+8oKzUJlM5u0h+5ZzdZjUBoGnChk5vWIBMZhgWg
	 yGk+uFkAxclxqX9wsO2TxM4GXxxuCsXRMjIQarjN4shXv/w7fAq895YzFwRJHQemrz
	 DgMFCpA4NN8ufZDjPYi78GCdahk/4GcTigilxgshFlNCmPSfyiVmLY2KdTvtuMTqY5
	 Ygalskh/fxLqcv4w1SpFUA64RxcCxOiI5nrXv37CGMLD+RYID3W02UX5HETUrusl65
	 Xwah4GvoAjyiquBqeFX5xf9f/XqD8equRMJGJq6GjpNCYw1UNixjQOhUsEf0KzLyIb
	 qJAO99x0AD28A==
Date: Tue, 28 May 2024 20:42:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
 devicetree@vger.kernel.org, jic23@kernel.org, conor+dt@kernel.org, 
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
In-Reply-To: <20240529001504.33648-2-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
 <20240529001504.33648-2-gustavograzs@gmail.com>
Message-Id: <171694697450.2956310.4053503259175533537.robh@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: chemical: add ENS160 sensor


On Tue, 28 May 2024 21:14:19 -0300, Gustavo Silva wrote:
> Add bindings for ScioSense ENS160 multi-gas sensor.
> 
> Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
> changes in v2:
>  - Add devicetree binding file specifically for this sensor instead of
>    adding it to trivial-devices.yaml. This is needed in order to
>    document that this chip supports Vdd and Vddio supplies.
>  .../iio/chemical/sciosense,ens160.yaml        | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.example.dtb: gas-sensor@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/chemical/sciosense,ens160.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240529001504.33648-2-gustavograzs@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


