Return-Path: <linux-iio+bounces-21895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55AB0EDDA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E026C658B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4188285C81;
	Wed, 23 Jul 2025 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Zwrg8TSC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45852820DC
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261043; cv=none; b=aQHKR+bAqxlLaVtY6k3zkOr6x9G5C6neaNBUoz5aBHi2enVGy9+WnwQYLY1hUZdtvGA/vkZ3562dJmHQO5VhEx0Pet9YV61m5OhnL0wJ76UA5mgrIFSDnuotkY2D7S4fI9MYPjNz+7wj+sfCaDpGhIagzqGd8fULJq9JEf00a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261043; c=relaxed/simple;
	bh=ZHY/h59tAbqK/0wbesbk+X7El4NFH8OPaCa2ytpNm6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=queFfj+hsJF/SK4RbS8zs5nlxu0OTxkraiEWivC2cAwO2wck6TPygsn5anlr1eibuuZtSCRjOSfGAzwQhQTCAIJyl4TwVF19dHGysYGt/J3boJ1ZsMavb+LY7tGm0VsUVX7DiNJ8U7vf8iMj56w1mCXzz0/NQ/CQfS7ZNV4PVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Zwrg8TSC; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753261041; bh=5pA5ShgQgZcidUsbKYIv6FiytemMQ/qpkIyWSNUV9Dg=;
 b=Zwrg8TSCCFBL7tfGsNZVk3tyMB8g8F+Zg6ErwbVn01X07gP3PbxWhCITACTYfqSvAMdPU9Jsu
 0uAeCRFg+2gDcJSdW4cxlECxwhK2CWsJqBv5IoCcpPjyo1vQBukK4cjWrHcUaCjcYQnYwv6t4kh
 t8iExGdax4cWr4a78mbPkGVgZsxuSu3vussZ6VBmbDSl/Eo1EAeAOqYs7qiImtMScrpRN4Ae1pM
 4mKJDLVHtAiLhLnQR2BviWLMsnaZOPSMFaNBVzvVWgEjiAmzUfaPUt1IbiqVqXhVD6wJLyJdxhP
 CtiM96SSMZ+XhXLnIkPf5gClVSCFFD/jIFVAfH4sNkZg==
X-Forward-Email-ID: 6880a3e9144dc4a5e5baee32
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain
Date: Wed, 23 Jul 2025 08:56:45 +0000
Message-ID: <20250723085654.2273324-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723085654.2273324-1-jonas@kwiboo.se>
References: <20250723085654.2273324-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SARADC controller in most Rockchip SoCs are part of power domains
that are always powered on, i.e. PD_BUS or PD_PERI. These always powered
on power domains have typically not been described in the device tree.

Because these power domains have been left out of the device tree there
has not been any real need to properly describe the power domain of the
SARADC controller.

On RK3528 the SARADC controller is part of the PD_VPU power domain.

Add support to describe an optional power-domains for the SARADC
controller in Rockchip SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update commit message
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index 41e0c56ef8e3..f776041fd08f 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -47,6 +47,9 @@ properties:
       - const: saradc
       - const: apb_pclk
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.50.1


