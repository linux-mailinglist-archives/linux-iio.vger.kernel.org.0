Return-Path: <linux-iio+bounces-27421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92304CE9C4C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 14:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9206130145B3
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0A213E7A;
	Tue, 30 Dec 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmSZ1tXR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290441EEA5F
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100896; cv=none; b=O9vmxozC134JkMU826fV9k28NYcN55pFDc1qLzuUwGE5JiWtkTGnSzRf0sfmsr/Qwd3+zCsE6DqZWUCt1iOoNFD8/2HZ1j+l/eOToXeVDFvDD45zjU6F5E/UJxj+5vgG+I3cIkciQx3JHw5g0rGs50ExezJi1atMM4kNokFWtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100896; c=relaxed/simple;
	bh=Id22RWJdiD1lWCvJ6wPUpNkE50dgXyI6el9nvkjasPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k07c9ah1Xzj03wFyKSvoaTdJdbAuA48wbpG1z506diy35VM29hdJhBtNt+Kpc0zhnm1+BVfWYOtP2jfgiuksP4b1YW4hHo8N7Z2rp5+iTe+/pWkMRt1zsrNgHXu3+H+NIzNnVyFzwtaAm5ya9/7aJOxuqiLCjg16wWZnOeKRLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmSZ1tXR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so6702576b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767100894; x=1767705694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDWnxPQ5/BZi65DH5ONyZDXL3Tpvrkq0u7vocACuE+U=;
        b=OmSZ1tXR3VgySbjIuZAVaPtGXyRPeFxBkCojSSw2jDF7n8Z1JAfeldf4s9boFIZUN9
         ZykW5CweeV+LBJhljIjZCW1MNrvGotUKrUAGZobPLUF6ODSFGyJIcz1BqHCX5q7A+maL
         muwOD+sxSKjX7QmvEDtUeMSTbEeQVECnqSvQpcQC7B3YmzSkqdsU0mT305D8vCvsxuhz
         ZisgR0OKh5LyzkuGYqnaDietOFeGabzvrWmNda+aon5pVkGiVz8VPGjxa1VDXYq6HA5A
         h3UNb30nqhwlW6bnuCdoiZ13zD4++kOHa8sCApmfW0U0MAX2jn/gTEtJDGYOZz8f0F8P
         9P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767100894; x=1767705694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDWnxPQ5/BZi65DH5ONyZDXL3Tpvrkq0u7vocACuE+U=;
        b=Ko5/e5t5EebnXaQQB0Fc3Kkrzm/EopDSVoSOeEqIAlI636xS2FJUAhqdpgHQfNLGEq
         HaNCklj/vG9weh+DdiP0jZxVN0o/pToTBYxFxakEXbTz5UWaPR8jPrtrmewJIMaK/+Np
         djGIeBTFHCMjV2q5lJrZ9PZWBTLQWDPyTCkJZ5X48slSNWAWopAoui/c88MLdiB+Yj7B
         TM+/iC+UBCDwT/aaCO1GtLjfCzjXrBZyX0GJ+7voXWiCF1oW2Ao8vOHq0EOpJ20I2ClF
         r9bTDGik8pdzydhf+57FWVyRhsP4lADYfZs/KC1ZmBCjP2/KVrr086sQHtjoeRmvJ+kU
         J+kA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Ci6wDkX/nKvqxcVqJ0+sXf/Sg491XncgnvzAD2i8s3KWtqZ08dCZmWl564OxeutRrvq2cfG8JfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx414ZjBb9mfyVB11eLYpGSwhVhkuRxpFQ9CE24fTOAAlq0cvVE
	f5QBKGRYLDMRTBmA3+i2LHQOtjWtIVCHz0z41zMhbKDjRFk2HaH8jXpN
X-Gm-Gg: AY/fxX5DF5xq3NWJzIzsojtPkmpbhCFl9qnVVVab+Rb5rqCq/+Pkp3+9uU2h4tmGZhu
	7nKgN5bMRhzT5vc3nVgXnzohjY/KpRj/ZEf+YJSI2rpxqtqv3Fws0Ce+0O1umxgU1DC159pr2z+
	Vw6yVb5JM2yrnPrWcD4OxvoBIoaCxV3Dia3Z0SYri8XJPJFxQYYCbGjaLC2bgBfJbpdOwaNgVE4
	2M2k2r7yMcOiXlSSTQSjIbf0T0VaKQ3E5l8T7VrXwMIV+9IiRLRW7sB7X805xh5TxO1Vzj3h3fb
	rJ8GWww7XJbMfO9wVCDg5rU6eMiQuUgEMF1KpGFQFchMEkvxkkmberZQEVphiWQa+EEogV5xkOH
	kMsnrFVVpImkTlqDuq3ASLkIOhi6HCabM6hbKP3WemS2Nl2Ev/mlfNtY4m02UpJEqQK2gVyBhqg
	6M7qQL22XlDQ7VbRdLhYAxtBdjd+WDsB0/YjE=
X-Google-Smtp-Source: AGHT+IHKH0V9VAEfdHhckfOoBsAhYOHCEl8/fRkP84Km/yU8GhngDkm43LFibTbH/iRmH1/msFbvAQ==
X-Received: by 2002:a05:6a00:bc90:b0:7e8:4471:8c1 with SMTP id d2e1a72fcca58-7ff6627b86fmr30752936b3a.34.1767100894401;
        Tue, 30 Dec 2025 05:21:34 -0800 (PST)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e88cd71sm32469013b3a.64.2025.12.30.05.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 05:21:33 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
Date: Tue, 30 Dec 2025 22:21:26 +0900
Message-ID: <20251230132126.217802-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230123609.210454-1-suunj1331@gmail.com>
References: <20251230123609.210454-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
twice instead of checking both SOFT_RESET_MSK (bit 0) and
SOFT_RESET_R_MSK (bit 7). This causes incomplete reset status check.

Fix by using both masks as done in regmap_update_bits() above.

Fixes: eda549e2e524 ("iio:frequency:adf4377: add support for ADF4377")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 drivers/iio/frequency/adf4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..48aa4b015a14 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -501,7 +501,7 @@ static int adf4377_soft_reset(struct adf4377_state *st)
 		return ret;
 
 	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
-					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
+					!(read_val & (ADF4377_0000_SOFT_RESET_MSK |
 					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
 }
 
-- 
2.52.0


