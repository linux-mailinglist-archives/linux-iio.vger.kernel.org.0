Return-Path: <linux-iio+bounces-11505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E49B376F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958BB281AC8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5B1DF740;
	Mon, 28 Oct 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi14u94O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0B1DF25A;
	Mon, 28 Oct 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135652; cv=none; b=IgnSzKDqZ5nw2nrCUfzg6w0SUv7y6QhlhhKP19yz4Ff+iMdqhBSnebX9mPGEJqmlY8/JcOyhEB7+DmwLWT2/XbwE6GUaEOLOSSGD9jFez3wBiRrypiCPpRACJfoW+MuQJsb2aojLSwZ8YaTDcy5vo0ly1Pb6ZOKf9cGst4l2ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135652; c=relaxed/simple;
	bh=aixE6KnqmR8OcBrthKNIhiEdCAfB2B2LU1R3NXaeYkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y60gL7YJuFtEbGLqA3VNs6YI63yaYfmN8A+lsG73n2VTBq6C1/2+6UYqazEOXTaeEty6rVqeS0otTkkjSs9y60u8+J6brihj5zk3YMDw4TbhLIlnrLsBRwrnaGPvMS075GyjlA3EmP5RrO9O06BhzwRwvRZ8A8oVmEW1JfKG+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi14u94O; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314f38d274so60950515e9.1;
        Mon, 28 Oct 2024 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135648; x=1730740448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie9fQ66DaZpM44fAw6qdsW10ZbEKB/GAbmD5tzOT3cM=;
        b=Gi14u94OeButKb2aM2AztzOfntXJSdbMZqwGZDfPdffgSuFCzjoXvifC74eSpVNUbe
         jJc544bP8CtX5xmPZx3vfJZp+ztkw9pq5kjb2KcvGJF3RpQ3B9WjlEefnVTp4AUfSmp3
         SrYBeM1VOG2ffbE5PDpeb/kvwQoPDpBXLp+bgIEy/0LFAslFnSpraMjdZsUmzu6aBDtZ
         ug1dAhrJqttB/XwXg6FLYCPng6AHdHfq38saWccP7pitGvTkyZESXfCAStlRBJtf0MDb
         B6nGx2cxnpaftcL6JBU+FSWCeO2T/keWyGHx5MZXyDEYX9XfrhmIgNDxD7/JZZUNq5Bc
         1+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135648; x=1730740448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie9fQ66DaZpM44fAw6qdsW10ZbEKB/GAbmD5tzOT3cM=;
        b=maF3a1TXQojNPBbZYrc1tmI7jseubSB4Qv+H2yq71S9UpFpjA2CobKHm7BzvUVIT/3
         HE8pnYV5AU8uiLTvgL2nXxpwFKFRqjdjC65qpkDxUSNSl4XuVLF/UeneQ24DxObWBKR0
         NSbir+yJE6y+G59tHD7b9ks8XcpzRbQD9HTK1RWia8bSY22Fn2zKNgNHKR9b6t+cEPNC
         YNPlwtESZLUmb1WuCn7M099yCdIWqyvRqjVV6gUihJFKL/vGsQXkCmBNb+ldHLYzEarj
         5pDVFzzI4gAXRVVOwRu7J6LFJxH7jID1GhUINZbVEfTfkeBnmxdjZ9JkOv/wr94Yl2Zu
         FDiA==
X-Forwarded-Encrypted: i=1; AJvYcCVMH+EuRM2xIc6yMQ4lWBkfuBuRyCuVmt3qAdWQGty6yVXCgx+akoP+4Jk4ANv8ytLdZe8qhbAXiEhQ@vger.kernel.org, AJvYcCWf3Qxd6Og6dAUMAw+uqdy8ptsMz7+yZ3yOJ9fRS7ClAc5+HjlCSWfY6BFhbvJyK2El/mdQ0ZHWy1rDvR4S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpi169QwXp7kx/foGc6EoAhSN0t9bfIGFBF8CKAegCCxHhKIMZ
	a0JXJaT1fiMghOK9loxTRU1ZeEm7UPVfKDVNFgErWNEqF5FoXp3o
X-Google-Smtp-Source: AGHT+IERJdgeqAhjlKyOXCBFDrJdfh21VutLc9rJe006/hvoYCn/slT5R+J71LBaQi7xxuYYrU63uQ==
X-Received: by 2002:a05:600c:1c07:b0:431:52cc:877a with SMTP id 5b1f17b1804b1-4319ad29d00mr108530015e9.34.1730135648346;
        Mon, 28 Oct 2024 10:14:08 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193595470sm114693795e9.15.2024.10.28.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:14:06 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 18:14:01 +0100
Subject: [PATCH v3 1/2] dt-bindings: iio: light: veml6075: document
 rset-ohms
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-veml6070-integration-time-v3-1-dd7ace62f480@gmail.com>
References: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
In-Reply-To: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135643; l=1308;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=aixE6KnqmR8OcBrthKNIhiEdCAfB2B2LU1R3NXaeYkg=;
 b=UxuQV+Wwv+9CgyKsp8f6JqvH6NOcvq10FU9kC55iPIi7+RO/OPojKDze3zSFXXv1x28SQGl96
 vWWY8iZDhz2CNyR4RPGH02dn0uUTHs/jzk9k2sQdtenpwB4byJ/G8of
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6070 provides a configurable integration time by means of an
external resistor (Rset in the datasheet) with values between 75 and
1200 kohms.

Document rset-ohms to select the integration time.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,veml6075.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index 96c1317541fa..5381a90f7f7e 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -22,6 +22,13 @@ properties:
   reg:
     maxItems: 1
 
+  rset-ohms:
+    description:
+      Resistor used to select the integration time.
+    default: 270000
+    minimum: 75000
+    maximum: 1200000
+
   vdd-supply: true
 
 required:
@@ -29,6 +36,17 @@ required:
   - reg
   - vdd-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml6040
+            - vishay,veml6075
+    then:
+      properties:
+        rset-ohms: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


