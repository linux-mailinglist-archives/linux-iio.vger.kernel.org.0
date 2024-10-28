Return-Path: <linux-iio+bounces-11486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC79B35D2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DF282276
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8B1DE2DC;
	Mon, 28 Oct 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vl9nvToY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C41DE892
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131696; cv=none; b=nJ/E2Q36dYmfR/f73pMOL0wl1y15G+KGwJs59b+QFlgy9OVFP4Eokg+2ba5rz06J+BUmPG5ZVu47LPlW9XVLhY38j0zholCycU0uvpYJ0oRzwPtAw9rwigWKAYg62FhCT0c/xeoJRo0OTk18TlVgEmogsfcVCbZ3JSI16VwoHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131696; c=relaxed/simple;
	bh=Q3QxaUlS/XDU3QA4rjyNh1tlJnHYfuWKrZr+wanO8+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjT7IftWGz36pG0Gsi1YLmQV0CEHIpG1g372aWz+u2TIIPpY++W9W7xRa2UTHE/0F4S0RfB9w5r+tynnXnlni328M5A/OoFssV7Z0KP7ALQuvk+HCWozQ5JTygEHzH3vwC6qbiYDygwa6G8YopLVbhdKqV80PD7NhDOsOFfgm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vl9nvToY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so43982165e9.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730131692; x=1730736492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n29IoiTPJrF6OYmF+KobxTlTWl3cfGwoPoCGp5OEkQg=;
        b=vl9nvToYMY4xKEq+1xZEPqf0eQ7TXT2I0X4DfaUkP9oaJp7CbOjL6tW5R192jaWX9Y
         aPJcOkMc4n+DK1CZ8NUhJqL/JfAug/cVq6s+eShvScKxMzL/XCCE0iQoynXYXpveZDpS
         g3b+4AYLGKz+T8uS7JN7R1F9h0nDYoESIb+LwcgDBF0hxBsQb5uLCvpeJnCy1afwXI5U
         9yryOHi8FXF1yj54Dsf9Dl5WYHQq8PuhSig4lLFEiZ2Xfy/Xy9ynTf0WZsJlUP1NE+pW
         LxR3I/OFALBc8e1hxMwXfI0QwIqNwG606q1I0QfeMsaCT1ywj7zK0dUZFts35rQePucs
         MHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131692; x=1730736492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n29IoiTPJrF6OYmF+KobxTlTWl3cfGwoPoCGp5OEkQg=;
        b=ByU68HEANZBJFV0s0O/wKuMhVRxxRe8EE/i9cqHMKE9hzGVIWVdsBO3opWYbBpDH+r
         RnwfzouMyrvXdjpDy/oMxl5tcNNfYJBGkmWBzFbslZtKneQ3v9j6CsRnLnfcrNO0woci
         61+S5afZVGMyO8WxxKxR4G+RUaX40RUrBDIwus0mLm4vPyjQMnVCcQAzQ7VjRfc76d/k
         IEh4yQdHmuU/hG/vQOe6+Lv0Ke0lvSYxrbiNBTc1Prt68SkN5Dh1+jUT6wlhbZSex092
         wJ+eIwsPnKdfglwhCEF1ckAsU2jYC3fltOD/lf2qdlyf+VShqEuc8nxsubi2JPPa1fnd
         wR/w==
X-Forwarded-Encrypted: i=1; AJvYcCWn5gPqmGU5XsxreA+BnSxSdZx6iBKO7YMOLRcGv7eejJzDk2L6hCnnVes+jbtlyrppzy2mak7fD+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnkJaG95s3kSg2ztVa1A/0+dozh7bpzR3nxMeJmspu9UhwmvB
	5gcze25gBTVfBPZfVgWZt9wgzuT4QmMbBiUFe0tVtYwYGtTVY5sPTgWogJO1Beo=
X-Google-Smtp-Source: AGHT+IGTTNwM36u4ehcBdBp1E2Z/jZ/FarkrASZnPHpMcpoVz+dZV2l3GUoiuK00QJpdOItCIGtw0Q==
X-Received: by 2002:a05:600c:5249:b0:431:6052:48c3 with SMTP id 5b1f17b1804b1-4319acacd6amr94080325e9.16.1730131692517;
        Mon, 28 Oct 2024 09:08:12 -0700 (PDT)
Received: from localhost (p200300f65f0c3200f401bf2b6011cd64.dip0.t-ipconnect.de. [2003:f6:5f0c:3200:f401:bf2b:6011:cd64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56742asm144128975e9.21.2024.10.28.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:08:12 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: adi,ad7124: Use symbolic name for interrupt flag
Date: Mon, 28 Oct 2024 17:07:50 +0100
Message-ID: <20241028160748.489596-7-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Q3QxaUlS/XDU3QA4rjyNh1tlJnHYfuWKrZr+wanO8+8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnH7bYmzg7DGHXywqSl6SFLbA8pR5lew2ru+9u+ uVbFRciR4iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZx+22AAKCRCPgPtYfRL+ TntkB/90uPk+646Eeixz6qfjHKuMuMJglRGThG9GTrZ7MJUv4wxWwmpShyMvEcs43GAEztdWeqG XRfdic1Q/4XebS1GCR7mCiG12IGnqK8xild+9xjKadZ+9imkrDtZxrQbzyaaGnUs8okTQGDnkQl jlqBKwbChv1TIJgWPJXyR6PQoQrP1SkDGZMhuRooWMzJieL8u8JY6lPXSfvPxkN4/NjlsYaG4v+ x5dajhmSeTPd7dKUepQU65M03zR2ufbuC+DYRfioEOZ5BDylqoJzBNgP//yDrShys2m1yiLr2BQ xHNcX25V8f771TNBYllxelcT0ZCbt2Ahpkz4spKLk101fXm/
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using IRQ_TYPE_EDGE_FALLING instead of 2 makes the example easier to
understand for a human (and adds only little more effort for a parser).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 35ed04350e28..de49b571bd57 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -111,6 +111,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -119,7 +120,7 @@ examples:
         compatible = "adi,ad7124-4";
         reg = <0>;
         spi-max-frequency = <5000000>;
-        interrupts = <25 2>;
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
         interrupt-parent = <&gpio>;
         refin1-supply = <&adc_vref>;
         clocks = <&ad7124_mclk>;
-- 
2.45.2


