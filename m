Return-Path: <linux-iio+bounces-8610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96C9570D2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A89282A08
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C21178383;
	Mon, 19 Aug 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibaVmu7B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C4178CE8;
	Mon, 19 Aug 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086132; cv=none; b=GXkeZFB429QRWWWqf36UowV5NKEKcvFMPhwqstTJJTGLtAdFtUimYmPxU7wIRD2Pmsm9jcsXmcJGlLAqja9/YsPIiSHQu7Qkcrnba9RFWEFqJVd+URcCE5BfzE68SH5paj9tjmCEceeLBuz9SzgkFU5UiEwGArr+B+L+PDsKAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086132; c=relaxed/simple;
	bh=HEzJDDA7iAbH6s2K1+1fGk+8dut+cJutnjgJj/HWYcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ny6JrI05YTzRRCtQbztFZsw3A2zGUucBW6HLmNGejS5no1z6wajKi8l5+l7U754Y1HiyAdhLpaaFJtm87hkhqiDxryy1+tTNbAoaJpGYR8S/OtzAmegD4DfN1qpR+Q8F98rzgpodDW0doeJuF9oGztPzjTJh47ycn9cUO4iC/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibaVmu7B; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-709346604a7so2211461a34.1;
        Mon, 19 Aug 2024 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086129; x=1724690929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGT2rYhH6YuMr14pdSYvfteEm0BRhaU6zPY4wR7HVp4=;
        b=ibaVmu7Bu7C+az4FlPOws+oJ9fT6giiuC6Mp8L71EA1byYuHBULRXUywfXq1JLyaPb
         AneWWyc2iXT8MMgHxmsdXMyfPrn1w2wkp40Df0SOB5k44F25frQQGyvlhHo4UDFwV9AD
         85Cf+NJZx10/VLYFpHfjFpo7UoAFVUp1s7xldzvZmADtNEfj/IXVMxjBybn6D2sZLwLD
         0E7W1W8rxaF1IunoUTCq9nTZ53ycepNKFo8TG94/HSnWIulzSAi0R5jdY03FgRouNidt
         HztUu805Hut2aDN5SVfTjqnESWIlE4QBFqBKwP5SC6+OhimP28azmzdS5voEfLArPwhe
         zLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086129; x=1724690929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGT2rYhH6YuMr14pdSYvfteEm0BRhaU6zPY4wR7HVp4=;
        b=WyXXCsVnDid6GlHryyP0+dPHhf53hXaxS59EcgiDMw3MfPl40vPfIXvzfZcmV7jPiy
         kBfM2B1+oWdQaJcYWoLcNwwleygCVMA5wgQhGoPFmSCNzuYsvqxXR11eocHqYWEzn8XQ
         Y8LyYr/mUg8FJMxLwNyDnFDu2km5dqL2LC0ka2sUJvoyHHsv0KHkjNJKPVreLzJkCF4B
         IOuHwSWiLDrAc3IDGS6BwjRXJs0YqTG7ZHW3r1oWYytV6bRuLKZ9IXojWP49ugonZMZB
         fd1wf2IBIPX8hq82m97Ltm9a6IO+NH6ma7WPPW5YRu8AgsAu91/P5eIeYbmMEJRijEH/
         Jbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXrce5ygSwmboBu/X+V5xvrKplYi9X/mHH8WCSztyGQ6J7zpJHSyI50URYvsel71U0qq8cbD9YkghbBbUIQwm9uCYjylaEG3z6JtL5EqKkCRwfjm2K6al8cr3RN3UnEoxSyhnvYYQ==
X-Gm-Message-State: AOJu0Yzh33EkcaIsfXVlzNUkRUaNluz1LDCWJgusnYTQpwGPuKa6elia
	P8Vz9W9jxfG5KXVTrqLMF9AwrTdsb3cbAQYr+7OfHg6BoN0fiCJJ
X-Google-Smtp-Source: AGHT+IHwC1bOkEu3UpOsz6uuWZJRs5JKYc9Qep4yjBeJPfyuZ2QbVvJZLOVGJiYVt7QAbcg5B43E8g==
X-Received: by 2002:a05:6830:6088:b0:709:33b1:fc38 with SMTP id 46e09a7af769-70cac8d59b7mr16910408a34.29.1724086129542;
        Mon, 19 Aug 2024 09:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:49 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 08/15] dt-bindings: iio: adc: Add AXP717 compatible
Date: Mon, 19 Aug 2024 11:46:12 -0500
Message-Id: <20240819164619.556309-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add compatible binding for the axp717.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d40689f233f2..1caa896fce82 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -37,6 +37,17 @@ description: |
    3 | batt_dischrg_i
    4 | ts_v
 
+  AXP717
+  ------
+   0 | batt_v
+   1 | ts_v
+   2 | vbus_v
+   3 | vsys_v
+   4 | pmic_temp
+   5 | batt_chrg_i
+   6 | vmid_v
+   7 | bkup_batt_v
+
   AXP813
   ------
    0 | pmic_temp
@@ -52,6 +63,7 @@ properties:
     oneOf:
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
+      - const: x-powers,axp717-adc
       - const: x-powers,axp813-adc
 
       - items:
-- 
2.34.1


