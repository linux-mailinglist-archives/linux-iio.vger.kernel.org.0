Return-Path: <linux-iio+bounces-1876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D913483924C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CD1F2477E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07E5FEEC;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asn9bIbh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B55FBAB;
	Tue, 23 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022874; cv=none; b=THwjHnVJS6c5QmxGzKnLWLC8f3rokPv/6hpjK5amBF5Y0i/8lvJs642oTZdv6qTCktcpQKWylvyOSRv5OT5Cukki5XnZbGVw+7SByi8zo7tdhIa4w06W9ygH8IclCN1MvBXmZV1I/LVv+6ZIB33ZidA4VNrS731/q6yRqShUg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022874; c=relaxed/simple;
	bh=xr5qpjqHK5CAsrISE6t7Se5huBP0yOEOBWSopxvnoi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0lWWbBLhO+SC3NfXUrxKkHD/xZIXgBkAf7bGf1dgpW83tPLfNEjL7nHWftgR2dV3KLbDykFS7JQ2QPwcUv+VoQQBd0e514ii94Zbj2u4/fwZq86V93a/h7oPXBMaSJS1j0OuKI3ukKPg+bYsx/DajPWZGgmrchBV/PAp5ypZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asn9bIbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDAB9C4167D;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706022873;
	bh=xr5qpjqHK5CAsrISE6t7Se5huBP0yOEOBWSopxvnoi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Asn9bIbhl1sjRZxyBzsC/LC6G60bjUQ+ECGfUzwWe2tLIzJVjTf9UVuIJkeDJT14J
	 7//5Gg4D9YqRZX2DoK9oKZ4xqlOUBDDjxmB6j1bi2uyVfgolvB6hrbIXuB6BWg0T1j
	 td+flgmRPe/Ynx10IAxigCuosEweIRNNB2Dv5WqD15GwDnMD1zXB+88XykAQFmTdQ0
	 pdiMY5NY4hTzVfC+dYS5jibpBk4ga6nZIuP1+yPeXa34Bpe1JthN7b3cLLpwoVB2YI
	 dD0prvJD+Y665wrLtjbsUdex8ZnerCtcf3HKKFVUgNM8EUWTbAA+G0DwoQ3hZM3cwg
	 8ZPq2kxI3pZFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC306C48277;
	Tue, 23 Jan 2024 15:14:33 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 23 Jan 2024 16:14:26 +0100
Subject: [PATCH v7 5/9] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-iio-backend-v7-5-1bff236b8693@analog.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
In-Reply-To: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706022871; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=TmMsWX73B4o1Dpuycs2q1norfXZ2MzGLcAxOfBi1JfU=;
 b=cg19qs7waKgHTCtX8Vk0w8wiIN8fThNkIARUOY7yBAyD8R+pKwV9vuZb+1s9bTbq3bpYAaI5W
 nfGn4QG4QB/BcJ8S4wSFRsmXo6vMyYUgL28Pos0vIgMU8xy1DLOzjF4
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
index bbf0dee2fb9c..44203e42f0e2 100644
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


