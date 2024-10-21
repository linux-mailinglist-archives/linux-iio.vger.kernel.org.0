Return-Path: <linux-iio+bounces-10910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836239A9203
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4493A2849BF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803621E231A;
	Mon, 21 Oct 2024 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqrDGz5V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163E1E22FD;
	Mon, 21 Oct 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545736; cv=none; b=SoRejCCesSxLoEtT9i+y8fkcW2sW9jXQYG3pg01ynmPr6/EUWGm9MzysD0FER+ifMT+DqQ4QkKTwlzJq2xvlVF+qBZ5Q1h5IWzYMdI2sQOlyznXAybxMUfuvj4Y2MV+WnaS18luuFI5UlHILl/kSsb/H3kiSilyCLZ6sW2rBHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545736; c=relaxed/simple;
	bh=45vqd/WdYUHXFm4JwoaKUVJKi2ynKYo+Eajdvm8ssNw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UitFK2m0jk7dcfCbFgd6dJH3eh50kh8UudR1dP4yOAqcMwvRk3zt1yQXaG47/WmcTEN52+V6TaucrWHKgLcF8RQv0vy0TaOUnglM7cgknNfAn890J64wkzhI15rjUGl9S2olPjHsRKWo3JnXAiipPz5WWYXlKVTWa06eoX9wfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqrDGz5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4A9C4CEC3;
	Mon, 21 Oct 2024 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729545735;
	bh=45vqd/WdYUHXFm4JwoaKUVJKi2ynKYo+Eajdvm8ssNw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dqrDGz5VOvzee1EKQHol5tVprwJtiWV0J745BItnTQrhka7U4M1pejCc4340Ama/h
	 NeNRkQ8EgR2Y5WI1/eBgwsqPVgICsj8SKctwVT4rPZVMXE/x//+qM8STipfkLbLH3L
	 9UHwCtef9ss3aALxBDWDkQhZY9V67JkhBbyJw+ecWedL3t6usXNu25ANeF1+RqIg+T
	 6BYaMZ/jzRef3EQ2I4f8BeE6cV6e5FzXD+qXzpcfAWew5eJ3gPfk2J3W2p+J2N4Kq7
	 JkLVFn7BLo1cgRbDl2BjNYne0a/O2JZni/7YcbpQ5BVGncfEFYeO0CpnEse0pm8590
	 TK2qkvOvmktHA==
Date: Mon, 21 Oct 2024 16:22:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andriy.shevchenko@linux.intel.com, krzk+dt@kernel.org, 
 linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
In-Reply-To: <20241021195316.58911-12-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
 <20241021195316.58911-12-vassilisamir@gmail.com>
Message-Id: <172954573446.1279869.6203749214462845887.robh@kernel.org>
Subject: Re: [PATCH v2 11/13] dt-bindings: iio: add binding for BME680
 driver


On Mon, 21 Oct 2024 21:53:14 +0200, Vasileios Amoiridis wrote:
> Add dt-binding for BME680 gas sensor device. The device incorporates as
> well temperature, pressure and relative humidity sensors.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: sensor@1: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: sensor@1: 'vddio-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: sensor@1: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: sensor@1: 'vddio-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/cirrus,cs42l43.example.dtb: sensor@0: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/cirrus,cs42l43.example.dtb: sensor@0: 'vddio-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241021195316.58911-12-vassilisamir@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


