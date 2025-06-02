Return-Path: <linux-iio+bounces-20139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C8ACADEE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120F73B9A23
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9B2139B6;
	Mon,  2 Jun 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH8P+s/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DF17485;
	Mon,  2 Jun 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748866982; cv=none; b=aqVQJimT1I9pVdYoaxORxmAy7/5nIaLpaifpla2N0tBmuKmD1uT/CP/aWEbNvqoXmmrqvMMhdLm/dPcXf4ioED48TK3+hPA6V4a+JMOWYW4fFaUOW1lfg5xLKOZtfH08MWkcpMfIUPxtWRPD/78orl9FyLh+kq/+Cu5vsJq1qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748866982; c=relaxed/simple;
	bh=LrpYnWwRqQ2fm/LULB92EX1rn4RlP8w3zOCG97Ytfb0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=q+M99lU5sLzCuutkg5EI0Kx0OJke8xL8eEJmHIPKMZa9kSQRBHkHMxWvUhM8FHs3aRxkWam0jd+fTAmdo6XEt5Py6b0jjSw1bDPh6U+MxdglX50Mu/qL1BynPAGSvAcO6b2UGy8BHe2Gu5yIIYr+H2vDE+B0C6hEQOfTn5XXF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH8P+s/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5406C4CEF1;
	Mon,  2 Jun 2025 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748866981;
	bh=LrpYnWwRqQ2fm/LULB92EX1rn4RlP8w3zOCG97Ytfb0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=XH8P+s/6uHV0G/AUxM/CUAKy1Bx8y4n7STCn3MNsw0QSUv7jbkKemEwBZHZLi7GSe
	 dlBoxSiFnVxEJxMXlnIOQ73bJK7QkaF6ZL8Q01gt9h2Mp0QOr0w39M74LrRKT9LWeF
	 kWdtqAuYJWRLUFLiy756cCW0xwmRbgxuBGhrZzFo12EiMtp+hke6HR0iDxp0KeoYPN
	 ytVlyyppkVOJVfXlmaEAdzFEVANeiRL85qP+GI8FBfFgdtHju/rCyQTPAJLov/5ftD
	 iF/Qmg50PcpKbL1xXRbdSoDLZYSfkj7dr4c+rJrEFiwXlIBYpHbwup1VzlLVP99Uo8
	 MZ6ZTPKpkE04A==
Date: Mon, 02 Jun 2025 07:23:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nuno.sa@analog.com, andy@kernel.org, linus.walleij@linaro.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael.Hennerich@analog.com, conor+dt@kernel.org, 
 linux-iio@vger.kernel.org, brgl@bgdev.pl, dlechner@baylibre.com, 
 lars@metafoo.de, marcelo.schmitt1@gmail.com, jic23@kernel.org, 
 krzk+dt@kernel.org, linux-gpio@vger.kernel.org
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
In-Reply-To: <187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
Message-Id: <174886697998.948762.16527380744873036141.robh@kernel.org>
Subject: Re: [PATCH v4 01/11] dt-bindings: iio: adc: Add AD4170


On Mon, 02 Jun 2025 08:36:24 -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4
> - Dropped sensor-node and most of defs.
> - Updated external sensor props to have similar name and type of adi,ad4130 ones.
> - Added constraints to properties related to external bridge sensor excitation.
> 
> Some explanation about the constraints to weigh scale sensor types.
> 
> The predefined ACX1, ACX1 negated, ACX2, and ACX2 negated signals are used to AC
> excite external bridge circuits and are output on GPIO2, GPIO0, GPIO3, and
> GPIO1, respectively. If only two pins are specified for AC excitation, only ACX1
> and ACX2 (GPIO2 and GPIO3) are used. Because of that, if AC excitation is
> specified/requested, then those specific GPIO pins must be used with the bridge.
> Otherwise, the bridge won't get properly excited and we also cannot guarantee to
> avoid short-circuit conditions since the level set to GPIOs to DC excite the
> bridge depends on the GPIO number. See AD4170 datasheet Figure 113 Weigh Scale
> (AC Excitation) for the reference circuit diagram.
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf#unique_149_Connect_42_ID10354
> 
>  .../bindings/iio/adc/adi,ad4170.yaml          | 543 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 550 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml: properties:interrupt-names: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


