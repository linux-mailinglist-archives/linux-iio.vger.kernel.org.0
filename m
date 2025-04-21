Return-Path: <linux-iio+bounces-18463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5324A95321
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF8F1884176
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DE1A08A3;
	Mon, 21 Apr 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqk+1ETf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E213AD1C
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247380; cv=none; b=aau/wyHrccaBWdOC5Zc7ov5P8Dp7NFfAGEhwo0u3NtRd1zDbE1zT7SVK2cxB5AtpmWxqcIdQYnxrZ/r4Thna/uvgMsQ9g8O6GPOmdtuPZQmy9qlhNKsi5n3PRo9Ph+p+AN9qxIdFDqaKk7zmqoi0oV50XER0wszCdhGHXKUhVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247380; c=relaxed/simple;
	bh=+DKimb+Q/nMlZa0SCZKPm+OwEKZgqX+32muQBm7FvPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBZCNIyWCYQWUhtOQZqi6DvWzhLdAfnBBHkMKgfeWj8GyoWTXgKUNVhXXyvUGBsDalu/4BhZCxi+nOKIOdCkB1JOsDpxnbNmCfHFMnEAMdg1AOTxQzhEjqKF1tn/tCfC6o3qUOyL1wmZ9uww3SzUxxB+BwyQO/8gZc1QNQBpB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqk+1ETf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7376e311086so5587595b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745247377; x=1745852177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikronXgEbY2VKrrWLO+4kL67ca9yalw5pS90fyz0WCg=;
        b=Tqk+1ETfVwlNDr2/l6+DBK0yFOmwCFkRsy+EJv4XqHUBsOBWW8mbIjVb+3CwR70V+X
         17HAFyeiMf6Wf2WosZxB7LpRshxZ7H41jYkJfeRigRuXsa9NYexMhJLsT4g1E0KlYTRF
         dQdZx826gd++/9LuG1oxQ4X8QyTDApKp/yQcfN6uwU7sHHUOi2hngPyzV12YM6QB+d+u
         wffC/lOf3uHva6fXvTQT3Y/lX5jhe4ExMM4dGYc03y4AEZqDtFORjko21qC8m82Wq8Cl
         k3aF54PzYsoZA+vimbIRWuxMgl+zdTlbuFZLBT58mnWjHguHP2tvZJqCH5A3L11NN7MP
         VgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745247377; x=1745852177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikronXgEbY2VKrrWLO+4kL67ca9yalw5pS90fyz0WCg=;
        b=ZIjCvMZCyma0apAwcBgTwxe4wEbbO9eCfYdBcrPwyU4CAZzoWumgHqa0iytnyAjf0/
         O3VIFERFi0XzrXOxzcdA1iz1BsuCHW8ne/22W+kUPClZV4T6yfAZMqJX7tX0g+5qAmfJ
         wwH8myWp1ZR7JDkqwus6+SoiSo+1Nn/pV0ZmDqfOFLYR9spZKUd+3+YYTNFLIaaRwRSr
         dxNZAYm8OKTHKzyfETBqvtSAi9jTR4GlWnOHpG1EOVSnSgCaui6RNmG2gZ0y+J0iy+11
         XxLJfIfwXue5gYL9EVWzAe+GFXFCxLHsCqhUUle+zLt5CcC6GIjrJdaANhUknc24kGND
         pejw==
X-Forwarded-Encrypted: i=1; AJvYcCVdjVmsbMOiu8G6TNEt6H74R94XE9NtIs8u2fx9bBGIOKNKD/nVtpjY4OhqApsJo177F6N8Nzz/ozk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz92LvTdHM8Ymie6YfRrNE6HX+KiWbc0MWkniiRS3LD0P6snndA
	QIRnI/yVMO+XjN9JSsCzT83bONJAAzLRFhZcHsyLPlAsuGciIMOd
X-Gm-Gg: ASbGncv5utkfqTYT/k3w/0dsl4mSgfwM2T1V8eKxzJI65+rQzeVEe0ohm5qQFwMwnBc
	6pM+yVyJ8JE7bAPtrEoIb+rfkoQW13lACuFRLCyBv0w2tL47/xK4Bus3qcCpBezYlxujIafWxp8
	ktL/E7NjbgzepBYkrPLNCwwQgB+exzqEjF4Ga5JguuthqY6xSNsTEOnQvFgAKtV0XQmdllzsIlP
	XRrhFuB0q4Qx9XrrvbmVw7RCdWTB8Vdgw+PbrY6auPXofBnJ+cqs8lVjo5G7FvghIbqvR0D/f0b
	85/OUD7bUGXyKTI33W2KOqF5XF8dQFjLf5nnV2ntblkTFiGSvkRCPh6v
X-Google-Smtp-Source: AGHT+IG+zpo/GWs01c+dd4XgWcdl4TI325k+lPLYvQwfzKeI6Mke+h/Y1CjoOXGl2zM0bj+Bgv2IGg==
X-Received: by 2002:a05:6a00:2e84:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73dc15c4883mr16038249b3a.20.1745247376728;
        Mon, 21 Apr 2025 07:56:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:7840:8465:92a2:c15f:daf7:f67f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58333sm6685504b3a.118.2025.04.21.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:56:16 -0700 (PDT)
From: Arthur Pilone <art.pilone@gmail.com>
X-Google-Original-From: Arthur Pilone <arthurpilone@usp.br>
To: jic23@kernel.org
Cc: marcelo.schmitt@analog.com,
	linux-iio@vger.kernel.org,
	bruno.stephan@usp.br,
	aschwarz@usp.br
Subject: [PATCH v3] iio: adc: ad7091r-base: Remove duplicate code on volatile reg check
Date: Mon, 21 Apr 2025 11:55:34 -0300
Message-Id: <20250421145534.91146-1-arthurpilone@usp.br>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arthur Pilone <art.pilone@gmail.com>

Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
same test, checking whether a given 'reg' code is
AD7091R_REG_RESULT or AD7091R_REG_ALERT. As the volatile ad7091r
registers happen to be the only read-only ones, the volatile_reg()
function now returns the negated output of writeable_reg().

Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
Co-developed-by: Andre de Lima <aschwarz@usp.br>
Signed-off-by: Andre de Lima <aschwarz@usp.br>
Signed-off-by: Arthur Pilone <art.pilone@gmail.com>
---
V2 -> V3: Ditched macro for simply calling existing function
V1 -> V2: Renamed macro and added clarifying comment

 drivers/iio/adc/ad7091r-base.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 931ff71b2888..647a7852dd8d 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -387,13 +387,8 @@ EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, "IIO_AD7091R");
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case AD7091R_REG_RESULT:
-	case AD7091R_REG_ALERT:
-		return true;
-	default:
-		return false;
-	}
+	/* The volatile ad7091r registers are also the only RO ones. */
+	return !ad7091r_writeable_reg(dev, reg);
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, "IIO_AD7091R");
 
-- 
2.25.1


