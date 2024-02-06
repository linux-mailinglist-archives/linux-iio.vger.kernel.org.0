Return-Path: <linux-iio+bounces-2231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78B84B1FF
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 11:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747372810F7
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2952E12E1C6;
	Tue,  6 Feb 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L064m/8i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146412D76A;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214123; cv=none; b=SzXioM5LcbNDUDfoes3aObkbooz2MNIJ3JOzDZ4RUjyMU+KZINiwRN70oBdgHCCYQSM+HmfGDxz+XJR1PLm6MhXBsc5zlt/0btir9kRCs+koCigGCprQMFX3JLIFdg1NYkJxXEZGLNBpTifWFikdI9seVkpONN48cj3FaVPI1Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214123; c=relaxed/simple;
	bh=LQBLYklmekWzduhDvWMnRdDS9XzLc4NWHc91y6WvANM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSdvDbqeDOatABPixBbT4Aiqdr9HIJIurGOLeNPAPMi8f0Njqj1J/t/9MMIVtYeg7K8wdz+S6oxvMdEujXVA8yiUS6KbYoZFljHUljsBGSWjLGigHGRfewX2AWYsQBgyMLKbWsRo7dgkiOE/+/B5ebv6aIzEskJZLwPjyuL14+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L064m/8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F7A9C43330;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214123;
	bh=LQBLYklmekWzduhDvWMnRdDS9XzLc4NWHc91y6WvANM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L064m/8iUZhwz8QNzz4Te1sGObjSB8X49mZZs2/RZOl0OUp32NtxrFdsx2Ori96/+
	 5INbXokpMujX431W5A4kb8k70WYknwFCIrw7IPS/EQPVqDJ6+XvMRcdWjsakcOTA32
	 wFCuWnweZ9Y0nXFN6rCiQNGEwqOMunEL0C7+1Ez78EAh/OPbuclnIiUgDOf53DvX9J
	 5HRARAV+pRgiFsGXa3eoB9bDEJT9dYHMrpRMDRFHri9svrvHmz5TF3gEG70S6Tg7t8
	 bkw1SV4dvz9Wgz78bATzDDaPNN+YHonhBxif4UNZkU6pFYZdUT7i+T8v9fkjToPCvY
	 h/p3mYpaWwELg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BAAC4829A;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Feb 2024 11:08:26 +0100
Subject: [PATCH v9 3/7] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-iio-backend-v9-3-df66d159c000@analog.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
In-Reply-To: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707214121; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=bQJmlHehrmhQX/B6Z0TUvJq43/kDkxEOa1pI4QQc4SY=;
 b=UU0+lxgXBC8Ha34Ecp2/uPc7l3fEvqfnNdJ44dMWJHdI23m5TVRZnd/TElq2+aNGIKa/e7DF7
 vj6ey2WutosD4xYc6AVwttXqOug94Mhu6On9dCNhAt+0ljoLmb1WDKo
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


