Return-Path: <linux-iio+bounces-19285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A4AAF881
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A801C064EF
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477021504E;
	Thu,  8 May 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtiw1Fe3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC213635C;
	Thu,  8 May 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702675; cv=none; b=jszkezSLdXDJubK6PEbzrcIVgBq1relRnHVU/ORQtiqbKV++1ZoLTqDCvEhQwQdE4maIZ+rhTwd2jRfjKpN7jXT3969tmMEQ55STYkVvgq9wkwM7v0MYlKmBqKLPu0VWcsjrlPYpkuWYNZZ+ZHfIn3RsJxP6+Xn7xUXfTQa7MfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702675; c=relaxed/simple;
	bh=PocAb1ppw+OcP7W7z0BpynnnsbupAp/hFOdPCA203F0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nd0Vv+fFT5MvTpj9wl/X+4+3LpElk8q2DnVcmHjRPyHxk6GreD3rTx7ZzmMT4XsFdANUOO+z9HvPcpVCJnvdyN/Ks7WFLoQvqjsi6gJcmz+Jc6j4IWLyhx1unAWa/uGm4q74f7VvKQp1/meE1WS23oCXXXWeQq7Seh0w049y67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtiw1Fe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4F6C4CEE7;
	Thu,  8 May 2025 11:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746702674;
	bh=PocAb1ppw+OcP7W7z0BpynnnsbupAp/hFOdPCA203F0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Vtiw1Fe393DXA/Qmf8g6GOtvL8Wd/KgC0TL/xj52C0LGKFcmFIp6SmEPN5XwsbbQp
	 PdPSNEdpy79QCoEU62qiyOp57rQbiEj4MUd93a8tI8UYyOgnEOfuTOXp9o3dSFD4e5
	 aLUmlWHwSJnQ9PrSOY63CGNshy9t3zLR+UIKcDWOAXwjKr/BU2YXAZcQgTrc9hEzhx
	 RGVf+1VZt6y3rGWe8v7pidNAy/VcCm6jNgddtdnMGlWW49GpEWEc81USID6WWPixej
	 f3n/1VMGb8YQOQ5FIYzuuUg455DC4vsRUqpF4MLmZaDKAkhzR9I3Z2quxVuavXNae1
	 uV8MlAxhPuhsA==
Date: Thu, 08 May 2025 06:11:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
To: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com>
Message-Id: <174670267187.3889412.7858960687511929039.robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support


On Thu, 08 May 2025 12:06:08 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support by a per-channel resistor value.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


