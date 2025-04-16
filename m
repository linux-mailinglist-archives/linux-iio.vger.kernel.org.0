Return-Path: <linux-iio+bounces-18165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431AA8B828
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 14:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807F63BEA5D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5DA24A066;
	Wed, 16 Apr 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IlNHCSko"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B62472B0;
	Wed, 16 Apr 2025 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804963; cv=none; b=WIfz9V/lph8WCgXX19xNX8XRlo20Sd/moHAUO5IqGac30uCHG2fpmondfsHZFuC2HEmwnLwToLRKjXbRF84sq9Hqj6+9FzduXSaCmnUosVWG/954aYli/HlDvUd2HMZKG/WmOOE9hxiVQwVycXh5gHcvS5jkxbfycARE6fH+aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804963; c=relaxed/simple;
	bh=8Txu466c/6xQlElQq0otpMS6pP2mfPlFbhrON1pbh9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PG1i2QNjzQ3IoqmjXrukfZiqPYw6UHyUIWyvnESEYZcBsMgEeQ7P3qbNEE3bzvgEko9EEpiwyhMsHZIgObMRXoTolQ/El8HtNvUtJ4jM9Jw3HQdBubscqzxKXhHn9bsJhsVBVhmbTZLEhHg9HBuASVxe0NyCzy84iXtHv3+y1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IlNHCSko; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744804959;
	bh=8Txu466c/6xQlElQq0otpMS6pP2mfPlFbhrON1pbh9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=IlNHCSkohp9fm4csX2yQMa/YT6wSK7G/Hi+7IYLr3nYmt4lfyRGgOvTVbhqJfJpHA
	 X1TUQOZ29gEP/7R6xW3rx/7s7GvAEs1TwBkTnuGOCsmTVH2tMLBj0nF8TkcckklEZy
	 aqxC4KTuDOukEYluEIEMtfiuQqIH6fq/43ZUZ/EDHQ+V/D3cZ/zHiZOSEPS76Iu76V
	 1f4D1TvfiT6STv3EVRM0d/asyfhpoEJIHjc6QTg2p1WfxWjMZHjjZZM9S2JmxkunmD
	 1KYsxaOlPe85y0fNkD3p3alNLZmbSHH5tp5bqa26u1JkjrfpewjUCyBzET4uTZ74zq
	 O6xvGafV+Pc8A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5376817E35EB;
	Wed, 16 Apr 2025 14:02:38 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	zhiyong.tao@mediatek.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: iio: adc: Add compatible for Dimensity 1200 MT6893
Date: Wed, 16 Apr 2025 14:02:35 +0200
Message-ID: <20250416120235.147889-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the Dimensity 1200 (MT6893) SoC; The AUXADC
IP in this chip is fully compatible with the one found in MT8173.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index 6168b44ea72c..b489c984c1bb 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -34,6 +34,7 @@ properties:
           - const: mediatek,mt2701-auxadc
       - items:
           - enum:
+              - mediatek,mt6893-auxadc
               - mediatek,mt8183-auxadc
               - mediatek,mt8186-auxadc
               - mediatek,mt8188-auxadc
-- 
2.49.0


