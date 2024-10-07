Return-Path: <linux-iio+bounces-10277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96D992FB9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C082286FD8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6221D1748;
	Mon,  7 Oct 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icynPHoe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96741DA26;
	Mon,  7 Oct 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312418; cv=none; b=f/3tEmDHhcS67/i/fvWU3NMctHtR1BGQcy4lNEFDWYOjcKsxh4rhz7wjhr2RprU8Ug5aPnYJzV+FjhzD+rAtBf5eYO/GWNQNfFbVfd7iuXbGd9GT6VQ1ngEkpc3XmM5cNJ3kNc1psT5n4e9r2gj+w/1yHbDuWjENoA53Tofq7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312418; c=relaxed/simple;
	bh=te6hFLTS05zT0eZ8ILkDO4EXBOueM9RV2TUahtuJf9o=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=spq3JK1GsdxU4vpxCPJu7Da5WHZ1o/B/pa4cn4REFrn9yaVRPZvJyzNNA9VQkIqWh+FFV8fTC9u9FMRRyHnIaVuUoc3sMhpUo1S00f5/zeKjqbar4kcg9UxXfBD11OKKtMDw3V/zyI7l4aOpGf2jdJ8NJyNVXhI07YteEHvHsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icynPHoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E147C4CEC6;
	Mon,  7 Oct 2024 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728312418;
	bh=te6hFLTS05zT0eZ8ILkDO4EXBOueM9RV2TUahtuJf9o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=icynPHoe+ataw4/EtSYkg8Rr3EeRIECkZBpd52KKVVEbaFQgVeub+csTqpJOR7OXD
	 9CX28srKgi4AdFU54B+vdVjbi6PasbTmUzc/F86g0WltdZILn+5jZIm734DISUffg7
	 T3v67zfVte3oI6lmiruv/H7wJyKelmtkLqttG8mYPit5mE9Nbj8B581bd4Tq4a+UhS
	 /j4S1ByFOcjqcJgFyrJj/PaHn5QPE+B9bmXKv2ljSO3i6NtZhYsVwOnjBwC5gapz3k
	 TCLTC1hopD0YDDbcDUIt6HX17SJEYtLxw/Epehbv8HJZZ8//9mrevQhT4w07DR3D+4
	 Z8uT2sVNAQm4Q==
Date: Mon, 07 Oct 2024 09:46:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org>
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
 <20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org>
Message-Id: <172831241751.297559.15638330476708022279.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: document the
 Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor


On Mon, 07 Oct 2024 15:14:39 +0200, Neil Armstrong wrote:
> Document the bindings for the Allegro MicroSystems ALS31300 3-D Linear Hall
> Effect Sensor controller by an I2C interface, mainly used in 3D head-on
> motion sensing applications.
> 
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss
> unit is not available from registers, thus the sensitivity is
> provided by the compatible/device-id string which is based
> on the part number as described in the datasheet page 2.
> 
> The datasheet is available on the product website at [1].
> 
> [1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../iio/magnetometer/allegro,als31300.yaml         | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/iio/magnetometer/allegromicro,als31300.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml
Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.example.dtb: /example-0/i2c/sensor@61: failed to match any schema with compatible: ['allegromicro,als31300']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


