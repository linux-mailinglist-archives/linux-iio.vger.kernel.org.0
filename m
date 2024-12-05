Return-Path: <linux-iio+bounces-13119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA219E5CAB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0847B1882A81
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FA227B94;
	Thu,  5 Dec 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daZ1ttaI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED673226EE1;
	Thu,  5 Dec 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418838; cv=none; b=Bsa62vVWo1c9RkDCU0jD7IwJfF5cSkYkZr2NOgLq156dwW5ncI3pIHVagxxmpop4nE7uJ49VB9i1qJ2VYWLMEeWUIwd7EDa6eMheDfwZ8LhefFch05QB4SPprbzigbpZ2TftQGs/CVf+sYaj63R58ROb8pZ+gMNyRAHLfCromqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418838; c=relaxed/simple;
	bh=tvlpR3ACIZjZ26sU6DfiM9q4+OrGk/guXwAtGKWdyjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf9SwPn+tJUQVYRX4vo1xZD15YPPNv9OJzZsJ4jhWPic3Z3G1vFYmYLUtvC2sn+ZOeMayGexg4HwMrgEBT/025JyKurlUoNmwckQ+TEFkbxRpRynkhC8KodhDjEuTyBf/TruCSyxcptK2UT5Nqv64t7QHF9//Wh2o5FG8XnbrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daZ1ttaI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d071ac3f35so199770a12.3;
        Thu, 05 Dec 2024 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418835; x=1734023635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/9VPQ+Uf/rRtf7/eLBAF/0nGYfYrUrX91JqSy1ZhlA=;
        b=daZ1ttaInfSQrLywFWmmSIws9Yj+rsOsGj9R+/3xtkYTDy6T+TAYYBATALi2KM71dG
         vvVKcy66fCcq79ULpw2lPRi+0F8w7sGbUZeORpmTuJBzISCN0TbOn4ggcfFJcdcICtxd
         TtQ3YgIno5lMuvQbUbPtDPiPQAZSUgOByuDWGGXVSPPr06dhkf3gPAk/DIEJ82CsoBSA
         Inl3wvSyjpyEoAb8VPXoiLO0MLF03Ekk4LNx+ZH5G9VfqxB9cfL4Z4O/txkfhHLxUAEe
         KMpBf4TrJXF7QHUmUFYY/ZIqa09vi/V0WQ+jPqwoyKGS6S2TUxk9FngTPRvELnLAGQEu
         4krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418835; x=1734023635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/9VPQ+Uf/rRtf7/eLBAF/0nGYfYrUrX91JqSy1ZhlA=;
        b=uVxDebyZdywcPwQ4p1iGDO2HU6SNoOU8Axg+l4RY1QbcPQll5oxz7u0bexIhy+E1iR
         daNg7gX++sfe2sZ0pF76GM+Rmm5O+x3hkGMb2Ah8XF0j409RKjz10zJHCTznhEWU5rmI
         mwmGcgBVHY8v8EUvhZCmCOVJVhqzae+bG/yqWD8rA5FaJZgyAMbmu2u5lLlH/P4KHbMU
         1s6n40M1xv0wPwL/G7ysdhDh0p0/uGsJC2I7kYVuTfdjWbg0EO9/zbgW9xP0GNVzj4zg
         eecdYgJWYNXmUgrZejDg8dp0z9rVRusPstapfvlSgU5uPsYa29hvaizxJ935NIvGEMCr
         lgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnv/dP3kleP11T+gV2BkKzlsSg+VsQ0+h8PUsY2pb2NtsM4kju6Dyv2efKTR6Fp2d+kpreoTndO58A9nyP@vger.kernel.org, AJvYcCV+lswd1cZ8yl5mYfA6c3e8i8RqFqtBMzlTyu4xsxiZgo4Yr16TyVycjpvLElFyrL3Wc6n+ET9coZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG52nuktf8b0rWda3YcA6fryGX8Rtm/m+YMMLfeS+qdrt0TMK3
	wbTYsG931k2bqR9CdVg/4pw4+Q0L6WI6nhm+F1bjhiei2iju4cHN
X-Gm-Gg: ASbGncv/dhU04ZmQgZYkOdJ9QlQTkivWvg3pRfIusAy6Buuo9TS+MrS6Ri3t2HVr/8i
	doPkHvoaWsW2xA6eXsh2wamFEKpSlX+bVrir9PjUTS+8+2Tkh6rNt5F5ugCD+5eALNG6KSI/ETg
	/LD7MpwAhsCk8BUb/Jpruj4iNLQTvaOJyRXsNpubsqAspmX72Tt1S68EANm0eZ7d+0Pyegqalcf
	Wxg887nRrqCeePrlGNkqdGzDBvwfmj63n+W+8vjfuM4pkfcfMWFlkbkjOSYnt6loz4M7Dt01Tsr
	ddCnxr59XPijjH/4o7fAlHL9mYLQ
X-Google-Smtp-Source: AGHT+IHxniLzjtZZeihCKuYCDWQbeQp69Zkp3YB2hcdmv9Z/VAazVP8MlMX8EXaUqEsfEQlcf208GA==
X-Received: by 2002:a17:907:868f:b0:a9a:2523:b4fa with SMTP id a640c23a62f3a-aa5f7d1cecemr489437866b.4.1733418835073;
        Thu, 05 Dec 2024 09:13:55 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:54 -0800 (PST)
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
Subject: [PATCH v5 03/10] iio: accel: adxl345: measure right-justified
Date: Thu,  5 Dec 2024 17:13:36 +0000
Message-Id: <20241205171343.308963-4-l.rubusch@gmail.com>
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

Make measurements right-justified, since it is the default for the
driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
the data becomes right-judstified. This was the original setting, there
is no reason to change it to left-justified, where right-justified
simplifies working on the registers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 88df9547bd6..98ff37271f1 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -184,7 +184,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct iio_dev *indio_dev;
 	u32 regval;
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
-- 
2.39.2


