Return-Path: <linux-iio+bounces-13050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C29E2EAD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 23:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F5B3E5EE
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAB208981;
	Tue,  3 Dec 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX7AY1NL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8BE20B1E1;
	Tue,  3 Dec 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259196; cv=none; b=TQ+wWnUQboPW51x0pL3K42kYv7eEpACPu5rOa/GpEqwcCo/M9PnyDKUNT0ZyoNGXDCXSo/DkJyIO22MInp7jq4b3gEzNp2EOkSPkcofrzFnolgSzi6bXLxjIX5Fbbs67vUgvfiegUHp3YpiQbyiks3d1omtm3kw7gZ05VCeB2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259196; c=relaxed/simple;
	bh=hjcd5A8voRW+pwEIP7TsS26RQsBVlcg+595pH9ZdwXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsJ/nRGhbULhOn+7TV28C92OxPCM7WcQDsJzkpRLa8Js6w395P1/vpJFUXiS7QC+E2aa3+JCMSkBxuMjtQ2dHtZPVvzLoTEIie6G3ZkdBUeinhG5nHEa+3nqZzxLLiv4IBzssDVQjXjLaveyppJOwm/+eWBMp78WfgvYDx3u4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX7AY1NL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43499332f7aso5206475e9.1;
        Tue, 03 Dec 2024 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259193; x=1733863993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSRlyww607wNG4Ky6SHBw5ubjyNIkPXdbs/bES90CC4=;
        b=SX7AY1NLNr8cfTES3KW3u2H1/xlcCT1OFihE3UbBGgG/Lt119uXA0EWv4j14bkXYk+
         s2k4XQpsa6n5quF8n28kbxAD4z0zNEV5k+YVs8FkKS/FSCTGhH7ZKFCrwhAvbN5m9toa
         kpqh9Odgp7+S9h6q/Y9cxHDx8EWvuLeEyPz0DAOm9bThW1/DE5gZb1osrwPJS8e4P5o6
         csa8U/GsICSoVasJffS69yWfpJRCYE5vDmPQDjCR6yQM7/NgOC7Zyp7wfFbvBcZI8OXb
         S//4d+PfIYrnVpSI3j42fshpbv4hJv7tdSH5bNAsF2d067hbkDStobeS99LUrXFmYq8a
         pmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259193; x=1733863993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSRlyww607wNG4Ky6SHBw5ubjyNIkPXdbs/bES90CC4=;
        b=bfcZIf+CLgtcwUnk28KCv8agb7UB4lbEpVDn0f4OK5wHur1fRAZelz+iuqIGvo+rjc
         wMkJze1OxtxKhFCxuxwkEVL6j8Ln38Coo13n0Sc+7EPSQpXT82lubdkKXbB1bkXW39F7
         Qrgyr0mE+QLyp9XuB98JBhuC9N/DM+AJ1Mb43M1gN8V8LBEbiEE/7tLgb3DCkqEA+GfJ
         xEL8hgJXWCHinPBY36BymwiN7WkP8fU2As01Cu+dmsU/Q3EFwoFJpvETf+umkeWpK9DD
         2Z9QEDVOyigMby4Kux2yYqJRJE4GwZJYQ6VrJnVWWDPd3/f582Rw4XIAeh9j6YODdvMf
         ntZA==
X-Forwarded-Encrypted: i=1; AJvYcCVqkEY2TzDz/ZczjvpLeM558EVeJMpfnZOSm+RbsGKF1NJTJCQkv7fG1K7jvVO03q8+e3DbCXk0Agg=@vger.kernel.org, AJvYcCXnxNILbypcAIWgXnE3imKj8VBquNS09LVWAq/m+hQPMfdXymibpZOVeT0870Jmj9Oa1ATCTIjGw1LoOXdm@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwnFzB8JW6OHDWg8y9nKP8Lb3rA3MjfQtHMnB5uUom8feHUZi
	G9JBYcC6U4zqh7kzfF44DinSEs5tR04EMDD2tIy1qoZEcFqk+v8c
X-Gm-Gg: ASbGncvA4rQrDXULOx/10b0TglzDmD68EjAKiBbtpl75r0e26OVSS804p3KYjp0Rjwk
	ZMPtMgmJgL3wWxx1j4YLLBHbJheaGkDUrze1VanaOn5VVfFl7Nt8zdFJDPRi0XV1bkDAWWtH4uq
	jNAbQqk1rVZ9d/Y8ytCF2ryRLS6YUmHk5fR6EzOIM/AJjxJhWMDpd+VDebR/ivQ8jeqGffeSSNT
	vw4VfT55T0n6ccZrUBjjkJhIC7bddouAT+O7pbl20YZzcJjp7W4PBCZ77F9KukeY+ONgfbVyt7L
	ehszmt0B7FcXFKBhWdbXRDw1kAw7
X-Google-Smtp-Source: AGHT+IFKabrlhumUgKLcNroI+FaBmvovJMbwHTjB5dMy0//6WqKHy/yNGRh8dTYHHwqHPYZ4ste/DA==
X-Received: by 2002:a5d:6d05:0:b0:385:e88a:7038 with SMTP id ffacd0b85a97d-385fddd3402mr1240391f8f.1.1733259192709;
        Tue, 03 Dec 2024 12:53:12 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:12 -0800 (PST)
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
Subject: [PATCH v3 06/10] dt-bindings: iio: accel: add interrupt-names
Date: Tue,  3 Dec 2024 20:52:37 +0000
Message-Id: <20241203205241.48077-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203205241.48077-1-l.rubusch@gmail.com>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt-names INT1 and INT2 for the two interrupt lines of the
sensor. Only one line will be connected for incoming events. The driver
needs to be configured accordingly. If no interrupt line is set up, the
sensor will still measure, but no events are possible.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 280ed479ef5..c3483a4b652 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -37,6 +37,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    Data ready is only available on INT1, but events can use either or
+    both pins.  If not specified, first element assumed to correspond
+    to INT1 and second (where present) to INT2.
+  minItems: 1
+  maxItems: 2
+  items:
+    enum:
+      - INT1
+      - INT2
+
 required:
   - compatible
   - reg
@@ -61,6 +72,7 @@ examples:
             reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -79,5 +91,6 @@ examples:
             spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT2";
         };
     };
-- 
2.39.5


