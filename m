Return-Path: <linux-iio+bounces-21725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4CB07D87
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 21:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9017DB6C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1628F933;
	Wed, 16 Jul 2025 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="KXclg/xV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36202AE6A
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693761; cv=none; b=etWhoy6oAbOgW3Mn71R3gqIsN4KKl/+tpLxw6nnjgXi4/r1JbX5WY05YdK36rPE63nE+t5pDHIHJjSlcQqW8DQ4v6RoNqGswWv5Crr29fgrouoKcHGEGKfZ9RULFMvze61qMOz5cy4xx8gNehszyUM+78FSMgVZY7c/eMrIYY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693761; c=relaxed/simple;
	bh=k/Q5DBejNMzt+4K7U74iYJgWhhtuCCnwkpj+ILpgbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fc3i708wUAo+I+SQ8iaPaa12ecuUqQASL1H58WYgJ4BmBH5xBZVZbfR/fgKYJ/fEVaMN42fs/o2zdyqks6jHyFTI5pAi45Kf5R035V3oC2iclcfnj53OzrakkfuK1O/tR4fhQDS0GQHJ5mIp+kKlszCyuQFr0jaSgAzyjZ6c+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=KXclg/xV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so34452166b.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752693757; x=1753298557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKJGgL3dXmlMtgNUnEfM4H9D31BkLDQJTcqBEwKr+iU=;
        b=KXclg/xVYoSykq9la90BJrE6a9Symc1cmVPo6hJb+pSlU1HpoMA/pBSFZr7MatfW2Z
         RTFz1phL9UFqja8L/UFJYj/w49f4l5D47yBQKDLjtip7Q9CuqY4ZYRiYFE70w8tOUqVm
         otm9Nf0oLVeV7iqTwZzj7zq20A9tCpOE6kWzaXjJ1M6AqSatH9b9lbLbF4seKQ4Mj1tu
         p8DG3mCcHRb5k2/uf9e18dffN4OaL9AHNBUu9KgWj/rVtUjE1ZpEfAddRrzRDbfGzOti
         +wspIFI6wjYVrK1A4YALIzMKM+/Pg4a2qVTl3M7vwMh8DoYtVs7WiJYehpfpXG3XYHBe
         vBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752693757; x=1753298557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKJGgL3dXmlMtgNUnEfM4H9D31BkLDQJTcqBEwKr+iU=;
        b=VMM+e5tMToHGXOLvwcT75/bnvrwAB0OU4GRqZMxZYIC0UE1AGE3Zh+ipHeoRBq/MVQ
         9Kw0M9XzpcaQzj85XD62eJPu8e+Odu9SB9fb+OwaemipbauA3VQaxwVZTUM+Tyr/vg+O
         E5mP0kfn2VaEKcj1Mv40pWl2gEp0lEfC7hdHTGF2AMfVmw9xSw8NqKk89WxMoKrNDbEo
         utRuRYTLPvPKeJXktX7LoyPsutcgBzb+7tSGHjmqS4ngTor0k9MwsrvEVLNgh7flrIh7
         hGpjh56niBa/12E/l1bAim6JG7pxtQS5T+6fS/Xncssa3rpc4CG+0B8fg5jWMbeJ8Sbh
         lIcg==
X-Gm-Message-State: AOJu0YxB44Mar/Ob0wMY6nL2KaIGbXhfNxk1k27h52G/H5C+QtAF9C78
	gZUhJLgbCBOGEsxD+8op0vzJNRwkeIysm282XQK2EhyyiuaqCCn02+I4bZRPwTxXEFjPvYAiPCg
	MGWKJqdeZbw==
X-Gm-Gg: ASbGncscFM/jnDCcCh9++5UX2S9B7RFdfY6Lep7KJBur7m7rCrZST/IxJbpcdjjDWws
	MpoPSFfQRpZu4ER/1r297PAqfly4/E/XIUEehGNLFCrWMJWWhqBNQEvEgaQ0CQ2sHwZ0eISTjAN
	C+bWgsn9OChRQM5LOxMHZzzfVAOK44rgorhAwSNHjTqzoJX8XbfcIgelrfxA7JpevOQUzYoF8g5
	JCcwYv7nLRsvpBisSunW8K1QYWPBZ0pVkl+Fbu49mUIQ9aUApsMZ7lsWLp1xSSWVMCTjzmccNoX
	E5wxtxx6/WiUP2NkBimSmm0pPL5Hf3aJdN0WOsbmIswZfP/9a/YCBnT3+/M3oNewOehd5J2cA/b
	HpCsAeEDjPgvz+NQ8OivZ8ZO120nrPaU/Bh1gw8X/Y4aJ3A07
X-Google-Smtp-Source: AGHT+IFppsbvPqruYEuSYa/J9YftjEC8sUsZzT7F2el3Stu4LavGH+4Tku1i0ULs/8ICUIOR5VYPig==
X-Received: by 2002:a17:906:c105:b0:ae3:64e8:8c5c with SMTP id a640c23a62f3a-ae9cddfe7f8mr391967466b.14.1752693756773;
        Wed, 16 Jul 2025 12:22:36 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82de8easm1236204666b.153.2025.07.16.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:22:36 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-iio@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
Date: Wed, 16 Jul 2025 21:22:31 +0200
Message-ID: <20250716192231.30337-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In inv_icm42600_accel_convert_wom_to_roc() multiplying
`threshold` by `convert` may result in a number requiring more
than 32bit.
In this case, although `value` is 64bit wide, the result is
truncated because the multiplication is performed in the
32bit domain, due to both operands being 32bit long.

Cast the first operand to u64 to ensure the multiplication is
performed in the expected domain.

Fixes: 50cfaa9a46c8 ("iio: imu: inv_icm42600: add WoM support")
Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEFORE_WIDEN)")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7a28051330b7..218bb3eb3dd7 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -347,7 +347,7 @@ static u64 inv_icm42600_accel_convert_wom_to_roc(unsigned int threshold,
 	u64 value;
 	u64 freq_uhz;
 
-	value = threshold * convert;
+	value = (u64)threshold * convert;
 	freq_uhz = (u64)accel_hz * MICRO + (u64)accel_uhz;
 
 	/* compute the differential by multiplying by the frequency */
-- 
2.49.1


