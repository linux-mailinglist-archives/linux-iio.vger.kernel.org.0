Return-Path: <linux-iio+bounces-8975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E59684EC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBFE1F20F67
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790617DFE7;
	Mon,  2 Sep 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/5MR4i1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C7140E34;
	Mon,  2 Sep 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273468; cv=none; b=G+JhoJDKngnT4Va9WB7C1FgvU25VcivXUPRfmkXbobPTjW7N5x8tztgBRgG5XJtB2W42GfwgAWzC1rm/q9HOU986QJv7CXrILjyGjMBHyVwwm25a49RG3YpL2EdeaN1BXCJT9tzwAfU9yLwDPmwJvbybkB2kptkvWH4ZXk5yGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273468; c=relaxed/simple;
	bh=jdSFR5dflXd8fpMvTatzxbqGeUD6Yxz2PW0iNP7uLJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raBx4/CMuHvINLyUvltWYSHfcSfr8GjE96JzdmGF9F/a1DZdZmF7eoNCyezBlHMdMpeyvSOcgynef2UrhvDFv8N90QeiEVxNgf+NbUf3/Io9nNlUCCIA5S662gnRbTYar4/LThsjeWypRNuRvbPVxBlkTiS0uE8LUSiBK1pmMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/5MR4i1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2022fea51fdso5726015ad.0;
        Mon, 02 Sep 2024 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725273466; x=1725878266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7oJJiFlPi+ClYfQCyULP5hYtvTzBStroZU4MDfmcAg=;
        b=J/5MR4i19BQ/QEQO7CAPeWKG4bfsuoCW98J9Hu8S7b9nulG64gLAsvyP4LB8Lm4iJP
         SpV7XU7a23eA5OuvZUAAtMTvSm3+4/EvCB1McbVEWys77boxChOciVt+nyMr9wrgD4us
         wqqYGnecrce5oznlFn2h9QQ6aEnXlmkP1tWRkiHyb8wp3pDYy6diQU3prIHrO2ahAlGm
         bvlBq7ycnTGchFZ+q3m3KJua4udf3gtBEjfflUf8QncHzZq+2AJ+lWChzXp8dEUpKNY3
         PQrEe0AijRmInC1F/Cs7+4Dbg4uVQZ7nnH6SHcbX/Xj8F/qUEB2S1H+ZiBXjsF03MU1x
         /qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273466; x=1725878266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7oJJiFlPi+ClYfQCyULP5hYtvTzBStroZU4MDfmcAg=;
        b=KA0KyZPR+EymErzHOOgteLs4rl6kGCEuUFcqmhPFhVH27iyLley88qtQIF3s1SkqaA
         uBPXin5z50sZci5UYYerPPEdUfvtKITyffZD1t7+RaIf9DnMYwHoR4vGzD6152dDy92D
         JpA48NYp5Xqp2fDbMw4lSNyajiQkHohei0WlrcSKwSkHs9xmA5MSwtN6cbSqqpqp4rCt
         Z+Cy1TBHOIuemmWoosZPhw9Tevoz0jAsmB6c4406Zn/b294ZViJRomWaXfSlZOm6s4cM
         4BTr+cRGuyrIDsYZKg6wJWKptuPrntrxQkM6d3epL3xer7icvilP3KsSf4+GNZ1Vm1AR
         Y/kw==
X-Forwarded-Encrypted: i=1; AJvYcCW9+1FMHwvtBbzvWAEDeB8ouNTvFt4UR7lMKFyqVkCD46l1Y3mKpSZzKmNe/05/NXMHNetSBnAm0vg=@vger.kernel.org, AJvYcCWFYk/xdiqoTmV2DffoydDEe0k3Rnb0lQvglSmZY4uElb2gdWW21TLmcqEUDubNpXGlzJj4RbBY9OH+025u@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUn/0ZEiGL0qA6lb4ap8H9Xq6+0SxoFGstF8DYipPZTdA27iQ
	xtIxsg+63R7jcjeTW+i1Hy2fcrHp60cHOEAHNkJBY1dBbwYN6KWL
X-Google-Smtp-Source: AGHT+IGYG/z8TxdFhaZvJxTHdQsZnxZiJONpi6LBj0BZWqrUMIhXRqUmJJOXUO7hM7cTZNeblLqMkg==
X-Received: by 2002:a17:903:228b:b0:201:e4c9:5e95 with SMTP id d9443c01a7336-20527683fabmr58460505ad.5.1725273465627;
        Mon, 02 Sep 2024 03:37:45 -0700 (PDT)
Received: from TKPD.tail60dea.ts.net ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd653sm63707545ad.74.2024.09.02.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:37:45 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
To: yasin.lee.x@gmail.com
Cc: jic23@kernel.org,
	lars@metafoo.de,
	dan.carpenter@linaro.org,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: proximity: hx9023s: Use 'CLOCK_BOOTTIME' as the default clock source
Date: Mon,  2 Sep 2024 18:32:10 +0800
Message-ID: <20240902103210.31369-1-yasin.lee.x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Override the default (CLOCK_REALTIME) clock source to 'CLOCK_BOOTTIME'.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8b9f84400e00..5363357a9a46 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1074,6 +1074,10 @@ static int hx9023s_probe(struct i2c_client *client)
 					     "iio trigger register failed\n");
 	}
 
+	ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
+	if (ret)
+		return dev_err_probe(dev, ret, "clock boottime set failed\n");
+
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      hx9023s_trigger_handler,
-- 
2.43.0


