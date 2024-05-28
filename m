Return-Path: <linux-iio+bounces-5399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836968D1E9B
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E32A286757
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C38170838;
	Tue, 28 May 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsHs7Y2l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978BE16FF26;
	Tue, 28 May 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906285; cv=none; b=EIdlNalr7Vb6oeJTXlE6pUqLcjNADq6orB2+MuJ+pY9hMgifoU6tquE2GyjoEVsDxTJ4brZw3LM41VfNhSx9Y3B6fy3fAupaqdOl7Qmz5PI5hsXOqQZfUVfXKg+36zFhsB1Jbn2N1YcH4lkFYydFUN+xk0STFA531/JJUaqE/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906285; c=relaxed/simple;
	bh=liDXXVG7+jQ8j+oBXW3RimuL4xRzdKCL+2zOICN0PdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp/7JaXat8N5Ubm54UwekxKpttrScG7D2gRc3/oaM1WxfkZOgKJDzD1zYYqwHyv1UUyUvTuzpRY8PNIXCxHAc6foEX0zXEgySwtxRExG5yGFhItdDNKGGrHUBwNGth2yBIjGdEhXRcydEOZYSqJ2Y4Eus6r4MIhVawqipkRpSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsHs7Y2l; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a635c83bb7eso11152766b.0;
        Tue, 28 May 2024 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906282; x=1717511082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wseiunJrGIIyj8awYaIYhXek1PnSx7l5YTva15LcNDw=;
        b=EsHs7Y2lsUUI4SW9sbynLLFx4q8F4c2jHw73TB73geEtpYw9bi0wQ1dBuI/6exmpNk
         kWCtNYp7s+cyuCpY7R/ms/uPZN2Rl/68csX8vJ9HkghIPwLXpGb8w2uCeW6/Ka4A+8q6
         7OVW01ldacDeSKLSRZJ/xUBYcNvT+xJDA9sj7umm7ep/t3CgGEehJ3rWXnCrrToMydiX
         pFoeohWxUgaThrqvQRChEQWMIPXMm8CLZyayU643n5AfBheRrLSElumhcxQZ0kKJDFrs
         7oUTwgBOb5fD2vFUPIQrnqASh6XhMP3V4iUgpvZWg75UJPxcZG2P9DtATQQUUyFiKzqd
         uNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906282; x=1717511082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wseiunJrGIIyj8awYaIYhXek1PnSx7l5YTva15LcNDw=;
        b=TIsc2ehkpuID6JdPf5Are8tKDWwATmEnK8D828yKP+G6kpheDelYioicBS6IYSTmbO
         cBwEmj+pn9GBocFBfDxJDaJutpMG5h1BIE1C5RyqH/HSncbT+Fe89mMwkHsXR4rK+KSD
         RQj80dCdSzyLKUwBhhKcCWExNj4MBItpCIxdaw11bU7P/eZ6p29e436O3kr1iIxDvj/+
         gPyqDcYvSxadW7862IY1tY5rBWPKlmbPfRUHRJzY2VTlodfGekRwFWoP4lIvW33gv6RD
         9pIx0Z+sqkk0LHYxSnm4Z81PtYYZZO1ZpuAlUPjrOVbvY01W6ZtzVVf7YHuSbOfGE5Iw
         xPrg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Yh7kp6SxIruFgRyzF/DNhCQR3oGNh4eAYH8ZbyhG1AjpRUSSR/P9NtPOQ06NYp8bS0bN3vi7cCs7GpSlbPuRcwWErXs8INYRRLTNQqPdjHfSKfF1CG3Ti/uiq7y0b2Ca5FViTn9KZ0K7X5Gye0VxuTp9pq9yfvwlY3qvk5O79g==
X-Gm-Message-State: AOJu0YykBqzCp7AIHptdOKpbm+4oAk25okfIO7MP0qnf+4iYzA1uiBj4
	uQqqX98dYBxKK02XarAuXT5QimG3vF07CWl2iNCYTXjaP/hAcSxaslUJroQ7QN8=
X-Google-Smtp-Source: AGHT+IHvA08i8QamKiZ58gTTamfZdJV+p5hNUVrLMDt5dxAW5Q5YnomMPGo2zg0V1ndg055/dKoMGQ==
X-Received: by 2002:a50:9e6a:0:b0:579:f196:487f with SMTP id 4fb4d7f45d1cf-579f1964978mr1951212a12.31.1716906281536;
        Tue, 28 May 2024 07:24:41 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:41 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 3/6] dt-bindings: iio: imu: Add ADIS16545/47 compatibles
Date: Tue, 28 May 2024 17:24:06 +0300
Message-Id: <20240528142409.239187-4-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS16545/47 compatibles. Each newly added device has a different
angular velocity/linear acceleration scale combination, as follows:
Accel dynamic range:
- 8g: ADIS16545
- 40g: ADIS16547
Gyro dynamic range:
- 125 deg/sec: ADIS1545-1, ADIS16547-1
- 450 deg/sec: ADIS1545-2, ADIS16547-2
- 2000 deg/sec: ADIS1545-3, ADIS16547-3

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v2:
 - updated commit message
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
index 56e0dc20f5e4..e3eec38897bf 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -23,6 +23,12 @@ properties:
       - adi,adis16497-1
       - adi,adis16497-2
       - adi,adis16497-3
+      - adi,adis16545-1
+      - adi,adis16545-2
+      - adi,adis16545-3
+      - adi,adis16547-1
+      - adi,adis16547-2
+      - adi,adis16547-3

   reg:
     maxItems: 1
--
2.34.1


