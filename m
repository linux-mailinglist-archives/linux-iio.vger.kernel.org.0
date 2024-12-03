Return-Path: <linux-iio+bounces-12985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8AC9E141B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 08:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FDD284CFB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5B19CC3A;
	Tue,  3 Dec 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="h5o/K34o"
X-Original-To: linux-iio@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C853193404;
	Tue,  3 Dec 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210549; cv=none; b=cod+VLo3NoVXsvoqieqqpZ7Q47NTaelO1BXDM6BiyEHR4TLjjGi8JNTjbgEAuSWvyVC43V806Z3MJWxam8JnKTXU56KF7ATXtMOvxRmve9i43YVlKbEeijFgQz+fl2jqBBdHaIfE3aXJZrL68rBQdreRegmlHmw9isdkdJLcL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210549; c=relaxed/simple;
	bh=DFyp/R0jxpqhgTccWILwnURhQxdrodsREP29KXQN+N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SNm4f1Bvk9arHJ15jLeMR5f9AlkD7R3LSttN9FTsmS6/I8fEuYoc0eG+tdDjRks7Cjm3BGGyPpG6Tfuyb1pzMD5aVEnf2IVgyPvxGxwG3F2+QBu5JIAVHvee+4tLPMfPRS+lK+ShXJTLT295OubQhSdnFhHT2nB9Oqx2tEp6z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=h5o/K34o; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=6jVLTp18SWbdeHtZP7DxFFXE7kTlMhv8zC8+fegqAt8=; b=h5
	o/K34oPg8+8SwkBX8khV2d7Wu0g3b4ZOpHjfAR3tPBXA6w+M5QnUkx1VCy9oSEP1egtXjetVywu8v
	rqQZ9m3asJCGVwvI3X23OXs+9GutOQlLs7CdT+T8nSU41H3IgqRRL+GZBW+Lc3vbdOPfXtYe8u0Ah
	kZDSFGz84FakPUU45uufuu+patmO9SA9W+0IViMkI9JXTn+JvwHqmk6w6VH3lxb+wjq3Ox3As/LMO
	jxFfUDDl5KwQJ07NgCgziGHXLJsKUEZKioJiwx6fScOpZ6wPWlzIPi8h06SNgdl/I81xRq+3YpiP2
	m1auGuSBqWqDDgGffG+04g9wcwVR+drQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tINEl-000Fgf-BV; Tue, 03 Dec 2024 08:22:23 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tINEk-000MPv-2Y;
	Tue, 03 Dec 2024 08:22:22 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 03 Dec 2024 08:22:11 +0100
Subject: [PATCH v2] dt-bindings: iio: accel: fxls8962af: add wakeup-source
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-fxlsdt-v2-1-ef523461b507@geanix.com>
X-B4-Tracking: v=1; b=H4sIAKKxTmcC/2XMQQ7CIBCF4as0sxbDjLWkrryH6YJQaCdRMNAQT
 MPdxW5d/i8v3w7JRrYJbt0O0WZOHHwLOnVgVu0XK3huDSSpR6RRuPJM8yZIIl0v0mipBmjnd7S
 OywE9ptYrpy3Ez+Fm/K1/REaBwjk1jEr3yhh9X6z2XM4mvGCqtX4BzuD9qJ0AAAA=
X-Change-ID: 20241129-fxlsdt-2012530ca076
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27475/Mon Dec  2 10:41:11 2024)

Add a wakeup-source property to the binding to describe whether the
wakeup interrupts from the accelerometer can wake the system from
suspend.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- Corrected commit message
- Link to v1: https://lore.kernel.org/r/20241129-fxlsdt-v1-1-ff7697a47cca@geanix.com
---
 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index 2d99e3811da07ea0453feafbcf82a227185ecea2..c175f4c4cbdb8f8debb0fe64ed21157f3a878d59 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -46,6 +46,11 @@ properties:
   drive-open-drain:
     type: boolean
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable wake on accelerometer event
+
 required:
   - compatible
   - reg
@@ -69,6 +74,7 @@ examples:
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "INT1";
+            wakeup-source;
         };
     };
   - |

---
base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
change-id: 20241129-fxlsdt-2012530ca076

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


