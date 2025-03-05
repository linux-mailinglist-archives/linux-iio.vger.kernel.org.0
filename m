Return-Path: <linux-iio+bounces-16433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA784A5040E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD33B0B50
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8E250C13;
	Wed,  5 Mar 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJfxVUCp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D0250BE1;
	Wed,  5 Mar 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190364; cv=none; b=Ayq2Lz+K7OfMLy3A6KcbbSbIR8sGK0x4ooXYW9n3Yr2OBSSaqiDHwCY4tjfvMSEVJc2NbCyCvSirDWzgZC2WcexL8VHw7P5mDGig/DMFgzyuxYGguLz8p78swaqgJ/2Zq92dsD0gXmFYqPS6M17Q2lqN/azzP8Bs+/81dF2stfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190364; c=relaxed/simple;
	bh=sPIjwemLxkj6a9SRgASP7zlJ2AGGs36MMsMMo1SWiQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOqteNnvgKxMROwD4HojsCTzLsKY5MMcCHou09nFMOoYr12bDG0kLqWGYgytlN5f7FM7uWgSa1B/ln2asR1ferWn5huNY+0KvVbit88Da37hncrOIaPpHj+wYML0EyFO+NIEfIZ6zknm6bao5KtUna+AK67LRA/r+Z6FPxLaKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJfxVUCp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223785beedfso93432855ad.1;
        Wed, 05 Mar 2025 07:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190362; x=1741795162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7CqsHn5bokc3+NcDk3/lA+pgZAOj6766/BLvejkqbU=;
        b=MJfxVUCpuObotJjR3OhroBcXOlYqnXHCBJ+Xxqvm//WIm2LOZKNxfYzC41diqi98El
         K5ov5XnVwD6ZgpGS/pJUZCw/eOkcxk/bhsHLZjqtYal73wp97g9NuaN1lI5cg7vlaKuW
         oQw9j9ChW5FhFWcPKGz19FJ59gQCL4kPfd+llOxYGCmraaoE4fLpSGeEZBuxBkK6y+yA
         gZEsUrPu6YKPmEHEw3JzKydJ9eC9rWtQTymMIg4Nzu81vlxVsqmVSMssfsHyGCy08OVg
         MisSoEXSCKMGNnvUSmXfDmOMIjSOv97aqgkxPTKL2goeTNFqEyX8nXj8v2qZxz1lAlRl
         z5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190362; x=1741795162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7CqsHn5bokc3+NcDk3/lA+pgZAOj6766/BLvejkqbU=;
        b=fFzptmpVH8thgwItQlIJ6yJXOM2cCvN8jaHx5THEeWgG482pkr4BrhMUqznZVRZ3+w
         WJ0u0IS09EQcObEqbL00lQUC9i+9lB5cZKVBQKSy8e6ZPmZanJxK5oQctfhXdDJNO67/
         B+ugvciX75ztP5TK6Yo7jh34D05yfyg8RU0zSZFG2Bf7fASPRwguf13viy8vt1s9JLas
         TwwFjX04tA51vEkCpeOekZUFU3ehYyjVyoKJKpXdCroI7ADTUat30CjwJqmBHnyaAryU
         FTbTPbUOqhbQpRLBCIB99YDC0iDIfEbZixSeAT49xy0MCKeuiAD8RkBrCMd9MSoVxPg7
         4CVw==
X-Gm-Message-State: AOJu0YyQxhK+DBG2twY9FbZ+lzZxlbLqNzLdB7T7+8VOWYuT3xIeYaiH
	Bs8JyWDp+pmfWHY35fhMizRI/J/qmkc3BwxyaxQ+felb3A28bymqyCd0++PoqMo=
X-Gm-Gg: ASbGncsNHPRn9abcG6Ema3HNNKMOBnI3Pkba/tuEhIjvpAHwJZKMTduHlFwTKStjNHp
	7TCL7UIxWjLBTmcFMJijRWrg5S8xFqlp6Uic1aC2ie7F+N+V/vLZFvgavRr1Og9fJMoauhDA7O/
	VHabBafGm6Imztarg+KcskXMBRq5dps7y4xZcaFJgQL7fxS7wrUHAbcT/PlsRZ61jHdzW4C4qZe
	1sfrVK7Trr3zFKbQw1HXyIlbogPuQ+AGDUdKLG8lfUQu8FTpPqhm9WHXOwGOnCkuJN/PoSm08KR
	m3f+MPrey0lzwp0xa8J5AfoIF2u0lKzt/8V4F/TmoNKnPdd11Mi6Z2nAV+MeZfEZ5ec=
X-Google-Smtp-Source: AGHT+IFRhZMcPG+j/Bvhc6eaaBbKGPiO9odO+NpCBvKjt6DDu0TCzAMrD8Y/zSal1OHpJpvffdLc3A==
X-Received: by 2002:a17:903:fa7:b0:223:5525:6239 with SMTP id d9443c01a7336-223f1d0fe68mr64532755ad.38.1741190362551;
        Wed, 05 Mar 2025 07:59:22 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9d96sm114914245ad.54.2025.03.05.07.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:59:22 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	lars@metafoo.d,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH 1/2] iio: accel: adis16203: Use units.h macros for measurements
Date: Wed,  5 Mar 2025 20:59:11 +0530
Message-ID: <20250305155712.49833-3-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305155712.49833-2-simeddon@gmail.com>
References: <20250305155712.49833-2-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded microvolt and degree values with MILLI macros from
linux/units.h. Also fixed typo in comment (1.22mV->0.22mV).

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c1c73308800c..ac4b28bcd766 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #define ADIS16203_STARTUP_DELAY 220 /* ms */
 
@@ -173,10 +174,10 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			if (chan->channel == 0) {
 				*val = 1;
-				*val2 = 220000; /* 1.22 mV */
+				*val2 = 220 * MILLI; /* 0.22 mV */
 			} else {
 				*val = 0;
-				*val2 = 610000; /* 0.61 mV */
+				*val2 = 610 * MILLI; /* 0.61 mV */
 			}
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
@@ -185,7 +186,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_INCLI:
 			*val = 0;
-			*val2 = 25000; /* 0.025 degree */
+			*val2 = 25 * MILLI; /* 0.025 degree */
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
-- 
2.48.1


