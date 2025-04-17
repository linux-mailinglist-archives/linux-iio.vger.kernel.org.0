Return-Path: <linux-iio+bounces-18194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA4A91FC1
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9432463FB0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88B2512DD;
	Thu, 17 Apr 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW0X+a6M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEB15A868;
	Thu, 17 Apr 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900489; cv=none; b=dahIYUhsKFJYN/ULGIUL40wMUYxZ6C38QkbfR1m5b9AyF73W+6pMGsv+0mqUijoqsP546mJPYFUY4oswpn+spHUrIlMa4wXehdZN24fT9yMhHjHkD8bHgW9/kb5afUN00nREeHEWLUIr+airppRuQ57WrhQ8QXc0pE+iWX/w//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900489; c=relaxed/simple;
	bh=UAWbwn3OEwNZoN0Hj/TtDK0n2Rnxf+jEq7ZazqpZnGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDjKVZSBRWRgdIDtMK67zrdL2RZaHC2e0WZDMZKbsY/oOFAmIAKkvublJeuViZB6zEeFq29Fg/9joyUugeieXCJkq61KhoPHQqdBwOFRkMwfZr5vKVciMgXfppgsyKMElErXjtW5mPXg5asQGEvvrKClL/pFdsuQviI6vGrf1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW0X+a6M; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso13078906d6.0;
        Thu, 17 Apr 2025 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744900486; x=1745505286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+vcDWcINfOfJjicxisaFlx0tomPR1D579mnXzAv3jI=;
        b=VW0X+a6MAcHE5egRIu7CJTxIDXkAfy8sZBl8awesEo1oFLE7pI+0t6UMLlNXBm63bB
         wuh8o1+npYblh4erZkNsWwhZyyyEhhN+Fa//vNKTSN49pXteap6qnCB20CzRgjlYTpTz
         yCN7DN4gfeTFKkfT0Zq7AstEAvpR3RMHBxeitwXjAiIt1esIKLIR3zKDao8OOHhPhKy0
         SIROcGtNFxT1LqQi+kqNcaiKEPzwucYf8syO7D6A+jw60gsjfFOt46agEz3zjKc98m1V
         QeuaPK7yTfUSi3caG2j4kAZ1yz6Cy1yOm27kyN5yNl1VYxwKQ46/mrXSPtMqj+cePscj
         wgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744900486; x=1745505286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+vcDWcINfOfJjicxisaFlx0tomPR1D579mnXzAv3jI=;
        b=iCDmU/xhHQgSN5TuPRPJyeIfiD7McL899bPcSJaNMY767SLYaRL3ESTlodDIT3MouV
         /KTT/HSsU7K4If43p8Kfgxa6gUCa7rC2yWa8xRpNrz/3jq0d46ZpWZLOExKIB6+w2tFF
         zCO3E69Ux/Na9F7QT0JLm095urQaL/Q4QUk7lHdIRTXeE4C80ryxRu8uQqMUNHvjYBZA
         JXmBY9CiI7UTygs24i1p4hDAznEXxOOL+e/u3dF9FY4rvDaF//B/Q0E9RypbcpylMRFg
         lLEhjCB8Zz9mZOb87jTKocxNnsudOT/LHqO2q94woWp1qUlDgeCX4Z9ILugOZAtbxisg
         sf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdHkf7sxZ+3wOUtAMYNu9Kv0ZRD26Y1MFlp7vxUtU0vaEhn4SS4HBXRJCGSgT5HHjv4EEVgkfdv4M=@vger.kernel.org, AJvYcCUgZZr5QxJw1qb/nn6AbxlWbMVCDF7SpaV7gGrs8hyz4MahBJdW6MI9Yd/C+congDRmDksuUWKqAPPTot8h@vger.kernel.org
X-Gm-Message-State: AOJu0YxBa6Fj2QjHoIIsY1Uixy/uPkIzdAgJnoYCj/hVyppHmJpxoYNN
	NioMBNpU//6AhNrilBP5jSolCKhSTRCTbf9KDq1s6plojYLrXSbq
X-Gm-Gg: ASbGncvFCHp2CWYZpIpjURAkGxKgEBSBFkAQpoZCxuMAf41VtJV+yb5Ddwg4U5EAt/e
	MqmAhX34KAPU6MkASh92pRUFvvDJ3qW7j6ztLErPnikGHEk6i/HBT41nCNJyqmWcjnUMki72Qun
	EAcL+3LfufZAK2wLEH5yQWlrBnrhheprljuJhtzGH3Jy0qqPw33tG+QVDvMK7+M8Ex9ZGde0fgF
	/rXXqSvh3cYj43LI7VSTFjv5rMmK5ifc8OrqthRAAjM55lSyyx93+qhShV1w7oEOfjTBrYcr04t
	KYdTGmm3lgPp5aI+3rox0MUXgwyUHJgmrwcWQyZMug+Sons9nMqJ3LQOkv4im+gf+zPquCcBmit
	B0bmheK1D30q79ZspQJU=
X-Google-Smtp-Source: AGHT+IG9icZZSGylR/t9AWhZ7mftH5cb8yzalcC3BXZjiY6qJg9z16eiJpMA9UlK9w2SkTnLcK98IA==
X-Received: by 2002:a05:6214:240b:b0:6e8:fbe2:2db0 with SMTP id 6a1803df08f44-6f2b3028031mr87470066d6.30.1744900486480;
        Thu, 17 Apr 2025 07:34:46 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de973552sm128069896d6.50.2025.04.17.07.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:34:46 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: frequency:: Remove unused parameter from data documentation
Date: Thu, 17 Apr 2025 10:32:20 -0400
Message-ID: <20250417143220.572261-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD9832 driver uses the Common Clock Framework (CCF) to obtain the
master clock (MCLK) frequency rather than relying on a frequency value
passed from platform data.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index 98dfbd9289ab8..d0d840edb8d27 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -13,7 +13,6 @@
 
 /**
  * struct ad9832_platform_data - platform specific information
- * @mclk:		master clock in Hz
  * @freq0:		power up freq0 tuning word in Hz
  * @freq1:		power up freq1 tuning word in Hz
  * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
-- 
2.43.0

