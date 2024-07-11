Return-Path: <linux-iio+bounces-7502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EDE92E9D0
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F831C22596
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6715ECF9;
	Thu, 11 Jul 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="M6QZ591f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B483CA3
	for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705541; cv=none; b=mIO/fSpGliLqIygj3BkrdDuFu1V6P8jdFxsy9QH/3XCsvOmzMJDTntNmFrvvy1WfzssTiVSWRPeZceI0QWkrIxHTHjIuCuKUGSoExH+HaxP9euYpS2GoWcI1OyU0TYGuQ0KJFpokHspDXsrqPWceMB5C25FHrGuxgaB5szAMtD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705541; c=relaxed/simple;
	bh=LNgfPEONwz77obs5vu86+jwQLoPPcNzIkcXBF7J5Q7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUZuq7Q0qWxX19U0sW6t5lKLLfE5XSfPxhg90XP/SjVJyld/b2FlEA1KBedfZMcMN2M17N55Yk50D84cOFlkwrCCR4Rn61mpjcI/AFxpakG2bbxSTw7pyoOnj5QqyolumRe0deh0WBYrRZXVqpPcZvR0fXi5+F6qQVx1EwB65kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=M6QZ591f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee90dc1dc1so9473941fa.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jul 2024 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720705538; x=1721310338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/c+0OryQ/xDZXy3GXgibVWASMIq5wTTdQXB096fDbxc=;
        b=M6QZ591fkwKguDcp27deFU3Mye/AcsIkg7OuZWaN/VzIhgL4niEsa4VgMGdxma18e3
         7jxeZo0mtU6jKMSO4Lhd9hzYRWasVuoszXnGz1xT3tGYLUSsiY3tq9jKBmfqsW9CMhBA
         L8Jrc9thwAhCcoX3di7egt9Ij39dAKM9CGvaraRHCE2Zdmusm6wISK9cec6M1zke/ZLj
         Z4xhv8dmSpQgKv9V39ojiTrnTVQfEB+K42jPROaZha5iN9W8kZUpB2nVXHuvlU5/JxM+
         RxRXm2bImdyho/jfa+vCo5sdobzUTfCpYcS+tkNR5zgawUbAelbNifVcycpmfTFOQbbO
         6BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705538; x=1721310338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c+0OryQ/xDZXy3GXgibVWASMIq5wTTdQXB096fDbxc=;
        b=Nod2K502WuevkY29wkZaI3TH3Jhbh9iKfaSVVXWdYAnAAFxxPPsmyuYYB5ebQ8oYQ3
         4S7T81CXNC9J3iS+3A17mIOzrHJg1Qb2pOoXjr5fj0kbkDxPoy4WltISbgIDcfsbn+f1
         xP9UhZPs2AQTvvMhkg1trIDDyZqjB09RQ64JSjXiPddEE2WEAxAIoS/hjmCYdust3ljC
         hYbHy+wLYdOE0jLrOskcjwBVhrOesMksjUX2YWj3hBKp3Mp/3+LVfB+ieLA31ouZknue
         xdv7Guznx82KqjtOmVntk4NiX6VvEiwVdKIIm5+9HYQ6nGUj9dhSONDf8sifOJDVemXP
         5Hjw==
X-Gm-Message-State: AOJu0YxgfBt12IuJKWrEg+JlxqruShTB7wqdW4dHHwbntT66Zj6b18cj
	zLCI0LFHTGkkNatn6jQ3l9uIMhacDG0JWp9nEyzCy7QBnSS+eCdeE2gqy/UPXms=
X-Google-Smtp-Source: AGHT+IEnRul6UAvbY364YlS50mTbM15zix7Loi58TE8dtn8HaiZFAwF2Qoz4+y294My1CpS5s27RFg==
X-Received: by 2002:a2e:8797:0:b0:2ee:854f:45be with SMTP id 38308e7fff4ca-2eeb30e528dmr54794621fa.12.1720705538039;
        Thu, 11 Jul 2024 06:45:38 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42667720667sm175476835e9.33.2024.07.11.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:45:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jbhayana@google.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] iio: common: scmi_iio: Remove unnecessary u64 type cast
Date: Thu, 11 Jul 2024 15:45:03 +0200
Message-Id: <20240711134502.168484-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable uHz already has the type u64 and casting it to u64 is
unnecessary. Remove the redundant type cast.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7190eaede7fb..ed15dcbf4cf6 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -158,7 +158,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	 * To calculate the multiplier,we convert the sf into char string  and
 	 * count the number of characters
 	 */
-	sf = (u64)uHz * 0xFFFF;
+	sf = uHz * 0xFFFF;
 	do_div(sf,  MICROHZ_PER_HZ);
 	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
 
-- 
2.39.2


