Return-Path: <linux-iio+bounces-13431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDF9F17EB
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9D8188F977
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B22194C7D;
	Fri, 13 Dec 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg3mc8WP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5031922CC;
	Fri, 13 Dec 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124763; cv=none; b=V/xCx+nit46jx9prOv40ss47oT9nVYl59q1VRp723AJK3ACaX7vj9V/udZMHw5Is5hVXqwv3kvH14QGrAGslpRCh/EUsDwGRBCwU3sosIYJNpaxpJNIscO4idGY8F3pB4arRg64MrZoD7flhtao+oTKRThnPMb0PJwxJCoteu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124763; c=relaxed/simple;
	bh=NU4JbdrsQg87bOi61vUISeaVNwRoypO/AVKmenkMmFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVDfxpQh0NGrzZjcdDiW53JtTB3ND2q1pwedPiWjF7h7YOMMQYvpa8k5bowcdHI9L193ut5KAZXbuxKg2+zpLZZjTXORPWlOguTUoWn0l3T/Qcd1xynPm+uaCfrOvNG4FPqqvLrWxmsri3Pmpn6hVQCjHRITp7TcLCLufHn4MUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg3mc8WP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385db79aafbso174474f8f.1;
        Fri, 13 Dec 2024 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734124760; x=1734729560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2lr25cDx/YgeOG1ygYvcK0LTENnBnexDb7bSksAIok=;
        b=bg3mc8WPv0VNmRlv7aDXq7y0iWHUyxXETgMdWz5/DB7Wwm4Gf24QVu3hHM8e5DqHF0
         i5Gqo585XPFw5yOxvLaKXNSqxnxdKFNDqoFl7wwAdPeEv4spf/5Mg4/vpiHT+fblGXz+
         fHPfHw5Zl6OgnJ7bRmQ1gtt3Dp79vjqdqEBCuV37YHodpaui90JJcg2242DFPIfdgo9k
         aERK9nli1ZESmFiUW7ZQInsAQBjTaonTodaQV0EDHulWaITtZRzKdc/uO59g2i1hmCmf
         nnHbZfSZ4QFKbYALHKbIB8UqpkvaQiY8Y6Vlt4SZ4oenpTZWsmEtV37D6liPfHWBtUxV
         DgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734124760; x=1734729560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2lr25cDx/YgeOG1ygYvcK0LTENnBnexDb7bSksAIok=;
        b=QdKmNSbSjQG8vfDksc2Y5isZvDdszeneYB3vfMBnayqDzbx5s7Zo7THh1gBWhnnjPr
         ke54yK/kCNBHuUw8H+1R6BSetQQHyAQJ6wFDIb8z8NO41k3pftbYamUi0G4Sd5uPr5Hc
         kAIiRCXuiWB17d0IvqDzIlHsTjdk8KQack7IkXnc4pYO0O/08s6irku5hjW/jyz9rQJp
         +5ro4Lf0hs2J0TiRZYH3PWVyimy9iY3mMv04KJJhr3JZJi1KuhfQWyZhF5maZzj8DKNE
         4H34oMXwvOJ2VBQ1pwN+0dJzNh0NnorM60fTCXXLXw8fgZGohAnP7eDgV4XX5VMtnoHw
         /0rg==
X-Forwarded-Encrypted: i=1; AJvYcCVoD8FhMHVrNnMnWdTMng+kIT3RVbwJaGtrQ9KwXaSENbW/bnelMPdXQkzGInAiRk7G1cIWzy8tw/M=@vger.kernel.org, AJvYcCXP9D2nmkJgf6yxfjZ/9gqEj73tLaTON4LS9SinSJMdMZ6hWRE60OG0A/mN1CT58HUvFQFkQ6F4zG/W9j5i@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtETalFlOr9bQLcMPxehZRDIEtr187jG6lhhbKwGvs3XOOmKS
	I//t5dgDoI7VzyFYPNdsr1cEJLzuhr87VobF060b+nEuUC5Wfwy5
X-Gm-Gg: ASbGnctBgqWizvZC8i8hbtteDCV4solAg/OI6hHoGSe9bsetuJMa+ozcNW57K4zbNxU
	as60SKL+KUK5EqhD39r05rTgGHaK5/i10VooziXzYBQCyjKl6wdADEePM6rkv28oyAqF8pOyA4W
	uI0+4M9yqRJPynJEpcUZg0oM+Wvxc/aimXTUb0INnfhcUAkAqkr//GcQVJGJM50jAk7pPqdF0je
	4hPT7ERSXwMV8TJePyG6+N4wIXmJcDARt+Tzf3d97gyLhYI2Zhx7Uc5/d3I1Bp/66wA0nSXyreV
	q8TvR5B/NdnK/ZbugsE+VA8/3ojLPAl5X8Q=
X-Google-Smtp-Source: AGHT+IEA0AQO4R1cUGDiXpbOqZYKUVQrghKYgZjET699HiuYI7NmxFhucYLLDcjImsQUnCC59Hq69Q==
X-Received: by 2002:a05:600c:4f0b:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-4362aab44b3mr14042745e9.8.1734124759486;
        Fri, 13 Dec 2024 13:19:19 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801acfdsm552484f8f.57.2024.12.13.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:19:19 -0800 (PST)
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
Subject: [PATCH v7 2/7] dt-bindings: iio: accel: adxl345: make interrupts not a required property
Date: Fri, 13 Dec 2024 21:19:04 +0000
Message-Id: <20241213211909.40896-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213211909.40896-1-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove interrupts from the list of required properties. The ADXL345
does not need interrupts for basic accelerometer functionality. The
sensor offers optional events which can be indicated on one of two
interrupt lines.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 280ed479e..bc46ed00f 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -40,7 +40,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-- 
2.39.5


