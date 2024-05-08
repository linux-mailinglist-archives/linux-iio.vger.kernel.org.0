Return-Path: <linux-iio+bounces-4876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65F98BFE13
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80280285D01
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7771B3A;
	Wed,  8 May 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOTre3FX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015B6A338;
	Wed,  8 May 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173998; cv=none; b=oJnfgOolsK6/4ORV3cG+oG0VE7SCd7uyUJIDtB7bDJTQPjvtO5bXkt57VZ5bvcrytpJQrbm3AshN2e5qF2bjW6tnaVP3O7m/SPvsGxOukudbTz31HTGZrHiq4iIkBX0brOlx+wg1OHGdaMlqus9jP6yzPwPOAm7lGJzvUyncuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173998; c=relaxed/simple;
	bh=9zSFQR2pGZhUOaid3u8PXLRIFlLlwtqKVGoRxSlKsAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RachTwKGtJsVJehEhPqapwy3mrYTkn49m+jHNLymrblDIJ/LmCd6lclLA1OGOSNmmZY/ey9c/c5YrHTf/7L0y0TuXp1t/Wy5WeSxEefOaFwmZAnwttTWHiwg+pOaKLqwOLaX8QA4KcCdWl6tvSDvzVSVUbUnLtzLILXjp8nbc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOTre3FX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41e82b78387so30762705e9.0;
        Wed, 08 May 2024 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715173994; x=1715778794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnT/YJtZ8STbmQleXum+ZqC2i9nh2Oy0JldN5QMTL+U=;
        b=MOTre3FXpm9FjCszDP32F6ADDeZB/pHpv7v/Q7A6AU9doOWfwv9j8ykqsb1SmEZGR8
         0sEMWUdvblKl1jFAPMc8jmHysBsoVh5wgmp+43a6uMWR80EbkDjqCXk+2s8nsnHOH3zw
         RoxoQh2v4zOGKPm9wIB+SDzrVus2iLtOftk4kmURBFoCOH3Zsw8W1G22xs3QMsz1hC7R
         sf8Zu5ZPv55ZmMv/1e4a/eNZvdD/ql+nKPIoKkdAunMCjffi5CEbySnaDBtYq4+84+ip
         Pgthg+NlVDdrpbTVg+aej3Cx2T432w36wR5NO6e8mt0WSEQMIoPhSr/gbR3BCwIVhhF4
         gv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173994; x=1715778794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnT/YJtZ8STbmQleXum+ZqC2i9nh2Oy0JldN5QMTL+U=;
        b=O1xwOHEh+KHt4KzIvbfMJdoD/E1yl90x3xKXySy5QI+veMqW3m02S8e1o8qFf8cmFx
         7ald2Fi2Q42kVWIV6NBa8b2ZSqKIgS1xXKoORJm5iWqkrMSHdhp7CV3a6NkmbxfATg7k
         e9L8FEL1llPuhx4JamSfjPrz4hTy1uFCQlwbrW3RciPkGtiyDuG9RS0+dBMgFeWYqEx9
         7f97xcOdDLjdQPzBqxJJnyMvXAqimoi5u9Lm1HFgOb5Dfdu3k88CuowkoQFLTitUmYo6
         JCe6xVPeMHUAfU3hWCZPsayHN+1S7nt+GeP49of0Dfn3/38iB4jzTngEM2bUHxSmbbVk
         /0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUFGeWUcVooD7ez/RH9oKSxCoKbmLMIBWNfeVsuLa5gF5MuNZJFjiMKUMg9D9PEz1Ok6tj8oGXn/KQyTMTiPKDVFBVedD7NTMWeF89yTJvNzT/o1AcmicpzIlLkihVCcVrnuubTw==
X-Gm-Message-State: AOJu0Yx5C20KtcV9OVTRtCKERJYvthYd4+jW7rj4MxXQoChmcNYXS8lY
	kI9L/9HCUa4IF6+ejve5tM3jQABjvRAR1txZ3Pufm0c2O1IwdWaeoOrNimobUO4=
X-Google-Smtp-Source: AGHT+IEv3bFEOt2IvBWG+X6uw2lXxB6cpIybgJ1x3St1+xpYA1Q8dMg8KPQnFPdpIfyz6GshB4wHBQ==
X-Received: by 2002:a05:600c:468e:b0:41b:c024:8e88 with SMTP id 5b1f17b1804b1-41f721ac5f9mr18819575e9.33.1715173994532;
        Wed, 08 May 2024 06:13:14 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:13 -0700 (PDT)
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
Subject: [PATCH v2 1/8] dt-bindings: iio: imu: Add ADIS16501 compatibles
Date: Wed,  8 May 2024 16:13:03 +0300
Message-Id: <20240508131310.880479-2-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ADIS16501 compatible. Similarly to other ADIS1650X devices,
ADIS16501 supports sync-mode values [0,2].
There are two differences between ADIS16501 and ADIS16477-2:
- ADIS16501 does not support pulse sync mode
- the delta velocity scale value is different

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v2:
 - updated commit message stating the differences between this device and
 existing ones supported by this driver
 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index 9b7ad609f7db..db52e7063116 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,adis16467-2
       - adi,adis16467-3
       - adi,adis16500
+      - adi,adis16501
       - adi,adis16505-1
       - adi,adis16505-2
       - adi,adis16505-3
@@ -90,6 +91,7 @@ allOf:
           contains:
             enum:
               - adi,adis16500
+              - adi,adis16501
               - adi,adis16505-1
               - adi,adis16505-2
               - adi,adis16505-3
--
2.34.1


