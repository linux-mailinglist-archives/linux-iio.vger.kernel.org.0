Return-Path: <linux-iio+bounces-19684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFAABC0A5
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447017AF0A0
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874228541A;
	Mon, 19 May 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuLTBbq5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D4285404;
	Mon, 19 May 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664787; cv=none; b=NdceuOC6ho6p2+ffqYfL0tgV8nzkcI9giHBt9XS5GQ2LVOvLELBPjAoC81X93Adbjxc/eJSlM19KPXznCRwLktS0zgcDkLxtzaH6s8+K5tKVMOpU/CNC4VVe0pVSPXx2UTKY+lGYrE91nbU4q6T/5omNoHlTGQOw63lkjsziOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664787; c=relaxed/simple;
	bh=vZ1t4A51HBNBV0vSdf2YJOMmppC2iughxgxQzwPkvts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUt83+fZJBvYF4pg3SJ5P9JvPlbXo18zSmQRSJb7W4YZ60GnYAKCWNoNpnhbbSkZ4f5VyBMRn8RCFDsgNSgMD7d6A6llKQFLyuLsBFOiKPdEWOTDYEqivqtbJqG0pOT5LK0oIf8YWTF9FAV+cS4kLQy25+S8HcK5p52s4JfI1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuLTBbq5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74264d1832eso5835373b3a.0;
        Mon, 19 May 2025 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664785; x=1748269585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPZsREccUdFYIK4k967V5KtxVftBRfR0ix29sWoMslc=;
        b=iuLTBbq5dOgPXbfpvO7MYE0jpVkXIQRvexcXYmqeSUGLyXgQR4CRXmoA2VGYPFPpWs
         ZOU8ONQO2ihIVwUeJYxoAMA+pQmFlkEY972BYp8ehP5PM1ArKhdSBVsjtOBbqUUmBmbU
         iVi6eKPOeqMGfAxSUP5lz9UEdUZ2jhLx3id9jTCgy6XlI6T/5trU7QkRg8ZuW28ra7ww
         /6iesEauCO2CLL8SqJQZDU0PLT8HUPxyrY07AlsCXoFwk6QmthEFt6cQmdwCH3PD4Z5/
         WpgZbgO7xQ7vcYzoazQUCDu+2ErxvMMC3i52ns45aaaTb1kcYPisAWpUR9ucDNXhJnzN
         //gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664785; x=1748269585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPZsREccUdFYIK4k967V5KtxVftBRfR0ix29sWoMslc=;
        b=QEuKmDZQmvtOLP8y7njr5mv1vFDkst+ues1XJgjCy2SIdvpQlkKJ1WfrWfF7P64B+z
         QVtJt/nawGd8sr6Eg8Mtv58y31ooG6U5e+5L+qWkyzXU3nga9W8Kamyzq3wvDekdrYeJ
         pkFeKTX7evwtIMD5R46ruuU3SLs7nG9Rh189HH9H2Hl1rvzK2l0/2zuvkClHogi+D2Lo
         AR8yjK0eDy2Zmd9BvGQ615J/9AzA7pgH6ogRc11TrJzSVZhn9COZD2vxe/+GnlsAzGFa
         DCoZhG300nVmyHIPKChPfuwfs5HwTntHM0v26+r0JC3BZXOcAuVe5v3WvVDjLnBNhVvN
         Znjw==
X-Forwarded-Encrypted: i=1; AJvYcCV1nUYHc8ruxYuvnCuADiCl8MrC0ms4LSx6w3Tqks1htp2agyWmmxtq0pFr0UUAu3yDNvCejb/Os+A=@vger.kernel.org, AJvYcCX8ckFAWmqlWsFeWYM8A5Q8PqT02l2SwtJu5s67Kn+0BM+96bVGc+pOwwQVmL2MDBrMmc9XKJlsb2ltsjJo@vger.kernel.org
X-Gm-Message-State: AOJu0YxepjgH+RKm3+zoIDD0racrboYj8fzVumIeYrAYZyHFBJgvtNIX
	9AfT9iPe9XEfuP8hSHv90Qv7XgNPvAMYtv6XwV6jzArv87cjCSR048LP
X-Gm-Gg: ASbGncs4WmHGjKLBwtwjzS15UXTtYWmWHUnrxJtNk7KbqFcwAactIxkkWKaUYkh179T
	JWefldnIffwXJFanNbskPNiY7YS8V4cnTP8khsHqxbg4br1XFWwnCrXMqOL8zA/IVCUy5oe6ax5
	aOU3S1r3xMX9mHkYOJNBScIAxHLIXhGLz5DfjNACxvCrbErGI1INnTeyMQTfLnC1iBok1wnkzIo
	IXAKMbc6TddGavSIjJ4Dbi6KVAkx5GwKZi2F1JVKmRCS9Ke14J87dc2qWuel35cVnLTiCYqBF+w
	HQ7RMRftbBXc5H2jKRj+0mYhmsLJskEddxR0HlOw3t9RXTPF8RM0IQnfhw==
X-Google-Smtp-Source: AGHT+IHegutPpp+7Mq2QigLGVv5E6x4Qai4KUmb/XahCPIf3K57/IVQkrVmCbOtx0FZLO6yMB5m9LQ==
X-Received: by 2002:a05:6a00:919f:b0:742:a82c:d832 with SMTP id d2e1a72fcca58-742a98e8fdamr20168635b3a.24.1747664785410;
        Mon, 19 May 2025 07:26:25 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:25 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 6/9] iio: trigger: Define timetamp-related structures and constants
Date: Mon, 19 May 2025 23:25:58 +0900
Message-ID: <20250519-timestamp-v1-6-fcb4f6c2721c@gmail.com>
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

The `trig_type` indicates whether the trigger calls poll() or poll_nested().
The `early_timestamp` indicates whether the trigger grabs the timestamp at the trigger.
We need this to prevent the consumer from overwriting the timestamp.

To allow the trigger to directly write the timestamp into the consumer's poll_func,
add poll_func pointer member to the iio_trigger structure.

However, I'm not sure if having a poll_func pointer member
in iio_trigger is a good approach.
Would this approach be acceptable?

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 include/linux/iio/trigger.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index bce3b1788199..f3b89a1e0318 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -36,6 +36,10 @@ struct iio_trigger_ops {
 			       struct iio_dev *indio_dev);
 };
 
+#define IIO_TRIG_TYPE_POLL		BIT(0)
+#define IIO_TRIG_TYPE_POLL_NESTED	BIT(1)
+#define IIO_TRIG_TYPE_BOTH		(IIO_TRIG_TYPE_POLL | \
+					IIO_TRIG_TYPE_POLL_NESTED)
 
 /**
  * struct iio_trigger - industrial I/O trigger device
@@ -56,7 +60,10 @@ struct iio_trigger_ops {
  *			i.e. if we registered a poll function to the same
  *			device as the one providing the trigger.
  * @reenable_work:	[INTERN] work item used to ensure reenable can sleep.
+ * @trig_type:		[DRIVER] specifies whether the trigger calls poll(), poll_nested(), or both.
+ * @early_timestamp:	[DRIVER] set to true if the trigger supports grabbing timestamp.
  **/
+
 struct iio_trigger {
 	const struct iio_trigger_ops	*ops;
 	struct module			*owner;
@@ -76,8 +83,13 @@ struct iio_trigger {
 	struct mutex			pool_lock;
 	bool				attached_own_device;
 	struct work_struct		reenable_work;
-};
 
+	/* RFC, exists to access the consumer device’s pollfunc. */
+	struct iio_poll_func *consumer_pf[CONFIG_IIO_CONSUMERS_PER_TRIGGER];
+
+	int trig_type;
+	bool early_timestamp;
+};
 
 static inline struct iio_trigger *to_iio_trigger(struct device *d)
 {

-- 
2.43.0

