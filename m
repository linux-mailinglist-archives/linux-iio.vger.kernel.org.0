Return-Path: <linux-iio+bounces-19519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B0AB752B
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 21:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBC172E9A
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5528689C;
	Wed, 14 May 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQVLaOTs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBEA2253B2
	for <linux-iio@vger.kernel.org>; Wed, 14 May 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249750; cv=none; b=XJJL4uE73So/LOZQC/GUYahxkzvFWgnnZ0CHu5njcg4mK6gad8mu4bJi6XU/MUJwdl3R5z1dwhpMIz67UlXxSJUmZfdKXdpjJjy6pLwg0OrCRmRNnkCdE9LQSUQ6EC/PXjlCeirY0Vg5lH17CgrsfETl/J54Lqj2MpYP2zOfBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249750; c=relaxed/simple;
	bh=EyH887FyIkjfdlaBlYHVZB4u2OxCoUrzPccypAbPf0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m4FAONsCfERVa5eHFuG2dQ1OIksYisoJNdaWTCRgdGQThRZj7fDMMFrssOD5qc4OmbVN/D9r2UQIPaGYhfMoziWDzclyFoPIBeG/8UOtIuJe+/KIqL5+aRm97Hb25ThPtvc3Lk4HRbu8MSCY7/5SM6vKsNcVforcZ0GurOun7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQVLaOTs; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52446b21cfdso29793e0c.1
        for <linux-iio@vger.kernel.org>; Wed, 14 May 2025 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249747; x=1747854547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPAxEwhugIYtlKiMTJRbGSYbcWigPkRu/XosQLLUCRA=;
        b=XQVLaOTs0xAioRvELFSiWB9HSN5TTRJHgoRrdDdColmY+VaUzzj7SFlESeI2d/Xs3f
         f3QkWtekKLHKJnfOYHwh6JYvftubWEEknKZ23eFlRkyf1yMKl5hVKyoUxGlIq6rwkQcv
         bfb/L2Zh6bXerPztwd+oqPNqpLfsCQ4AhtBrNDHMINnZcHyTUZGp4hB+roEQTxzhGHTL
         3FYi42GCRcd+LiXmcthh+43kuUuq2/B9HMZ/f+yJsI1kWB46cYo9dtDpGTHWw8oQ1nbc
         YQGXkE0GkYhNiUUQExz5krDu59CFK/vWOquCzN+3iA9quZc3Vlr7JG7nJTSnwuWV2REh
         N2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249747; x=1747854547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPAxEwhugIYtlKiMTJRbGSYbcWigPkRu/XosQLLUCRA=;
        b=V6ujI6fCF51YQWsfu+1kYggQe/6Uc3vRQIWMa2pDXKiH3x3lTkYTlAQTB0eChWjCGj
         cSaQ0SWA5pWX9GTA+n6JkTpiQK4VaEPRr2I6/t+z9OL8MIRw96Dtq0fMKuIjKh6LysYG
         bvadTy5uXP3ERZpTJHyoC3UnqkhRlGQnZNsPSD/o7SnFbfMd4JPw2kompJBcrx1iHpiR
         hzfkIIUqF2QVokUMFE/ojoAzQPFfYEnmLawCw9tPOjHmvG3zRoBaH83N5TW9NAX6XuYP
         H0j2qO1R/+hUNVXUFSQ5+pnONN8LdZFtzeJ7Xr54hb+hCCGlAzuolOaeF8Rem57tYKrR
         pMtQ==
X-Gm-Message-State: AOJu0Yw60+FZSFREcF+BHUx8eYZaIhvPdpfmUwb2VWqTaotDGaiOaFI2
	Uoc4OvBWaq5/SPm69JrtMxYfhaf0a7a1cBem1BThU7ELb4YsfTny
X-Gm-Gg: ASbGnctnR2Wi+4L/vZ8Erws35MXaYmhYQ9ovkjW/fItbOaZTSatPPIy3TpJA3GMG9/j
	e7d95X4kKrmS9eDMI9/bRo6QW9V6vfq7iNf70MFHLgA/SilfQM8Wic2lPe0vz2zC696wMYilAz7
	2h7GDe+HZWW7omqTTKazViJA09W7FiFIqSpkd37JbkNiYpKjcZscZ0KCnLv3/DhXzcTEVWxfEGW
	WtK3gfXAGVNKhElh7v7wVjZWSfJAYiNer2mCWTtgxMxiNFzlv+P/GIVU+7zhjPsKKeHH4dk9hHR
	o3coCxOeUQHephBq+xqVaJ4+RYMeLFdBVi67waP206svKUmGbqcNRYJ5v01hp0YbeQ==
X-Google-Smtp-Source: AGHT+IHn8owK08iFqu+ZpSgkdpyS8p0IqAXgIrApXO/aY/NAVWqXUoDC1qxMnvu/zIk8lwrcnX17ag==
X-Received: by 2002:a05:6122:2018:b0:518:7ab7:afbb with SMTP id 71dfb90a1353d-52d9c6e63efmr3882229e0c.8.1747249747078;
        Wed, 14 May 2025 12:09:07 -0700 (PDT)
Received: from octavuiPC.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c7ff62bbesm5373878e0c.29.2025.05.14.12.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 12:09:06 -0700 (PDT)
From: =?UTF-8?q?Oct=C3=A1vio=20Carneiro?= <ocarneiro1@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	ocarneiro1@gmail.com,
	fernandolimabusiness@gmail.com,
	eijiuchiyama@usp.br
Subject: [PATCH v1 RESEND] iio: adc: ti-ads131e08: Add iio_device_claim_direct() to protect buffered captures
Date: Wed, 14 May 2025 16:09:01 -0300
Message-Id: <20250514190901.11011-1-ocarneiro1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add iio_device_claim_direct() to protect buffered captures. In
ads131e08_debugfs_reg_access and ads131e08_trigger_handler, data
reads are protected by the function call to avoid possible errors
caused by concurrent access.

Signed-off-by: Octávio Carneiro <ocarneiro1@gmail.com>
Co-developed-by: Fernando Lima <fernandolimabusiness@gmail.com>
Signed-off-by: Fernando Lima <fernandolimabusiness@gmail.com>
Co-developed-by: Lucas Eiji <eijiuchiyama@usp.br>
Signed-off-by: Lucas Eiji <eijiuchiyama@usp.br>
---
 drivers/iio/adc/ti-ads131e08.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c6096b646..00a7e6494 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -578,12 +578,16 @@ static int ads131e08_debugfs_reg_access(struct iio_dev *indio_dev,
 {
 	struct ads131e08_state *st = iio_priv(indio_dev);
 
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	if (readval) {
 		int ret = ads131e08_read_reg(st, reg);
 		*readval = ret;
 		return ret;
 	}
 
+	iio_device_release_direct(indio_dev);
 	return ads131e08_write_reg(st, reg, writeval);
 }
 
@@ -627,9 +631,11 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 	unsigned int num_bytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
 	u8 tweek_offset = num_bytes == 2 ? 1 : 0;
 
-	if (iio_trigger_using_own(indio_dev))
+	if (iio_trigger_using_own(indio_dev)) {
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = ads131e08_read_data(st, st->readback_len);
-	else
+	} else
 		ret = ads131e08_pool_data(st);
 
 	if (ret)
@@ -670,6 +676,7 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
+	iio_device_release_direct(indio_dev);
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1


