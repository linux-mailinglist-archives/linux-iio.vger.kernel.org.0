Return-Path: <linux-iio+bounces-25625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D01C1BB55
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 16:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7956F5A0CA3
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132C33B6E4;
	Wed, 29 Oct 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MTnCWUVI"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DE2BEC30;
	Wed, 29 Oct 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749589; cv=none; b=PTB7nk1a38ut8DeRwEZmivS5pkIh5zmkn32qKCNIYQ5hCPbgfvcbqzibVPySRfF198ABbT5R8HHpjeR6vat6RsWa9we72ymulvDpd3Ssmpvs4iKYFNysd551VmKsvpwMfElCIQfnE4xThsoPASfDpz4+phxkmioH6gGG4EGrYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749589; c=relaxed/simple;
	bh=N6uMqjuiISTOWC7xpwd26uYXqqmjP9OurvhshEZsv3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qkdIgx8GWQ6ES7i7oeuIBbgW4n5WtwU+i4TMCJromrjcoeqYi8AD8I7DBFQ3cuSlmcySiry3AxzPCJoAEOPz6wmCm/PYhDyDf/Wucptt3IqUs0zegGq1nn06yB0sO/dj7DMGhH0a1LQFMAt3DAUuoljmAHDn3Nd4QBG4a+q7z54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MTnCWUVI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761749585;
	bh=N6uMqjuiISTOWC7xpwd26uYXqqmjP9OurvhshEZsv3s=;
	h=From:Date:Subject:To:Cc:From;
	b=MTnCWUVIZZoLoLMUjShhq8WfeteVxk53b8MtdCO/RuaHHHwwbPVsprs3iphiRon9f
	 i3wnUDQDufMa7SIFA9FnJbbf2pfX8mAROh0/n6jGryZYgPpAoc6Qcb4Uqw924UrMbt
	 csfoHWmzQPBgHv+oOijFX5uceXKiZxowHYHGA2+cNlgITkSlWeDOUH6pqWPdXHaf82
	 Yv86sXEv++OHoGIK9G2CEr+sbEN3P3Jjzlbc7GHBdYjnjwuH2ktRVbFTVBrTxVcqgA
	 9zTQ4wKO3qMTtqVyreZOHoDPTHNvTTIuUETLdBfx9JHsdhVfwjLJIXqjDeV4iv8fHv
	 kfnRBfbS6VUZw==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 325C517E12D5;
	Wed, 29 Oct 2025 15:53:05 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Oct 2025 15:52:53 +0100
Subject: [PATCH] dt-bindings: iio: adc: Add compatible for MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEQqAmkC/zWNQQ7CIBBFr0Jm7SSAGqFXMV1QGOssoArUkDS9u
 8TG5fvJf2+DQpmpwCA2yPThwkvqoE4C/NOlmZBDZ9BSX5XUFmM1ylgMFSdOgdNc0K3NBY/GumB
 Jups5X6D/X5ke3H7u+3hwpvfaE/UYYXKF0C8xch1Eolbxn4Fx37+5ZLO9nAAAAA==
X-Change-ID: 20251029-mt8189-dt-bindings-auxadc-89ad9e0a7834
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: kernel@collabora.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761749585; l=1241;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=N6uMqjuiISTOWC7xpwd26uYXqqmjP9OurvhshEZsv3s=;
 b=Oicll2/zjt262uSpgPWCOKPgyQiMpk6vchlAy9c5/PYkfYrtCokj1Yu4U0np4tZKQMgwvgHA/
 debgLh2k2e1BoaX6NH9qSgaQZk5VbTgAzovLXnicuABrQR9Dv0xjjYu
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible string for MT8189 SoC.
The AUXADC IP in this chip is fully compatible with the one found in
MT8173 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index 14363389f30aef85c596251fca0fe800200e2b41..d9e825e5054fe51c4010fc8a97af05c7639d4753 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -42,6 +42,7 @@ properties:
               - mediatek,mt8183-auxadc
               - mediatek,mt8186-auxadc
               - mediatek,mt8188-auxadc
+              - mediatek,mt8189-auxadc
               - mediatek,mt8195-auxadc
               - mediatek,mt8516-auxadc
           - const: mediatek,mt8173-auxadc

---
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20251029-mt8189-dt-bindings-auxadc-89ad9e0a7834

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


