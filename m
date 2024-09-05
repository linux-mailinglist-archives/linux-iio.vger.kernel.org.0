Return-Path: <linux-iio+bounces-9209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7196DF9F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 18:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A79DB26D18
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6D1A0711;
	Thu,  5 Sep 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQn21NAw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0381A01DD;
	Thu,  5 Sep 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553690; cv=none; b=hxumCIfP6kuQXYCarI/Mr6UAA8n+/VVrjRnHv815xkstnowVR+dVH84reJ+AFtrkbKd2LyCNCmiTOYEaSOYm0K6vwflXHRD0y9AckC1NW5N0gPGImHcK1ld3TiHfJIDDjkb9BNp1X67HagJNjFC8sQ9pXjvap9bvzt9BxyrOhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553690; c=relaxed/simple;
	bh=FP+BVfo2UMegtFvHwfZox0H5CnqyUyzvhJUx4qmnh4w=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=G/xwhPv3Vnd0clxqkNlyfI7a3hRL/9c4wKGaK+zD7fIPDKd6AVePmFmo7fNzh9S6di974nIv6ysVW8FWTCTePFXfnIjyMu7bq1ZlCDLksJk7dy6SYYten09DRCMuh3vgoD4hSNXgjvUz1FOoAFgCBohotPK0gUCgcPoNacXPuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQn21NAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3854C4CECB;
	Thu,  5 Sep 2024 16:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553689;
	bh=FP+BVfo2UMegtFvHwfZox0H5CnqyUyzvhJUx4qmnh4w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BQn21NAwWjjAejx+Ho0HTAOzzCm1oJKRQUAnQQdKi3JGcMENg9epzJUnWBR0Ojav6
	 XFdnvzPrUMO1GfOCutI6pEOZKFK99F+FYwcgmfGQbGSQ9xUuyCYToixFR77cv/Ak2L
	 l1jPWfeZDTcyLX1s1Y4Lllv2MKwUdqukMNCQAQ1IVxgSRAfL698Q+C9LD4LJuH/PMB
	 BUBgwRUW/P5Z+LA7V4po1Kr+3M5HespZ7oKbj1FXJtgODjmfpmHxpRaPBAg5ykZ3ba
	 Q/LC8xPB5pLDlha4dj3uTnLSQECtlIplHIJViCs036tuohh4hZDPJhlOo6w4vaFFOV
	 ilUr/iadk8ouw==
Date: Thu, 05 Sep 2024 11:28:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
Message-Id: <172555368662.2001148.18336732787459313920.robh@kernel.org>
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible


On Thu, 05 Sep 2024 17:17:35 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible for the ad3552r variant of the generic DAC IP.
> 
> The ad3552r DAC IP variant is very similar to the generic DAC IP,
> register map is the same, but some register fields are specific to
> this IP, and also, a DDR QSPI bus has been included in the IP.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dtb: axi_dac@44a70000: 'dac' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/dac/adi,axi-dac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


