Return-Path: <linux-iio+bounces-24441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D752BA168A
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4651E561055
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 20:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4DE321421;
	Thu, 25 Sep 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLgDqBIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705A626CE11
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833163; cv=none; b=BEuz8CL/ETN2Jp++A4ZwFeGsXS36CMaDliIi8HvUDHs4d/DUoYbVnkufyFYn0idDcF4gGO6/N0liepWoEmrA0w8f4BoRETrZIRXpQh9GpGXsjbK0jT1LwiI2toBKGzKU490DP+hE3NAbzS74sQWrNNJ4ExPw5ZgWYDuwFJIy8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833163; c=relaxed/simple;
	bh=RWsMT7+A3hOigM/6lKe9y0xp7C7c2WQ715Dnkvpx1sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu4wcAcCge/FDdfg8zIGOiFxL+ZETybp8cjPV5pEG4heCkWpwLMWM4nVmYvm1vUmJH0Gzhwi/KvC31rWvKLV4JCHqTzeH7U1HIQad2x+FR40zDie/nudTty8PIPDQeht41GzDwEcEAORlMrRAv+/cbmNg9kbZ3kxdC5xYqeALBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLgDqBIv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so12062345e9.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833159; x=1759437959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EXqlzb/n7e+U7sXee7rlDRiXcbYy1hChaEgy4phOls=;
        b=HLgDqBIvrYXMXP04jn9b4Uhuo9rCVRop2vIs2SX9xljt38rQU/YpL0Fx8+W46oBQZR
         r6Q0vYb+8Y/QyCJonJJl5EvTbu5zWqgZTkBqWsLHnDjdTxuHqD4Igx0CGRazIHrk1+p5
         gh6gvTeLsn5xTuxqkbptwMAeSnp2RPZ/scnpeKeTwIQZQNmXmMLLxRrerwamSR7rL0vf
         qQVpWHs9EUfBxERM2Iw8NScgX5IMdLAPRy3wZfpdj+nN4bvmqTSoaf3ELI7Xqa+JDU6f
         3pzsrpV+B/Uf4cGapwMcJv3RHc+DiiGOFm86eqyaaTTaH2BImbb3Mc0Yk2Kjxiddgd3O
         RLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833159; x=1759437959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EXqlzb/n7e+U7sXee7rlDRiXcbYy1hChaEgy4phOls=;
        b=HCKFrP0IIkxz9yQYEAis16GL7eW+39I0+gc8XMnjijWs0/2mU/5gTzTdBW1/wreiIe
         cntq2dNf4FdNR7m45aelIVOu9mj58TRquAHzfxl8Kxlp+L10obK4p+yZkJuTmr4TFReG
         o88HFBgV/I0U0JHmnIL8VVRNfavGEcAUxKjkuCAONGLraZ0OIVfSJTsSUHrAoi268e1f
         1o9StizGXte/rpZ7ggxNiTaaTd2XEth3sbtkwM+EEJtYzPZkq9R2osOBUgg557QX+OTt
         99wbNUwykjPTvDjjfN8mziW8JDe5XPd9r2qyh890qEagcuYp1ZJyIW5tV7mizS66tQd3
         sYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyso3eBJWpccM6rb+ZNzl5ssNVDY8iaYnPWAJXVPCjBuGwQJeV99FnK9T1fyXFu2TvtfSTcKEYWno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRUhgnJUXR8GyuU0oDni3GtdC9/nvcjzxtYX3fExTlMFUY9t3
	aR5j0VF3OxwrmiVDMiR6rp4ybLDg2aqmFDtdYuoOIaaEWsLDQwp45Otp
X-Gm-Gg: ASbGncskVQXtpggaxyt/SerMoV5lTRiZMbo3J1aXhm1QsO0D2rTDZtVTuEW/uoPm/1s
	FqOmp9thdS5hviaIqV/nlJppEu+XoCBrSk9DWkIDA9XcHiWiwgO22J2NIC6kkvVaIA+kcVry72v
	+VOZdvMQl5fqphP8DvsP74UGVaFDfWr/yZRVRueoLTLopiHSVQ1rIWML5x18j1yrm3gc8NvveZv
	w2U5MBX8P0m83O/8gquqQsrOdWhW2jBj/S1w8LV9qY9uPKIBQwfg7MwYlmxsxjCPNUvTz2x2yVf
	VXskzoUia00S3X21uH/ji1Ph5ZKBg+Z60s8gSdvOgbsuihxTD0VljUuuHmder3gCZIjWwrEzPc2
	XBr4YxJbNwS/n0Wt6N9DGjG5tgtY1U7Yp3yBTf+8=
X-Google-Smtp-Source: AGHT+IGQ00c8yLhRFsKEKF8310MPtSUTnfr1KkARNOF+iixnrySN5lLqz/3E1NySce4/V/DN+APhFg==
X-Received: by 2002:a05:600c:6306:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-46e329a8503mr40457695e9.2.1758833158549;
        Thu, 25 Sep 2025 13:45:58 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:45:58 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: pressure: add binding for mpl3115
Date: Thu, 25 Sep 2025 22:45:35 +0200
Message-Id: <20250925204538.63723-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925204538.63723-1-apokusinski01@gmail.com>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPL3115 is an I2C pressure and temperature sensor. It features 2
interrupt lines which can be configured to indicate events such as data
ready or pressure/temperature threshold reached.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../bindings/iio/pressure/fsl,mpl3115.yaml    | 71 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 71 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
new file mode 100644
index 000000000000..2933c2e10695
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPL3115 precision pressure sensor with altimetry
+
+maintainers:
+  - Antoni Pokusinski <apokusinski01@gmail.com>
+
+description: |
+  MPL3115 is a pressure/altitude and temperature sensor with I2C interface.
+  It features two programmable interrupt lines which indicate events such as
+  data ready or pressure/temperature threshold reached.
+  https://www.nxp.com/docs/en/data-sheet/MPL3115A2.pdf
+
+properties:
+  compatible:
+    const: fsl,mpl3115
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description:
+      set if the specified interrupt pins should be configured as
+      open drain. If not set, defaults to push-pull.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@60 {
+            compatible = "fsl,mpl3115";
+            reg = <0x60>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "INT2";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..918d4a12d61c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -113,8 +113,6 @@ properties:
           - fsl,mma7660
             # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
           - fsl,mma8450
-            # MPL3115: Absolute Digital Pressure Sensor
-          - fsl,mpl3115
             # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
-- 
2.25.1


