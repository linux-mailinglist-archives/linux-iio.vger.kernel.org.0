Return-Path: <linux-iio+bounces-9340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FC9708EB
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3F6281EF4
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370E176231;
	Sun,  8 Sep 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkR90sQW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F34175D38;
	Sun,  8 Sep 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816185; cv=none; b=A/ra+WThq4ehvwxht3TYobm8VPVYYlopPnyjgjHR9Mvex5FCpz7KlKmyZO1SDbY63VOPR6LaPt+l7stUyL8Y7l+9R7I3TlXgBovLIlciKlBPcGV3ax0MliP7bu55LF4wquEsH1y3dHARB9EoYOLiGFRaXbdb1OU3xwaiEAs6HtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816185; c=relaxed/simple;
	bh=uiUIyZJVJg/fPR21KVa0NDmzQ8espFwF7bhhnULzNbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOEuoMol0GQMjxTGlADHmFQaoIybPysaL3gjT/aFPg8Je36mZAu75Uw3OTEfFsAZxFxmoOMeqeSItPS0ygv7z0t5Ik519nkQhCv4Qx3dkytrkckyqfTeRqSWcz/H0UX34oRWIXi2EHFd2hpSstaVKWtI1/4mP/Sk0punh9ARKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkR90sQW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so378628466b.3;
        Sun, 08 Sep 2024 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725816182; x=1726420982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feqwXH3kQuxRm3D6rXIoWCmeWA2p2GmLQf71v2bQ8pk=;
        b=jkR90sQWV2UlXAmY2wDgf+Mv/OuO/OrDz1NN3r30YJaTnmfYcp4l6fE4Sq7KpmdxcJ
         XB6u/MyTFD7mdGUE8jAkoC/UNgFx6kSGfZq1piHh+AwzQNhzzxpDHmWz9D/YN41+CavW
         4q5YAXgfiC5/zQIs+rujApiggjm3s7YDD3eauiJtwS1lJuzjNhOcy4qvGAHts+Bp7ncU
         Wxx8ZaQyWnpul3KtHmlTDqy65kQO0SBsUcFFdNS+Am2EtTmCushey3vm9TPsSaAhvoiu
         CEd28exzTGB7NAmSGMMj82wzKq6ej0pNJ1UMxwoeyHrCJLzUYICmUJpKHzuurtb8S4L0
         z2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725816182; x=1726420982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feqwXH3kQuxRm3D6rXIoWCmeWA2p2GmLQf71v2bQ8pk=;
        b=rlq2D/6lZzHx22gcpqc5qHESYl5j9rcg9tuwkqwg1MnNZVwyCg3We2/urx8diFFzb4
         aarWZE0986O6Q5jYm0KbZHmNLII8hsMuxMQg8V/WWpBS2J/FVNdTcncoKdOJMWvfcxQ2
         7q8gaM5glkaLr/WZI+i3tfOqatxS7TLYolzg03jignh03mTOeV3jh/dIbu201btOoRFp
         kJ1WG1k2wuyQC98FGmyqH2Os+VirlvFLn7arxG9qPdy5eS0DstVrHvTHuCs/y7cn31Zp
         8ZIkkP2Tg9HqrsRfDeKVQBFmS68xbqP5SpJclupjiBFvpeiBBXq1VmtFuxu/a+JkZsgl
         fAUg==
X-Forwarded-Encrypted: i=1; AJvYcCUSUOoshvZkwHR4iZkDDZml6yog3umN/QYB5O6CSoKHrYVRphZyVlNMkxJBVCf73Mnkawl63m+LnxPY@vger.kernel.org, AJvYcCVaVZU7JtIRgFlEJBZUH+9jexj4kE+0oXbxONU1A0G9kJ11QDP9AQ97iW08lEOPeG9pB8+jbQyjkO2KVqVg@vger.kernel.org, AJvYcCVga/PpuNzk+6TaJhVE56bBr/wn+XNdkQkzeyeoxxfT7NGH09axkGPPs/fe8inn6J5EuyJ6UyxwzGF5@vger.kernel.org
X-Gm-Message-State: AOJu0YyyR5FPKSk/nDj621/PtbnNVaHc6lk7KkUw1F1KcOdiRiKib1Oe
	AIqQASwbgdEA6599OyqqnYzbmEup3O+HVzRwVxltHZXeUCs1vmyn
X-Google-Smtp-Source: AGHT+IEaF40Nh/8w2IQJeY4chUK9OLvn96dacLKbqddNf/rLsY+5vMPGrMSbH0rTeoB1Y089eDjUaw==
X-Received: by 2002:a17:907:97c7:b0:a86:9058:c01b with SMTP id a640c23a62f3a-a8a88923c31mr631494166b.65.1725816182437;
        Sun, 08 Sep 2024 10:23:02 -0700 (PDT)
Received: from localhost.localdomain ([78.210.149.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61258sm228048066b.116.2024.09.08.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 10:23:02 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: temperature: tmp006: document interrupt
Date: Sun,  8 Sep 2024 19:21:55 +0200
Message-Id: <20240908172153.177406-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908172153.177406-1-apokusinski01@gmail.com>
References: <20240908172153.177406-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TMP006 sensor has a DRDY (data ready) active-low interrupt which
indicates that a new measurement is ready to be read.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/iio/temperature/ti,tmp006.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
index d43002b9bfdc..590f50ba3a31 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
@@ -23,6 +23,9 @@ properties:
   vdd-supply:
     description: provide VDD power to the sensor.
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -31,6 +34,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -38,5 +42,7 @@ examples:
             compatible = "ti,tmp006";
             reg = <0x40>;
             vdd-supply = <&ldo4_reg>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
         };
     };
-- 
2.25.1


