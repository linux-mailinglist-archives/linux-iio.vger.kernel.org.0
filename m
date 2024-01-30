Return-Path: <linux-iio+bounces-2044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9FF8422CE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 12:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82E81F27B23
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jan 2024 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADC66B54;
	Tue, 30 Jan 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gN5nViwy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AD657DD
	for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613522; cv=none; b=TdmJyrkh9vwG/kbIZo9JeP/o7SMZCEuBSwrv7FpIYE+HHU1lcl4aP8hj6GhZsdEw4Ya+ocoPIch7ls/c9EyOlZOH9PJVuXZJyq7ADG9hBERdTOXvp0v3I+HSHqYfwTrrYivu00S8zsLyBQyU1LKHYZN5oZZxtKYrq7W5/irvk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613522; c=relaxed/simple;
	bh=kGS2YlYpwkaMeLuYA2ZJo9VryN5LNnd/3OS8jgCksRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3V9QBh9xslfaZ1GC76YNZsEihy5cGf1G9BFVfYiBgqQXRw1hC6nQtGPHgLX1owc2DZgL3mhmEruWH6ajvxmKbDxxUAFW4fMqPolliAIwwDku4aZ67vjpH0mUZMpPBvPrJRwH4z+MPQWE7cPNgpsiB0SJQ5yQPYhHVXT0NfrWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gN5nViwy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a315f43ecc3so378590866b.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706613519; x=1707218319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOtNl4cKe7GBawJQPo+KdaP0XIGpVVB++fTiPzkFZX0=;
        b=gN5nViwyIq+mAad0AUgZIWiljRPN7K0k1UbDJ9u8WH6WZjj6luj3ynXhHB5CdB2Pgz
         +7qeAFesteomf5lysPqhVXl6Qk4hUyVUUBUPQINMso0AsWlVxO/koPk6dBvCFQ+1D7Pw
         nMlKJrq4ogmajAi0yynsCeMe6Zv58+4pKzT26BHMYGZ2XHRAQZsffftTGrlvEIVOVdBM
         NTxmb/eiTa/Bc9tx9mo02bdEFPlyAOk38jfErBl2ayqn8w2GxMZaMR1kx3fBBy54e6z8
         BYpm78YD5dIYTg/XCSR88aU4O+2gZQb7vj1ILZl5ZQ2WuGXoOT8CZ1ZTzisfTDYWRVPo
         oWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613519; x=1707218319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOtNl4cKe7GBawJQPo+KdaP0XIGpVVB++fTiPzkFZX0=;
        b=oy0Akz+nvL8qq6IofLi7OsDAqtkBEPn5HMFQ3KgalOCRY2cdn7u+0gWcd+Eips+O1h
         sTmi4jHrumwgFNpG4ZnmH+mNc8v4TYaScJM1QzaoHhy21xNz33VWduRtThXqFkL4PFXW
         5hLnkeAWyYyfJHB0tnhhrdyve3/g0NVNNlUx33vsHLAtr6uvbePaK6Fm8nJAfm03a8n5
         PY8IlZVqOJpsPIhuEmumGbeoMa3kWtqZk7E/tJapKESsyYFqaQS3PF1DnaQsdTyVIGBR
         dCZKzhIroBiRIOaNv4YKTVwRLer1My++tWik9kx2MDipGFoM0YITBiAaD3JRPoat4vAg
         cWrg==
X-Gm-Message-State: AOJu0Yxw1a9OaGyOr3b1GURnF5+1dz3QMrpsTpc9PLYJ9AOdTxvI4Qhi
	VAtdMrtOqHBLRNzvygYfWdY4oSkC/qdOCcH/uQ6xPUgBdbbBkINyYDWC6gnEjik=
X-Google-Smtp-Source: AGHT+IH/ny2CqOMsS25PWFkZVT2GcF7qm5uWsJ1Y+uwbTDUyS9YsNWk+xyeJG3SSE0spkJqW8yAFog==
X-Received: by 2002:a17:906:6882:b0:a36:3d9d:59e4 with SMTP id n2-20020a170906688200b00a363d9d59e4mr392530ejr.64.1706613518942;
        Tue, 30 Jan 2024 03:18:38 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090634ce00b00a35a11fd795sm2559079ejb.129.2024.01.30.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:18:38 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
Date: Tue, 30 Jan 2024 16:48:29 +0530
Message-ID: <20240130111830.4016002-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

voltage-divider is always an iio consumer at the same time it is
optionally an iio provider.
Hence add #io-channel-cells
Also update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
index dddf97b50549..09f10d7c4e02 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
@@ -39,6 +39,13 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  '#io-channel-cells':
+    description:
+      In addition to consuming the measurement services of an ADC,
+      the voltage divider can act as an provider of measurement
+      services to other devices.
+    const: 1
+
   output-ohms:
     description:
       Resistance Rout over which the output voltage is measured. See full-ohms.
@@ -75,12 +82,17 @@ examples:
             spi-max-frequency = <1000000>;
         };
     };
-    sysv {
+    p12v_vd: sysv {
         compatible = "voltage-divider";
         io-channels = <&maxadc 1>;
+        #io-channel-cells = <1>;
 
         /* Scale the system voltage by 22/222 to fit the ADC range. */
         output-ohms = <22>;
         full-ohms = <222>; /* 200 + 22 */
     };
+    iio-hwmon {
+        compatible = "iio-hwmon";
+        io-channels = <&p12v_vd 0>;
+    };
 ...

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


