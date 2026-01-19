Return-Path: <linux-iio+bounces-27988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF3D3B5A1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77DD030392A3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987C38B9B2;
	Mon, 19 Jan 2026 18:24:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625336402D
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847076; cv=none; b=lSHSkM2NEFoc8WgzVyS1A23BIwBaTfsnUMEvc9S2v21IuOiTcbXfv4AU3Qy3Hyl1nMzu1ojCqQ6mul4qdfcuTsPO/wNXovOLVXHTAz1ALZ0w3twyU1o6ez9/Jai1KZOWo9i8ZGXpmGGzR8jV8Oik5Ubsi9XwcErw6sDO0nDCkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847076; c=relaxed/simple;
	bh=hfRqSHoUd/W/eV/madXW+xbCjKlyqcFtv2XVBYIuxKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBEsRmvyK9vKmU9GtRSAuZGqUEdzm9z8u3ocLEHxYqzewwDM3c+UeX8FZ+bQMRdoAxRR0cxpAV6ZPNo6wFkZVhQc4TpdY2zhjesEdxd5GZn9QmDkAyY9TWNvVgTEc3dR3QCvOUHPFa2KdJXJp2mDLpRPzA2eKz0FdL5gfliTbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-0004SL-7c; Mon, 19 Jan 2026 19:24:26 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvO-001SUe-0v;
	Mon, 19 Jan 2026 19:24:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vhtvN-00000006y1U-2H6t;
	Mon, 19 Jan 2026 19:24:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v1 1/8] dt-bindings: iio: dac: maxim,ds4424: add ds4402/ds4404
Date: Mon, 19 Jan 2026 19:24:17 +0100
Message-ID: <20260119182424.1660601-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119182424.1660601-1-o.rempel@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Add compatible strings for Maxim DS4402 and DS4404 current DACs.
These devices are 5-bit variants of the DS4422/DS4424 family.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/iio/dac/maxim,ds4424.yaml          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
index 264fa7c5fe3a..efe63e6cb55d 100644
--- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -4,18 +4,21 @@
 $id: http://devicetree.org/schemas/iio/dac/maxim,ds4424.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC
+title: Maxim Integrated DS4402/DS4404 and DS4422/DS4424 Current DACs
 
 maintainers:
   - Ismail Kose <ihkose@gmail.com>
 
 description: |
-  Datasheet publicly available at:
+  Datasheets publicly available at:
+  https://datasheets.maximintegrated.com/en/ds/DS4402-DS4404.pdf
   https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
 
 properties:
   compatible:
     enum:
+      - maxim,ds4402
+      - maxim,ds4404
       - maxim,ds4422
       - maxim,ds4424
 
-- 
2.47.3


