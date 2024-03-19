Return-Path: <linux-iio+bounces-3631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E319B8806BB
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820681F22D09
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233A405FF;
	Tue, 19 Mar 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdSom7TR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1163FE31
	for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883685; cv=none; b=JOb4mnOuv8iTYh9RCVEB+X2kvjqpF4N0Q5fIcrC4nYoCQZwnkh/ChapeI0WHF8gbp0E6R6VlEiqBuYIGdtSvpMMWlw3mOU7ncifBctCI3cHSDpIvXJfUcLiaXxthIW5ZzLz8Er9YaroU5lp4PgHV1zcCy9Uz3/CbZ+27U9vaNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883685; c=relaxed/simple;
	bh=LPB/loTv6jwLemSVQJ5Jso+LA3c9y+5gnY3dnI88Nt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otN264FE6X2kPFW+dAubBYAWe7rv2cGTeXlqwEcqVUr8745Uu9Mg4uuD0widv31fClDeE2mVjbh9t7X3O1EJhhLweHqX916GKAtQVNHNmFHXfSDj+EdXqVRhvrrSRA3JaIdAxVc3bVqChdpfcfun4jJ+hlREhsx9reoT+biETHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdSom7TR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512f892500cso6835695e87.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710883682; x=1711488482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaWaiuiJkKvicNkhaHabUPm411hAG420T4S0Vhvt0XI=;
        b=BdSom7TRQyROfPgrSwDYNpp7Va0Yu/UHzfbY01W8ujn1Wg1OGYawQ8uDytSsi1H0YY
         QL3GagpKaKOc2mzD3Ie07k50zNy1eKzKAQwUnGJdJlrE1UY0rvCUNIxV+bsjDJzwE9Zf
         xDWvqw3/1lcgr3sSUgCgLG2Mw5oQObGr7e6OwLyoV5LQerDVzwItFw5RAwINIY22+jV6
         XFzdk1i1OW6UCoZmEju0x5+oMtn2qHXdf/OJelphTZpvwgAkQgdXFGwyY0imqdnTx7iI
         C7Mz/n+qeZLgKp8JmS6Yn8whpOzFaQ8XrwdyDAeUGjemaQEo1mrC0p3SdxKpOGBUH5su
         5Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883682; x=1711488482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaWaiuiJkKvicNkhaHabUPm411hAG420T4S0Vhvt0XI=;
        b=lRsWAa3WnBby67soPnuInlCmQQJT3PYbo0yr7YrCyvaG8e//gxn7n1iuY6/CzT35Oi
         Z66Dtfrk9LBtxM7vMUIRpIC8JaSaEnysVDWfNcwKG6ydPY6M/JEOoCPE9OoqEWb267tR
         fz7ULRXu0RRUUa9QzJODXy3fBiAyUeGFoNg0qIug2o0pHgrktzeML1lop228rDJsyzwN
         Veb+n7W6elmmVAerL9v+S4n20w5/WAdrBkdBpL8d2FpH6tQIIql7o0yRFM8gfsyI+dN9
         dTqDJexV7M3x2na2+xIvUfrhO8SnQXMP038kF00gCpo5Ori45Pipvq+xhUcRCxgN43LH
         MmDw==
X-Gm-Message-State: AOJu0YwW0fINmwM1GUTR+QYVXRmxD/I/ae+Cgx/iXjcP+06y/mcRS7dG
	lCs6Y9+8iI7XEKdGlkd08CDodfTO+u5tjXe0JgkDrSPOr2YWM1lb
X-Google-Smtp-Source: AGHT+IEGQYR82edYXqyPc3sWbHmabQ+EkIlTMNX4h8yunGN+eIT3RvVjU0bzQvQ/oSqjuPAM6K1Fyw==
X-Received: by 2002:a19:644d:0:b0:513:d5ec:afb with SMTP id b13-20020a19644d000000b00513d5ec0afbmr8562340lfj.40.1710883682198;
        Tue, 19 Mar 2024 14:28:02 -0700 (PDT)
Received: from a989ef099cc9.v.cablecom.net (46-126-232-210.dynamic.hispeed.ch. [46.126.232.210])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090640c300b00a46a4a14555sm4402518ejk.86.2024.03.19.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:28:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH 2/2] iio: adxl345: update documentation for spi-3wire
Date: Tue, 19 Mar 2024 21:27:13 +0000
Message-Id: <20240319212713.257600-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319212713.257600-1-l.rubusch@gmail.com>
References: <20240319212713.257600-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the optional spi-3wire option for the DT binding.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 07cacc3f6..280ed479e 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,6 +32,8 @@ properties:
 
   spi-cpol: true
 
+  spi-3wire: true
+
   interrupts:
     maxItems: 1
 
-- 
2.25.1


