Return-Path: <linux-iio+bounces-5335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5AC8D04FE
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71751F21C19
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16B17DE1A;
	Mon, 27 May 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMGtCWa1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793D176FD8;
	Mon, 27 May 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819997; cv=none; b=OLr1ibf1azXPQ6M244BSKRS79kQ1uhAAt8aCHbtEd09hgXJ0vtrc5sX+wM82Dg/Y75yOxBeWcplM2XW15hHtPpjuLAYJG7WULIh6ESpbcQfg2KstV/VpiUECpvcFM/y1iuX6/6viqgQ78WMys7xYZ0AAmhte2BEsqZOwBey+rUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819997; c=relaxed/simple;
	bh=Dv0xLKCtZ4d76jsw2G+RUKxjBkQEtWQxE0mfjfwmZYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oU0vU94Sb8uNv2VoS1BE8vKa7rtnFm20NHpsllMH3MSnw/+x2luOXR3YcLr9eHnH+EvjDMg84Ekbg+SwfCuQKbSML8qXL95aWAc2bleueBzbfD/qXEDjKLdNMTF0ScNBZeYh7jhErMfwn7YPY5ZFdM6wQSTQsstUTauy2ZNWc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMGtCWa1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so110170635e9.1;
        Mon, 27 May 2024 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819993; x=1717424793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OBYE292Zh9Fhskf2+d0uj1Qw8NWUS0cqPxDEoI2PRk=;
        b=VMGtCWa1EcR7NVRjF++es5tpjNDEjyB2jRwdjummU0Paq3x+ixaUSxzqcljnzWrLS9
         HZnAZun27SbT5fPFW8xG8jf8exZtCOM1A70O+ci21Br9my400r3ZMliis/YNg0VBeb+G
         VZatqw76H+FxMPd65EDBlhF02Hb29a4l8AaRcf7KzMH7ta5B+xUhUwRlrwNWg0GylEMQ
         GyzGBgDBtsvQBkIj8uOijdSp4YMgBITDpVCSlRPi4BCG15WQi0leSuSYBna9dIn5110p
         MwsqLwNVkJdb6axSaQNd8QHUFxqgoW36JSQHY/nZFHmgyIASQpQje39v82mPbVQirzb6
         Otgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819993; x=1717424793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OBYE292Zh9Fhskf2+d0uj1Qw8NWUS0cqPxDEoI2PRk=;
        b=UBtYoHhV0FS0BHMF7f1rC5o1tfeVFdKkS1mfL2Isb4Xm5drrAmwR9gCN+3FJHLasuT
         0rooD9LT5iRLloiL0BDmh987PD4wzr3ru0zYjmjiXRXxjGi2CCf2ZUhTWB3VjAyvmYH6
         L7TiELicNAaXxWzB059PEfKOlzNCIo2cAppfro1g7Jhtag5MLB1KDBZSezeJOQSy3Pll
         t5MTBDMlbUI4go+zPZwDkcJIwBo7J+l1p7K8T5cHzm+mH/3LzftIeOzZ5DJ/zfUCFTNo
         IVQzcykuOaJjwvQtV5iCDpbZUx9pzfOTkdd5NmW+eOIEG0JpjFD4473ZAFDJtbDP2eSK
         3S6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZXgrpFW1ERfHiUO/g5Kb77P5NJoMPB+cGjfxcsigg4hRbYRuE+OaM+LEu1Egrtz3zyL1xhYanJ+J33LSz88gKG9Fxh3It5C7d6jL+PQ6u4TF3wbtyZceXofKU8abci5m2FdhyUg==
X-Gm-Message-State: AOJu0YwVO8Y7z/Hr2NvE3rVm5iVsO1b/xe6whnwlOQ0zjVKpDJfzCgmB
	yvYO3ecqrese6601X2ElHN2ByX+kQTUNqfqwKgLQJbdJUdB27qKcNchBAy5x+oc=
X-Google-Smtp-Source: AGHT+IF1mRnWcubwTo0syLbpJm4KLzzwBeWHSKF6Vr5YDDhEMfwH+/h1WXf52O0RkQTdlzS+kEosQg==
X-Received: by 2002:a05:600c:1c8f:b0:41c:503:9ae4 with SMTP id 5b1f17b1804b1-42108a99c46mr96384175e9.25.1716819993459;
        Mon, 27 May 2024 07:26:33 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:33 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 8/9] dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
Date: Mon, 27 May 2024 17:26:17 +0300
Message-Id: <20240527142618.275897-9-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS1657X family devices compatibles and specify the according
maximum SPI baudrate.
Similarly to other ADIS1650X devices, ADIS1657X supports sync-mode
values [0,2].
Each newly added device has a different angular velocity/linear
acceleration/ delta velocity scale combination, as follows:
Accel dynamic range sensitivity:
- 262144000 LSB/g: ADIS16575
- 52428800 LSB/g: ADIS16576, ADIS16577
Gyro dynamic range sensitivity:
- 2621440 LSB/deg/sec: ADIS1575-2, ADIS1576-2, ADIS1577-2
- 655360 LSB/deg/sec: ADIS1575-3, ADIS1576-3, ADIS1577-3
Delta velocity sensitivity:
- 2^15/100 LSB/m/sec: ADIS16575
- 2^15/125 LSB/m/sec: ADIS16576
- 2^15/400 LSB/m/sec: ADIS16577
Each ADIS1657X device supports FIFO usage and a sample-rate of 4.1KHz,
meanwhile the already existing devices do not support FIFO usage and
have a maximum sample-rate of 2.1KHz.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v5
 .../bindings/iio/imu/adi,adis16475.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index db52e7063116..9d185f7bfdcb 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -37,6 +37,12 @@ properties:
       - adi,adis16507-1
       - adi,adis16507-2
       - adi,adis16507-3
+      - adi,adis16575-2
+      - adi,adis16575-3
+      - adi,adis16576-2
+      - adi,adis16576-3
+      - adi,adis16577-2
+      - adi,adis16577-3

   reg:
     maxItems: 1
@@ -98,6 +104,12 @@ allOf:
               - adi,adis16507-1
               - adi,adis16507-2
               - adi,adis16507-3
+              - adi,adis16575-2
+              - adi,adis16575-3
+              - adi,adis16576-2
+              - adi,adis16576-3
+              - adi,adis16577-2
+              - adi,adis16577-3

     then:
       properties:
@@ -114,6 +126,23 @@ allOf:
       dependencies:
         adi,sync-mode: [ clocks ]

+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adis16575-2
+              - adi,adis16575-3
+              - adi,adis16576-2
+              - adi,adis16576-3
+              - adi,adis16577-2
+              - adi,adis16577-3
+
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 15000000
+
 unevaluatedProperties: false

 examples:
--
2.34.1


