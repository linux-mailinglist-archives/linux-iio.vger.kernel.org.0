Return-Path: <linux-iio+bounces-24693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 838ACBB7E13
	for <lists+linux-iio@lfdr.de>; Fri, 03 Oct 2025 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AD9A4ED5C2
	for <lists+linux-iio@lfdr.de>; Fri,  3 Oct 2025 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33601BCA0E;
	Fri,  3 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byHNo2cj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D62D8791
	for <linux-iio@vger.kernel.org>; Fri,  3 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515879; cv=none; b=jf6yZY8JRXVDE4S8+n+FoNQMmKtFudhLSbrlfd2vwFmsjyWuQyQrzrCUajU5miUJSEzwXr6AKPT5oZxhVvRMueEFAqj5zIyNKmzXhUIQp+ObSNg7Fe4k2eTm6QzurrGdMHycgVcCe0XtFd/yt1DNtG6MOUEoWU9sFl1yCHZ94hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515879; c=relaxed/simple;
	bh=JWi1dPRv3vJCqMXY79ZyUqMo2r9f6XEgGFQSh0PF4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PobhjGcP+sWztPKvxHXBEGgAm8VmSdZmejIXgrp7/+vmaDq/3I4hnq5Ke5G8zntEsWq/ZpCrvfY9yBvVNwMjVbROPcMN9h7LNmwgQ39j9y31GF4vwYTo6NtieQrUV5yMJPnCAJEchKmvJgaw2K3tIfzAiOIm45eMAOYatDB949U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byHNo2cj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eceb38eb1so25637855ad.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Oct 2025 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759515877; x=1760120677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kU7VZ7vV5hwPE7SqFGuxKZUDC3/bfG6HT22JnaO2Ak4=;
        b=byHNo2cjEA3tYigtlp8Da67WikbVD9sxluPWW5uGwqXzNWb/UP2vWCm4rOiZ8leDhE
         y98aUQwFXwu/Oa/o6H3gQuHgIzcQtiR3XHv0BTKem+glpUbGhTkjNuor/tVRvGBKSX3z
         x242aaNf41AzwW5u+Cyt6guQDGrzBDaBRRGS88gIYNVmFTQeZyXUY2NhZdPEt0W8WjMF
         er9DCApnOLOkCIqd+42pt4Z4dz+3P71bhyCsXvkh8wQMYP6MF515PSQFC1TFKYgSbM6Y
         /JgOeHeBW38hPj8YUzVPA8t+9DT5T+3szQJp5gjTf2r4vVIh16x8mRsoL+PJmACXdq3w
         EmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759515877; x=1760120677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU7VZ7vV5hwPE7SqFGuxKZUDC3/bfG6HT22JnaO2Ak4=;
        b=j/gXn/P4xwrlgUAVLpkRNFNkdXknaG7Th3TsBeIKvmS9F9ACxX2ahwYJNPGLN9NQRU
         APry2BBWwmv2piIsSdO+jz0cx7/Jspuqnkjli+LHnC/EolD2sPg0QB3Ucne+enDy20vX
         Wh6QINrjhC+umUXLwrCaKdH25KIkERonzuBbZSXK1iTazYE8pYO6Tr7GTb1b4KkyYKfl
         jo3TM46aP6inHFLVG1oK0wXoQYhbBMpKVcyOvDfA5mhev/iiANszib/85jlTuucL+vjE
         lCIo22dzk5nyq8Uwkn0TWcMJ8B/DkSggP+E43G3UuTZQHFXzems0o6SKlz/7hMX05kDc
         3HpA==
X-Forwarded-Encrypted: i=1; AJvYcCVF/tsYv/2BZrhet9QIivoQC3uAUF3b0pahRHL2FOvH/NeV+n/3MEehgMmgZphLnW4CGLKkpm2+m7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BLiRuO5jnTQp8AGyIfeg7WlWDwVPfIWw/a3FCw15o+JHosJS
	FFIUAOP+L8SFCrxnXOpptJW7enInSPUvsccueFmzAaRCBiyytbogGsc=
X-Gm-Gg: ASbGncvp4vYzUOnOPkj/R9juqD9E6S/ROpiNY8fYAMzi+xp4Bjy8iQiNzfEYQrGAzNi
	TGM+QH7j9fMOtYEFXzPnQWbwijPnobxKxuPSRUrvg7ju1Rx+gdkNHYnDedTAQ81vPRlDUSW4xAo
	DHO+G71DhYorUPEj4TcUh0oO7Et1cY/A1Lh700RhhguQDmR2HeBKtf5KqbOSDD3pVWZsVpA6rp8
	RxwF3A9JqIF8FyH3wfbRqPdOvAhDK0AJiINy8dC+o/pqJKHjuozFoN6mBNVoy+lOv8H6wByvuBA
	l4BIbfxuxjJ2j+Q4CTZmhpUAfFDu6x9trnZ+RAOp3PxQjjh3vT9jsfRt4JftCAyBSJe/7ZVJ/nV
	jlpbiyK/oIszHqWB1LQGCF7OqWefle5w2NhF/R4MaBWggAaNXCZyCdCbZYnfHyCRqukZ8o2jpj4
	pEDtPgmSZ9
X-Google-Smtp-Source: AGHT+IH5QhP47DXSnOQBBU7jylbK5b8cnwHLes24+MrTlxFkvQFuCftLsMOaQ91gvww1HCvpIhSTsw==
X-Received: by 2002:a17:903:1b25:b0:28e:756c:7082 with SMTP id d9443c01a7336-28e9a546d94mr46300255ad.15.1759515876493;
        Fri, 03 Oct 2025 11:24:36 -0700 (PDT)
Received: from samee-VMware-Virtual-Platform.. ([2409:40c0:106a:c9b2:3d7a:7a89:eeb4:6f87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1233c1sm56773155ad.47.2025.10.03.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 11:24:36 -0700 (PDT)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: anshulusr@gmail.com,
	jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] iio: light: Fix typo in variable name
Date: Fri,  3 Oct 2025 23:14:25 +0530
Message-ID: <20251003174425.9135-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a spelling mistake in the ltr390 driver:
'recieve_buffer' was renamed to 'receive_buffer'.

This improves code readibility without changing functionality.

Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 drivers/iio/light/ltr390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index df664f360903..277f40879932 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -121,16 +121,16 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 {
 	struct device *dev = &data->client->dev;
 	int ret;
-	u8 recieve_buffer[3];
+	u8 receive_buffer[3];
 
-	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
-			       sizeof(recieve_buffer));
+	ret = regmap_bulk_read(data->regmap, register_address, receive_buffer,
+			       sizeof(receive_buffer));
 	if (ret) {
 		dev_err(dev, "failed to read measurement data");
 		return ret;
 	}
 
-	return get_unaligned_le24(recieve_buffer);
+	return get_unaligned_le24(receive_buffer);
 }
 
 static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
-- 
2.43.0


