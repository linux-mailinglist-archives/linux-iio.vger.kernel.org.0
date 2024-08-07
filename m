Return-Path: <linux-iio+bounces-8304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198394A4AB
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAA6B22CF8
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CE1D1742;
	Wed,  7 Aug 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECvgJNgS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E691D173E;
	Wed,  7 Aug 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024071; cv=none; b=ejO7zIb/79pNtI1W145d3Grf/drJMj9IHbMFfC8poSs+XKnnJYoSWR/YNapPrZoM9t+0FKT251mgFFVn6/kTYtYIXl4rCCAkotuyra3pcmWrZpDisJCT6UZ15BswDSQoVC7DPVJQ1kUN6SLyHhDIKDMe5Jr+OYxWMtqYw9ZJpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024071; c=relaxed/simple;
	bh=/W+05LJJu3p9mNXq4i6BjmOXtbvwMphvQ98oqXMYewE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nK+Eu1QHB49BpTQGDbtD8f/z3GWH/kfq3Slv0IKrEZUTC1jdvdrXOfBXWmAv7+Bu1H/aYR2wXwsuzvOU38smbprUPNW7zFzv02K9+Td5pu26rbchDMyyIqeMSbKRUV61hPjUryNyxBGxGXdfLp8gdWitkKh4l3B9gq/g8FvxPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECvgJNgS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f040733086so18376201fa.1;
        Wed, 07 Aug 2024 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024068; x=1723628868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=810tWogs+Tnt7fFH5BVJ7QxBIOSjaNNzpsC9bZx2HB0=;
        b=ECvgJNgS4yJzPWsKvRzHHZMSINaoA/veK2i8FQZQlOBE/vhn6pM/NYY7y+ONW8avTF
         YeYMcbs1uqzap5mForN6ndhTlbfrjeLRzglmt4v927aOX9iTN7fukDPL3DiCPQoayB2e
         uFVLDwJ1X1R4k+jf1pQqiCDHTfsrrB4/pM2LRUY/1N3xPiHqWtKtota6cIvudbkX5vij
         dqSRqrBN9duX+u/7eJ2AgimQC244toWtju3Qmqpog6+wsXEtAUid43I65Kqk3FM8CLYE
         CUgRVG4BlzeHO5juYuuRfVAalyu5hU7QnHUiMeI1MEq9UfW4/buzl1wXdsytPzI2a+N5
         ofiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024068; x=1723628868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=810tWogs+Tnt7fFH5BVJ7QxBIOSjaNNzpsC9bZx2HB0=;
        b=lWW073zRQDW028CiQSYyx53XC6awRMooz2jGg0viguj+AbEDTo6NDOLArQS6FwdIW+
         HVJnj/sXwhqd0EueG5IlMK+u5/3onl6ThYIUqreh/RtlyWRS9SnYPwJZl63DpLPZ/O0W
         SOKUOmmHpVsnRblCtfiX/k2/QpgqaQHvkzce9x3aCvs2seLNfOsddBfK1qSZAQQqUR8c
         NdiimLmvpN48q4YW39FZxkG2coGN2/jWptZW4rxPdUOQ3ygYuBeBqS14jJ2cd9JXkXrn
         JUBJbFXeSDRxVLLi/eeCiUxNEZKWUlaspbjol/baClCVNcf5YN18Ir8YlLCAc5248Guy
         Tg9g==
X-Forwarded-Encrypted: i=1; AJvYcCV+cYEDrZPnOcY1LNDl++L4mb9iYvlnc34S5jds1piNa4OwG5bVueRVZnPUmBcNMwaz3Q/JJMDDJazTeSVTxFf56C7ct3aNossha4KiT48dVTIgriBDZ/Ahfem5tZfv3EMiRICghUhs
X-Gm-Message-State: AOJu0YzUIGNfbTM/6Zu0oWEbXmCv6oY2hoxhe2p4HIZkNTcIbbVJNKJD
	0hI0ezuf3sdck/78G8Shh/NL9aWZhNo44FabDi8F+9PvYRuBnoyW
X-Google-Smtp-Source: AGHT+IEuslsF1bAhVsV7NeiyR1S0Ob3GtNE0i++EGf/yFxjQpqPEUW7Y90WKuLzpWV5/I6rcZXamBQ==
X-Received: by 2002:a2e:9b06:0:b0:2ef:2e3f:35d2 with SMTP id 38308e7fff4ca-2f15aa870d0mr114129001fa.5.1723024067227;
        Wed, 07 Aug 2024 02:47:47 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598e049sm20565075e9.23.2024.08.07.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:47:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: Fix spelling mistake "avaialable" -> "available"
Date: Wed,  7 Aug 2024 10:47:45 +0100
Message-Id: <20240807094745.4174785-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 3f2bc6451325..6a6568d4a2cb 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2002,7 +2002,7 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev)
 	}
 
 	dev_warn(indio_dev->dev.parent,
-		 "active scan mask is not part of the avaialable scan masks\n");
+		 "active scan mask is not part of the available scan masks\n");
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(iio_active_scan_mask_index);
-- 
2.39.2


