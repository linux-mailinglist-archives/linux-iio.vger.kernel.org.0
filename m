Return-Path: <linux-iio+bounces-2093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD68472AE
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 16:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE0297CC6
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD0145B22;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtkyvT8H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A62D14077A;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886594; cv=none; b=leQUTLCkrkW0fG6kc3JRvW2xWy+uHLFmt96W1uWPjEzls6OL3YAlEC6q/VPpA+TKeryH8zRgdGkzdCGlH0aGp2Euf4+EbiCrBymnYCH/dtC3z/qNwuJO0yWsC82KQhCRrtAysQ+4EEDwcF24w0WBo6EUVTwK0zs6Gshyd+NP50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886594; c=relaxed/simple;
	bh=LQBLYklmekWzduhDvWMnRdDS9XzLc4NWHc91y6WvANM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAH/H8FXHGQN/KcFh0jssCJ/doirtKPFgCIDU9L7ejM2TC7ZtHOpSv9TQplgpfTze6aJ27aJRY3SUH/woY3Z5fK8koYyHXkcLRDjgOl9kn6x3aKiv0OrqN6044KhBOchFjbYaWFrzXJ+zubU6YVoamLeY9FhHzjQyLibqPX5vbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtkyvT8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2816CC433B2;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886594;
	bh=LQBLYklmekWzduhDvWMnRdDS9XzLc4NWHc91y6WvANM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AtkyvT8HAWTBHMPisY9hTdiCimv402l0yoOGFOh3m/GC0gp8trU+PTIGjItUsJYzf
	 vaVYCodxjBzgTJyGzM4jy+vpAM1FLNaq4vQxs5H/pitTF5c5KwquLr55ZdszzY8B/2
	 c3XFTIMBOK8vI9pnxMBbGFDZ98jS9QS8j0mtAdEFXw6rB6AiKDw4Zx9GvQVSswgCU2
	 wbLQYc9iKunEFEbPdEjqizM5XMONrI4GG0kgix7+FCoJdPPJlxdd+CFdtEtU+nosyt
	 1FBY1fEXA5fVT7cj5K+p6KPuc+hPPx5zDebWRTTpWhN/fl58Ujd5BoytMwHxjGeE7P
	 zCFnGQ/PLWNpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC9C48297;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Feb 2024 16:08:34 +0100
Subject: [PATCH v8 3/7] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-iio-backend-v8-3-f65ee8c8203d@analog.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
In-Reply-To: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886592; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bQJmlHehrmhQX/B6Z0TUvJq43/kDkxEOa1pI4QQc4SY=;
 b=zyPzB9qS7gWJLrroUn9A3eNCiMZsbV++yuAY/PC9gywL0dB6TojL05RKdHtn0MZGEbWEgmEvq
 5/YYRuXn0e9AZbJGcuW14lPdwueNDjmlVA1OogtfCyB8lb/9kCC/u2D
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Olivier Moysan <olivier.moysan@foss.st.com>

Add support for creating device links out of more DT properties.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index caa3e54aae13..0e91a5f4d0cb 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1245,6 +1245,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
@@ -1335,6 +1336,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
+	{ .parse_prop = parse_io_backends, },
 	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },

-- 
2.43.0


