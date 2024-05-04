Return-Path: <linux-iio+bounces-4801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDFE8BBBB0
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1794628204F
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748F37140;
	Sat,  4 May 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0LgD052"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3A23763;
	Sat,  4 May 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827648; cv=none; b=VlVDfDzPRN7TGvIBq9l21BWE+uXQwtcs5dcNP+X71YAkS8VSuZgYrjK4iaSKKkl+DGKLjSnU/HFKmyulfRP/n2x9n66qIv9TLQmWWyoePoMKq4nETVr2MadfSd7aUg2Lt7l7QHlryA37eL173FOqY/zahclAm+3q3LhQtN1WaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827648; c=relaxed/simple;
	bh=1XLsS9UZ3/2QFzrtiwlhMbPrbRDok3+gNqxLDQ7l88A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5v6MR0ff4C+bTg4nEzqDlSGSvBJV5NgJ0avGdFrUTFQ3PsdPzoc1E469IWAcrLTRaPjgYHjd5K7AmvEZ5s07tfr9DtTD1/EZtcUd866XipVd9QWU+ekb3+wsHYRl4QsJ0O2KcQgtlPnCl+vSelSDHEhx8LzSiNwcLP9KqnxvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0LgD052; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so4376405e9.1;
        Sat, 04 May 2024 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714827645; x=1715432445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIHGQYXLm+H3AT0/XK/EI9TEN++7QBgYZ3oaGHN9sJw=;
        b=g0LgD052s4k4eR96/OJkr4+m8Erc7/BSv0iJy+TWoOrjL5AtM9m1QneqpuSQP+q069
         FMSNIvaAbUwX1PBKNmCy3AzXeNqNj+4alocwyba810NMNFqIwDsV4/OyWrBOk9rDm+9C
         Leh37TxDzpoMeSBFdOcKb5SyFnfIcL/n5v3y2jfuRJySxa3Hx5qWrdybwMnMXiy2nDlr
         WThTHoygp6CsWoC4JG7Z7nE1BHG5+pmHLnC/ZfYQQwqPe4RlKJ2Q2zyLaMqDnbDi39/V
         RXL049h+e2SxtHkEOuUD5dzdZJtxwBZNhcWTbYz3+7LuM1ODHEV6Qy8WpSNy8nyaWUD9
         XqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714827645; x=1715432445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIHGQYXLm+H3AT0/XK/EI9TEN++7QBgYZ3oaGHN9sJw=;
        b=kZF8y7IKBdqnN3c59nFBRNCV/csDeWNb+IKwnEC4KlK1uorfzLdOu/sQyoqmQeuuPJ
         B/qFAzzcVFwz13bzPJIC5QZUCv1cj0Fwh23MGcgfDKVb3rfWa0DDFzA9e1bByM/W1tTc
         Y+2KmjBesZwncoWaOVh1qQoiGfBLDjPCpWVLKSaFCVJtcRsXP/No4H9/HWDlv0sXrhOr
         4wwJTHUGJR737KIao9wXfor6xZSDBn1GeFdCQ29oDyk7lHzBacttiVb7uXCWChSNr0pa
         xozqNE27IUbdqCiXyP/6srF7UhbgBJXhsUzivJmRKYmmiW3OE5xAwn8lTUuXaNHpP6PZ
         A6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTIEnbfnktv4TTPhXnFLwChg1BdQ8GFEGdWAdHaiI6SQxEBYc3oqjNXP7qZ6OshfFPf2vOt1xhzJM8yATmFv4LJokKx87Yjy/2cvcku/6b5ahy8X6us92wxzSxCuoo9M89kX1kwixvhQ==
X-Gm-Message-State: AOJu0YxclTmv/fC6y4NbTqfHQdg2Lj1Oh2SMCmimoBDWVWOIB1sjA6qW
	qLHNwaSggQCP4HEWN6CeP1NLvDs7hZfFJY0+wWuNo6vywU5HZAp2L7EYb78a
X-Google-Smtp-Source: AGHT+IFXPso6D3OpBTPljSL2slSyWkyt71cnnck7i19mdvCVJ8hlHJfxiDrACzw264Taqq3o6Kqwug==
X-Received: by 2002:a05:600c:3514:b0:41d:7c48:5555 with SMTP id h20-20020a05600c351400b0041d7c485555mr3895582wmq.20.1714827644972;
        Sat, 04 May 2024 06:00:44 -0700 (PDT)
Received: from [192.168.1.130] (BC24954B.unconfigured.pool.telekom.hu. [188.36.149.75])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b0041bf45c0665sm12888998wmq.15.2024.05.04.06.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 06:00:44 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Sat, 04 May 2024 14:59:49 +0200
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: bmi160: add bmi120
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240504-bmi120-v2-2-3b3ce6e1c3c6@gmail.com>
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
In-Reply-To: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.13.0

From: Danila Tikhonov <danila@jiaxyga.com>

Document bosch,bmi120 compatible.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Barnbás Czémán <trabarni@gmail.com>
---
 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
index 47cfba939ca6..3b0a2d8b2e91 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
@@ -16,7 +16,11 @@ description: |
 
 properties:
   compatible:
-    const: bosch,bmi160
+    oneOf:
+      - const: bosch,bmi160
+      - items:
+          - const: bosch,bmi120
+          - const: bosch,bmi160
 
   reg:
     maxItems: 1

-- 
2.45.0


