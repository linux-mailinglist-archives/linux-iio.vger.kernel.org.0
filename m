Return-Path: <linux-iio+bounces-17522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC2A784DD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 00:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4383AD514
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8821B9CF;
	Tue,  1 Apr 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bCuzmVoc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83EB2144CF
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743547840; cv=none; b=MKKGy6XwpLL1G+t+1wZO01ZiTOnY06l3cXGSDtiB+h5bLhSwuBNicxnrh4m23FvE9tUTQHHgc6l/se+Jd+63ug5idOF9byqtud9TQ/q8KDjOnbtQ7elDCHajnWpz+tJn5Vx2vvmys+weKo0/j0PexHsdNNXht7kz9tp4bx00XuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743547840; c=relaxed/simple;
	bh=wllrbZcObwGAw2NDOjEh96guXeIJUG4ySHs9Mzrn5qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HB/9Lc5ZRjF2ICaUTqsh5ilZwl7cBtJ1qRIXEr2b75dKPuclmOSOZNBKkO+sgpUl7nAYIppsKpu8uUY6k5GvT/x4P/wn8iLsaEo6DS3C4ENCIUYMFDQdX/n7xKKmKpv/JLi6H2xaH/o2ZYikp59+ajP6KrjF4oZChMwkFlqUANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bCuzmVoc; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72a4793d4e2so3806988a34.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743547837; x=1744152637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY3LwKeQSjqjV8tkE42G4HURVFmjP7EU20VDalM/2sI=;
        b=bCuzmVocI9E3Eq/hhATmFlmERpucWHnxqY0UqiM/EG3dxoeB6UkKqDekxdcgg0ljDR
         3DikBxW7Ksh6ThBFM1OB16YeoR9E56SWFvOAHplXc13TmbswXBAK3Vld3yvJmvFzi44y
         EzPJf5QDBFxAL9aow0WhDODRlVWuPjo0hJYlESat9yIed6MOIP6lPOrx3Lv2wQAtBnKp
         2DGZ6cARoog9yxTOA+IcIdcf73p1UAbA6NDJSBiZZlDM88Pre64CRtqxvk5VZvb0NTtN
         GQbQcu+hUGJtM9TLZMKP4WxIWpIiK7bHV/Nzr/KO+8ekyYdNU3k3w33JUzlz33PPfGaU
         lnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743547837; x=1744152637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY3LwKeQSjqjV8tkE42G4HURVFmjP7EU20VDalM/2sI=;
        b=DDg1LBfWro35toLmIIocc1FwipYkU9CZnd4tVA8GNEmClXKOWx1gIsKSEpxqIA0ia0
         J4pHz50OmBBhiWkRH9IL2o5OZjMeTCXtAaKWYEPXMIfiKWglI+6MTEUjMzGBxwVu94/g
         kkdleawD+ldkwnbBR5bmG4Dtue7WD12mzz4kDI+qdmFUenT6n6jW1vgqy6Y1aCJNpfwB
         K8TtvveSAq3aB2D4WE5vMbqHXHC+NOUcnsRKsJT9XRnZDyo3zrpoAYdTkOjyn2lr049L
         eW/+OKtgs1WjSD0byIXdRbhYY4GNeqPsoOIdGmeYNTsHBD7ZZmsAsQRhTExMOKWDK+yQ
         FCLw==
X-Forwarded-Encrypted: i=1; AJvYcCW3/wHdUcJsW5YLbmnTcqlSonsfaM1+PgwLCXCVAIRR/TzCN+sKVWIbDX5HIKpfUDGSEEP/8kBDct4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRZh6ADGZpGdittjnRYG9wEBLOlxS3rh5Cluq2DQgk8cPQY73
	zJYLJ1ros7ZcBQX1/xuVNDMzgKnqte05GQ3hX5wrrjYumcN4NuRnU1H+fjNx0eI=
X-Gm-Gg: ASbGncuW6TwMiwW+oJYww0KUXi8IgfpCXWR2LhG55fqxPubklrGPpTfT5u+YGZwHl/z
	nFN45IeGuOtVmw6OgP0IdG1b+o+TvSmlnW9nS4bJ9wSGlD60jweI/vnDCifr2Q1I+YA2Uk8aRs5
	bqhY1xVGJXyE3qJPm6y45zN5xd6ZETY/uxrjvUd/FKav38qc0bHYYazvPCFt08vahwqEDqwezL+
	ZwlV+/P0B5xIM6xkqxU3xuX8MxfW8Iyf6wiR85sqlNAP6HhJl3PNod3YFlsfXBkp1nW3PFoZuIo
	9UJ23hT0+MraYjjf5BAoGwURsx9kcIehFZTKcGzocypTLZ+4ul/ISuRtKOk6VJg9dfFKB8Al/qy
	/
X-Google-Smtp-Source: AGHT+IFDp0AhTF61Q48nqN3yJ3kD3UvIIm3ZCEgDN5dT9w+U8dAZ7ndt8F2LawR99JrCPDj14Qxqeg==
X-Received: by 2002:a05:6870:6110:b0:2c1:4e25:e67d with SMTP id 586e51a60fabf-2cc3822a497mr2416377fac.24.1743547836885;
        Tue, 01 Apr 2025 15:50:36 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a860267sm2541894fac.36.2025.04.01.15.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 15:50:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Apr 2025 17:50:08 -0500
Subject: [PATCH 1/5] dt-bindings: iio: adc: ad7380: add AD7389-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wllrbZcObwGAw2NDOjEh96guXeIJUG4ySHs9Mzrn5qQ=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn7G236w79skU8tariQuUPZDNW+cVxj4WjqBK51
 SAIlOIvdJuJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ+xttxUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMwMg/9Edgch9EspXTEYY+1JOhAYpgOz7/utZQkuEugP1+
 WwGFOvvz3YncY1JSOHxF1TmFSzva8wuhTzJIBcQegux/n4r3/3sx89zqemdZXUhd/HGu8C9lxg8
 kUbW+hr48TcPubsoCH43NMmedD028osLHS8r9Dn70MpvCOT/rGmsCMHQjgXGKoPNeXVOmQFH2rq
 tOntr5Uy0Tq0QFnTUKh/WhqEiBcN8m0pp8QtHn5/b6sOkTI/2iPNFeK8TSDl2NpYZlmyqFVaHHI
 7I/FDCdm7li0ksgc80/NcF686dsh2fDXTjcKJMaB0kawSXWMl1K7GfSTQJQYOxHmEr8cI1ZEKNu
 s66jwGniuIFVo/+oBarBcXjMtCCB5ZNvuRTHWRn4D5Ivi37y2fYK8qgWAyT4SxFdobT4VYXRj2M
 KtMSMoJ+F3xE9zTBbwX0kYduwfQbwjFp+X82PdGbmYXXaSOnzx5glS94Z/eLVeYRPd1FOfbQoup
 v7319GkkzQm6ZTd9q8yVn56dIHnPdNIFxQr9HtuQRhibTIYIoprOtFokmkDy0rWIvzDAIqfrX7w
 4Dj3CNXlRjX1rG9wDsF1o+l3WZBeOH+ArChguo4PrOzybCsf0abvL5HIpNuQQ8QH8x6cWpKVUj1
 LL+QynRMc1Sm7ulcHfPuGhzaiN71DRyd5rt17XvlyhKw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add compatible and quirks for AD7389-4. This is essentially the same as
AD7380-4 but instead of having no internal reference, it has no external
reference voltage supply.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index ff4f5c21c5482b77ee2774b01ad6d426e68cf207..8dae89ecb64d723dcf2b4af1e0505fc5db49595b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -25,6 +25,7 @@ description: |
   * https://www.analog.com/en/products/ad7386-4.html
   * https://www.analog.com/en/products/ad7387-4.html
   * https://www.analog.com/en/products/ad7388-4.html
+  * https://www.analog.com/en/products/ad7389-4.html
   * https://www.analog.com/en/products/adaq4370-4.html
   * https://www.analog.com/en/products/adaq4380-4.html
   * https://www.analog.com/en/products/adaq4381-4.html
@@ -49,6 +50,7 @@ properties:
       - adi,ad7386-4
       - adi,ad7387-4
       - adi,ad7388-4
+      - adi,ad7389-4
       - adi,adaq4370-4
       - adi,adaq4380-4
       - adi,adaq4381-4
@@ -213,6 +215,15 @@ allOf:
       properties:
         refin-supply: false
 
+  # adi,ad7389-4 is internal reference only
+  - if:
+      properties:
+        compatible:
+          const: adi,ad7389-4
+    then:
+      properties:
+        refio-supply: false
+
   # adaq devices need more supplies and using channel to declare gain property
   # only applies to adaq devices
   - if:

-- 
2.43.0


