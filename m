Return-Path: <linux-iio+bounces-5953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1198FF6BB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7584F1C25C52
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F019B3D2;
	Thu,  6 Jun 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un3sXB7l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAA19AD8E;
	Thu,  6 Jun 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709046; cv=none; b=UBzGbd0czd1LkOwj9UckqcHgztr/1LJ0WBJqCalta7CwoBiU9qGNsCsFZWCJwMHGaZETTZr246o2rW5l77HmTde80aHprlHTAavWFzLf1i01zBIcHeunTzcFlLE6JBmRFQU0ojX0v2lqosBj+grcXszJR+Hp0QtTTlrXyI4KqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709046; c=relaxed/simple;
	bh=S+y06tbyb7l3dmgkW15C3vV7SWVp7fWDI/UrIz94VYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1wvwQuy/4/K+ObVQb8vnR1k7m5bJWd3dDpw2NSzb1HBzza45OrM5/GUsIIPiNN/rdl1G/0cMxNGY/KF95j7HqtojpUssMcMF1bBm+GbxYjiTe0s271UCsTL9MJj+RQ80X/IF1cbRNJPgGM50bKbNRXkGdxkFAr/hHPGyt68yLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un3sXB7l; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso1688530f8f.1;
        Thu, 06 Jun 2024 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709043; x=1718313843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nTflblya1f+VabXtxA0V93oe5w2CEdoB3bLkUiVHVo=;
        b=Un3sXB7l+0yhDt8vb3N/eFrfWM2WTKnSLWmYNQxS/+9X0xNzIduSQkpbEKaGTVgH1B
         rJ5Hc/FmVWqPgHPYxbHQ4thl8HIFtilkB5TEP+Q8HUJ5j+pQLCEcigIqoNGNcuNHy+Pb
         toxKt0jr7JLIIdqZuNGhf8IUu7YhnkTyCKwTgD15etQWqLVFxoZzYNEepjt8Uls36BFC
         A2rU+g+DyEmfuDRtPQSOZBYo1KxFUk0b/V9Qffx1bWnPv90I2pEgworZI2jVgeNuHe/Q
         SeLINYHut2Ej8/nPzReAuO25kixTuvMzhWY1QaXiWANSRgC/QVjr3TvBWcmRbkikxkpq
         l2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709043; x=1718313843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nTflblya1f+VabXtxA0V93oe5w2CEdoB3bLkUiVHVo=;
        b=a1H3tM3B/8HTQalKlcrtcs7/3D0sjYoexVW4oAmOXwYHcs/KJ1tFBdohwOabmbgOJ9
         obmSi1moDBxXLjKRZPAxOuLOIS1JCA8oioWRkMkMtPbflh3z3Cp29gtKvENBW0n9UiaJ
         AykDMOCXgtNkLui0C4X07ki74+wBq4Iu1qRUk4HSVXsStwzKA7m5onXrYpfu+g/JdNzN
         EXa5cSfad+LIEkVQAWWT+VHZJnO/xed1G5HTvB+odx2t6JyfhyVZdmr4HxA1h1Lq93mM
         6bF+XsR2VHg+c31zMR3UBzsWgY080Py01xTdtk+QJmXRuENNSXozStdPmjMx+tYkr966
         rLTw==
X-Forwarded-Encrypted: i=1; AJvYcCUN8wat4c9aiHPUX8IOPPRVXXjzofdH29Yb+oA3WEvrqgG0W76jnpU7uEWvmZs4Cx3EEm6ZhqE/WaQzmCNlyS6G0zDdSUKNOmJq/AU/gK15T1fcIf+hZMEUWDDwt9vrYtWwlZ7T79tP
X-Gm-Message-State: AOJu0YwcmkH7w+qYycnqNiQUPThbw4xkSdcvuA5OuA79sqfyi32JE9bo
	N2s+V4IApjOOKZC6+HPdRowdq6Y4WSxA57zkwEcl/I6qOETWCEnda4fFV2QIf5E=
X-Google-Smtp-Source: AGHT+IEhei8E3j3fhgmh1LA9eZSVtqHZRMkkpskKPk6xmds0uJgcd5ZdN3j4g43CYBu/wt8w8PbQBA==
X-Received: by 2002:a05:600c:1383:b0:420:182e:eb46 with SMTP id 5b1f17b1804b1-42164a44859mr10364955e9.38.1717709042735;
        Thu, 06 Jun 2024 14:24:02 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:02 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 09/19] iio: chemical: bme680: Sort headers alphabetically
Date: Thu,  6 Jun 2024 23:23:01 +0200
Message-Id: <20240606212313.207550-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order and split the iio specific
functions with a blank line

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 1956b456141d..2466398aad05 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -12,9 +12,10 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-- 
2.25.1


