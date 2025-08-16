Return-Path: <linux-iio+bounces-22824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCB8B28E2D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E5D1C82738
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811C2E62AE;
	Sat, 16 Aug 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBlfQnPt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6328F935
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351496; cv=none; b=NRY6yjVeGsExiWCh4PNEMjJexlXV21s89NaUGm2cUKmY6bmxLF8h7yZ4f3UdD+I1VEMNfH86sQaAHaiCN9O3U7esqh/lkEQk7F5i3Mb3ka5uJ6+X7wu0v2cniehURUQkYpyiw++ppDRdmZg7FrV/i/euva3MMJOm96nIhF7aHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351496; c=relaxed/simple;
	bh=7UbQKDN1GEFhBsxxmxfizY7Ssvu0Moj8dhGuUyQptOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZujslxP6HXaAYlZP5gELeyKVhTkJ6XewXrguxcwLJ3rJmqMfJR/x2vDN69QlLNAB5pANDvMMf2aEkJGbORb4nljmGyHYCbLWZFOMUBpBr/zPEu91YHkP/XLlPGL6eP5aW3rn099Gmgqp1vBJBKKmLfe4vQy/76JVw12ozh7i7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBlfQnPt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so2016309b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755351494; x=1755956294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2J2iSSCaNNvRGZwQ/4i2aG5ul+1gTH3QhJIp9bBktMk=;
        b=FBlfQnPtVKKVfYe/EOVGZ09qRBWV3xIhc3lftvqwCd1rOdL0+wZglWp+A8U171Xc9v
         VrhJtLUVhUwg/aKl0MKBtkvo8htsJbeRRgt/p9ctBpCBp34OLYY77KG8g0QdnMV4dd2m
         96aBb4sOdWmPg+wXHoEQS3dI27hUu1H86moFmwRWDPd+hwCShLrKbIRtIRzXKuaUEpuk
         Lyzw+p4mECrWxQWrTS5K1JP08fYF4uUQNNHIGI1v66KbM97ZmDseFOlvftC9zBthQ93Z
         0ED7nvTkQ5tZ1n/H7C32OKKYc2VVkjii2SquEgHPbARKUWxNHMaprt3b8G8ehC53Lr6a
         qULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755351494; x=1755956294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J2iSSCaNNvRGZwQ/4i2aG5ul+1gTH3QhJIp9bBktMk=;
        b=uUW5Jn54p1+8pV0D9Dcx5ufcqigjdLDm5mQSAdQULIsuCdZqg7pu2LDmldvc48m3he
         Azyr9Kcp2r92djr2E8muzJcNCqrYk+vGUbd1v0LQ6Zcd8OiWv/Iv3cu1fMVVi/A6hC9J
         aA2chWwLxkg0hdH3xOrSfJtb3IrSJ22ClmebwzAmtZpqCxyYhc//GGTbB0kQPn4q274H
         0Brggp/dPu0631WEDbvPPORhMcJU+/IThqXmRVV7459dZhYgMflM3vCjtaSeahFn2C42
         prHIIG4lHgLqByZTlST/lxRcjr3B+5iCNjWif5HMUm/cw6gPVBZgdNJNTD3SJYV12Df2
         joiw==
X-Forwarded-Encrypted: i=1; AJvYcCVzBdzDN9Gx+wXubIdMHVNqkTnAKqh27t9cvfun7AL9Q7074d/QVWI6qhzPt6IWA+8Li1mQ75unqpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxomo9NbPXtiVC0G0ILLBcg1PRK8It+NledwSzM20jEL6en5YDU
	R8hQJ9uB21Lp9PWNpm0hJwHLStTwDBBzpaWnvq5KSkT+86d21FI2oo1ogfXLCA==
X-Gm-Gg: ASbGnctm9i4vErBeAFwUPZlHpaLR054KCmdqYndbmvm3gLRjapFCE0TJFfTNNqoduM1
	fCOk3Gxg4AOHFgpVYn8wxglEK2FUfgRxj0MHeNrLo2LOpDfQO/yAyHCtj5+FacT50QP4oaOE8it
	JMfCTOvb6elO5HbDcS8rC605SpU5s3xi4ppV3bkvJIK2Cv8iWzsFsX5oU+2uM0yoPts8UK0YHgh
	s8A7leyVIkoobavks9kvSvVEASJsNP6tBngJEbWAdtK7DtZ8uSH8UtKH9jrBKRNynZ+gMctt5XU
	ZZNG/T+Jj8xOudausw933lUiRfvjApd3oX5Kcw6Y/TAWxLDiuyFuf+XVxKBHYq2ypeHkFIAcDjz
	OfTMXBE10GYU5fjdQOvH1+AYsviTsJT1fUlNmCl+ZnR5Ri1SH2o/vxw==
X-Google-Smtp-Source: AGHT+IFTHcbP9aHD8Nb5BFtiVW24xICOOoY85jJsclKqcExAllJZ4AeqSU09r1U55OQXNwokZ6LSTQ==
X-Received: by 2002:a05:6a20:1592:b0:240:1d69:9cc9 with SMTP id adf61e73a8af0-240bdb9b540mr17807581637.16.1755351494274;
        Sat, 16 Aug 2025 06:38:14 -0700 (PDT)
Received: from chandra-mohan-sundar.. ([2401:4900:1cb8:7b85:8034:5810:5a19:318])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d77338dsm3812707a12.47.2025.08.16.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 06:38:13 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: adc: ad7768-1: Remove logically dead code
Date: Sat, 16 Aug 2025 19:07:55 +0530
Message-ID: <20250816133757.98624-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clamp macro returns a value within the specified range.

In ad7768_set_freq(), the value returned from clamp() is checked against
zero, which is not possible since the value would always be between
50 and 1024000.

Removed the 'if' check.

This issue was reported by static coverity analyser as logically
dead code.

Fixes: fb1d3b24ebf5c ("iio: adc: ad7768-1: add filter type and oversampling ratio attributes")
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
 drivers/iio/adc/ad7768-1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index ca8fa91796ca..a27591bbf7df 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -687,8 +687,6 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	int ret;
 
 	freq = clamp(freq, 50, 1024000);
-	if (freq == 0)
-		return -EINVAL;
 
 	mclk_div = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
 	/* Find the closest match for the desired sampling frequency */
-- 
2.43.0


