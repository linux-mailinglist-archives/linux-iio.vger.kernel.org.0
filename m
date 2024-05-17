Return-Path: <linux-iio+bounces-5083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FB8C81B8
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3461C20E61
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5125778;
	Fri, 17 May 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd3HKYdP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7682D051;
	Fri, 17 May 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932086; cv=none; b=d6wqsDFVtVlnQaieJvnzx3OuJaOkKUYmo0MHYq4wWtK32UPFUV+KCbt39kyzB7p/zf9XncKXkXRosPyjYC67CepNbX/nvMyvYmkzm5i+pnIspxCkgDsKcPR5J3EjZmk+VE0DlcAk/VZoAoqlynJydg3hyBm4QjO60e6GjWF6dMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932086; c=relaxed/simple;
	bh=CnactspXWFYoO5w+2Ksy5byoYNmyuaYzCsB2zW4tpAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDYq5uYUQhKyri7powdDLLVcQF4xcO2UwJ383zBS/nnvhwpwkIhGfO9YPTV0ZLVUkfSbjOvZdLXzV/nNxYowaUkWJYlSURjvk4fDL0pgarNX/ZXylZw1Thg4AZSI3TtX9AX6os9NsaRMC+m6pgnFkCshxbB5/4ErcmnpuAObaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd3HKYdP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4200ee78f34so46349655e9.3;
        Fri, 17 May 2024 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932083; x=1716536883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igxMcXe+Zi7Wo20ehi1lnUFWbTeoBDJu/oEIHHAelog=;
        b=bd3HKYdPGFIUiUT180NqWXyqdfzRMJGr/XQbOsY3gBkLg8yHvV9GGzQy3SojgzJhtC
         1zEJugGIAtpqD+BzsvlX6gnDO540gZQyV/6YFoNR87gv2t/vI2xTIHKcYhVgAiZ2+2kZ
         017QyeaW5yXUvPybD73YzZMSxfLd6TIh9SLHGicAtsEoYmn7/4c9VysPIptSaH6w0Mc9
         iNrVN74JXnyeo9ez/CnH2BlUOTYyQqpku7HNlWWvWp0BP3NMi6iSfBxto/NYFm3c8znA
         g/c9YAORSlQPVPI0tYv8WUDU4iecWWtuiBRPpO3k8KvIP636TWJZmTzwGJXeRr5S+F7P
         j19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932083; x=1716536883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igxMcXe+Zi7Wo20ehi1lnUFWbTeoBDJu/oEIHHAelog=;
        b=AfjnEKjd/rsU0bqghZWgupeJd7E8m0PHFGUzQgxfYqkuZEUwlKgD0spnR+wg/toktH
         QbZNk93jxkY6mOztPCXFNJRaardDHloXk18O8EhpS5vTSqN9tZQ0tFBw0820idRkxwiC
         goWQ2oVefhBDJV9crbqIkexw0EGxrB/PzBgyeMiSPtwnOKR5MqyjuZ7FnVK5ED2ZulV5
         VVY3QNqKKs4STUIp3ZGizoU9sdnVRB/jwMUXbl2XqV2ZigWxSyyAkOnoprjopqwJguqm
         yGgM2p1ujRnKZHz0JOsibn76PxeDvQrwea0XEeyZCmjTTgXu/VveKpUKqT0ba/BXCvmj
         FcRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5MRHlE0Itb2aFDwd350yz9rL4SzVKrHwYoLf95L/o75OtdIPsovWmVavjOCVnCTH7thz0WWZL7MUcvUKkNgwdZQbgfxWlnz6ntZ2g5f73fJX/fYOAGf9heKYhedZJHWbl7rgHsg==
X-Gm-Message-State: AOJu0YwSJxtFGRqD05yXvAjOs0B8PNxZKC3fi315/NnOqXCMCN7HutuG
	7XHuRNWTKfURAs5LAr/SdhACo8m5IbDMN/xq6I4NywQOPbYt/Rr3nBrW4SPH8Ts=
X-Google-Smtp-Source: AGHT+IFX3vvrmp5FVGnvrtWKhwTlbY8ni53a5Jz+qOeBDVNI0r/zvHkUUmGLcpsbwVFlmAQdc7w6dA==
X-Received: by 2002:a05:600c:354e:b0:41f:fca0:8c09 with SMTP id 5b1f17b1804b1-41ffca08e22mr140381395e9.40.1715932083188;
        Fri, 17 May 2024 00:48:03 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:48:02 -0700 (PDT)
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
Subject: [PATCH v3 8/9] dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
Date: Fri, 17 May 2024 10:47:49 +0300
Message-Id: <20240517074750.87376-9-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
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
no changes in v3
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


