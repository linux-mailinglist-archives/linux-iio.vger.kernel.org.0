Return-Path: <linux-iio+bounces-10120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451B9904F4
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEACE1F22DCA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427372139D7;
	Fri,  4 Oct 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em+5CgZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E42139C1;
	Fri,  4 Oct 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050171; cv=none; b=lXHVp3lCxz3HExYpounW4bCbwHSgRH/fXJ1io82EWELksCmlEAw8v9/Ty7l/gZggFNmjW6DHST6rZRpkF3jxzzCDC1/+O7zttwTjnjUMWTSliZrfSqaAzCTsi5/o7p3mVgqaNPvJx/bSHkUH/qyojP0zXBG6yFKTc9xPlLzr3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050171; c=relaxed/simple;
	bh=yN8SUhpAjfJ8/0spTZ6dRj/tXZ8S6c76kFKETvQwJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkGDxj9S0kqQW5H5p+cQB/1iuuZdXn4LzZx31FLNOpVS3iJ55KJ8IIflMsaPhXGswWMITVkoXSymjKfa4owKgLN70VV9SlBcMvahKkv5bAsLBJhJ7aF2wRTa4V4t+op0/rPD1El3agxhLVGNFK+C7t0FHam9DaROwL3j9Rpyfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em+5CgZA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20bb92346caso13885725ad.0;
        Fri, 04 Oct 2024 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728050168; x=1728654968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w34Wnptij8o9+LvaBRb09LGIk4Fr4VbA+yDkgQ6EP1w=;
        b=Em+5CgZARkCvHCH2qwSj976YH0KIOBaxHz2Ie+96ZNaY/R1DfFdkAHiABocXl5jBCu
         MGE8YmwPO9pgQH0Rgz9gcHpOan280mHHs1DZIPuZ9p+J+2qFIPa/6L6XLE9idDxw2x4y
         CC0IG9ssZQe+SHtBmcOTREXkbhy6B9br+Eypr9u7xDgr+HXOrENN5DQyZ51AIGYhvP2G
         q7S+hhme6xwCETocG6z6dOEWiXt9fXCL4QAyHhclZX9w+GbR0LbbMzi+i0+1yrPk7lQo
         e5LD61W9PMEyv4fkkWr5UvEad7yjYOOmWYyk4iLNn7o2nGQdVYCCLtUCd9z+y9OKc66u
         CzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050168; x=1728654968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w34Wnptij8o9+LvaBRb09LGIk4Fr4VbA+yDkgQ6EP1w=;
        b=qxpzL26mE6O+rpuYh601qAPDnMgT9F3Dv1CAWbP2nTLJogLanCUoPOkGdjgz/K8ldH
         kpjQLlH5WMGfWQZyk6HXzetqeuycdV2uB8nuBIvLhHeqx8GoKkZat3s2heWDBBrxfIGz
         4eWPp1Q24/wkHqHGjoEA57BdT13bO8mm8j5EKjjPixKEe3asWzX5loSQ7TY3fuH/66vj
         8BkOyR17bsE+HTb6tfMK14DzWVXJaSuxB4U5Cf7RzHGLhDHYOepbnjnonYxjxCWJ2Wqa
         KDJWkgcydIHNlVND3oFg5KsTMa8tGJ40XfzPGVl/vglxTYZdPpui0Ta0yEpImxUcbNex
         Jibw==
X-Forwarded-Encrypted: i=1; AJvYcCW4b7cAYKSaE0suFXiXNpIou0NIlS37kDE3hwL+jfvzu1hwxb67dEVh/05+Zo77MNAkysIoWw125RgG948=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WCCJTYgqfaEjQUnhqy10lhne1Ke7PbXKK5BtceO5DJvQHsp2
	uf2S0HdBdVu/waTqpAQKd0lbzcSsEWSj4oVjC+qeLx1s0JhTps69iKZAFrVW
X-Google-Smtp-Source: AGHT+IEzZ8ocBImw2b2gwP2Cq+CX5jEsJOuOHPSqoTZYo3XFgjLhrsXNbjht0U/WomzNScJsC46LbQ==
X-Received: by 2002:a17:902:cec7:b0:20b:db4:d913 with SMTP id d9443c01a7336-20bff494762mr45580545ad.11.1728050168483;
        Fri, 04 Oct 2024 06:56:08 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20beeca2256sm24468175ad.91.2024.10.04.06.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:56:07 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config function
Date: Fri,  4 Oct 2024 19:24:54 +0530
Message-ID: <20241004135454.5784-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of the ltc2664_channel_config function,
a variable named span is declared and initialized to 0, intended to
capture the return value of the ltc2664_set_span function. However,
the output of ltc2664_set_span is directly assigned to chan->span,
leaving span unchanged. As a result, when the function later checks
if (span < 0), this condition will never trigger an error since
span remains 0, this flaw leads to ineffective error handling. The
current patch resolves this issue by checking chan->span rather than
span and also effectively removing span variable.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 drivers/iio/dac/ltc2664.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 5be5345ac5c8..64c8a51aad81 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 	const struct ltc2664_chip_info *chip_info = st->chip_info;
 	struct device *dev = &st->spi->dev;
 	u32 reg, tmp[2], mspan;
-	int ret, span = 0;
+	int ret;
 
 	mspan = LTC2664_MSPAN_SOFTSPAN;
 	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
@@ -581,8 +581,8 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
 			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
 						      tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			if (chan->span < 0)
+				return dev_err_probe(dev, chan->span,
 						     "Failed to set span\n");
 		}
 
@@ -590,8 +590,8 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret) {
 			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			if (chan->span < 0)
+				return dev_err_probe(dev, chan->span,
 						     "Failed to set span\n");
 		}
 	}
-- 
2.46.0


