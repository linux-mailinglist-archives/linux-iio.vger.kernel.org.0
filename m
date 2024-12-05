Return-Path: <linux-iio+bounces-13123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FE9E5CB8
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4301883A04
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49122B8D3;
	Thu,  5 Dec 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W93ZXfi6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B522B8B0;
	Thu,  5 Dec 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418845; cv=none; b=acCfiHRZdNlCtXxGnNKR3C7vSLnEiVG5TNm4vIXOwtn4M242hgm1egEYM8WGiX78EoaG9xmMsW6UTzmNxgJ69SsG/C4Cul3via4au2tBMhTEadcyrKIr/6RCFhdDwCtZ3kHyDFcwzIGuI4tixB1fZJrPdOuqehkM01GPDbjGhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418845; c=relaxed/simple;
	bh=DNVEhDMJmPlkCOLPbA9YCV7kbaVuS7EEz+47Is7CTEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iz4vHmWx9jYglkuXr6wn1TYK09wGzUrP8uzun+bffgLvkNF5hmqquPSD+7mjGuFhyYstCGp0wHt0+mdmKVYkABI+ZsCVXsSXLbkZP7KanDcxULENUC/1Ve8KvMvxQ9RqZz2z4njJqN02XqhWwggpdF9AIvIqKo+cgZ6x2XHAcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W93ZXfi6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d071ac3f35so199800a12.3;
        Thu, 05 Dec 2024 09:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418842; x=1734023642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooJ274uvhKmoCEz5rGR7u9j6kRhYQqTeS8QB6cKiNxw=;
        b=W93ZXfi6+48RUidBRKXTiN7yk2GyJ9497YZ2e1deUcL5Tikv1UMjLfASCmg3YbyR1e
         0pBWdvSotCxMKSLjjFapm2a6kn1EyYr9XjlHFe3Xx8RWnSSDPNMqMZbgVme1yKIUO8Ki
         JUd8LReuA6iZKZITz7SocU/sVp8qIL9smNoE7XD8W1eUAMZ/XwCuFoLP07FvF8XeCOfm
         2pZvpNtOaGkDmuiUOKiXJUF7GJlBBvYiZRVLS4C/0uFQWo4CjiMV4YD2sXXxpuNchNLf
         GwyHBzCrO4p+Dc1jrVZtLoLPrnvmN3QwF9IS5nZSQYeyr1la+QPQM0oyPHuOSnUeJtw0
         wvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418842; x=1734023642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooJ274uvhKmoCEz5rGR7u9j6kRhYQqTeS8QB6cKiNxw=;
        b=oFQGdOfz3U65Zvq6PmVgZFVUSBvpKXFsFEc+bCMdxh0CrqdNnCdX64Rm59GZ9Adr4u
         aUrgAIuW76jEYE/mmtqdLAP7BiXefd+eW2jG65pi9F27ZyVS0HKg23gNImidouP0Q/Nb
         oOS3VK9R0ZB7/rxjZK/vzv/4jsSI/rEeIkmHsT9MYGkloCeBdteLqx3R1qwqIpVzR1bT
         19AOu/j2W5LBkYvm1odXZ7zkMNTBphBePlbj/AP3YtE1nz3ueiAZ0hUtKEq3LQoExnLn
         uZpWU5IQV0B0DCKM+QOw4ayomh2UOWg0IxwlSSOOhuNxLN+lbGXawZuC3f9PBZZU2AGH
         BayA==
X-Forwarded-Encrypted: i=1; AJvYcCUwbQ8JHih3oxULspsZAOyuVVfFY1HcnyYNrab55iQ9yckMOoKw/PtRNkEKKMxlA44BHY/KJzXPWZc=@vger.kernel.org, AJvYcCXXj6+JmUNNC0HVB4a8o4KN32+wKURjffXM9PR6EfzJ+mHvWMpJekXMRm5aG0TDvp+oFDQyWQMHXe+m01ap@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/agioqe/2qMglNT5QY/85r5RHUXL9XKIy1Vn8Cu74PiYBuG4
	CSdfvDFUHQ97dP2VkLSO4UjBMurqHZ8IsFsRsrE/2YhX8/0+bEw2
X-Gm-Gg: ASbGncsVJKS+4ZjFtLoDcq7/uEpJ+oHEVlFIpieB4t8WC847zpMW3Skd+BiSfcCHzWN
	pgdCgeyuOAYX8DEcoZ5EBBWQ392WZxNTin2E3czoAwUVWJVw4ivCwKCimo4Uway0lALS8WrpGFX
	FQ4BUNB4iZC2nzD1kjiQYY+lq+nTT1fK1uzARNorzKt9gV+wKDjBm/LFT+Cpcv2xWuj+jVfFCMV
	04Odkxrhy8js5892oJtNnK1MIa3VhSIVUyuR8bhoc+rlYH7i8dovlApe2hk9G4y0XmgpNGVnzJh
	qBGHYfet2LaIxm++hC9YIw4TN17L
X-Google-Smtp-Source: AGHT+IFe38z1xRo3uqmxUHzVoerDbRxkJ8LFyH5rUiT/0wpMEEspjDL0imPwxHkekg9FrRKZVMSZsA==
X-Received: by 2002:a05:6402:520c:b0:5d0:bf79:e92e with SMTP id 4fb4d7f45d1cf-5d10cb7f978mr3994076a12.6.1733418841700;
        Thu, 05 Dec 2024 09:14:01 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:14:00 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 07/10] iio: accel: adxl345: introduce interrupt handling
Date: Thu,  5 Dec 2024 17:13:40 +0000
Message-Id: <20241205171343.308963-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241205171343.308963-1-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to claim an interrupt. Init the state structure
with an interrupt line obtained from the DT. The adxl345 can use
two different interrupt lines for event handling. Only one is used.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1d020b0d79c..e0a8b32239f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -11,6 +11,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -18,8 +19,10 @@
 #include "adxl345.h"
 
 struct adxl345_state {
+	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	u8 intio;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -212,6 +215,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
+
+	st->intio = -1;
+	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (st->irq > 0)
+		st->intio = ADXL345_INT1;
+	else {
+		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (st->irq > 0)
+			st->intio = ADXL345_INT2;
+	}
+
 	st->info = device_get_match_data(dev);
 	if (!st->info)
 		return -ENODEV;
-- 
2.39.2


