Return-Path: <linux-iio+bounces-10697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FE9A2FE9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA931F23195
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879701D7E50;
	Thu, 17 Oct 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmuQxz0T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E41D79A6;
	Thu, 17 Oct 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201180; cv=none; b=aLkAcn8juGxvuNBzTK1VWjxzR1GwRQzDJimthLW6a/V7lZj6FNuDQbEaUXqaear6KVAQsfysN+vAN14O3q9ZTdDHmQGN4p26Y/XLCfOFqLpGElNJ2GdwirAh3D7owzyZH7ZDA7Seb4lTNQpHRZKzQ+LYxVsO8X3cmSTJq1v3beo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201180; c=relaxed/simple;
	bh=XfmpPXJ7lrciSE6RtVOlet67kVCWxt6ObkwJSrdhHrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0EDS4NEYxswhHs3mNsm/60hsCqxNa1hq41zQAQKdtmOyr8C8/Lfvz14MCUNt5Jmabol+ybM5hTmma/muj3+EgMdBBDqZ+ou62n1tMg8AidmE6gDwhVHkiRSvR22+CuIT4BcMyhtabRY11McNgXPpJUSGwdw/oOJvQ8U+kpGras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmuQxz0T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431481433bdso14441815e9.3;
        Thu, 17 Oct 2024 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729201177; x=1729805977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2nkA+EyiMbr9RhGqSZKfXddvPtR+ztqHhHvUR6oxHA=;
        b=BmuQxz0T8LpPIZlzfDZ4s0WbWzijiZSzas5W6Bv+3Dhc56Hbk2tthIPWg90Q1PgJlg
         naGT1CyluvFUi3aH3g+yL1lpGy8zuzlH2AJ0VxLVprCuAokn6Bdi7QDYniVY/V3iBnAX
         6G9mTL1CEsi0gzsRkVPFHtAWh3qbW5hp5suf4Ck5zhvIkRr9joh2YNbZiAUdT16XABe0
         9GkUur56GNs8WmF3LpKPbGrbSCz8AHse3yLUY8JFfteC5J3vPn+eat4B8+otO+rGiyWE
         1bWHOCmDI1BdJmIEGbUnwaRKc9BY6zPuWdy9/0ssXM27KHlximGbXIzsFKlN22FAZs2f
         frLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201177; x=1729805977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2nkA+EyiMbr9RhGqSZKfXddvPtR+ztqHhHvUR6oxHA=;
        b=RXpsTGiLWGFfEkDKMtBYX5nEu3k+oEHpDIAYrzZb59DWMdSsF10i/+eSYhBIAk/+kZ
         xfqBdry/AEjHfOtffKPxoQkNkHXvjt7ML499QQljfEBIEmgJs82hb1gUAfhbmDhIDVr8
         Z2afiLU9EF/xSLg7ab23Fh/GEc0kPjj2iKggxep2Fby3Ncg8tAzsV7nsAwNheemj6jBE
         Ufj/jfOLiSF66hByn5+sRbeqZK/AThKQNRc0fGDJkum667Y8V4C+l8c/e5Ej64YuzIro
         pYUUOngNIiasUe8bv89Han3RDbmSOoAIyqO0aMt1FG4B6HGgxNzoMRHioXJ6wpiTM9DW
         LUkg==
X-Forwarded-Encrypted: i=1; AJvYcCUVIYgBJfgwjQGcoDrmuAxv5wvINbfVK3DnWqILR9J3B53CUvg25ifJBOgm5EBH6G7mI19oSYo/by5o@vger.kernel.org, AJvYcCWMInAtzYU4YHvuZIcEpJvPEoHFP2600JPm7j1YBlTvLiDAWCh34MSCseW/fdgESd1qG5j5r3V3SySiXWlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JYSrWJHHJMk+uigr1wBsAu3Zm4Qrxqzwwqd6pRvuZSxZavdi
	eEsLLmzYQsAXiceWJhylD/kOAPSPVs7Xcs7qZJI603p/rOLdZXNZ
X-Google-Smtp-Source: AGHT+IFF9VmVWlsrG2sVfZuGCchUthzNGpeWMIfhiI1PLc5Fe2e+D5gJBT5+gnlznMkV29rA8hfkJQ==
X-Received: by 2002:adf:f605:0:b0:37c:cc96:d1ce with SMTP id ffacd0b85a97d-37eab6ee898mr213628f8f.24.1729201176794;
        Thu, 17 Oct 2024 14:39:36 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bb11-f817-987f-ea1f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bb11:f817:987f:ea1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06a73esm99874f8f.43.2024.10.17.14.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:39:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 17 Oct 2024 23:39:27 +0200
Subject: [PATCH 3/4] dt-bindings: iio: light: veml6075: document rset-kohms
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-veml6070-integration-time-v1-3-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
In-Reply-To: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729201167; l=1258;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=XfmpPXJ7lrciSE6RtVOlet67kVCWxt6ObkwJSrdhHrQ=;
 b=GMz/+5QC4THsbJR+HKYXlz3zVSK2wLQzt80VSJqDO0ZdHu0W9YLTb80brsKv0VY33mhiThuo2
 jSd9lWJTW82BWwzJ4z5bi/k22Y0doFCT2OvCJC8Tf+nwK90kIJN/FQP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6070 provides a configurable integration time by means of an
extertnal resistor (Rset in the datasheet) with values between 75 and
1200 kohms.

Document rset-kohms to select the integration time.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,veml6075.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index 96c1317541fa..3d3ffeaa22df 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -29,6 +29,22 @@ required:
   - reg
   - vdd-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml6070
+    then:
+      properties:
+        rset-kohms:
+          $ref: /schemas/types.yaml#/definitions/uint32
+          description: |
+            Value in kilo Ohms of the Rset resistor used to select
+            the integration time.
+          minimum: 75
+          maximum: 1200
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


