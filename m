Return-Path: <linux-iio+bounces-18398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A9A94C1C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 07:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A72D1892608
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 05:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1521D596;
	Mon, 21 Apr 2025 05:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDwB31So"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3B2AE8B;
	Mon, 21 Apr 2025 05:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745213327; cv=none; b=YZeNvq1ACMDUuhKuWb4KuTHgB7kRxhQjBNFoiMiCx1swiWIocmBaOvVjJMu80qWc82ZtAktxyPKokUu/fhfc1QeGddSG26VLnyP8pNipuZbt/hFX/GBaKB2npH0KRgJOTHy51GX9X6heurpG2ydLjseztx+Xq6gDmJxjpt5mQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745213327; c=relaxed/simple;
	bh=uDN90Jh3qTdoUiZiE51fTLRRcZklSjWs9RKA1FR0koY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=F8YBhMEhJFdpFTp2qz5QtUhyi3GP14jZ4EW1MwTbd24p5n/JRTTyRcA3bJDocik5DQpE4oE/kFpeCxaDTInEtnjVpX2+q1N9N9LnJEkdfJljMO6gmZQ6G9rVU+eOZLiqRNwuXMJBPLa0eIXZiF2PGYch2WkLMKE96/pYU8Ri440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDwB31So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AB0C4CEEB;
	Mon, 21 Apr 2025 05:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745213327;
	bh=uDN90Jh3qTdoUiZiE51fTLRRcZklSjWs9RKA1FR0koY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qDwB31So19tPevXrXM8Qea9Gj4MtoDxXu94Oi8s8Rvi7CxKIFlzd1CpBVfttBqBmu
	 xJa7okEGP6I0/PmwVHMfvzhoIyICN9VBp+IO7POutl27hIWlRg2GAGuqmY1B5PHyq9
	 Ef7nGLZ22g6mx1Fm+y60pZnPu53zRCMngBVHHpYwka/E/jSDe9QK8G7N5l9IwGC121
	 ucLPm4E8v/Fjvi5yYIlzPmeMyGUmIhr+A+RUHdxReRnU1kTdhLAk5YxcLl30RSXvp0
	 VRUg9GYwkjCLmvgcMTkpSXZ/rlxunYblECGkHMk9lPh1hwmXEbl6WEO5AWkTviKtGs
	 nQa5bWPh+T4VQ==
Date: Mon, 21 Apr 2025 00:28:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
In-Reply-To: <20250421-togreg-v5-2-94341574240f@analog.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
 <20250421-togreg-v5-2-94341574240f@analog.com>
Message-Id: <174521332490.692661.11314304172212857611.robh@kernel.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml


On Mon, 21 Apr 2025 12:24:53 +0800, Kim Seer Paller wrote:
> Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel)
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls. They provide full-scale output spans of 2.5V
> or 5V for reference voltages of 2.5V. These devices operate on a single
> 2.7V to 5.5V supply and are guaranteed to be monotonic by design.
> The "R" variants include a 2.5V, 5ppm/°C internal reference, which is
> disabled by default.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 100 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 ++
>  2 files changed, 107 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/fsl/fsl,ls1028a-reset.yaml: maintainers:0: 'Frank Li' does not match '@'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):
Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
MAINTAINERS: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250421-togreg-v5-2-94341574240f@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


