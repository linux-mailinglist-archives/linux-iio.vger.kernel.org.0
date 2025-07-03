Return-Path: <linux-iio+bounces-21297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FEFAF75F6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598473AE63A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C828C2D9482;
	Thu,  3 Jul 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3EaC7pG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB382222B4;
	Thu,  3 Jul 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550115; cv=none; b=jLx52m/FEOTElbgGCTBzB1Ozy6zYYKyPy9G4EKFyLd0eGB4oypokQXVoFovOzP+mE/XT9kQJ9IcPZGev6le6xZzugLPr92u5SDGm50JhHv5maBrEhm8KEOhCfd8D5Ql8hrEXhIcs1YJQh828/44rmoH6RygLjLbx9Hgpjf8xY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550115; c=relaxed/simple;
	bh=AzCyOeLYvvkd8ESz+bYjZcDSyDUTK6UgemqQUMKPmC8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qQBaU2bnCGLTjLEdsbgb98xZUs53nypw3fn1VVJ+QmND+epKxsjdZUu/PgvtVtK7y1ptVOwCcnSOFQjQkDx8BV4uSUi7O3lm+1w0TOOzyPiWK/SpvZ/ooZvrjy6GozGG81IVH0/kHWhmhWo4y0aLtKftkaSIB3dMJEEzC1vPGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3EaC7pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8872C4CEE3;
	Thu,  3 Jul 2025 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751550115;
	bh=AzCyOeLYvvkd8ESz+bYjZcDSyDUTK6UgemqQUMKPmC8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=O3EaC7pG9AYMtZ1GnmxlMDAujjKd2jjjy8oV9NgoYzH33twFw/sto/xm7oA/kF4wm
	 QKXDolNstpowlpxlrxtFoYSELRJCAvHsmAyB9bIO4x0OOcS3jLkwCJPhzS/Xh5rqgz
	 hk1vVueopNKfKZwerZQwRC1wTfPrEKXOhzdgvICHl5lxnT3QGCcSpRVfZwU2Yvpf2P
	 gwlN76MM4FZmH3RjfneQUsu52PA9EtUPDjDJyOSwwjbtj7GzYI4Hl0r3FlkazbeZzQ
	 YrlMpFfSPcWldPwJK0mnkJCRlSXQFfqiCuJbJ6NKbsa+4YwMgk3ttTtcbZ6Kkg8s4G
	 1KS1rB+xP+p8w==
Date: Thu, 03 Jul 2025 08:41:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, nuno.sa@analog.com, conor+dt@kernel.org, 
 zhiyong.tao@mediatek.com, matthias.bgg@gmail.com, linux-iio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 krzk+dt@kernel.org, andy@kernel.org, 
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org, 
 dlechner@baylibre.com, jic23@kernel.org
To: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <20250702214830.255898-1-olek2@wp.pl>
References: <20250702214830.255898-1-olek2@wp.pl>
Message-Id: <175155007600.1164337.2694125057173487421.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add thermal sensors support for MT7981


On Wed, 02 Jul 2025 23:48:28 +0200, Aleksander Jan Bajkowski wrote:
> This patch adds support for the temperature sensor in the MT7981 SoC.
> This sensor is exactly the same as the one in the MT7986.
> 
> Changes in v2:
>  - added fallback to an existing compatible string
>  - removed second patch as obsolete
> 
> Aleksander Jan Bajkowski (2):
>   dt-bindings: iio: adc: Add support for MT7981
>   arm64: dts: mediatek: add thermal sensor support on mt7981
> 
>  .../iio/adc/mediatek,mt2701-auxadc.yaml       |  1 +
>  arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 32 ++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> --
> 2.39.5
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250702 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250702214830.255898-1-olek2@wp.pl:

arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: thermal@1100c800 (mediatek,mt7981-thermal): compatible: ['mediatek,mt7981-thermal', 'mediatek,mt7986-thermal'] is too long
	from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: thermal@1100c800 (mediatek,mt7981-thermal): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt7622-auxadc'] is too long
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
	'mediatek,mt2701-auxadc' was expected
	'mediatek,mt8173-auxadc' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: thermal@1100c800 (mediatek,mt7981-thermal): compatible: ['mediatek,mt7981-thermal', 'mediatek,mt7986-thermal'] is too long
	from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: thermal@1100c800 (mediatek,mt7981-thermal): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt7622-auxadc'] is too long
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
	'mediatek,mt2701-auxadc' was expected
	'mediatek,mt8173-auxadc' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: thermal@1100c800 (mediatek,mt7981-thermal): compatible: ['mediatek,mt7981-thermal', 'mediatek,mt7986-thermal'] is too long
	from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: thermal@1100c800 (mediatek,mt7981-thermal): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt7622-auxadc'] is too long
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
	'mediatek,mt2701-auxadc' was expected
	'mediatek,mt8173-auxadc' was expected
	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#






