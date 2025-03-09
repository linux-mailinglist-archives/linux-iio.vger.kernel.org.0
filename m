Return-Path: <linux-iio+bounces-16643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00782A5878B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6076B188C506
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977F1EB5DE;
	Sun,  9 Mar 2025 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0JXbanM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71216ABC6;
	Sun,  9 Mar 2025 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741548927; cv=none; b=q5X00xK7XaxhkfBJVxBWdTLfFnjxUjegKqR4iPHh1+aCPPIQIHsCi3tgL/3hcDzkyTqK9C/WX91UgWWUpVZ9txLYeahgHmFcPqntYzdm6wSSI5Q2a6Avb6fJT2uOf4u1qmooIQfu2ayekGUENviTZGFaYQ1TFCbHeAw+gl2PG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741548927; c=relaxed/simple;
	bh=ZjHBkqFvk0zbDOru5sf8uasFrgssx3C0djXgwuAhSdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6X7ITBNZCz0H4esBfBv0TGAjBvyDfFyXtVSsz5ljmp8UnV/mOycvGy7TDc/89Z0jHFjgGiGVnGJQ8PfiCuONnRsQVzIxJM5amo/WO0bLRdbRb9C6vcl3qBydyAI4ItLXxzgonib2sMdxVKJn3jT9t1erISaQwNeRLP+mmyi0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0JXbanM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394944f161so3743395e9.3;
        Sun, 09 Mar 2025 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741548924; x=1742153724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbUzJmxapgzgWw09oZPaDxkV8e4tUfTsDNLWys7VZTM=;
        b=g0JXbanMZd0/KW8MROuT/svKRnD6qX/psdvH0dG8e5VwxQ+uwRbg5yAE8EXAdJiwet
         +SMKoDrOJPEWZFnuV+Oz5w+XjNPFc7qifdzotbFjEd/+hSKFmbvpmFTKhjbWkqTvZb6O
         IpmD670RTpO8sGXMxfRGyOE13c5bIZ0uODT6+rMgANiPB8aAQ+AME1Y0I5nnl9lc0OAF
         SzKL5HbqQ4F1OsYzKcPT3S4+m5IEnJlmbsS6MXSxc8kUG3wvD80qGh9PBOw9KVdK2Ntx
         oA5JkmeEj5NlD+KOL9s+4Jqc8hX51d10VAzs2w8RTbX+kyupTUBjTL6aaum5dfc6XnLM
         jdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741548924; x=1742153724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbUzJmxapgzgWw09oZPaDxkV8e4tUfTsDNLWys7VZTM=;
        b=wOzE2lD4cL1UOzTcDJVEbpB++QGzadelBdNWruL8jccv0MVHj2Ks3iUouB/lVfEyb/
         2PRki1aZhDQENIAaMHLOhi9kSWJe59kF/XJXr6WnX2RQk7jrLRmcNa4qwsKZEBHt7cyF
         iyhHX10kBIGXVDjKxXeP/IjavPIcjljppG3e7O5tYW1Nr7Z70bsNjR+ds7/bRKTIpQG8
         BlPrpxGpsOaFJvNSbvLOmU14FSu6B5H+UpewiMyykxqC+C0cZL7jVL4832Gw0Psn3RyB
         AAKOphSbK+aA5kX0CmSWysZpGRjZThGx0oTROhfBy9l7CrSgsghUvKlfH2YsGzkxwcT3
         U1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWHJJlzqJXdayii79bRNV/5Vq0SHjWV5fAKKgYCeOjmzWqCXsHkQbIMwxyYcOrcEa70Le32s1GZrqyy0K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73PvXJ41VmrYEKYmeODBKNvlgSj0GE63czFZ/ZkAxxovR8P24
	TNkn2F6hsjOgaTthuk9pdWhNaM3Vm/9mRDYZvuKuhlwmvAh+K8sl
X-Gm-Gg: ASbGncsq0skJ/uvlqfK4c8gpWqXtvn5bfcHoui+AGJzh4qTBglsRBo3XHTKbz4DkVIA
	9pNIfMq6vbhLjJM51Qyaw0OKSGqs/qelcAUJs4GyfWxZRT75cR+7esdNZ7TU4aE0H71gakUcnRE
	/007ub0CRPXF8AFerSR1TtKHjyxv5cNKiA1s2EB3sqEbwODN4ApXAiB80YbwSM9bmSVGpgIGZRg
	DheeEyjDiWOjAT46cfxGgVR/6kVHm4mLil0oQ68RkG6YO+lfNvFw0COIn8nwXTcHSx/zI306YiC
	CmAkQU3lwAy94A8+bmQ0V1wmU+voZpxknyJqL+dp+et1kionVCSMF59WErBRTS0czsZekzq5Ugj
	e9Lp7/D/ljtTdJ3Ovp9tyFIw=
X-Google-Smtp-Source: AGHT+IEpKB4oca4daPbfMLgWEgJ3n/URe5b+sZ7k3jNAaJICC0lsGFxV8py0RS119iFPUhsnZ/Kkkg==
X-Received: by 2002:a05:600c:5122:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-43ce6ed2670mr14984185e9.3.1741548923472;
        Sun, 09 Mar 2025 12:35:23 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm151089595e9.32.2025.03.09.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 12:35:23 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	cosmin.tanislav@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/1] iio: accel: adxl367: fix setting odr for activity time update
Date: Sun,  9 Mar 2025 19:35:15 +0000
Message-Id: <20250309193515.2974-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix setting the odr value to update activity time based on frequency
derrived by recent odr, and not by obsolete odr value.

The [small] bug: When _adxl367_set_odr() is called with a new odr value,
it first writes the new odr value to the hardware register
ADXL367_REG_FILTER_CTL.
Second, it calls _adxl367_set_act_time_ms(), which calls
adxl367_time_ms_to_samples(). Here st->odr still holds the old odr value.
This st->odr member is used to derrive a frequency value, which is
applied to update ADXL367_REG_TIME_ACT. Hence, the idea is to update
activity time, based on possibilities and power consumption by the
current ODR rate.
Finally, when the function calls return, again in _adxl367_set_odr() the
new ODR is assigned to st->odr.

The fix: When setting a new ODR value is set to ADXL367_REG_FILTER_CTL,
also ADXL367_REG_TIME_ACT should probably be updated with a frequency
based on the recent ODR value and not the old one. Changing the location
of the assignment to st->odr fixes this.

Fixes: cbab791c5e2a5 ("iio: accel: add ADXL367 driver")
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/accel/adxl367.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index add4053e7a02..0c04b2bb7efb 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -601,18 +601,14 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 	if (ret)
 		return ret;
 
+	st->odr = odr;
+
 	/* Activity timers depend on ODR */
 	ret = _adxl367_set_act_time_ms(st, st->act_time_ms);
 	if (ret)
 		return ret;
 
-	ret = _adxl367_set_inact_time_ms(st, st->inact_time_ms);
-	if (ret)
-		return ret;
-
-	st->odr = odr;
-
-	return 0;
+	return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
 }
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
-- 
2.39.5


