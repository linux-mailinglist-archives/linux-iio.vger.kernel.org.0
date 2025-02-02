Return-Path: <linux-iio+bounces-14855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A44A24D79
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73D47A1DA8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C211D5CFE;
	Sun,  2 Feb 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTDv0JNs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BA1D5AD4;
	Sun,  2 Feb 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738490978; cv=none; b=bDiRQOdhNHE7oQzv4EgC3eX8nVaW2O/imYSQBWic4S0WQr7ZPw+JVBdPMxVplFC9syiS4hgcH62dNB8MyoAk7e+xyGIq3Hb4wSA4/UxUnz5cFGCwXuFRxacRgY4l2O+pRqpdaDaCQgK7fH0aP5Dsz8XWH2ZopLpGztN7Ng2c15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738490978; c=relaxed/simple;
	bh=5VlAe3jxiuk5OzokFFJo1So/AaSyRkT2DsUEIG4t8II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bo4C3DE7+QRniKZCcxx5zV4/C1361vk5+NujFCl1aKx+T+qW3C58vsvtr/32okSRrRYodHwH9iII1fnbXYCyl4273j4+xZR3iiBWPVltw/UkH6s+8kn4oSAzt+jCuUrKMEWHtd0v6JAd8UeHfEMg5h9uhECNmkexo/APCrSA1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTDv0JNs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436281c8a38so24229545e9.3;
        Sun, 02 Feb 2025 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738490975; x=1739095775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VA3K9Hob0m9MY8QGKSjO9vg3lvjiXSBqKyw6KdIzgzw=;
        b=GTDv0JNsFgp43TfwRPIJfi0vFw7QHgRBxmUgRsNmzzqQMQySQLFcNETrvAQjMqPz4I
         LH62c/eo6L2RG+TJahwPwyE0OL81U3MQnXeI1YVMUllt8ijiyxavVIY4pDKPfFn7yeKy
         Rh0XA1JBiTB1uf84JuoSDnIOw23Gm0AulQfsfsFMuzCang9a/FDaASOwTodL2X7bpAlv
         NqvjyRpy5NKbr4f4AG68CyVbVOuBIWw1fuizuPjXQBTfvwCZZWuzA9UzthlPD2ScDnOr
         rN8iPGVyXy0k6NZ+zGcogKsijNoYtsRqW07z0D2SgooawRSRKzqSf8f3Kh7zmDtjRgNl
         RXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738490975; x=1739095775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VA3K9Hob0m9MY8QGKSjO9vg3lvjiXSBqKyw6KdIzgzw=;
        b=VpZozIYpJrv5jd3LtjYTAgQ7Gx1JTGNcGU1/gyz2NR+Gp59vzF/n6VrhRkuSJp/zqI
         Itx+C8E4Fvy2Xnf6Y22XlkMRIFe6R5ZxRleMISJP+7ZwDtLH5ORvbnshkqRUy0MZkRdh
         wI8NZPHwW+pAGWuM4fxRK1AOBWZaFvl8FgqziUCFKP+F1BfE2Dh3i3iSwq6xOOa3RlEr
         VxN076NpyCFfwNXKtp68T6YJEvoHPeaxtP1QErHie4zmB7of5eegduaLIcR33GO//2e3
         pzJAtjMHMG0/BJ8+5aMQ8+xyim2DvNaDVhNNtGCYz0JR3QXer1nhV9IkMgBzqeVSq08c
         0d+w==
X-Forwarded-Encrypted: i=1; AJvYcCWYe+pcdNm0/lJ5sOa0ooz4a0/Rk4/vK27bcoJ8pjG39+SQVdvp7h3zm1wbAvjf//a8wqLdyRulHqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydSUOzRK3GMBOwA6jBX5K04c+i+IbOKxpa8+QZf7y1wruWNhI
	vs97tN6QyoHbrpKa0xxtw332vMrgE7Dck3fZbodT3BFS4TragOvm
X-Gm-Gg: ASbGnctASds4f0FVE6pUVNlttVaJl8mnZ0PwdtCqS4zqA0fCAAwn7/KGBK/GBiwrS3Z
	aY0ePW100CXhcHT1LpU2pbwtN1rxnvaebR8I0g/70rK81dVVNUHFkU+WjtDGfq1eU6tstjGFdYy
	S96YcPwaJpJ1XJRJCAhxN1aRZ7aMiKiNhLiuOyENMN8UZstMDfautUdClBKME6qqlWNa31C9JEH
	Z20Z9aXN/2pWMoMZl/mCI5m9uyZ4FtDgZpWsFRFTPYwugX1D3Hyx+FLk8k2lwkoa+aGLIkakr6o
	5F5zZfZfnKyZ9KJVGg18h/XU8Bm4ldo=
X-Google-Smtp-Source: AGHT+IF+a+gUUvIe7DqCBcQ2AFtTJYs5ah6uhJ29zfNdV/ob4ftWfR8AlIQycWNbaa5BG3iWVn0bLw==
X-Received: by 2002:a05:600c:4c24:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-438e01fdfe1mr127962045e9.4.1738490974629;
        Sun, 02 Feb 2025 02:09:34 -0800 (PST)
Received: from localhost.localdomain ([78.209.22.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81a39sm148546635e9.35.2025.02.02.02.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 02:09:34 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH] iio: magnetometer: si7210: fix magnetic field measurement scale
Date: Sun,  2 Feb 2025 11:07:10 +0100
Message-Id: <20250202100709.143411-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applying the current scale value to the raw magnetic field measurements
gives the result in mT.

Fix the scale by increasing it 10 times, so that the final result after
applying the scale is in Gauss.

Fixes: cb29542a178f ("iio: magnetometer: si7210: add driver for Si7210")
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/magnetometer/si7210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
index 43b00d76505a..27e3feba7a0f 100644
--- a/drivers/iio/magnetometer/si7210.c
+++ b/drivers/iio/magnetometer/si7210.c
@@ -203,9 +203,9 @@ static int si7210_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		if (data->curr_scale == 20)
-			*val2 = 1250;
-		else /* data->curr_scale == 200 */
 			*val2 = 12500;
+		else /* data->curr_scale == 200 */
+			*val2 = 125000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = -16384;
@@ -274,9 +274,9 @@ static int si7210_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		if (val == 0 && val2 == 1250)
+		if (val == 0 && val2 == 12500)
 			scale = 20;
-		else if (val == 0 && val2 == 12500)
+		else if (val == 0 && val2 == 125000)
 			scale = 200;
 		else
 			return -EINVAL;

base-commit: aa61400ca17e264a4b597e3c0cda011c6b9b3bb5
-- 
2.25.1


