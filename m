Return-Path: <linux-iio+bounces-24768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398ABBD78D
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F83B3772
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B7834BA22;
	Mon,  6 Oct 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUxaBNwZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667471F3BA9
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743680; cv=none; b=pusL//UEq5uyqrzztyZDZeXHxw9pihMTCNte+FkAr7zvL1EyS9WQ1zeZveFy0hvIxIzeyIpVMhczy8MyTEm0uicSSkEL3oMdiP2qG7L8r4iKfd3LzF1KGnP6RD0hlyd24sFd5U38y1aFLznxzS+LgMDZAJjzkyV4oFb8yAGwstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743680; c=relaxed/simple;
	bh=24sZmUViPfdoTKlBu2+lcVKxGUTmmLWmXX2XY780LyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9X3ev9wpZfrUSzJ7PqmkheoF8wsDdmM5l7QUWP3brgdHggON5J7O0yhdZqXjm4xKeiUOPKwfrCECs1EzoaE1f+FfAjA5dM9eWIrpNQmAwOAJVrKSp/iUWcYQNQbqSULLIoDWnbjUhFOt5A4xnuYLu7azhzRFxRnzyf8PB3ejOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUxaBNwZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781db5068b8so3806551b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759743678; x=1760348478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4g2Dt/TcqCZ9Q+bj74Qh0XyQkDPrwX2+n2zSBd62o0=;
        b=KUxaBNwZvGcwamRZJX0e7RLMwx/zkU6oGe2ZN/QWOMKfcMorIKjKHdFyexwBSrSfxI
         Teh9/XcIpweC+YxHPynKHU9uhE5lX1R8ZhaX9RkvLJqoDSyRG6LvOc3IDrIjYinhKi8y
         IT+WxWaNdOjBRMDpMZPOmFi/dtoOyq6OHmwFxEhVU5+sAtc5KE4W1AMyTBoR0SF+yTqE
         TZM1WjSRZbCRWgrfBfCpHY0DOpwcMP0IR945LAsi1A4hRlRQVz/fQfNM5X1mIaLzD5XC
         xFbh2WvZucvOl/coP6Y1qLdgkQAmcRbsbWDUIaeF6oVUw5uiglYpvq08ZD52uoPv7k26
         jWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743678; x=1760348478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4g2Dt/TcqCZ9Q+bj74Qh0XyQkDPrwX2+n2zSBd62o0=;
        b=jDwjXwfOlJbYP3yklA6hNKu4LOQbbd93NHdT8cDYXl9iCi4FZUAgcu7hA4Xgs8sk8E
         pH87XzAM8fTFvvXtEYhVqpOggaAecTRcIyeqBfr13T1wlE4EBtuntFPeYUbG/QJjYuNg
         7f0eIGjedxsODH+E31SIaL7W4qYdP2z3CbBSPR5e8V1ai3cnnIrRMvk6+oFpPEQSGjp2
         Ms7LNOF3uLuBs3c/USSYCUxc4i5ovKeK+5frnrYuRbqp5C9QIfhyxcXlVx/TGOUqsSxV
         8W/84O7uaG9bG+WjrDtasYU1diQDtUsxNCgy8xxVYsqt8p8PFcnsoC/scLk+mI8kMiJl
         TQxQ==
X-Gm-Message-State: AOJu0Yxo7zJExY4o+yA//8TTpE52FAVB1I+wDpkvdWAgIQhrZbDWM9EO
	fmt775z9tfCyFcQFPLDmKYR+g9s6+VKW8pPZBZvb/dZ8nJHXSTK9FRrr
X-Gm-Gg: ASbGncu8pHpmQaELvkSWhtuuVPl7QKTet+V9uuND4WtpimKANWHlKlWIKx728M5Bu5e
	JHjlTSWtoI4NEMHFHpfb2aa8f76M2Eb3bveXRma1jI0hBKOkcF/9I8Vmqo81AAAo2Qj690bCmIl
	lDT06DB3zAMteJIMRwaRELaPk/5JbDp8JJTmXiQl7Bj6PXO3FYLb6PR+W1X6gka2BxXM4E+hHyb
	SHBG5SofAnRw4bU0U7QYdV4hun7WWqeYd9mDzNtV+Bv9LPBoOgQcDZFoqgANL2W3/PzB5vJJyCi
	yL3lqNpJxw7tiQKIBaQpInuUrhdDLP9mnInRDOinueGyynqHFq/IBjYuS/qH6DGjVgqbiOQXOxP
	0bAp3PBSf4EalDlNtue2uhxjlgu+tEJPr6+197w==
X-Google-Smtp-Source: AGHT+IHgfM9EDZrwpjiaW1k4I95OIZfCiOHLduIpkcRPiYnJMWY4Fkb+eSQxUHRYkT1ib759moqT4g==
X-Received: by 2002:a05:6300:218e:b0:2d9:4afc:e1cf with SMTP id adf61e73a8af0-32b620ea86dmr14590976637.47.1759743678561;
        Mon, 06 Oct 2025 02:41:18 -0700 (PDT)
Received: from ASUS ([119.63.139.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b609be239c5sm11325778a12.19.2025.10.06.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:41:17 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Taimoor Zaeem <taimoorzaeem@gmail.com>
Subject: [PATCH 1/2] staging: iio: ad9834: remove empty ad9834.h file
Date: Mon,  6 Oct 2025 14:40:24 +0500
Message-ID: <20251006094025.259440-2-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006094025.259440-1-taimoorzaeem@gmail.com>
References: <20251006094025.259440-1-taimoorzaeem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove drivers/staging/iio/frequency/ad9834.h header file
because it contains nothing except the include guards.

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c |  3 +--
 drivers/staging/iio/frequency/ad9834.h | 10 ----------
 2 files changed, 1 insertion(+), 12 deletions(-)
 delete mode 100644 drivers/staging/iio/frequency/ad9834.h

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 0038eb234d40..d339d5e8e043 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -21,9 +21,8 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include "dds.h"
 
-#include "ad9834.h"
+#include "dds.h"
 
 /* Registers */
 
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
deleted file mode 100644
index 521943aa0e61..000000000000
--- a/drivers/staging/iio/frequency/ad9834.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
- *
- * Copyright 2010-2011 Analog Devices Inc.
- */
-#ifndef IIO_DDS_AD9834_H_
-#define IIO_DDS_AD9834_H_
-
-#endif /* IIO_DDS_AD9834_H_ */
-- 
2.51.0


