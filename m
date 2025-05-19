Return-Path: <linux-iio+bounces-19686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22486ABC0AA
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F257AF930
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F927286408;
	Mon, 19 May 2025 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS2Yl4+q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84482857F7;
	Mon, 19 May 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664792; cv=none; b=md7/Z2ebmYG20U6Xaa7ssHshEdk8mM3tGDVZyvNA8uErMqaVFyDEq7JZ4TLMblK4/uPmzlajGFxvl92ffHaBVfoXtIkJcJkbiDvaHOHUiBkAndGBOQ0AQ9f4RD77AkDbOXnjQS+Aw3UTUgp8WTZO3qsvmExlM/tejF23X/Maq/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664792; c=relaxed/simple;
	bh=zjN83KWFIllAO8wzvZzv+RKCQLnKnBP+FKXxjhFv34o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASHlLsOjYI6A/As7Nphiu+Km7GHw8dq9bFHHd6uCZ9bppE5YuH4Lub+IqYCNM26FrPiZz5pbAwV85CDP0qwh65NGm2zqbWXPDZt5v/7qxFu3VGZF4ccPxDM3ULL64wAvIFWAxobr8WNa9YQS1jFZ93IKY555/VQzPIwBacyukdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS2Yl4+q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74019695377so3483419b3a.3;
        Mon, 19 May 2025 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664790; x=1748269590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPSK08R64NjDKjVa8ynPBVMp8t7R/JlH6tOj8tW7ci0=;
        b=OS2Yl4+qU6P9xPK+KTGap22R/23CT7uHB5qbnBquM1vtl/tMzw8pWQwlX7mEVy1cS6
         5nuxKPQO/Ku+LGQjkqfan19j0qP/wdU885os3eVCi3ZivzCmeyGQ0S798NUTiibVwJu6
         SUCaskGJEnhIykbvT4L4f1iGX9ir+TTisWYbDaik4ZjWZYlVUKhMtv/dstm6IgDe6XH1
         CPs7PFb+b4GZwVGMVs4CIZDzAlfI7VFcszxIouABoAwcvH37P0AiH18L4hlirCwWdVlf
         vtR/1riimlcyZHveafQKkaULxKAWZ9yqLw8US2zQJC3myt+gn0VNDHhpudso9SgQlqT0
         8XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664790; x=1748269590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPSK08R64NjDKjVa8ynPBVMp8t7R/JlH6tOj8tW7ci0=;
        b=IfjEWqR6QpNV6g146sFzIu4ATlQHLFhqubv911p2LfYVqqnyWjhig8Fn0Do1+x1VG/
         3xLnsy96nwyjwl+ZfO90jUCTo07rMEhGtJYLccoCb6pwGOXW+zCa2Jyt8YTinBEElg0H
         ote76aOPJCKtU3uAIbTNjIDMz6lktjqIiJYrAR2Y/08i39TdGUw7fIPTXCdgrcb4CTOn
         EJrzkw4i3zruHcT2rqLTsUZjgBHlcaSxLKQ17aOFcDkUku+oubFUL3JkycVc/WI9offQ
         Q+z3Bz3188wW5CBScWgmWWgS8SDEv2MUuceaM8+nRrrSrr1sUuHSnwxjf9ssH04/Vg+9
         wygA==
X-Forwarded-Encrypted: i=1; AJvYcCVBZqGZl2yZkYRizecfXwv++G0lAnoVvcLUO2OCiSl1SA5dWhAHOYxXxsj+xbepEeG1TqdOPHDla+M=@vger.kernel.org, AJvYcCVkDCF1VaMVuajDsmHgk0A2aWA2XUSMqWylNa+XgrNvG1L28Xiz9Ob8HUFJhwpzbfLW2ddaHxqdOpH6nPME@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4R/HQSSKuJEW9tOVj6tcO1XftaP7OnSwPnnRoACkXNTKarkR
	TFvHvF2QIlqBTUgpIZae7Cn1F6iTEwRlkki8OnWzVGJCrNd+d9D+RLrT
X-Gm-Gg: ASbGncvbjNC35NES8p25FXOVGj1qQMC15pcznHF4bG58jJ8StgfnYEFIBeCKSiwL5+T
	TMLm5bnqFnnemrAFefCfOSfNdgF+S+gkLXgLdG8BHVBjFYfcoL/RNhzFs0o0RthakYLK0HvtuFa
	DYlUIQWA9NnL5jVDaxRwGe4MrSklarygkxjAruYa2bnJZvuaMp8ydYd0hIWXbMiEiWv/5R0Mqdj
	B0XENA30RSEFNMradBuB3qCUr3/SxoMy0IsIrS1NlXmdTaJ4tjM5PQTm+P5P5a4WxnFdRF5Npbq
	mJoTlDHCvkH+i9uJIczrEYT17JXbYQlKWsfMPxj36ipCxwfEpIQOzb9L2w==
X-Google-Smtp-Source: AGHT+IHHGm0TdevHKzxfg0NYOhWmxKOpnGpfnjC0W22rUmA3Tlsa1t6XHp8PoVu6uIZaBPZXu4FN7w==
X-Received: by 2002:a05:6a00:2288:b0:740:5977:7efd with SMTP id d2e1a72fcca58-742a97eb55fmr18873478b3a.13.1747664790147;
        Mon, 19 May 2025 07:26:30 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:29 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 8/9] iio: trigger: Add new API iio_trigger_store_time()
Date: Mon, 19 May 2025 23:26:00 +0900
Message-ID: <20250519-timestamp-v1-8-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Now the trigger can simply call `iio_trigger_store_time()`
to pass a timestamp to the consumer.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 16 ++++++++++++++++
 include/linux/iio/trigger.h        |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f394933b9d0a..a961156f0eeb 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -288,6 +288,22 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 	clear_bit(irq - trig->subirq_base, trig->pool);
 }
 
+void iio_trigger_store_time(struct iio_trigger *trig)
+{
+	WARN_ON(!trig->early_timestamp);
+
+	for (int i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		struct iio_poll_func *pf = trig->consumer_pf[i];
+
+		if (pf) {
+			WARN_ON(pf->timestamp_type != IIO_TIMESTAMP_TYPE_TRIGGER);
+
+			pf->timestamp = iio_get_time_ns(pf->indio_dev);
+		}
+	}
+}
+EXPORT_SYMBOL(iio_trigger_store_time);
+
 static int iio_trigger_attach_timestamp(struct iio_trigger *trig,
 					  struct iio_poll_func *pf)
 {
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index f3b89a1e0318..8048a2c69971 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -187,6 +187,8 @@ int iio_validate_own_trigger(struct iio_dev *idev, struct iio_trigger *trig);
 int iio_trigger_validate_own_device(struct iio_trigger *trig,
 				     struct iio_dev *indio_dev);
 
+void iio_trigger_store_time(struct iio_trigger *trig);
+
 #else
 struct iio_trigger;
 struct iio_trigger_ops;

-- 
2.43.0

