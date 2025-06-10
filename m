Return-Path: <linux-iio+bounces-20390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2979AD4565
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53D47ABD59
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110B4288C8A;
	Tue, 10 Jun 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGPBiut/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DA2882B8;
	Tue, 10 Jun 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592790; cv=none; b=PcovuRFMiWt9EgUUHiTws9oobPsAkXoI3PempyPFdiKLdZjyd6YEHCbJGDe9BUdd+39ylkamsNWtQUiksvmTlTGEIvZGL2pbd24MgVUbsEjqCgCMjn3BSBz+GcyWbs1WjqrX6PL/tSvqPjHgFzbX5sCSkwfMybkrRuHMs+FwQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592790; c=relaxed/simple;
	bh=gLYNKyZfadjn5qum66b4keW5vghvWeQtJMgk7Q7EcA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UOLSF8cohFW9foyi1D0/cUz5dPSKf3i5y2Xuq77OW3niQoaB43uL8rni36Mdj7o7HMjbcE5yLS0XYSy+3G2aqtm5IkhjJD5WfdkFUr2gw1iLXMfKE385bLaLRJ1GCk90C/VU7JwkEsRksoWLQ/EbgExZTI4f9rACdTsge2gsBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGPBiut/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4e6a0c274so748365f8f.2;
        Tue, 10 Jun 2025 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592787; x=1750197587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGhgqRwNMDzn/g47+sfXdw7f8ynPaKXSjobY4O9cee0=;
        b=LGPBiut/hybLtDBDs7Esymti4KTj0KYVV+4Le4hBUfw24nr3VDJYY3xEh+GDFiOZKX
         SG7oJmpTRR8Y8b6YwCscajjkBZRkYy1twFBD355S9W2OAiCB/k3lygVWVoCrvqPKgnwJ
         59UPuveFoacy0LSpnMK2W5aCvPwUMjbsvcEsFXfEadg57JkPN9gSGilLGGMmdYPE38XA
         2u11f4dS2W9lbbLr6VLrQdAwejmvTEwAtZzqPcK2BCCOpb7nyl+TgFKqMuFmAIkV5dgN
         MNu7zRQZw5efdhOSyP+pEE10XtenxUEYcoZuaGouKcPhP+10QIL/YlYhiSzEdtzL+0S0
         OjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592787; x=1750197587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGhgqRwNMDzn/g47+sfXdw7f8ynPaKXSjobY4O9cee0=;
        b=gx3R7iySddD8GuLErLv0MFdEWat4Zi+11Ri/pwY/IjxSotK0V2XdXOieXPUK/GVFMj
         5KvplYCEVYoFXsaOdZogTWv+JspH15GGCQ9egh2EwFCx1bpSOfh1MxjMl+ngNTT7ONrG
         a4KEBu6Kzy3MJmkwN+jB2rDv8LBlpeegRcGr7ac/H+xqL40xF3hWqWzDoHJwbd7s+R8R
         XXp/9NRW1cCw5xD9t6m5iolfV7YhpXmmuH0w5fK2+iYhXwXl2JE/i7pjxKkdmcE+hF16
         QU4CCayXhoflso3yK/XGeN1kJqJ1caULlrRXSUxuW24ZaR5J51p8C4eNbN3Q8GfGasmi
         0OXg==
X-Forwarded-Encrypted: i=1; AJvYcCVRf8Akxj9taFntjkIjXrFnoHe9V6kPNNytpRXc6wOiYX3WlL+vgCFucxreVRHkpIqkkg+3XalYtJ4U+ZJ/@vger.kernel.org, AJvYcCXQa4sr9RkeE9/LSDEri+8nxEcPX6p6r0gVOuYOpB6ABgcLTCmfoZGv18+c1HG21xUkNaOrm2yeXi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidJpmOnRRGWJOdSvZtn1oiJKGIFLutu47/GmPjJ9ABbgus9+x
	RxxZc+GMokTBC1CLA1wEn2Lu+3y6ODPJ8cc9xkGZNebFg+nuUfApAYYc
X-Gm-Gg: ASbGncsPPuwPtGiYUd78mguS7SZ4CzBR+n5/6ojgfUObz6Y5VmtS8jhLjEC9ZfkDLmU
	lkQq+qPUeI829I+8kxUHaYGOgSROUhr7cE9Sli/16GA2auV5n0zh5FPfLju41Q/h4GfdEz5Qzr7
	evYNn5noN2cF23Vor9YrTKv00Lj0N4uDqjQJby5sjxQ7P63DOwJjWUBmYG3FhAuh5yNT4WPOaAa
	IP3NcL0wPT2N7pLjcp2zD3DSUBOwPuvVsg3VB30WQ2KcNR/5kZdp1IP1kVhgTdrOT3UeQynnbR3
	ZRj14CRk/wUWDpTNoyUeprQwU3WttTveVlfkS/8D0bb1iHxEvXJ98/MPlUxy/Y4lsG35tBtj49G
	Japlxkqb8VUib0T/iGXbwsy/ibTA5g71CZ0OlxZjnPFc=
X-Google-Smtp-Source: AGHT+IHTU4elXrcJiKN3xNjpaTdbAvznXETnWPAb0sKX/d/YhvKdT1EkMMK213gdyMiX2D2K0ia6rA==
X-Received: by 2002:a05:6000:4284:b0:3a3:71fb:7903 with SMTP id ffacd0b85a97d-3a55880794emr173135f8f.10.1749592787289;
        Tue, 10 Jun 2025 14:59:47 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 04/11] iio: accel: adxl345: simplify interrupt mapping
Date: Tue, 10 Jun 2025 21:59:26 +0000
Message-Id: <20250610215933.84795-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mapping all sensor interrupts to the corresponding interrupt
line using regmap_assign_bits() since it takes a boolean directly.
Further prefer the units.h identifier to cover the full register when bits
are set.

This is a refactoring change and should not impact functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index cae9e37e216f..18c625d323ba 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -1216,9 +1216,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
 		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
 		 */
-		regval = intio ? 0xff : 0;
-
-		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
+		ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_MAP,
+					 U8_MAX, intio);
 		if (ret)
 			return ret;
 
-- 
2.39.5


