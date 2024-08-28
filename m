Return-Path: <linux-iio+bounces-8852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32341963300
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B042864DD
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81AD1AE870;
	Wed, 28 Aug 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLzLpgWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D661AE04C;
	Wed, 28 Aug 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878304; cv=none; b=aB8DwMZKmMTjgctzK+GAxZye2Rdc8WjSdkfAiIRPatyayPuImgHJUJYxZ5lDv3btEEeCr96axWUROEabR61An0jFN1RF1QqbcZ6NNMNzu3PU7F9RGswvkuXeH4e51XoFyWjEpGLOlHpnIBKCReUaf4/3JOQ/klIootfaP9nEam0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878304; c=relaxed/simple;
	bh=nR1UARKtJbgTLNjrbNerSzHx4yuTclXSA8lj7rB331s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANL2YNUr3/TjRwLk3qm6VO1a17urpNfiDWn+YPtPEfbvoPyUZvVUjYcgpSt0zLvcFC06xZiTfieRsqJTSQeb2Sct5Hv/wwJFdgnvOlp02DLiuk7/YQBiEmpJEmf/0mKT5NJ5xMAMLu2PYdSjuiwDAgPfk3v8+D2db0yTImNW51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLzLpgWF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so1955583a12.0;
        Wed, 28 Aug 2024 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878301; x=1725483101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8nxfW+rDWF5El11bTwqMOFX+cAJkoVWHy2J6xFbSEM=;
        b=JLzLpgWF845FaaNSErrHNkSU10wOmUf/u+gSXxCd/uq1VIp7oe54QieM6XQ5ePFygI
         4bwJwUCQlX1d+tYR+IbvlyD4lqqh0BQSQVZbv9ag/PJl4qkiy/gIjq6NiNwBE6n9Hi2d
         Ifh/FuZ3dk2XlkATeGvUv38iy1eD8VDRnmq/zij7U380Hll06F19UgJZPSU1ENQ5qCW0
         K3ksIWcroXCdKClJVi0HxiTZzvMmdk4RyuEhiMtY1iorsB1GaPTSfu/5UgqhmZBTZNef
         vLp0eecmppfR1BYFUeQ2YlN2cGUAs4n0eMREb1y7DldptSjjO74AcoLa6wfsRHf8c2Pg
         7QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878301; x=1725483101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8nxfW+rDWF5El11bTwqMOFX+cAJkoVWHy2J6xFbSEM=;
        b=C/+kbtxEh/T27yDm8QKhBo91oXLuLtPsc7kwwUADu43p/TTDzy8JiVQpSOFlm8Pt/b
         PHkAI+p2IP/lqE9/Erwl6GByJaETiQFODHB/kRZ//IXJaYGt/VnOzmXNUiudXvqztxLs
         mThZqOdbH3YpWwybi1sEKUHEyVgO8xGlawpNidqOJNjOM8UUhfaoY8WJrKPLJckaZCOE
         utuCSgp9HFTbhMwsE3TBhLO1bT97Dfs7wz1EDab46SNXr2YyHohd2AoCk0kh/03wRx8I
         VpCePu/f76TLw5mRNJg7s5BRCUQMS5ityjDUA7cEw0zxKAltm6bX+5Lwrb1ujkgphK0U
         BjAw==
X-Forwarded-Encrypted: i=1; AJvYcCUGY+FvnM14wG/JTbFRYa6N6FtVTqFfwIiAF2/EZxgvGmyE5tyk2T1zaBA2ZUjKm761cm9rLgL6mZtf@vger.kernel.org, AJvYcCX9EHCUupQH3rpQtilpq08do8CTUaNgMxUihhFbMfX57kqW77JmPcvuj31uquZHcPpqc/V4eJCx5+wK@vger.kernel.org, AJvYcCXRdX8NZn7ioOe23RERiBFMDVt1qduRWqPM4kC4CCDKlpj/czjKNwekserNKCDgod6nYLIHp1wGfiD5pz62@vger.kernel.org
X-Gm-Message-State: AOJu0Yxezqeo6NPXTVMwrkymyotQizsFq2a0p28774ZOGMzoqjEcjKon
	8KTq+CYefHf5RMiM2teblhkwUboBPVuPWu49UsF4r7K1zv3/EAKq
X-Google-Smtp-Source: AGHT+IHfQqlMMMF6MVOKFWCqgXlr/u9wp4s+BpMMSzK55QWj2QozDxuq8o3d2RqZ9SkkIM2k8Fuz0g==
X-Received: by 2002:a05:6402:50cc:b0:5c0:8ffd:6fd0 with SMTP id 4fb4d7f45d1cf-5c2201ad226mr389717a12.13.1724878300625;
        Wed, 28 Aug 2024 13:51:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:40 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 5/7] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Wed, 28 Aug 2024 22:51:25 +0200
Message-Id: <20240828205128.92145-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..edf5901c6c87 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -48,14 +48,34 @@ properties:
 
   interrupts:
     description:
-      interrupt mapping for IRQ (BMP085 only)
+      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
     maxItems: 1
 
+  drive-open-drain:
+    description:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+
 required:
   - compatible
   - vddd-supply
   - vdda-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - bosch,bmp085
+            - bosch,bmp380
+            - bosch,bmp580
+    then:
+      properties:
+        interrupts: true
+    else:
+      properties:
+        interrupts: false
+
 additionalProperties: false
 
 examples:
-- 
2.25.1


