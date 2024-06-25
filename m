Return-Path: <linux-iio+bounces-6917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BA916F4B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 19:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279C0281830
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1421178CEA;
	Tue, 25 Jun 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDha3Mc7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB717837A;
	Tue, 25 Jun 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336682; cv=none; b=ZE0tpYyeEhmJ0G6YS084aBFjsD9bk0Li/GWsXlzI27u5pML9NAH4xu5gvKNnsXLIHJx5v3nS8y+lW4hCFPKR1Jm7dsvigd5vDI29y3Hi/byUKjzwvSMHzz5aGUquEdTMAvQhVljwhZB9TAfFFzjMXJgeyRL5SHskD1+9XPDJ4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336682; c=relaxed/simple;
	bh=kHUi3Glz4/PPYP+tK0uqIXjQ/5/ZN+i50kgrI88ZFJY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=aW3YPmeN+tmKAZSO5qSHrZvdaGR0YT3vvD/054QV4kWawOH94GNgPc3PgiqFQDJtwKOENkOev7KIhVjy7muqo49+vvehvq6aeoR2JJMMXvjWrHyIrnL6ELmZOiUJ+n1VnRO2gaRhBss6328lY6bpfV58zACuf0eHnvq7prp7Eyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDha3Mc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E26C32781;
	Tue, 25 Jun 2024 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719336682;
	bh=kHUi3Glz4/PPYP+tK0uqIXjQ/5/ZN+i50kgrI88ZFJY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iDha3Mc7e1EnXsShwZM34VzZxT73ZEqVU1fcqEp5ul8RpW4X8NbqcoTTjaybEXfYK
	 7s0Os5QF697KdO3JqD+f20aD/+ANmQwd75mIpPRsemu6dYo6JNNvVlVXslY6aMkg4r
	 rYi7oVRLrQiZMzkWBeTZl3+rDVbhow/ZizrO3+eMiShJb50MpTWLb+pHsjY8Xv6wMF
	 x6RJWpYY1ds/kkzH9iPehgxV+kkr4c+lFY6zwtH2TkvTL3xk5jG4WEFnEcSVvvXvJS
	 cnR1czIzp/uUrzbsdZZE48AS2ntI5fwJrAgWrH0C8U1f8BydtzrVu+b5p5stm8RDph
	 6qT5fWVnFJA0Q==
Date: Tue, 25 Jun 2024 11:31:20 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: linux-iio@vger.kernel.org, yasin.lee.x@outlook.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v8-2-0c224e3bddbc@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v8-2-0c224e3bddbc@gmail.com>
Message-Id: <171933668079.3655439.16090706511349678205.robh@kernel.org>
Subject: Re: [PATCH v8 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S


On Tue, 25 Jun 2024 23:58:53 +0800, Yasin Lee wrote:
> A capacitive proximity sensor
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 93 ++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@0: Unevaluated properties are not allowed ('single-channel' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@1: Unevaluated properties are not allowed ('single-channel' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@2: Unevaluated properties are not allowed ('single-channel' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240625-add-tyhx-hx9023s-sensor-driver-v8-2-0c224e3bddbc@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


