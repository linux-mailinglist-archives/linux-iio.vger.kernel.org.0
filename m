Return-Path: <linux-iio+bounces-16113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559DA47B20
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 12:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C3616AC78
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6D22A80B;
	Thu, 27 Feb 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="e0bcPEHK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m49196.qiye.163.com (mail-m49196.qiye.163.com [45.254.49.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294051A3144;
	Thu, 27 Feb 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654236; cv=none; b=jreRE/YgmCadEOLmxvWuQpBhwJhgUv/2ZogzwwHqEYdcNusaRup8+j6si/6/6CBp9pBJIHoPImCyL6rws7F0BTs8rdyMb547D6iak023ZtiHdExPXXrIZN96weF16JtQ2sCWSS9ILr43Xa3xqw2+EKz4dIi0xosa94UnlI+npQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654236; c=relaxed/simple;
	bh=dhYd6F2dqDNDj2qQvvN2Q/ppd9sgGBv29AqvBxoescM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxERSVyaX8OCr719WlOD6hxkjvSWy56x1aZ7YW386Fn1jUBQBh9CF0H3VUYtGa7kXBS2itMy8Xfwm3BHyHqQIcSTtJ/8VAfDyytEDDz43oB7LN0qAEdp6oc7jEg9vOx9xTOdKNdMfhl48m4TJGeoNC3gzTW1q7QVJegh8N+Kc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=e0bcPEHK; arc=none smtp.client-ip=45.254.49.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b3592;
	Thu, 27 Feb 2025 19:03:44 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add rockchip,rk3562-saradc string
Date: Thu, 27 Feb 2025 19:03:42 +0800
Message-Id: <20250227110343.2342017-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0NCSlZOSE1DS0MYGR4ZHR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954713a34f03afkunmc65b3592
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6GBw5MjIVSg0dAh46Mk4I
	HxQwCxVVSlVKTE9LTU5PSUlOTkNNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCTEs3Bg++
DKIM-Signature:a=rsa-sha256;
	b=e0bcPEHKIbX6nYq+RNt83avtIJgzmJ0dBYHMbMFlfWxmOU7MwtvYPHem9TLTQHP8vcL+nmr1v6UTsDU5e6UMsAnWbql9qNH2oD7NUepG9B3Cm0hQ0xVpT4YYwHl2miCq3chD2S4IxG4D9CubqplSP8MLV7AvVn2yFquwWMzj0DE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=LKKAdsY3PqR35tOPthDUBhzW0huewFm3x2G+1m9O1mQ=;
	h=date:mime-version:subject:message-id:from;

Add rockchip,rk3562-saradc compatible string.
The saradc on rk3562 is v2 controller, with 10bit width which is different
with rk3588.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- fix dtb check error

 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
index fd93ed3991e0..d129b66a6207 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
@@ -15,6 +15,7 @@ properties:
       - const: rockchip,saradc
       - const: rockchip,rk3066-tsadc
       - const: rockchip,rk3399-saradc
+      - const: rockchip,rk3562-saradc
       - const: rockchip,rk3588-saradc
       - items:
           - const: rockchip,rk3576-saradc
-- 
2.25.1


