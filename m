Return-Path: <linux-iio+bounces-1763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73E832CA2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7471B1C22E31
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA0253E03;
	Fri, 19 Jan 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZO1hVAk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108C54BE2;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680070; cv=none; b=r7zRpB3coLsfLp+JVHEMHhKCl5CE6JYstEJmYLgKGn/+uDHtwvaIGO91cGUAaKC+zb771NXMx0JGm7G+czeLqE416ojPtcKO98MM/79twQi/icGlLnwGfXAdmMMuWFyowCWr2Jr1v0ciGSXxd0MEFcn9q9sNu0HvctTvytGf52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680070; c=relaxed/simple;
	bh=dlT7sb276rylclHuFkREGT780/vB7zT6Zn20C4f3HN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vD/coxUWDfvxVqtkmgNcYr96eUIp3XVT4/OnWBzhStiJ/vRi2cX2R3qGkEtEAzi845Ph/75elmM5iOSDwMrKsz42jL1cenry18S+w5fFHmwx8rY4qupKVrNROgcxlYV1afowEorFWaudcMEnNligcD2/gl/+6vgOIhFtB0RLFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZO1hVAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86668C43143;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680069;
	bh=dlT7sb276rylclHuFkREGT780/vB7zT6Zn20C4f3HN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pZO1hVAkOfNQQgHo/vs9v+ZW8VKrHf9HK+foJxbHO4yFU0pezybkCcViagdus/Ok5
	 YsCqW6LwMQHXtanUpwB+KXpWG4nbMH/v8ejACd5XKTn0OmKFIKkUy20lNRqE6+ju3p
	 CRhY3z7/SIog42+AwASXFklHkve+RI7/dyirhJKh1N1egN38fgLu9ehzku5JT7zZlF
	 TFk//P0UeRVGpw57C9DOh7ARVK+HwroTEVJvjwRzJYqQgnweEe6wRMLBSP+Uzzeuak
	 WV7uXIFfrIlBbE7KMP/zSxDYYZqYjBy78DfaXEVdG893hNtzTlY2RmzuQN0xr6tCk4
	 A0ycn7leobk0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA28C47DDB;
	Fri, 19 Jan 2024 16:01:09 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Jan 2024 17:00:50 +0100
Subject: [PATCH v6 4/8] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240119-iio-backend-v6-4-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
In-Reply-To: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705680065; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1SIlZLeWvH+Uj8mRjKYsNmpossjqlEP0aA6gu8k1B1g=;
 b=lNdN6nKGk4+4hx4VfCFtdQ/VUAEKRn7KSwFCyZ8I2knD5YtojVap0bJ3DPzxHHeEf27TmRvCN
 n+oHSpbXsjmA+uMQ989KZfm32N0AtdiEH1Wwy12ASJYHS6ESbKyWWjK
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
index afdaefbd03f6..c5909ffd93f2 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1244,6 +1244,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backends-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
@@ -1334,6 +1335,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
+	{ .parse_prop = parse_io_backends, },
 	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },

-- 
2.43.0


