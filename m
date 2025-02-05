Return-Path: <linux-iio+bounces-15026-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13140A2834C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 05:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98574166341
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 04:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB98213257;
	Wed,  5 Feb 2025 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cL60qL2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4D17F7;
	Wed,  5 Feb 2025 04:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738729167; cv=none; b=foTDhNkqzgrHMEQRwfZpbsbnz5ggG9lKo1RIBA6flZy8t/qbekgNgYQgU8/puIsqbGSsXGK6by41YhMvZv5H0QKgfv8eSE0WWkuDDgF9Ir/t2cFVnt3zwMIWfiJw1cHwUBo6IjGRr7c6rM+yk3aJFz2qIryQNIXY8vgofyJjYRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738729167; c=relaxed/simple;
	bh=kEp82TZcTFzdsH3ySV9d4fygaV26WlGKIZz5L3vog10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rUK3/7RRhI1CeaXqtQ/PSHl+GsNinyB+1uZo/n6W8sdHqWDRY9H1AMrtlkDv4BAdLUpb6T4SsvOiHhINkzEQw200MIemDmo4V1hRJxgJlDUXgsDmZAhZw535ZrAhn+8rms51x5vD85eri/eAWF6yNWK1chlgq7DzuB+19XirXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cL60qL2u; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738729166; x=1770265166;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=kEp82TZcTFzdsH3ySV9d4fygaV26WlGKIZz5L3vog10=;
  b=cL60qL2u4nQj3lk2gzIs0pcUZjB6Qqjxz6SjzZoC7WpIUflI2BChY4Fs
   ImkAJpg7z5q12G2YSbrzFiqBLpN++Jwqt3ci/8DstAFNG7lXxveHeU+4k
   OeSp/AUbWywSIokfGY6jIWd+19JjPMcCLwy+/1PzwSCUsr/xczg5yh5k4
   Rthtfig6jHAfbf2IPpHZPvsYQjmBDjtGW3yjeCR1VNY8VJk+IzNVeJhbj
   nm7HJ6w/xbLD1n1bkGgB6jicax+SX86tUsnl7yNeWBvmIvwhqIkND1Dud
   UxMitBbc7KrHkOz8HtXapWvBY1MC2pPhAenME1QS4w7IqHtSNmpoz1iyA
   w==;
X-CSE-ConnectionGUID: 2PqXhkWGQbSMV5Mi2wf2oQ==
X-CSE-MsgGUID: HinrJpVLRrauwdmn8wS93g==
X-IronPort-AV: E=Sophos;i="6.13,260,1732604400"; 
   d="scan'208";a="37284659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Feb 2025 21:19:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Feb 2025 21:18:50 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Feb 2025 21:18:46 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 5 Feb 2025 09:48:45 +0530
Subject: [PATCH] dt-bindings: iio: light: fix missing type definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250205-brcm-binding-v1-1-a996a840d2d6@microchip.com>
X-B4-Tracking: v=1; b=H4sIAKTmomcC/x3MQQqAIBBA0avIrBNUULGrRIvUyWaRhUIE4t2Tl
 m/xf4OKhbDCzBoUfKjSlQfkxCAcW07IKQ6DEkoLJTT3JZzcU46UE7fSm+iciMYijOQuuNP775a
 19w+cauLjXgAAAA==
To: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738729126; l=1139;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=kEp82TZcTFzdsH3ySV9d4fygaV26WlGKIZz5L3vog10=;
 b=KTRjWvKAPsdG4LpG06pf7j96uYK8YoKgCTYboPncyNHAEmtbaXAhAE8a83QuYcMV8smWAJnhp
 HMdf/2T8UcmDRBaQEZ8Xiub3QhYV+hqCLle1PRLkajs8b9Ia9mniNm6
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add the missing type definition for ps-cancellation-current-picoamp property.

Fixes: 47736b32d1b8 ("dt-bindings: iio: light: Add APDS9160 binding")
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
index bb1cc4404a55..f9c35c29fe04 100644
--- a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
@@ -37,6 +37,7 @@ properties:
     maximum: 63
 
   ps-cancellation-current-picoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Proximity sensor crosstalk cancellation current in picoampere.
       This parameter adjusts the current in steps of 2400 pA up to 276000 pA.

---
base-commit: 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e
change-id: 20250205-brcm-binding-71b6d990d67e

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


