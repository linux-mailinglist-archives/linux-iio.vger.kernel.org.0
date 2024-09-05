Return-Path: <linux-iio+bounces-9172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F496D204
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2661C25001
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED621198838;
	Thu,  5 Sep 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i6RoRD6E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DA197A67
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524663; cv=none; b=nKaI1HjZizPirb4t+zlKIzvRjA/sLDwYXwnRcs3ENPGZjM3SZ6TUlPoMfJSQEWMs3k1BwAGq3ADdREv29uagGnIT0nweKaf+BFlD7vcHygYGnMzIc2/anGXL4V1fV7/DLjfa5T6DWVBOpC9YSEKj+poPGkIXaRHSpFu4rlW/rYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524663; c=relaxed/simple;
	bh=/ovmFlVD/7j+ipJY0VPXyzdNP1zhe/wqKiyGk4ajqgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRUCz1XJaGAiI++F8hAvtUWWc1VSmnKUN++ZcMsM9QC1aPgQhNotj1a4CMKRYO2snzcXcIj5baiFkxiOdciIk+Wvgrq6Mdyy49Et6AYP1UnOa1fEoOn93Cerbw0XCMd6OfZHgvU1UFKz6be9uTs00EEyGAd02CJhVw7THtafQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i6RoRD6E; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86e9db75b9so74391066b.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725524660; x=1726129460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g46xgvcRuzluvD9uFfVgOC6tB6SvIHIhrOwQLDjP3Ko=;
        b=i6RoRD6EATH5Lxqi4OewSSRiaGl6NNGWHB6hGKsBJ6jcAUqcRFDTCL3IJPJ9Ckv4LV
         dEk6OJx/odAMKCi7gUEYz1nssTvKre15RqTsrlhq5L3CN7pkkGeHDa2j+xltYfoyOyMw
         Z4x7WmMK69KJoT6u0wNi7QDTilMIx8I97RQGcWe2XqqhU1wiCkZgYGRn7aZwcze/An2c
         uJZT0QPW+xVhCGPMkIj8G4hBSuJQWQFhXRlOgiB7ma2qXqZORPDwzLMASKhk969YXeQW
         VXkCvLIBVvUs2TNMSE90UP1Zw54v4aSkIBHqJUGq3CHnajYOtgM5xeIfggmks2vfrUp9
         /UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524660; x=1726129460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g46xgvcRuzluvD9uFfVgOC6tB6SvIHIhrOwQLDjP3Ko=;
        b=NMfE0DABNhKO19XfwRBjRnWL7AduEDa9BnJ2m0IsFeqQ9uwHaNY20yRSw89dqnHSix
         RXBso2GskpK/bRWWLBA3ri1YbCDXYSLxJbHT7aZ3MFYcQQLlly2/fxuc1Oll+11owIAH
         06js04GHC8Rm8eM+PPbRXVgQm+V4crVae+Nup3Pg1Wo5xRt0NT34waAAJj34IeES1tNJ
         aaDWdtt3ILmzLo9ImOd1eow+1hMplvGozaTHlzZV8CCrpmyEL766NAy70iw014p5AFxS
         3vIin7QUAaEz5msuM5+uQ2dgMZMOj7Vv1T6aqlr9epzUNR9v9DVOfnzc+vszIB9H5aeB
         /EdA==
X-Gm-Message-State: AOJu0Yyqzs/Jmn8Jl/t8d9OQwjlmpYHTiv+FVmYaE96BMZBDyxafeDnW
	EeBpoglysFz9W+TGGNBoSluhGqmUcYeXRNPqCSZLsYqWkcSnPnKq3YSFxP5QJ6IUEEJuToxWEYn
	MYr0=
X-Google-Smtp-Source: AGHT+IEPcapgT5c8vyHV3LQwJ4MKYkMzKLUd0c6or4eTsc0LfeUFrkNG8rK61o5FzDWPYLQrgG6jYQ==
X-Received: by 2002:a17:907:7206:b0:a86:a5a0:7613 with SMTP id a640c23a62f3a-a8a1d4c2db0mr918986766b.55.1725524659644;
        Thu, 05 Sep 2024 01:24:19 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c80sm102300366b.174.2024.09.05.01.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:24:18 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 6/8] dt-bindings: iio: adc: document diff-channels corner case for some ADCs
Date: Thu,  5 Sep 2024 11:24:00 +0300
Message-ID: <20240905082404.119022-7-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905082404.119022-1-aardelean@baylibre.com>
References: <20240905082404.119022-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ADCs have channels with negative and positive inputs, which can be
used to measure differential voltage levels. These inputs/pins are
dedicated (to the given channel) and cannot be muxed as with other ADCs.

For those types of setups, the 'diff-channels' property can be specified to
be used with the channel number (or reg property) for both negative and
positive inputs/pins.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8e7835cf36fd..b9bc02b5b07a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -37,6 +37,10 @@ properties:
       to both the positive and negative inputs of a differential ADC.
       The first value specifies the positive input pin, the second
       specifies the negative input pin.
+      There are also some ADCs, where the differential channel has dedicated
+      positive and negative inputs which can be used to measure differential
+      voltage levels. For those setups, this property can be configured with
+      the 'reg' property for both inputs (i.e. diff-channels = <reg reg>).
 
   single-channel:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.46.0


