Return-Path: <linux-iio+bounces-12269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4179C95D0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC951F2290E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13331B392C;
	Thu, 14 Nov 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVW4nAc0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B031B21B3;
	Thu, 14 Nov 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625819; cv=none; b=e3XOgGxetiAJeBfRBSbeMWwQFAHxoUXQZIqgkzA0MAz4wOwmnxMIEClEUuq6w0i3huaM2K2rT6Lo+F0lNagQGoelJVRof6mN/HqvfiXWls5lGvITSez0LwX416ZDWxuZel6DEttKDxE2U4ZdMUOTfJqryOH03/nwexYXPCAhO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625819; c=relaxed/simple;
	bh=aiLZjS3wh04TbJHljnL7BqHglqHGbfGl5zjpMcJ5K9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCY6JoebpOS9lByKI3p9Ye0V0A9GKWy4V/vhZtZT8osgo13mXGHzL0ylhGzXS8KppcJ7mfdTs8w6K5dkYfGDsK6laVdYB3lYFUzDwGlIytyAkwkdKOCZpU/T+wt4DJd9NzeDxvTplI8ILZ35V4bah3hqwnembAROlu/UebCYSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVW4nAc0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315549c4d5so1409555e9.0;
        Thu, 14 Nov 2024 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625815; x=1732230615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG4Ni7KzeRb+ZTbiEyqqdopwxe2k/jzkggqNyDeFT80=;
        b=cVW4nAc0vT3hOqh5YPlLUoqH9darh1QmFGV32gyuC6Xoq4aw05rIxrCAczpv6liYvE
         wxgyGPWpNfOpaLZMLJeKWjFB4MqmzM7tQqqeQvNxj3rhTl2KsTpc6z52cJsSZuOG7ty8
         HdJwGOcGrxHvzE34AQqIlh3gVPj3fnpu5chJGlXM+hA9ETqDA1vRNH4qK9fhxbSUU9mA
         oc1d80kz14KugMwdWmDStz+N9vyniJqznHfKj0n33D0ZgmFohSEMdgtdgwdm//1vsOgu
         DedSjWEGcOKCBhytKv5SPqjuJQGMNaMwvMwwqlzTsV2D6l8MLY5QqSZbbNV5kF2YHkNw
         rRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625815; x=1732230615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG4Ni7KzeRb+ZTbiEyqqdopwxe2k/jzkggqNyDeFT80=;
        b=ijaQeXtWVUwP+cL3oHySMsbCUzVekG/zwRg4nXRI57oWkitapH356QwRL5sC+0MObA
         IFIWm2k7EwkUBcjF/mu1nAaUPnk9h2JK3oZbgyNAVzM+o38B96Hhs7h15EapPHjzfFAQ
         EKBDx3JgNOwpjIHq6BJl+PbLljd1SfCEB4T2VyYXGG4pOO/wUCNtn239fa9mKN45yAdW
         jwKtIcV9KVO+wEw6sNIAdB9cIYuFiXZFvv5NM/mEh4shR0fHxe6Tj2omf6wvgFCYZY5n
         gH0nVHCls6TM2GpM6UHG0/tzsGRXbqZ1MwVKN6cE8ehYUFiMr2HoZYrQlBM7CHGtpWjU
         eC9g==
X-Forwarded-Encrypted: i=1; AJvYcCUD3u9+RiMEvS/WaasZjDiBUn3qCuMnak7QFv1l2dugJJlm1J4NdffXMrMPXQFmZu2L1IR1/pX1aNSziD1m@vger.kernel.org, AJvYcCXCdwQk7aST6bg8ndr/Y6TxYuKhDG5DxV3Gl1AKzWDE0P+WPwBCI4twGPdLz3RK54bPjeBUqeDq9R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jEVfioCLZgPynuBaDSXb7sBwdt7kNy1G0gyhqA7rmp4kFcSV
	Xz3+S8Ew4nYKsAfM7RHpkt4D/zHXnqUAQCJGYHPIr1mEz9i3tOrm
X-Google-Smtp-Source: AGHT+IEbgXJPAS9eq02cqKvDMQpsHbjyytZLtrV0zIAleuM/FP70X+eAjC0jjh4hWYN/wB7kqE2lUw==
X-Received: by 2002:a05:600c:510f:b0:431:50b9:fa81 with SMTP id 5b1f17b1804b1-432df7995f3mr1611425e9.7.1731625815167;
        Thu, 14 Nov 2024 15:10:15 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:14 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 01/22] iio: accel: adxl345: fix comment on probe
Date: Thu, 14 Nov 2024 23:09:41 +0000
Message-Id: <20241114231002.98595-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix comment on the probe function. Add covered sensors and fix typo.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 006ce66c0a..d121caf839 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -170,7 +170,7 @@ static void adxl345_powerdown(void *regmap)
 
 /**
  * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
- *                        also covers the adlx375 accelerometer
+ *                        also covers the adxl375 and adxl346 accelerometer
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
  * @setup:	Setup routine to be executed right before the standard device
-- 
2.39.2


