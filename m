Return-Path: <linux-iio+bounces-758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D480A712
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9537FB20CC6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AD30350;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsgXbBHZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9C23766;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94678C433D9;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048450;
	bh=OaL5pDVyJIzQrfAV3tfRNVjBhEsYl4sPC7Z23Kw0fvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UsgXbBHZOYINk+sY1x/vtSQj7ytj2N9zJgi77oRuT5TjimuU0UqY/9dhcB/bzVwHc
	 cyISDyrZtzTNEV94iCB5VlAMitY/V0YLNdrQNUJKyLBsqTV9fiqSXAUsi7fzvjFDaF
	 SeIgB9/6vvkKj4xG1Ah0v30WvHZ+IOibvprsLz0XqdwAtwBH0vK0RlUw7UjYdajdbR
	 kjyJdY7KIFt1h4w8EyLQURSkziy3ZxjgCKKOh6h7xo8npWPbE2WIu+XDBzmm6/WLwf
	 PEPeMMqXBwOozySkr9RPSS+Z1fO0qpKPmpyCeDpixhn++bPNOBUYHqoPelnQykbBxc
	 py2XEmd3HgtLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF10C10F09;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Dec 2023 16:14:11 +0100
Subject: [PATCH v2 4/8] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-dev-iio-backend-v2-4-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
In-Reply-To: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702048448; l=1344;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2i9xrdAocIPl4YQTG6hWpMO06qbcjhyhzYcdjiTi4iw=;
 b=cbii+i3yP3jIPhltKgMO+cMk7lQbp3AH6TNiP1bk4u9cI6OytDG7RqgvyVtDBXuBAva9UVNua
 eB9DDiWSpPhBMO31DX1dnTZBqg321dI3NEdgbCSv2V60Ee3z7Mmu+8e
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Olivier Moysan <olivier.moysan@foss.st.com>

Add support for creating device links out of more DT properties.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index afdaefbd03f6..a4835447759f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1244,6 +1244,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_backends, "io-backends", NULL)
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


