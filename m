Return-Path: <linux-iio+bounces-22957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B674B2B293
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5901BA1D66
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA53451B8;
	Mon, 18 Aug 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F48c6cvu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A21E51FB;
	Mon, 18 Aug 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549608; cv=none; b=orkvDzg5PdfVSy96q52LR6svZoUBM8FiE48ZoRigb48oXS3E9qa8bcMBgzKncQvmtwaz9BtSdTkr8oEVLPilH26O740o3pOiSXtmS9VstBA2AHHlulF1MsC0vCcvYrThod7juk2PExSJoZB6OqvE3DMLdjQtb+feF8BWg+DszMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549608; c=relaxed/simple;
	bh=un6CmlBb/KnBLBtbb+poL2wvc72CZRmrv9rVkcCejRI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=K8oti71bRR7XazZ/UiuAf0AQjAj46Y/0qHB5hk8l7vHSe1Ftke/rzF6WC9wO48v2BA5MtAk9swTVt3d0BvDZmSOHFNaYLGsvI1BKAZQ8VVXFk6T9QKRfJhbiUHa1LUah+CUuHHZh67hkWOAK54VuM7KWnHdhTaj3QIP+n25oIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F48c6cvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0800C4CEEB;
	Mon, 18 Aug 2025 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549607;
	bh=un6CmlBb/KnBLBtbb+poL2wvc72CZRmrv9rVkcCejRI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=F48c6cvua4Hr3EP2rHqDm7erWdjBVXc5xe123OabjflMPKJPNuGY9tb4Ke0I7SaQJ
	 NdqiylJf3qy+Hjw5zCjhe43kkyp9dCc1qM0Tztv3LRiU/nbAUE8JXblyGEDYhKfrl1
	 tF/UZ7nvt1DXCJtDa9zYhdUWYT95Fb1kYyqsa4q0zOJ84UscbK31yUCpG+b4tACCqx
	 a22S2x8LEAJrTOVj7GXcTZfPTKgTtSDCYspcb82YjfKitRpxyYoRm2/BT42aj0u2rc
	 YAge4KyCRNdd9pWhzrgBWa0IFaTjenF7Rt34wIdn1H0LBGRCd5Or9pAuRgJJ20jhcr
	 IiMh++A82R1cQ==
Date: Mon, 18 Aug 2025 15:40:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Ben Collins <bcollins@watter.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 Andrew Hepp <andrew.hepp@ahepp.dev>, Jonathan Cameron <jic23@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ben Collins <bcollins@kernel.org>
In-Reply-To: <20250818183214.380847-3-bcollins@kernel.org>
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-3-bcollins@kernel.org>
Message-Id: <175554960690.2041403.1071082388209698923.robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints


On Mon, 18 Aug 2025 14:32:10 -0400, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> Add microchip,mcp9601 compatible in addition to the original
> microchip,mcp9600 to designate support between these two chips.
> 
> The current dt-binding has open-circuit and short-circuit as interrupt
> names, but these are only supported in mcp9601.
> 
> The OC and SC detection requires that mcp9601 VSENSE be wired up, which
> not only enables the OC SC interrupts, but also the OC and SC status
> register bits.
> 
> Add a microchip,vsense boolean to show the chip is wired for this
> support.
> 
> Add constraints so this feature only applies if the mcp9601 compatible
> is selected.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  .../iio/temperature/microchip,mcp9600.yaml    | 60 ++++++++++++++++++-
>  1 file changed, 57 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml: properties:interrupt-names:items:enum: ['open-circuit', 'short-circuit', 'alert1', 'alert2', 'alert3', 'alert4', 'open-circuit', 'short-circuit'] has non-unique elements
	hint: "enum" must be an array of either integers or strings
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250818183214.380847-3-bcollins@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


