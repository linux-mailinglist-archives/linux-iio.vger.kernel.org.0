Return-Path: <linux-iio+bounces-4806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8828BBF5E
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 07:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDEBB210B1
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 05:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5CAD32;
	Sun,  5 May 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS1iTZ0S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB74404;
	Sun,  5 May 2024 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714887446; cv=none; b=g9T2IcemOlrMsa6g/y6bDQM87+bVqnoigJUye0PtxUNdcqwm4fTI+jQ+u2bGh3KgIZlS+gRPHoGUDtylHISwQX82TTQjgRw8PriKiTKcVSBFKnOHNrKGVUA9YmKcIiRp7jvpgAOPWlErKLJAwWDEHZLvHntEcbkoOwNyfZqbAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714887446; c=relaxed/simple;
	bh=1XLsS9UZ3/2QFzrtiwlhMbPrbRDok3+gNqxLDQ7l88A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLjgBMKoAjVgps3QOXJ7Xw8TiacytackHivHSbAugvVtcm84RvTCDlyRvHl85oBup79SUN+wie13F13H+LpBZckLgqE+rrI/sHWWpOk6xc7Qa7b4FH8kX3VlkWVegiFBDxGgjfuEXUNwswtZc7u4F0+rLH5XChMxUZltqmMDH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS1iTZ0S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso5910335e9.3;
        Sat, 04 May 2024 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714887443; x=1715492243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIHGQYXLm+H3AT0/XK/EI9TEN++7QBgYZ3oaGHN9sJw=;
        b=nS1iTZ0S0DCJw9sfjMiwHDuso423W4VHyBr13e8Ywgjkn6pvqNkKoP2mWD/6Gjhtpa
         2Hwlu7lCEITz+UclYQu5X8RfIS8wMRjDoHgwWUJbvFsUWi1lpRUZql3POpiFgoQtEaf9
         S+3V6AvroJ9NtOfS9IFrCTJsQpQiQP0bKTv2XMnSHWH5oW8fgIxFjnVv6u9aWflFHgLt
         bvzyaza1DFaKt9Hip4RXbUglFEadYrQXy1UObpEvfcpZAodA/4hS9vF7YZG8YP0EcRiC
         6ahIdoo0GeVwN8akRoUBZvks9ZE5xEPuKXhDVo5xJUhT96NINw+HaLYwdpI0tP1yeR+a
         oI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714887443; x=1715492243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIHGQYXLm+H3AT0/XK/EI9TEN++7QBgYZ3oaGHN9sJw=;
        b=e6sVRshxXPrGAVfFTVCy0f4UcKCQLZ+59y9AyT0v4QwZezVFPhlsvdlOkMR36i2olo
         76kmjHTU2E4JJfFL1O5A0M6Wbfjka7jux5XuxsZV8qEuCvz0fSiSim2V/CAhQQ+fZh7v
         Rn9jdwjvV2WscfMsB00a/GAxBXe93bTXPWfpNwj3lSgPvTrCFdqmPAqdtebYkQmgw8L1
         5yUewIORi4158Bd3QPLH3L5L67rd841u9J235XCgTzNBC79tpMN4ickVLZCyPuXN6ozk
         x0xoQR4YWYGIqTcUIrPTNzxPXZNOM5THKpYzH+esgDHplCoVSWASXnQPqSugjM86kEfi
         2+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNtruRrsXqkIOgQkkz1Y27ljnbA56ZcG03IWNnAhPbuXOXbJJRImXj+UtfM1TlSWx6bfFHelnE1imvasSo4rcGFhlwRHQjesoJgHQfzXBTHdx6s/QnJvNVnlVXYw3lAm9+dmCVFTU/ig==
X-Gm-Message-State: AOJu0Yymk+aaWRawjvlV1ovbgmBS04cvP7WDlxu2V3rxozN7Vg+bnrEc
	nmzoM1EvUmicevgyIzKzd4aKzv+BjScKkxHh5iLqHwe7JA+yRm0w
X-Google-Smtp-Source: AGHT+IGN7k0T7OPr4JF9BP8fH9zpFnfD92BtI6q/maJAqPJFCQ8r+3eu3k17OVb124qDqEydzKMNDg==
X-Received: by 2002:a05:600c:4ecf:b0:41b:285:8417 with SMTP id g15-20020a05600c4ecf00b0041b02858417mr4745619wmq.40.1714887443321;
        Sat, 04 May 2024 22:37:23 -0700 (PDT)
Received: from [192.168.1.130] (51B6DCE0.unconfigured.pool.telekom.hu. [81.182.220.224])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b00418f72d9027sm15050957wmo.18.2024.05.04.22.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 22:37:22 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Sun, 05 May 2024 07:36:55 +0200
Subject: [PATCH v3 2/2] dt-bindings: iio: imu: bmi160: add bmi120
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240505-bmi120-v3-2-15cee3d0b2ef@gmail.com>
References: <20240505-bmi120-v3-0-15cee3d0b2ef@gmail.com>
In-Reply-To: <20240505-bmi120-v3-0-15cee3d0b2ef@gmail.com>
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


