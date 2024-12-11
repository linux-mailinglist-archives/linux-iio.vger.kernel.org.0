Return-Path: <linux-iio+bounces-13374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B716A9EDAEE
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72841887A72
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032DA1F3D33;
	Wed, 11 Dec 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOLkl+dm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3B1F2C5F;
	Wed, 11 Dec 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958426; cv=none; b=dhCdD+aKjHaGWL3QbBmLYvnw+seKFsNSIZOW4BSvl7Y/2LbLmH3sJujTNya2YkSwLIdeuMwlL8xA73nMnErMLEdVb+xppnvXBTwBTJdWqtXKVm3Cnqdx7gmoS3WP3F+3IGNibCk218QEkTgcou420ZnjbpH9njrf0YaHIiOLn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958426; c=relaxed/simple;
	bh=eNdXn7NceJXq1oIEmRCXkUh+Np6+3pkh1tPJdSSMFZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shVq0PNd6mjRhL23iCh5YZPc/jDvlua2iqm4O8qEEXHDm/FS+fXy1LWgeqAbz9tuYWG3jpCccKoiTPblzp8D5C2pqnekMlPduOkcNriZgSOAeNHfasRX2NDRp4H4C7AEDATb3hUiP3b5KljbN9CoAuaHa/9fnDyF1n3FVw3S3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOLkl+dm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa680fafb3eso52276866b.3;
        Wed, 11 Dec 2024 15:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958423; x=1734563223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z7lFECm3AQjaZy7M+SmPHtp3Ebh5+HDY93z6/0ZpTA=;
        b=OOLkl+dmdIoadlGZxMwe5W3imve0LEg+bDv73DVALx2OBivJJZiHQG9GOozzW5FVpq
         KgCQg1T6lhtbspQXvmMnJUnZNOW52AFM6NKoLKATRtpSqsCysTpRhMmEaEm8bRofHIBi
         ufMoFfGHpI1I7uVnB+qIXWzZyjdddyTtISUrhmMpWTsJaYfEpnA/+djckuoVcOm09HQN
         ePjPZer1bHOnX2tVtwe1y/KWoeS4TQ42PaT1RSWED+J7hD6V8cD6NifFmdk7uYZ02M/E
         6Nd76UWtT7Q2zP/Tw6Yc7mH6KKkTORJzLQyUtZ0syrA636Kz+8Ip7G13EQc5jhgqxuZ0
         5WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958423; x=1734563223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z7lFECm3AQjaZy7M+SmPHtp3Ebh5+HDY93z6/0ZpTA=;
        b=DQj2UJmQDFxprqsc54oKpFIpYMVwVx6KCoZTdDxc06fiPy8swvbTbKlJptRP8ayO2e
         xx6iQOEMrINRmKon/aC5ktD2Ly9onune78IVJrILEHdnHl6IUWZAGzANOsl9u2gIPMsQ
         +m2SVmkx5JmJDvtHpXHPBG6BW3Z2uVCXqylYGu8jR5p+YGaTggvCfnlNYKJgZbwqEyy9
         uEhZIyKUtn/dmASadQw4FzOvEoqwi1Vz/HSd/hG/ZrfxJExX4QudyiksLPb9WCkUXtjf
         paClvkXhdxpFkjfMxKBH+Uv57Sims6kFGVUSPqy98cpx+LDPZECAyJKyr7OKgpDFC/zo
         tYqA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJWbxMtgMpHyEXfPKoIT7jLPNfDzqG4teRZAX1bKzAF0SI+2658DXsg1xj2+4zgAg8gg15eVAt4qfbhPE@vger.kernel.org, AJvYcCVgJHNk0IpxCIpuSmN1TyXJIwroxwCgQXY3eiQ8w0WsHBLGLD5UE3e9JFNKbWD6M0AptCxBBDYDvi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjN1YZmecJNL0L42wO8PVrjQnwAkOzgkTFFiyb6VptbBvEBeD
	robQX518c683kNifejRjmHJHDRb91WYc2liL8lMa1+PN8OD2KyKW
X-Gm-Gg: ASbGncsAmBISskO8oALNQ+0wymX4FbiwIkd2hQLU+VG1CHkxa5//ID5aeApC+yx/3e9
	nXQHf8mYSModJnaLDztzuqj3qsf4RBh0fwxj3oW2bzOuSkEnqAMpg2cc2oMJAP+CmQ/b0/rNObG
	kNK2gxkLfzl7wD37oHYEVEcJJGjw1bd7QagZXKM6T2sOqEKHlNENp1Wn7kHclEcvYLdLUnixs9p
	OUZa3Y9dBXDLh55Cj4zaTRVHZXeaHtwVCi8OD/2v9qbzlkW4nRNrRDNBQZcErRtfI1MMbf4h3GB
	mymO2h6Gmx+d02soX8AanJMvfyV/xOtk
X-Google-Smtp-Source: AGHT+IGO+oPBgBBEczX1RCqAD7vN572wRMfy+QkrNc8EKbcrChq6BKQ3emh291CVaE9LdP+ZRTPWnA==
X-Received: by 2002:a17:907:94c1:b0:a99:a6e0:fa0b with SMTP id a640c23a62f3a-aa6b116812emr187323666b.5.1733958423203;
        Wed, 11 Dec 2024 15:07:03 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:07:02 -0800 (PST)
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
Subject: [PATCH v6 3/7] dt-bindings: iio: accel: adxl345: add interrupt-names
Date: Wed, 11 Dec 2024 23:06:44 +0000
Message-Id: <20241211230648.205806-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
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
sensor will fall back to FIFO bypass mode and still measure, but no
interrupt based events are possible.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 280ed479e..0fe878473 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -37,6 +37,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    items:
+      - enum: [INT1, INT2]
+
 required:
   - compatible
   - reg
@@ -61,6 +65,7 @@ examples:
             reg = <0x2a>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -79,5 +84,6 @@ examples:
             spi-cpha;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT2";
         };
     };
-- 
2.39.5


