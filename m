Return-Path: <linux-iio+bounces-7902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244BE93CB25
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5352828D4
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F3143C7B;
	Thu, 25 Jul 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN3fePdw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6EDF6C;
	Thu, 25 Jul 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949509; cv=none; b=sxY4/z/kie7TOrNSSQlCS6SuWAscIqpAzIbbBuukbxNfQIa/3Z5x0neopKMwvZWGx2nIoceoGg7uuZKn9k8dZli6oW2WsdJ+jSjIu2kUxf1wTRTXa7Wv+AVKFpACCI7fGkWvQisGb/+Nv5r/T27R54NAsI4uyd7phTXtXNxf+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949509; c=relaxed/simple;
	bh=qTguyKQ7f6AzBwJUv00P+vfNkDjNLY7d8gYXe3e3xfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1X2WWOFsjg/0ndVU1HM5R/qHDTClQekvsDq3c0QplsjJhGLzAy/ROikeRjY4nx6qfcmSGcJAAmn4hdKbT/fClPSRC7wAtAaR1Dq/8kT5sRVxySI6sz8ULEux0Q6T/PdjHFdYjvZ0ClHj2jlIIlc8o5WkeA5TMzD8GmbnFUK13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN3fePdw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso141308166b.2;
        Thu, 25 Jul 2024 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949506; x=1722554306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWLnOh5ytsf26SCztBMinzCuGggaU98ctSJzSIv1s94=;
        b=KN3fePdwVSjlIePl/R6h6+O2eIQpjSjasDzuK0pN6XFN1MB3hH4F/2mPPcvVZCvyV1
         EiiVZTFyD203Jd1yoJDpcjcs/N4OdEF/4gJ30vyRbnKjBMZnfTdYXzPUcLVvC7c0ayhh
         dhplU8nsa/BJFh/0sY/XS1Rfm7cDh1Uww9We12vaDMpB0iWPhVEJ4MbBEKjTU5iN9zkt
         m/aPX9niCR5jXfjtsO/umkaV0SM3jrcuiTD1QltNMvdb2U2tDVWGreE+yIMibkDxywII
         SIxJMZSDwc16pBW+R6L+PDJ9VcNK7C6noQZfHkci1GQUHgO7XNcpmIpXmSI3bb/DYQ3n
         V4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949506; x=1722554306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWLnOh5ytsf26SCztBMinzCuGggaU98ctSJzSIv1s94=;
        b=W6WBbuzkffyn9Zoh4DLJOPq6Lc7W2p+6zXc5lnv1t476IfIovbfcSs1yyJXUhV9WZ+
         HVpKv5iHa9mB20ZCb/MQUji5/HA2ObmJErGzGPoPrgWwaZCWyzRi59R2zRmuOlIyIAk2
         6rU5VM5M9Tdc3jZ3KnfoRdzg1U5dRiwdqOD14lq6gV6tvOJuLznODxqAQm7MLAso2b75
         qLKqpUPpSgAkUBwg4S43ZFRyQ01kAIwSKN3lRB2m9K6Ury4ddV3Je9F4DbkCXxeuN9q3
         bTpyF/erxfv6biWzaWAiri0YrvpFgqlqzdKzeFGEz4FJGRx/DQ6UnJYZiBbYoHwKNIaq
         kVww==
X-Forwarded-Encrypted: i=1; AJvYcCUFNGVCl/2BxQYXtQnqqIMwadG0JmAOTZUOKHytVh8amaAfXLYsYJTKsH8BvOBEfBd0yBPMGMpPXVF9Nm9PwXmPKlHL6wm7HZB5LYXIrdVjYaXn0ujj77ZLOv5o2NhCw1vsMjFwz19H
X-Gm-Message-State: AOJu0YyewgjAjFCVEh+P8ZP/Th3Qrkj7m9LRqKc89hcTsHUSNwNJgQCL
	k/m+YZGJ+brevX7SaAiZWkI4t9vgvCSsgQXW54iSMKcT6bJH0wPO
X-Google-Smtp-Source: AGHT+IEdW5yrxCYUUf6/iWY6GpgcOqj5BZxN7p8BUBgiBsQlxJaTwZGi46iBJJR2SzQVOPk2WcycsA==
X-Received: by 2002:a17:907:7e85:b0:a7a:ce2b:d7c7 with SMTP id a640c23a62f3a-a7ace2bdcb3mr234139266b.53.1721949505674;
        Thu, 25 Jul 2024 16:18:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac61218sm115725466b.94.2024.07.25.16.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:18:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH] chemical: bme680: Convert to static the const lookup table
Date: Fri, 26 Jul 2024 01:18:18 +0200
Message-Id: <20240725231818.615530-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By converting it to static, we ensure that this will be placed by the
compiler in the read-only area.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 74ac887d8d8e..5d2e750ca2b9 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -438,7 +438,7 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
 	u32 calc_gas_res;
 
 	/* Look up table for the possible gas range values */
-	const u32 lookupTable[16] = {2147483647u, 2147483647u,
+	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
 				2147483647u, 2147483647u, 2147483647u,
 				2126008810u, 2147483647u, 2130303777u,
 				2147483647u, 2147483647u, 2143188679u,
-- 
2.25.1


