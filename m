Return-Path: <linux-iio+bounces-18579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575CA998BB
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 21:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C164A230D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F67293B42;
	Wed, 23 Apr 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/cnZJ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96A29344B;
	Wed, 23 Apr 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437286; cv=none; b=BbD5mW5KzTecrdBqzvWyzU2lq16x14rMWQxC4Sh/YG1DQxYy7Zu3JlIqktJo7RC2lJu/E3+BkSQI8tbUYX3pVtj60syr4GZtKkAUo4N/6Eg78fXGrlIPNBWivOgYNMa9MpPQidKWb/SSyqWUbliJjhQNHMbqmPFJR0+jAhIm+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437286; c=relaxed/simple;
	bh=WJOQ4kk7sSTKhNCBUQ4JjhOOlaVbEmRV7oRAcxB15KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWaFxdcTPR657vpzchhT0u+2VgZPXuJ/aWzjSyXiosB0sx2HX3BMmUFmyd/l5IBigJ/AOgSFf9+0RqH4qpqbRvT9DU/3Ci9rnScylHdzVjOq9Q8WcaIOjcfcJRNOj4OtejzW4CcwX0DO/373cChJ80uIuPZY/xTD40v6j4QWx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii/cnZJ+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so1249300b3a.0;
        Wed, 23 Apr 2025 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437284; x=1746042084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oogulVi3TonJWu/ThysgU2FWZjKwG6Oa0t9ijPvA1o8=;
        b=ii/cnZJ+jmYpFE6eAS+kw3QMnCOchTOJ6hjSRNXRvODsVUD/cH/9PrlgElfbqqcWlX
         uRnMhVlwHKZKgHi3MEqBQemFflmNdKR/k3pChjo8eO6sD9vfAgjje7OPEz3PwEwUQLnw
         mT4erLp5plkR2EdvThXJz4eogDHuL8B1ok9xFCwm1QxRDChH9z4ZeZwmRFv4LSk3HmXA
         r/oU9jJ7QeUuyg1+xWPwMYbue9Z9TfK/AUXr7jX354GXLuwFIqIYARmXDfZndQSqhZML
         +bIuX6jS/vBGSsLWGCPI0Ah1ityXfzETcOhZeGjdM93uMeOd92FPR2MgIn5UqbvmPr+v
         rw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437284; x=1746042084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oogulVi3TonJWu/ThysgU2FWZjKwG6Oa0t9ijPvA1o8=;
        b=uEaWdF+4vlTGs0m9IcNFF6hmM3kv3LE86iMi6AAqU24toyy9q/nao+1WxTsR7KyKND
         7bnkLQLwqwUnQXp9f6ErNiNF8LqmHSuf5RvZ2S5j87qGj3kcV9ydi7Db9ILlVpRZmRjq
         0Sde/mT8xaNrJ0yh2/edCuuh3Rk1doYB0kfA9/l5AYJj5dQuf6OX/a9IjEcwYduinKZL
         hXIUlUbQqpyxUQftSIlIjOK4rlJweaJOH3+6xCl1TCDIHv6Ae23UooiQvgZ6YQ99+6B7
         IHCbtJx4WXB48B+OtOEot1hIIsIsdsx87gk2lYJqT579PFQx5zaaWEc2asKylR9G0YOV
         EuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhxRC7P0vrzOVMIkJuI4txewmc6fszQeOhC0nLaPid8DFPtQPmjyGvmtf1gKhOzdDKVuGKwgPuFx2Y@vger.kernel.org, AJvYcCXrg34FkiGZK5qheftnup80SjsA5deWAhCoe3vSJu41iu3Y6IA1WcmQ5xhH9EGWIz8QYlwdyZ7HZor2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lDHE5BLdWeI96a68QvmIr+/ap1tkAAPOLXmMQ8pnes294/iV
	T/170TBVCB7pHKo/YoNC5UDJnFgC4QEhnrB8jHI+i0K+aT3CMkP+
X-Gm-Gg: ASbGncsdFkqtF89X6guztmPIPOn4ukjRz4c07RAIBkFqbPH0jYX8JRAIVs3j1+mlsYk
	CG2Hq4elMWfTRJzKKbfyoV7q/icVud8RS9qAzQ2sjTwMyvldxX2/aN7j/PEkaP/gNrsN+jzqIWU
	xW4vgnI7G3RgsGVn4Xr6lwvL+3GE2jkcW2pW4LFTyDFSWltCOnnGhasxOdM4wjBsBlrnkSoYsgj
	LnKPuYvz5qDz/Hq49XkBxFR4idRAQPLk8Q5pHZSXo1ww7iEWyDL56lSmnpjd2PdVDraLykR6/pT
	cFOaFEisjEu241nYkyedHz1qpC35x91AtdgUl6RiVFVMNbg=
X-Google-Smtp-Source: AGHT+IGapVUlXRnAcPS1xoIzRr3DSx6pVjShD4aDdBPwYt7PT6UkezzKZsAxks3wKLZT2fdDynxjmw==
X-Received: by 2002:a05:6a21:513:b0:1f3:237b:5997 with SMTP id adf61e73a8af0-20442e626bbmr516209637.14.1745437283989;
        Wed, 23 Apr 2025 12:41:23 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf6a2dbesm10938291b3a.0.2025.04.23.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:23 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/4] dt-bindings: Add Winsen to the vendor prefixes
Date: Thu, 24 Apr 2025 04:40:57 +0900
Message-Id: <20250423194100.53934-2-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423194100.53934-1-gye976@gmail.com>
References: <20250423194100.53934-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Winsen to the vendor prefixes.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae..6d35549d2e4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1689,6 +1689,8 @@ patternProperties:
     description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
+  "^winsen,.*":
+    description: Winsen Corp.
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wirelesstag,.*":
--
2.34.1


