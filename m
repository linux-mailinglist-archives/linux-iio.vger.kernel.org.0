Return-Path: <linux-iio+bounces-5467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABD8D3D5F
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 19:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F2F1C23653
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385271A38DE;
	Wed, 29 May 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNTPFFSQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED0A190670;
	Wed, 29 May 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003557; cv=none; b=fuqhaYa7Vmbk/8Dz46K7cfapkerqBstKgkyJjtYGUP+e/r2B0T0w8kzaPU7GwrlV1ynmWG2suHGJjPlvRf86nxVr77wT6URzUtZCC7OOmkbNrAtIjdFCmPHdhnmHRDnG7NE/F3RFy+9c1MeJz8Vm19WlxDzUJkYn7xMqLM6PEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003557; c=relaxed/simple;
	bh=8tVnrbrULFC79MkPLZU1HT1MRwI8OsH31Ws918LV0sc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Vv+KdkHI9qU2sP2mv+kru44DQMtHVquCDfi/2upmFpUmzNTP5FvUZdQduOjUIzes98oTV/d6BapaZnMOdA+FC08Eag5FXfAZRQRZa/nB7kzg6r1Q2YREfUNjnT5GgMYzdvOwgr95Cg3ZDwbfJxzPek2gB2ExXEO0ugvmElnl9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNTPFFSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434F7C113CC;
	Wed, 29 May 2024 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717003556;
	bh=8tVnrbrULFC79MkPLZU1HT1MRwI8OsH31Ws918LV0sc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dNTPFFSQPMnC/j7QCac9tJIdCCbEGiHYrpe6ckmgmZ9gAn1OuHqTVrBoHieyqmjvg
	 w5tdLUt/ECHAsYOYFKOWAwXLX10anrzxH4Ej0sg/YBwEh9fnwMWX8HMqAd/WcOobXQ
	 8bQV3l4AZOXgmxJITb2aak4XAbRGxMYzvRJBD2bW0AX8kfTD9CCc8mKXIeQ+gcpJT3
	 r21Fw7xyQWS0UI4X5IW/UAJCEvn0JIjdFDHOceNsdfIWzcHyjLA7/BTvN0YC4nN9LJ
	 87quRzlf7PNBczfnCtZvV86OPjzPE0TUhlomvLOgCbWnYiwp8FqEvomTaP/odflnMj
	 6wydnhTexk3Sg==
Date: Wed, 29 May 2024 12:25:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: ranechita <ramona.nechita@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20240529160057.6327-1-ramona.nechita@analog.com>
References: <20240529160057.6327-1-ramona.nechita@analog.com>
Message-Id: <171700355516.3194061.3370825262697979106.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: adc: add a7779 doc


On Wed, 29 May 2024 19:00:52 +0300, ranechita wrote:
> Add dt bindings for adc ad7779.
> 
> Signed-off-by: ranechita <ramona.nechita@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
>  .../bindings/iio/adc/adi,ad7779.yaml          | 89 +++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7779.example.dtb: adc@0: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240529160057.6327-1-ramona.nechita@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


