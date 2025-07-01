Return-Path: <linux-iio+bounces-21218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B2FAF0699
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 00:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A73B89CB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93126D4C2;
	Tue,  1 Jul 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRX/VJyq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8FE1A0BE0;
	Tue,  1 Jul 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409230; cv=none; b=Cr+WaqZEHTZxGaEDqGb5W1hdLnBu9scZlbruBWypD7y1WngACjF0Qz7KbKMgUvcvzIFNZC+zpdPeumdzfrwLtNVxPEFVgsMBCJ+SxN11DOq+BuMZFZi96t/irqev1B9dfoui5+7YxEuXkS4cW5tB5TzAWZ+n9sqQVfcWr3wboms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409230; c=relaxed/simple;
	bh=Ur6wdFFznd5ybB3HoNgkMigzcqlEJVhwelZY7J5qVGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaoZ79HhP0X2W2FQ3URLYa7ylTIAsGTCkzx1cIBLQg37ZbrVT6TpdpS2UafY065SDc2NWvu9TehuUMyzmZXguS8fmvXczBzLlH9zOvR/q5XTrc/qXOYVE6xSEvV70Wpg9xaLPbyks7oQiWd2TMtJ+ZRhBS/wdinCk2w69SyOrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRX/VJyq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so58728991cf.1;
        Tue, 01 Jul 2025 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751409227; x=1752014027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kyOSdbD4Kz3s79/+GLCVgDXW+uzhkik8u0Q1mi1pVE=;
        b=eRX/VJyqaqOWAAIGuGgp1hmptpCCzq4Wfy7X69jk8ZypXOvFTBlJIMMSTRz1KxtBBh
         M5SxTmlDIt6cZEnGcss+Ourw/uB4QwMcoj3e4XpmmC/QRMqEztQzmgb+VYE2sLEhZZ1F
         GtmSc8vn7JRjZb7GRpKobvEOG8sFjcI6pmQRL8yW164tiwKEPdgOsGIMNmHan9T0NY9B
         X1tyv0ruC8tQQ1uWDvKfOJFupoHV7hRZLgPwGh8ubBtt6ev4u/+IZyKs6klF0weiNWMb
         nrX/0WxtoxsxM+UN5qI1GvPoEz58i6AIKuQkEMStD8uSFsgQb2oO6KTeJ/GML+94eIeo
         PqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409227; x=1752014027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kyOSdbD4Kz3s79/+GLCVgDXW+uzhkik8u0Q1mi1pVE=;
        b=uBPOMEKumL/hrltopTO8JczfMn0dvYGazvFbSLSVUYhR7nI4UvMeLJI2gmyqFexDO9
         IWbvHSTlBiGgGHMWgzCmLVTRrMgTAE7TxI6zqkHDBUU/Yn996tfxW6iORU0gifRaDO0A
         vZr0RUUP56vKRwVBvgF4R32G5mmw3QBI6TSB0uQtvWV44amL73P0KJ8lovzzjnHQtmvJ
         4WDgzrrCtyYyQR/B6tg0VetWpgoqNei81/9ulDpIlsgGewRtgrRbylrRKtNRzeHgK+3x
         nnMcH6VPkIg1CMpJRoLBNAytSLgaGUj93QOs6O0Iak7GhoRYs5BgC0qjYjWFx7RFquDz
         AvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTSmNh6OgZcXEzuCcyNPrG2ueD+Fbo3Y0pSVt6ZEEcj4F4NIPOjgZHqld5BEPsQp5M7NEgqkHn31zq@vger.kernel.org, AJvYcCXH0zRC4uO1ocN6OVA1Sqp8aNJtfJeRJp6GtQhUY/mIFec01ZamT+4eCNAMSfDaJvc5gAjOS9apn4b8g8kY@vger.kernel.org, AJvYcCXu+CnfSP8jR5Pm2KZbCdDRuIl0XPbET6vlcR8RQLajg3PSuQ5erXVzVqeGRv7Ql6WSHN0kM3cQr0bd@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQ20zco9a8owa3PGJ7H/kHJaHjr7OyjSYWNpTLuSd8XWnFDvQ
	VgLvDT1HaziT3Ky1XuFlODQ1OFaa28I21Ia+pm0RxnVv/VxCK0vLbNon
X-Gm-Gg: ASbGnctPQbvbeu4/GPve6odFgvyS0JQpF/xN9Bmi94Z1kId8n28z5fnbzQrdUSjCXdE
	Qsnmz+I/T5B7rwAdzn5zLSITZDCQyUiT+8tNmxsss7zuBitGKyOpjpZxI9Km9a6yCCNJf1RK+nt
	aAjBxLmnSmoOOCW9Q2ni7TmKR0/d83x6KvoEJ86nXqPJOmT6dj+jyJj/Bg0L1hddlUwt2N8QlMk
	G83WV6k4t/wLnEji5v9qQWcTfeNx8vGMcNnlfNANbGfYj4xmzuaBNnUNFjAoEoCWpr2JDkfTs32
	pJYCYOinJmzODFk/qGBgX7/bC0XLSMMwTrydXCpg/dlGkL3xhI8kXNTthHryPR3o77NoH//67+P
	v4KH7mQfHPw2ACrRfUspz
X-Google-Smtp-Source: AGHT+IEhD03hyOOVoL7g1f+KmGinRUs2uSWAf4HhY0BvOqWE0uArMxFWLux4/CDVgyejOy6hnHzlUw==
X-Received: by 2002:a05:622a:188f:b0:4a6:f81a:4443 with SMTP id d75a77b69052e-4a9768a162amr14776931cf.5.1751409227401;
        Tue, 01 Jul 2025 15:33:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:632c:d5cb:2b3d:e72b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc55cc6fsm80726231cf.39.2025.07.01.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:33:47 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: trivial-devices: Add Garmin lidar-lite-v3
Date: Tue,  1 Jul 2025 19:30:41 -0300
Message-ID: <20250701223341.36835-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatible grmn,lidar-lite-v3 is managed by the same
driver of pulsedlight,lidar-lite-v2, which is a trivial device.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Fixes: b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property")
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8da408107e55..cd9d7d5eec51 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -107,6 +107,8 @@ properties:
           - fsl,mpl3115
             # MPR121: Proximity Capacitive Touch Sensor Controller
           - fsl,mpr121
+            # Optical Distance Measurement Sensor
+          - grmn,lidar-lite-v3
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
           - honeywell,hi6130
             # IBM Common Form Factor Power Supply Versions (all versions)
-- 
2.48.1


