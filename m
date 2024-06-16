Return-Path: <linux-iio+bounces-6324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E1909CA0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 10:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7081C20B4A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85C116F0DA;
	Sun, 16 Jun 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evb2ies3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564560882;
	Sun, 16 Jun 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718527210; cv=none; b=QV9D+XwQJx3MH81DhAVQNi7pWkUKFjNKuquyrGap/oK++LEeswe3rq+JwS61mODAMi0azcnTOvqj/oj3B0fuYUwPHKaJnw/BzRC1AfisZe+6gc0fvCg6xjC08l0gPBPJF66LxMqAyX48viIMnZECSk7AVhsVe6ucVuZA9Bj3EnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718527210; c=relaxed/simple;
	bh=EJck7pcx3a7AWGIWc0EJ/f50NGxDWyP4TA3LnCdDUfo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=k8vmEv3x3Xq6VcIMwSmtw5kLVrFdnBkzEZb2XOcjy2uoOHjBdmmrmkmuQ8psuCRju2nJoViZE9zSnqLU4YkxzX4J3qjX0IcXJ6mINGFvujFWVlhHtscx+xrnsDr6CcqXnzEmW/0fAxGVJKgb5KHWU5/S5/T5rN1afssFeF+plzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evb2ies3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14EBC2BBFC;
	Sun, 16 Jun 2024 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718527209;
	bh=EJck7pcx3a7AWGIWc0EJ/f50NGxDWyP4TA3LnCdDUfo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=evb2ies3EJdjn3Sk3UpUyB3jQLlqsotEHAGCzeWSIhYzOOse6CmBMTSnMc32macgp
	 OqgJKW6ip4XLd9amRgMXHZ0opUUT4tIbF56h7quNCGzT4WfmifxGHO7wZbBBSAMntZ
	 NjBMiAt86OIxothjigQfy17s9bZGAj4WecOJcLv7QTo8TdAr/M0inCG++RmVsJ3eC7
	 WjPC5UfBKkpl7AuQadImmOLJaL/shMvV7rvWCjrP42YrrL389E0gtp7/E5lyce/Qiu
	 sWMnLsjFnF/89RBO4ZbPRHanBXVroJL3vo8qkt6iJMaDl092W6t3O1w47fe4r2jnhG
	 piPQcRg1QXbYw==
Date: Sun, 16 Jun 2024 02:40:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: 
 <SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
 <SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
Message-Id: <171852720871.881703.5121305765787069941.robh@kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings:iio:proximity: Add hx9023s binding


On Sun, 16 Jun 2024 15:36:48 +0800, Yasin Lee wrote:
> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
> A capacitive proximity sensor
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/iio/proximity/adc.yaml
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:35.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:39.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:43.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:47.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:51.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:34.23-37.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@0: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:34.23-37.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@0: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:38.23-41.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@1: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:38.23-41.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@1: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:42.23-45.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@2: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:42.23-45.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@2: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:46.23-49.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@3: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:46.23-49.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@3: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:50.23-53.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@4: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:50.23-53.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@4: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@0: False schema does not allow {'reg': [[0]], 'input-channel': [[0]]}
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@1: False schema does not allow {'reg': [[1]], 'input-channel': [[1]]}
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@2: False schema does not allow {'reg': [[2]], 'input-channel': [[2]]}
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@3: False schema does not allow {'reg': [[3]], 'diff-channels': [[1, 0]]}
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@4: False schema does not allow {'reg': [[4]], 'diff-channels': [[2, 0]]}
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


