Return-Path: <linux-iio+bounces-25337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB3BF90D6
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4916F4F02BD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961128A1D5;
	Tue, 21 Oct 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="axApdpjV"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E613774D;
	Tue, 21 Oct 2025 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085878; cv=none; b=s3fB2YmG47hRejE0PjKB1ZPNFRHSzQKGwPzWc5HQY9M+oyiDyHVNAFwF9BLXC8ysjzPV5/4caKQyA2ZNeDbDuNM9YaUjBmHCYWmSQpBu+4fq6U5/wZzJPThQk0mGfXrK+9i1YB8m46HlxzvxeOEIxhEZBZfitXtZ3EGLzKU9A8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085878; c=relaxed/simple;
	bh=nEIDusPoveGLPCA4xz8vByBEtHvXjFLhtVGPTuxNNuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=km+5KBeKGPquizyGKAowfqnd0gNOdVzu6s8Ne0lq6rs/6eJCyiWGmXnQPr7nM2RIeLEEXmdFi/n9lJMno3eu9HwFI2E+GpJf7Kzp5xd/hPVS0O/8dfp2O2p+GSvH38A0cSjPwWvGRX3qCe5z3aUTn8/M/0tsCYUhUNy7jSjSNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=axApdpjV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=EIppjaamqtI6FQ1cWOda/fD6vDYDpKq8nIuZLe1f+YA=; b=axApdpjVP+mz5kUBmS/Q99032+
	qeJu4WZAhGej7RAJwVfV9ArlixJLfnmSzHP3u4Tf2FlafbmounvmVPIDGFRcMk4FxPfAZLz8AnIAC
	t4HJqyO8em+7upOfjmMNYYGCX+eAOb5PtVnZ7/UWqpQyWBunVK4OcBpWkPnhCtpYYJaWXxAFCidPP
	FB9VH/XPrtiD+5916PEIUKYnIgzBOufvObTqlTc2ziPwiYIcwJUI9dt3iUHMNI9vqxxno9YjcWHHm
	h8xO0DE55d846bJQyCVeWZsebL66jt6r+MMGLfnCXRtwuQ55K95hsYJJRPoTlgMQuxBcIdTG9GZ7h
	QtASuugA==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBKsp-0006i2-ST; Wed, 22 Oct 2025 00:31:11 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: Add rockchip,rk3506-saradc variant
Date: Wed, 22 Oct 2025 00:31:07 +0200
Message-ID: <20251021223107.193453-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SARADC of the RK3506 is similar to the one found in the RK3528
in terms of number of channels and the other implementation details.

So add a variant compatible for it, that reflects this fact.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index f776041fd08f..6769d679c907 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -16,6 +16,9 @@ properties:
       - const: rockchip,rk3066-tsadc
       - const: rockchip,rk3399-saradc
       - const: rockchip,rk3528-saradc
+      - items:
+          - const: rockchip,rk3506-saradc
+          - const: rockchip,rk3528-saradc
       - const: rockchip,rk3562-saradc
       - const: rockchip,rk3588-saradc
       - items:
-- 
2.47.2


