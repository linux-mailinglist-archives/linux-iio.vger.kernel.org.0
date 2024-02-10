Return-Path: <linux-iio+bounces-2386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9085065F
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D901B224DD
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AFC5FDA2;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BysG6IqY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8525F87F;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598641; cv=none; b=VFHcmN3DbyBWQo4Xe8NbR0p7uSMGEVsnZT6a1HBEECfCdwM1DJxbN+TiJnW1wMF+6HxMXaSWhffT5ZBhTliygveQweNKMGiyf1/RP1Bvw2O/hy0eo+NQfU0fi9lKtn3KlUfqbLyODqMuduK6fcmdO9UuVWDd4A0FV91KjorapTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598641; c=relaxed/simple;
	bh=LQBLYklmekWzduhDvWMnRdDS9XzLc4NWHc91y6WvANM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwPYimr2GgQbgTmh1s5Wlu9Th4/BLAyGqrS3VDlF2vNSi4DBzK0Xru+1J/X3Kqsd8YBV6rMzqgNW/NC5EKrHG7las2+JuTc+xyX2cBIqsM55Akg8foT1LYslgiHjfTCcQ0Als1WNSgGIOoGCgAihkzzJ0OD8SRbUQjeUfl+ppeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BysG6IqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25BFBC43390;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707598641;
	bh=LQBLYklmekWzduhDvWMnRdDS9XzLc4NWHc91y6WvANM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BysG6IqYwhFin/1COGlUk335xqSyUDcjxzt3IJVvsrFoXbr7KBIfqjhhzBK9KSTMu
	 bShP9OIVU7QG7wx2KieJJczB1Hx2DJn8T8STYYuXrVeBPGZlW6Jy9/0NpjJLb3EP6/
	 6cOaJFMU/DnfEtA+Twv4L75aG01WkA1UnD7/Xs858aARIESY9jirTZuHS1XEg7WJFX
	 UNJZokySSGAbIYxziQmBveBrUD2Jk52YoHyWb7OMvQaTSnO+gnbNgAfDb8ZEphBj7U
	 YXOjtUaS7s34Kwn9WPjfsHZxMYSvKRmcVF2M9Em3L6Zb+R3MHlmgIDyse8eeOidgDs
	 MbzqAab3RnJqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB8FC4829D;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 10 Feb 2024 21:57:15 +0100
Subject: [PATCH v11 3/7] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-iio-backend-v11-3-f5242a5fb42a@analog.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
In-Reply-To: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707598639; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bQJmlHehrmhQX/B6Z0TUvJq43/kDkxEOa1pI4QQc4SY=;
 b=fiFnhEUrHzPEeEubBW8KxBP9aQZdiNeGcZygt4rXH+wNvsS/i0gdp2CtozO4ij/SA4Y1P+JJb
 6oNfdpXihbpCJK8QZJynhISK4FV4F4MTgP+6yz16EkYVsUJ/Ed7dDM+
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


