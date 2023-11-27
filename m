Return-Path: <linux-iio+bounces-447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CABB7FAC88
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 22:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4358C281CFD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4F4644C;
	Mon, 27 Nov 2023 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CFvETX62"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2516101;
	Mon, 27 Nov 2023 13:27:42 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A4DD2870F4;
	Mon, 27 Nov 2023 22:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701120461;
	bh=dnI4XRWYFlNanBvAAEl4WZSJUEII9A6YsA8/KWQlGQc=;
	h=From:To:Cc:Subject:Date:From;
	b=CFvETX62Er+D7+zuPdI8ju/VDVZqV/bTKWp6BItoJvNrHp/BLI4XWTrqt18mc8KLz
	 wJCqzK3d/ilcKt7HvdJZw+MMsxyKeO9+ivBeM2lvXvMEWt2iUcb5zAQ2sV81EWhE5M
	 GruNwGTcOLi6229jvQudsPMN20PbiJUuxR813kMSRpHr9v76zS7ZFuZZaKzu9ysUAS
	 lBKb7iLcvyuL9xryAjdZsXKcR9GFM8y5UaCJMcaQ+NZbztjmh073eRLjKVb6i9Y6i6
	 JajbDqv1VV9uvobhX+axeMXZrxJerycSGPtOyK/cLyu9nrrw3y4RaZBu12FtVZXFyN
	 RBNUFo4bBYUpQ==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: iio: light: isl76682: Document ISL76682
Date: Mon, 27 Nov 2023 22:26:52 +0100
Message-ID: <20231127212726.77707-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The ISL76682 is very basic ALS which only supports ALS or IR mode
in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
other fancy functionality. Document it as trivial device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andre Werner <andre.werner@systec-electronic.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc: Vincent Tremblay <vincent@vtremblay.dev>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V2: Add AB from Conor
V3: No change
V4: No change
V5: No change
V6: No change
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 441b55723675a..d7ffecc0e9bf5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -181,6 +181,8 @@ properties:
           - isil,isl29030
             # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
+            # Intersil ISL76682 Ambient Light Sensor
+          - isil,isl76682
             # Linear Technology LTC2488
           - lineartechnology,ltc2488
             # 5 Bit Programmable, Pulse-Width Modulator
-- 
2.42.0


