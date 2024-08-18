Return-Path: <linux-iio+bounces-8573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE28955E22
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 19:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412371F213B6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1121553AF;
	Sun, 18 Aug 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+Bj/nrs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C61553BB
	for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002197; cv=none; b=qLqTYjYSK78SmgA76gPgpz8KaNvemywfRKMn7/iZiGmXuqRDG5/tvILxYsRd7+paGVhpjlgWFDDWR2mXB1MO3wor5/wyoe4wIW8jr2+xUfGKAp/41RcrZjFnFn5Y4FXALbp/NJNKJvEdwd+HAaxYUnbCkvYWoo8l00MTaWoxU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002197; c=relaxed/simple;
	bh=RQ3Lbz4xnyeSZAdJGZGVBRvmJ4qONoB82rnZnZvCrDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgONF6JLUUAKfNU9C5ExFJfPpCVivx0nLUMrgORnkoX2CJcQk5Vkywx6yvRMOUnLNrol9wcj4tiHLrwzefTl2Z94HtAzK7ZsWiR4Qh/XsLLvu94yB4vFwklGRABhZYuQEdjj4h7VAQiC5TB13BAHCv5PAlhiZz4fd9ZYbyDQ9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U+Bj/nrs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371b015572cso953373f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002195; x=1724606995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbwvlIVMV8xryLkD19IewQWLhOQT8FXVqlEUYqJE2Z0=;
        b=U+Bj/nrszUnTm/6XBHYONqYtWpiqcZvk6GUJduOo05arwopycosnQBE+NI9x1QUuM6
         FwnShm+tqhUq4pRTRZZwKfeOCKD89H/F7y54JLcNQ4IZZ25jZq2M0RcwRhoLxfHaMiWR
         DZgnp4TF4lCWIUj2b5srTG7NwMp4Xno/NbD9rjDfvmtXiD3sYy4tHcFm2XXTIqVpa8oe
         WpXMKWfoyT5zfE9knXESrFCGSH8estDAvwv3TUF6Tgf4zFOYulEgnACgsDcO8G7RVyri
         CzI6i3vepPydoSR/suRi76n5mmF4Kh8ISvp2WNcSHGkPGC/1HmLpVO4H/DvzGEOvqExq
         PKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002195; x=1724606995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbwvlIVMV8xryLkD19IewQWLhOQT8FXVqlEUYqJE2Z0=;
        b=Jlpk9PX7ei34GkLE9s4jhYRQOXqnjCh4lNDnNi/0gSmG2HkDueBr8us2mZL/+7o/dH
         vwiAHk7OTlQgcEMLucaBT6ZY7dFYc6kOQQD+WqeK+eXW2UDrXQ0SJD/486p6/bjMCtgj
         4u+CkixD4TnBc7uHPVIy7MAXQaaXTS5mZV3el1q5FHYRsL5d/a7F/6XNa+rB6hLCO/El
         WTZc7J1/qzs7Y+3QeriIobzwJylmGsOsn9dXtdDWpnjIRWg7/pJRzNYmOFbQVM3yzMkA
         ioctEOcXdq0Kmlcf2jATJU6FwIJUP9F/cUu3RpbfxklrpvUYSJI5qXZR+oVUD8cZ+64s
         wrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7IN1HENBka1VFUNB2sbtf9n1peAZsczmhXyhvQpoy6HCSVN4NJeiXQM0i/xncwzrcLADwoMZySqtt7vsXSqC/GxxWPmIaR6uX
X-Gm-Message-State: AOJu0Yw5g86F6YotNMY3IbTORY9jya9jp9gGjQ9hroYsVDFwpivt5ngd
	hcscJP4ODTS6jt+ZcFdLFblJHfuN5pGVunbe9+n9Aq+W1Ez+sZd3x15T3Md9IXFl3r9BDRD/u6O
	A
X-Google-Smtp-Source: AGHT+IFp3b5dXt3VaeULNgHqcg4QFbzuh6p5X7dQPwN9gftdTacq8ZYzKU9ZBjnuXrL9t5XVlwI1Bw==
X-Received: by 2002:a5d:5c88:0:b0:371:a92d:8673 with SMTP id ffacd0b85a97d-371a92d87a7mr3528329f8f.44.1724002194776;
        Sun, 18 Aug 2024 10:29:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm8486522f8f.38.2024.08.18.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: st,stm32-adc: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:51 +0200
Message-ID: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clock-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index ec34c48d4878..ef9dcc365eab 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -54,7 +54,9 @@ properties:
           It's not present on stm32f4.
           It's required on stm32h7 and stm32mp1.
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
   st,max-clk-rate-hz:
     description:
-- 
2.43.0


