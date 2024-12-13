Return-Path: <linux-iio+bounces-13432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7704A9F17EF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ECD16702D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1801019A297;
	Fri, 13 Dec 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKH1fXkh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A458194AEE;
	Fri, 13 Dec 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124764; cv=none; b=JgRcVSa2EIfxaxGTHbYTrKhLUGK3TFF6aBSozz1hfO1sYRbhE50YJfHOST0UP6qdfTCsGh76UQt85/uRSxQeyN6+k7FTQHyf1l7voeKdvPMjLLQlrYm8djiW1E2NlivRYaueBc0KfeidAnDr/nX4pknL002dX/VGEYJA4tUJ3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124764; c=relaxed/simple;
	bh=VN1pT1soceWpBRL1Ff/Xu3C46TBaJ+7J7MPPx/IwKw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ek6PnIuFfZFBxVRDtjtUNK+7qA16/p7EfpgRCI8AR3xkBBEMmLakyZ+XB1lj/c/uci3wid35X70gbkARSezZ3LTuP1ObRv8uETUMmEEuJyoZ9Httiz6ku7Oa0A1qpTqasCYgp2gLBma4a972VsGz1llZMXU9YTRpSYztkvRKUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKH1fXkh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436203f1203so2122115e9.2;
        Fri, 13 Dec 2024 13:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124761; x=1734729561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdD/19e5UCPRHcpX6fbB0zxAQ1c/6JKAgU5L9Fu+S8A=;
        b=EKH1fXkhZ1y3P4wt6Z06sYSsaciGdIj+NpZV4y0hET6zOV7A+K5Gi9J+W2ia10VYpA
         0lqs76BEdY7p510+Xiy/KLIxHs0vvfGKF8SLcp7Mx0q4GL8ZEX6WcVwy0ugh6tnQoOLJ
         eItEgvXTuzzgq2UkMCFkiZ0wuFP11pmfK9SEu+fBXxEFuWRvQdtOrHuNE5+58lqhAdv4
         DO0nNixsg2h40viYGKCtQPvl0e6RRsffL2G3/5/9QB/rlBJShJzsqGw0/GEA8DrSEXGn
         4f5ER0FLLna4vcFjETTnDLMrWcn7C2NuMSZzE9ofbutG8jp3ouO6GmCegs0BBQ91xWIc
         f3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124761; x=1734729561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdD/19e5UCPRHcpX6fbB0zxAQ1c/6JKAgU5L9Fu+S8A=;
        b=er/K6+yOH69nihqZgf5MESAH7WalV7FiZom9CV3PaOxULTuHkdTtg7GryQG13r3s9Q
         Ij3i6pumE4SGAj2iq0jrVtewdwsYc2+kG5117eUVL5UfKDBfZYsAeXJY+8FWQvHQ+9fM
         ANAnUVZzl3TG/zbAg5MN91LNRSvx6pj4pMv1GzY4S72tuvIasXXImIa1A0rTTrvaUCda
         QHSN1Vg0GK41VTIThO0+6NX/AjSL8FfXEXKZxYqytKX5rQlJoFSLy9KZN/n5KsEK12RA
         cSBBpuKAMfo8jIkEdgcxwZWL2Njtk4dSnI1MC/4/77hCdLjGoxN/jUHxbhHgpg8r9ybC
         eSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd01jNTvRKBmeH4DKs6iYauSvQNMsSXyatESwXTm2bvff4YaCuy37SSxj+HcoOXvea28qxVB81bnI+CIKR@vger.kernel.org, AJvYcCX4TmBnborZp+FfmnE4UUdCyXWwPbBZDJYNtvcvT8Y1ekBjw2OGOy2sS2cGmWp1QrrqCtZ0xlFioq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64Eb1IfVxIYN7rKcWYHkxAdOu6DVCMXf390f1taQl/yDXS51J
	sP7G6esQ+PxChQasvT7FYVGlOXCqfde1JNurPbCtR42qVuqojnvS
X-Gm-Gg: ASbGnctS790F3hqgzQXJKtY7d6b7LRFbPsyh+v7qi+EIybmcyoBm00DbEOCbxZIqT0d
	IPtky6l0JifWLgvY3OLeTQhHg/mHQeNuRZ9/38Q5WO12cG1ZFucDNw/JGgJjg2dZOcr38YHz75E
	XWMKPMkGpqt0fScgNiqccWIVVBzggX5B4z5hEXw19lDU3w7CrVeaPm9zSR6Ts1UCSJwsfagsawe
	eJw5C3cgXlsv346AJkrYajYWT3ny1BHb11+Fnpb0IZIXmRfPUS/sAOmWtKvi3bqQk63FvIOOSyM
	Yw1Od7kccb2hs3kTvGtO/3QQx/U/VB0PkKk=
X-Google-Smtp-Source: AGHT+IF0bko2WOIywFKeHNWnHmJRPLjjE7KSWwBu0xE4s5zDpafSbkJ9DMrewmjaXpkxGsDTsybY1Q==
X-Received: by 2002:a05:600c:35c6:b0:434:a30b:5433 with SMTP id 5b1f17b1804b1-4362aa9f021mr13815045e9.5.1734124761315;
        Fri, 13 Dec 2024 13:19:21 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:20 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add interrupt-names
Date: Fri, 13 Dec 2024 21:19:05 +0000
Message-Id: <20241213211909.40896-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213211909.40896-1-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt-names INT1 and INT2 for the two interrupt lines of the
sensor.

When one of the two interrupt lines is connected, the interrupt as its
interrupt-name, need to be declared in the devicetree. The driver then
configures the sensor to indicate its events on either INT1 or INT2.

If no interrupt is configured, then no interrupt-name should be
configured, and vice versa. In this case the sensor runs in FIFO BYPASS
mode. This allows sensor measurements, but none of the sensor events.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index bc46ed00f..4f971035b 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -37,6 +37,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    items:
+      - enum: [INT1, INT2]
+
+dependencies:
+  interrupts: [ 'interrupt-names' ]
+  interrupt-names: [ 'interrupts' ]
+
 required:
   - compatible
   - reg
@@ -60,6 +68,7 @@ examples:
             reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -78,5 +87,6 @@ examples:
             spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT2";
         };
     };
-- 
2.39.5


