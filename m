Return-Path: <linux-iio+bounces-5403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7908D1EFA
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC3E286268
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63A16F902;
	Tue, 28 May 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxsM2zqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329073475
	for <linux-iio@vger.kernel.org>; Tue, 28 May 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907105; cv=none; b=nkUazUJ7WX9NzqdHf+gjbduDpUnc3+P1kaqkjGeyMlOlY/zLxy/qcODq1XroJwLHfQiBrlhZhO1Yl7vo290pBv8swteS2ripMfcdcMAjrKvMqzJjpBI7tc9PkENUT5OYRNDTAu50puhhQJOYCi1RXqK6dls/SEw8OGwAL91c3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907105; c=relaxed/simple;
	bh=cTnDHTVCKun7sztzYzbrC1s90K3LykQwqdS+3SEueis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udRQmsN/buQjuckzXddHoQjU39GdwU7albQsNzlSkmPVSvjbKDbOHX3JuxMRwutvkfmrUdbgZriXsM6SAck+LbKR6dHwLkvL8ig4K80j+7G2qrWVBHec6886OF/9NrTrcbxsiJjXqHAS818Q/4xrSsdty3GWs8Og0jjLxDS4hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxsM2zqg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-64f12fc9661so57073a12.3
        for <linux-iio@vger.kernel.org>; Tue, 28 May 2024 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716907104; x=1717511904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSigm+4ILwqGVh65F92NpLduGjQpmPV2xoyc1ftURfs=;
        b=CxsM2zqgwxLFTfY3fjSE6G1QAoMF7fsLWCEoS4hyK1rXtVPyF3K1AIqlp1ZbbXrYBz
         5TfFq1rg5ya298dFGdcbOjX1+33mLC5UdydNAAvajst9mtkd+SDgs9Prar93N2kwM7iu
         LEJGcLNZo2xaRfS8kt+gEf4Ot/f0aZCsIr6BUcMS2qx+fIxwAGrahefaei47ov9dBBpM
         Xsefq2c9JwCI2DfooJvPJFlznTXoomGxvL8FYFOyVbCoJtcYGCw5pDrcieOzHsIeyxcq
         Q3U4j+xQmRCPRtLIzKs6pFlvvzAQ80ZARcTv+EuM8fytO4GV8GASTAgJRtcJWUVqRepx
         zNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907104; x=1717511904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSigm+4ILwqGVh65F92NpLduGjQpmPV2xoyc1ftURfs=;
        b=teRi803Cgde2PQc7JDUnftfaMbPJFav5ESG0EE6xS+UTEO15gtexSckdwqfuo2FgGn
         w1qV1enkN+yy0y9kJQ5n2AGah8I+VAUIYYnhFJE17WFCoGYLe3DfvbhmfCihyqp86jKa
         SsnizacOnskp7WlvH5mmkmqDECeEyB3KI0FvcSpuFn4aHUe8SNY8FIy69j4Kg821Jf25
         5MTY/o5XzfVR080YQL1ggNQrmcgl2UiQcdTa+VTUX9r0bbtbImn4JLdU8kaWpp3IpwY3
         jiB7W2tK5o++CM7cfyd+9Y6b2huAzUi3IbzYWFZKwB4eewZFSP9aAHVZVdyO9mlGoPLh
         WCGg==
X-Forwarded-Encrypted: i=1; AJvYcCV0j+IzW4549kPnmadMkdBaZun98If537MIG8s06bmTfm8ITIpQNcw/0Tq8csGb1McA29+hpazccTy+gSqzygTtmJgl1j5UAbZd
X-Gm-Message-State: AOJu0YwQfzpr4VxwsLfPOIMAKxjjMLKpQn+W7JirJZn4JT0p+tZFy/u6
	DcJTPI+F5FG5XwpJY2ND5mnWVJz9h/qMuHlK+5Of/AgLTpsAWq1u9OVfN2jO
X-Google-Smtp-Source: AGHT+IEDIS+MCMGBhyHSBM0osTtISQFGhydAANkIq9OP1f4yNp8hgqupqqQ5L4VbueUORI2fzWkgrA==
X-Received: by 2002:a05:6a20:3946:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1b212ca864cmr14737382637.1.1716907103675;
        Tue, 28 May 2024 07:38:23 -0700 (PDT)
Received: from bruna.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682274bbd16sm6500232a12.85.2024.05.28.07.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:38:23 -0700 (PDT)
From: Bruna Bispo <blbispo1@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	Bruna Bispo <blbispo1@gmail.com>
Subject: [PATCH] iio: chemical: ams-iaq-core: clean up codestyle warning
Date: Tue, 28 May 2024 11:38:16 -0300
Message-Id: <20240528143816.13409-1-blbispo1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a checkpatch warning by changing the struct attribute from __attribute__((__packed__)) to __packed.

Signed-off-by: Bruna Bispo <blbispo1@gmail.com>
---
 drivers/iio/chemical/ams-iaq-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 164facac5..197a205ea 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -24,7 +24,7 @@ struct ams_iaqcore_reading {
 	u8 status;
 	__be32 resistance;
 	__be16 voc_ppb;
-} __attribute__((__packed__));
+} __packed;
 
 struct ams_iaqcore_data {
 	struct i2c_client *client;
-- 
2.34.1


