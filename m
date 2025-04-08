Return-Path: <linux-iio+bounces-17820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F620A80C25
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8711BC3121
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECC818DF6D;
	Tue,  8 Apr 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mhl1XHJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAB2C187
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118507; cv=none; b=XeWwH3s3Q2EiXB9cKkZOM4l3Gjo0qCn4ugXvVf4yIACGmv+Jl1mKmP3Exybn0uETmjSUWMebdNUPJha5YMjChGeZFjtJ8v7PZNZqCwSJE6mk6HCBEsFJoJ8OHcMtVOBeK49NufS/+dRxda65Dl8M+jaPH+5Ct8JmMuw7WJjITks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118507; c=relaxed/simple;
	bh=mJgJq+zZMLWqDbzOKvdDkq8EaWO1dzLuMwrkMz0KsXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PfdXuI8nV+RNgB4eetScOCimq0n4PGv1Qflo9fUnIBqjZ3TTOdZD+uRoKcpm1nHys/aPQRCWt2hMl1O6HUTfHvCVvIdmfLvjtqIc1vB09SgdvvwqWk61cr6Es2AyGiPbU0j7+0mJbQqah6xVtS++/M9uQh69s+byhmwq67/uJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mhl1XHJD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af59512c64fso3684983a12.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744118503; x=1744723303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl8SMQ6yFSz1U//qzOWMiPyaq5J817/iUIFM3Px6Z1M=;
        b=mhl1XHJDK2IcvJMfVaV9eYBDBDW/rRNIA7PJJTcblm/L8azrynygygiiYpMp90iMSB
         u8UIgT2bW5C/w1z1iDfsyXZIZJsJSkFtNJE1xBn2yX5RRtvGNJFfA2LMz5McLBnxf5Z6
         t8F4h60frllFCIweaIH7c7y2Axm63nDkslwxmw8SISZlxeKEPjq8neOcvhqEqd0hmVT6
         EZYVFYKAb9ma+j0VVZTdOTySTL+YcTcATzEfkWLI+wvTrRAVIsCiMA/fQWtzSXbs/tKo
         wq4sOiy1jrcDSaA6juSksXURBeukpcYQKAGno9HILovjmo+GyZzMt/gTg/cXDdzZnQ3G
         DLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118503; x=1744723303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl8SMQ6yFSz1U//qzOWMiPyaq5J817/iUIFM3Px6Z1M=;
        b=QqPJmNvnuQkKe2/d2PsTNihgSIa5YGbEU72ufWU3/ij9KsVMopA+6yEwq26bN3gECs
         psw+J7o/odSu+xVvBQwwSD0aE0n5dfL/TqAX51a71s4JM+CpJjx7JYgPx4SSYdDThnbc
         hqsdICyh7IFIU3r6+Ny5C8axENmAVmwqlfspORMt87lETIq38sAG3rTtjA+sPtqdhbRr
         i8GRwrQz7YU1fOhN7D7mzcrySDRKGSn4aHIgbB56r/fHUhPLsUfVPcGwNXVkdYtNfVJF
         Uzo4cotuqTcT5pffPYvol/biTHIPGCizKY5CnPiL3BuJ3eoafTDA+1+I16ArhCx6e/m6
         GlKg==
X-Forwarded-Encrypted: i=1; AJvYcCVpNS2Xvb+lj+NY4l3r1CKhOu85YDCIZqPM86IdpLsgwxG3WZ9Q68IE+A1EaVn/BL1fXtcE1nb2a2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCXU11UWzjbaTfn7Wb7oF0rcO743Xc0TY4u16L/O8BKdJM09rr
	qk3BhMOigV/vjAXyvuJCxDha8G6RQ1OhPHah1T3bNKF+B95ZFs+tJEYk4FxTl/U=
X-Gm-Gg: ASbGncuSUAuPCzp4wZj4bhHlQTWemTNRNmRDzb2wZBjR80bxHDCh+jGJOM61y2f4Wjm
	7cJafksv+5gjGgxfB60aznQFksiOzFN35Sxx8NL2IGVsJzacGVkgxJyYr+M6JW0xYe4ZdGVxR4F
	B4nV4/Ec+tutC4Zt2UEbWkJ0c8gNxk5ndkkOZPApNp+yHcfQAmEgFHK+I7ckbZexOjer6af7xUQ
	V+yRvyZT+peviWwTmDTozr9PexztDr0DdKXsVH1JtT+yTqnTDFoY4JGKi2yprZsgbXHp7YHeq+i
	QB1tQHmhu8DzE+j69DcCFRec3srFcGukBFCPA1Sla3A8/hq5DoJj+fjRfz2LyDEAidG/0bjDwms
	8vCocB7w9+oEJZCV1Eg==
X-Google-Smtp-Source: AGHT+IEYI0yvG77vI7wLIcJ1amCXAazIRjj6uaOMMeamEoCcUQRJzOz8XlTJXNoLFtSNfoVsf7yykA==
X-Received: by 2002:a05:6a21:3942:b0:1f5:a3e8:64dd with SMTP id adf61e73a8af0-2010404f3eamr25769684637.0.1744118503224;
        Tue, 08 Apr 2025 06:21:43 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41af71sm7439565a12.75.2025.04.08.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:21:42 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
Date: Tue,  8 Apr 2025 06:21:19 -0700
Message-Id: <20250408132120.836461-2-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408132120.836461-1-sbellary@baylibre.com>
References: <20250408132120.836461-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adcxx4s communicates with a host processor via an SPI/Microwire Bus
interface. The device family responds with 12-bit data, of which the LSB
bits are 0 for the lower resolution devices.
The unavailable bits are 0 in LSB.
Shift is calculated per resolution and used in scaling and
raw data read.

I have been able to test adc102s051,
hence adding just the missing ones in that family.

Lets reuse the binding to support the family of devices with name
ADC<bb><c>S<sss>, where
* bb is the resolution in number of bits (8, 10, 12)
* c is the number of channels (1, 2, 4, 8)
* sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
and 101 for 1 MSPS)

Complete datasheets are available at TI's website here:
https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
	- No changes in dt-bindings
- Link to v2:  https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/

Changes in v2: 
        - No changes in dt-bindings
- Link to v1: https://lore.kernel.org/all/20220701042919.18180-2-nm@ti.com/
---
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
index 775eee972b12..392b4a3e867c 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
@@ -16,6 +16,12 @@ description: |
 properties:
   compatible:
     enum:
+      - ti,adc082s021
+      - ti,adc082s051
+      - ti,adc082s101
+      - ti,adc102s021
+      - ti,adc102s051
+      - ti,adc102s101
       - ti,adc122s021
       - ti,adc122s051
       - ti,adc122s101
-- 
2.34.1


