Return-Path: <linux-iio+bounces-5259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC38CE2D5
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C8E281C0A
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074C12C494;
	Fri, 24 May 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2z9J8Fe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C112AAC3;
	Fri, 24 May 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541253; cv=none; b=ksMqCVp/+XZhxLVeCvvPBUlUJS0x1Bs9Tvu4+ZVlnyokgzFF5PWnEp0Ibi+udj04eKrnoOl+uuZbRApQUgJuI6NUL6Z5gUUHul1phQWRRyM/CcZ1gbTcokJr6ZvG9Rh5uyc/H16qP/emgQv51rXhSu3/VnOvIQzgkgrJaJ7iL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541253; c=relaxed/simple;
	bh=xsQiD1UvO8gRIlIAtOrHigCFRrPOh5n4mRPVrc6X0jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QA5yMJqTW9ZT8yIYgCwNL1ZnZ8mEMK6xFdBPDP5X4+LAFBZg166rsENSyzajGf+wz+xJKkMCAY4pfCgMgtsVzW2hnDfVM6ymKjDwvCwXtSp5YStT6cFFZoN4nsedq2Eni5pp5okZ6maVkygVs0PQGFKhmD9W0Mc+moMQdXMyvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2z9J8Fe; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso60548666b.2;
        Fri, 24 May 2024 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541249; x=1717146049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmYQ7ZdnVtFOZaMvSmehe73jh+uAhVulow9jBpSSC54=;
        b=k2z9J8FegBE6ETLpKQIxrZ3ncOa2nriAbvT5H7PEBcUijLQzU2bI/Jksn77a0f3he4
         Fh3aMnr3D7lM3DGBrZeXhZosp9HedWL1CHhW5Oc/9dpR/cOwtdYiieOkkxLvxarEacYK
         OlGu7674zOQoQZYSN3MuyQfhygglg/26/yGjEQOtQ4kLZihJxWfqz+JYdpIKtTx3N0Td
         G2TbVKBSgv1P15guI1j2lVBV5HQbVnb4sMIsm/n9a4JXGRAsSHwdhN9Z+p0tOVwUn69Y
         1BzLBmYidvN5dHVrRhiP/tE2KVrlyIg1KqD1B7zGfwQqURmynNF1NkHDByv8djGXBN/Z
         tiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541249; x=1717146049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmYQ7ZdnVtFOZaMvSmehe73jh+uAhVulow9jBpSSC54=;
        b=sNuKNFwOnS8owax/A1Mo36/S5UtRPF8M0gnkhYUXT0MG5yh4v4sT6fFbiqP23U1p4a
         9cSj4RksFJwnVmiDdiKNgnEdJrxslH22/PWT9wDafZWklgRpoy6C5VlsUy+0sG7oZfff
         WriFHStrPUfzDPmhy4HUKFfGyE8YarYDqfiUxTXSkRgO5NZEDN+fvlD1YEcCPvPv9Cfd
         NTs4BV7o6FlNCsu4utKcJv2arxGsrXz4H6fmz5jAd8fSx0CjuPqTgFsy4DlUu0gtEsu8
         YC0pszxHXholdQWApjDBNVbayYtt0ctd5QGMDdPR7jelcmkGbPTNHcM+K+5ZFurYwy+z
         ljyw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgfEirMKxv5nVwnUDdjP5zEZPQhJIVmAnOGUSF5/JfT+K6EvFcIoOVnnJvzxr5LBc7g1zM5spgrFAiwxo9B6I220q0CgXeuAEcI8xkFT8ED93Wk+XY3t3FlZ91h4/NyB1D0yxiw==
X-Gm-Message-State: AOJu0YzQTPpxvQ7Rpw7e3D14FqMzNpIVX6GZbMNxjO8BsqiAhZCs/QKC
	jizHtZhdPbw4rHnuRiM/D7EY9qaM231fh1yZ9NsxyiZWpKNTpgDozCfrlF07qts=
X-Google-Smtp-Source: AGHT+IGsQLAwbR4+55XTTlrpTjDaAKvHVmKg8ubImlkgR/WtHIy2t2pReFFC1NuANAkAX+yUGJ9qpw==
X-Received: by 2002:a17:906:e52:b0:a59:cb29:3fb8 with SMTP id a640c23a62f3a-a62641a392fmr107991266b.1.1716541249336;
        Fri, 24 May 2024 02:00:49 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:48 -0700 (PDT)
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
Subject: [PATCH v4 09/10] dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
Date: Fri, 24 May 2024 12:00:30 +0300
Message-Id: <20240524090030.336427-10-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
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
no changes in v4
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


