Return-Path: <linux-iio+bounces-11273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449939AFF4D
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 12:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DD41F21270
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C81F80BD;
	Fri, 25 Oct 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2qRjA9Se"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD501E6321
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850400; cv=none; b=Tzj8ooUTUUYdiCExDgiw0ChnflPNlm+/dlCdf5Vsnn1X3E81hxq/8KeQwS0DIHjzCurU2LkXaUMUkgpyjAq5gqNsvzUNpaaO+GalCmCVK2spFY/IwASkJqIC69NSPPQbPmGAiPlSpW5X0wDcBZAEEX2nM9L6wmlQWi+s/Sp2peI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850400; c=relaxed/simple;
	bh=AHr8+bZPxOirShIhCBXHwG+5r586Z0HInHo9tKzwsOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beYGkSjpnTJPLMuZRy7JYxR97EcwvCcZNg6JcqWh4RoYi6Q5SIJx4LsckpjSEP+Yhjrz7SNMw/yqOYSaebiCm0cogAKeKKjzdq9WP5jsMFnGTyWZGi+te1Ealdx9ShAihEsAoR/Cg23eewCAkMGhfvjMwoZHgHfKlVU93WwJWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2qRjA9Se; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so243768466b.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729850396; x=1730455196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ6DHZ27Ytkbo5yrreDnReoJRhwwE+fVxb3ObxqCfkc=;
        b=2qRjA9Se3jGVT0kScf7/7IhFew8OQBfgHGPbaSaPj/f4M8UiWus+QVbhTIE8vkkXA9
         sZyVEA0Sw9RsifW70Qe1ZcN2J9OnpeqHsgFgw9/2b4hdVnJA+QeeBgGMBz7bnfd7dYLU
         ABxaRezj5N4s3IAdVOIEmEVVuUpx+7aKcJ5yvmJxBuxV9zEYVmf2t5g3ZRhtdDZ1+wB5
         pQaS4/jwa1Z1hyD3WVcoAJwCZBAXfzbUyp/WagNpBsnEwwIv+CrrbJtke5PPwyE9TEXd
         1VlImwaawsQWPG3Te1KVpUPMYpPtFoEk+pFPUfQGfOh4IJQaCPzMNOa0NBHLWMZ9JKsJ
         u+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850396; x=1730455196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ6DHZ27Ytkbo5yrreDnReoJRhwwE+fVxb3ObxqCfkc=;
        b=gSaCWBDffclrz7nwd7ZaVf93ns4AZV3tWJosLzEVWLJsYYj38r9fjwf/X8wc3irJ/C
         KKvtgxWAMfCsd3cHRJe2Irjx4g5afVh2GmV+zQMalYABeOqF/fMP4j49TJoypAx8JVhC
         5NJkILQtZ0LMIL/0BQlVqmt8WkWnTS503Ytr9jZlQIol60+MBdShb4JtKiqvKRJS52oF
         xKWsmZdHyDBoV6tMwct9zyWsYfmKH60nGj4VzqC1f/3HXzh8BoCG18gXBOb6gcbpMtyI
         99NUxEvNQIz4oW37E1MH0ZCp9wrJyhxQAaS0BudzdVhUjWXScq7qTbGHF/IVdHxSmL9r
         QYIQ==
X-Gm-Message-State: AOJu0YyR+ZrUtezetKUvhZnbpNdxm7bYB6er/BY/6atc+t15KyazpkpD
	0mEkftufSRH5I+1BgPoiedX6vzRN5rWKG6+Wd4c8k658zBYajIB/oUAGJk7wd26mAXGmZ0uQL+5
	AWuM=
X-Google-Smtp-Source: AGHT+IGC4Odl99z+7cktPBrI3HzWr9YCRt8QG1Iui8MG4JArqRNHoC2e+scaEn36iNftnLDlwe4gDg==
X-Received: by 2002:a17:907:3daa:b0:a9a:7f37:2b62 with SMTP id a640c23a62f3a-a9ad2815a49mr445493766b.49.1729850396140;
        Fri, 25 Oct 2024 02:59:56 -0700 (PDT)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f02951esm51737266b.71.2024.10.25.02.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:55 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	conor.dooley@microchip.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 4/5] dt-bindings: iio: adc: adi,ad7606: document AD760{7,8,9} parts
Date: Fri, 25 Oct 2024 12:59:38 +0300
Message-ID: <20241025095939.271811-5-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241025095939.271811-1-aardelean@baylibre.com>
References: <20241025095939.271811-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds the AD7607, AD7608 & AD7609 parts to the binding doc of
the ad7606 driver.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 0a612844029a..ab5881d0d017 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -16,6 +16,9 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7607.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7608.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7609.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
 
 properties:
@@ -28,6 +31,9 @@ properties:
       - adi,ad7606b
       - adi,ad7606c-16
       - adi,ad7606c-18
+      - adi,ad7607
+      - adi,ad7608
+      - adi,ad7609
       - adi,ad7616
 
   reg:
@@ -250,6 +256,9 @@ allOf:
               - adi,ad7606-4
               - adi,ad7606-6
               - adi,ad7606-8
+              - adi,ad7607
+              - adi,ad7608
+              - adi,ad7609
     then:
       properties:
         adi,sw-mode: false
-- 
2.46.1


