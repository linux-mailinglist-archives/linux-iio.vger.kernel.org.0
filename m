Return-Path: <linux-iio+bounces-19685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F389FABC0A4
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B2417B51D
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C4283FC7;
	Mon, 19 May 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDXJxmtB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E42857C9;
	Mon, 19 May 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664789; cv=none; b=B7APpTxWEa3TNXekhVQFssFH6BKBq4+iUXEAoHMV0Kp8RyiC/YDqtNAEyhZVG8PMYW3CuG+DlJvXUCxmVBJuq8c9kwtmEAYDaNES1dP964QtggUD2B2/RKEkpgMz7RWgKsNV7J2JLki4H2UgV4SdtH0EfDKYQ928AvxYJWz/0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664789; c=relaxed/simple;
	bh=/RPPP+LhZOCwn7VKPxpog19sLuXZfd33R51o4hptkMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcheBf0HHNoun8oT2H7r0xp7z8GapaPoRUamsie0rZ8Uy500LiSh2veJ9aFP6ay6ax7rALPnNx+7tgTD+j7RB4G4ffGhzQlyAaTb4le49VUw7/G2Kv/o4QtvPXAV+wkTLmMVrsybqlZ5/j2nqKWQcKC+zcLwEPKSDYlt5Q/ieB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDXJxmtB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so1863966b3a.1;
        Mon, 19 May 2025 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664788; x=1748269588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OLcPOuf7wIYZebsW+9sYq9tDaVIjAA8Pb1YresFO58=;
        b=PDXJxmtB8KHcb0gefnnfkOLSW9dpT4vYpvZmyWVEVvQ234G4XnlYoEo3Agcbe4iOfL
         +yzbYCtK8aAAmRqhYFJw7RAVurVM7yj4Df5YKM7tPJS5FTo2yFTQNU/vGmMbrVeLy3Jt
         +dKPeC+soopgow9DweVpMBUzx4ttb7jE1JjFGdG1wkjgMyMrfMhiEMFi9BPbWk4+lQy2
         W9fDcGL/w2fYOqG3UB4oDqYkimWon4NMjICTmZmvSvrFbyw9pkitkCrfYrkJd6Z8KIXZ
         wCQ3sgYWgn3GQU3LKdl38srE2Rm2qg+8PDHIbEDQktWh/hs2prnHOOCVXimSgavSA/gM
         3XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664788; x=1748269588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OLcPOuf7wIYZebsW+9sYq9tDaVIjAA8Pb1YresFO58=;
        b=wLs+reVNkgxmB/uKvLX2aJVGiIYS/HzTjaBhsUxuriwGebiLJb1ld10N6ECafcrISB
         YUmBuaWxb6QnLi60ZL/3zGuEM4WBSEjAW5V1E98kpj11dTXcE0Gpo8J/UvBt2L+zSXeN
         5QPD4npQoGMKMU+JQdTAm9suzC9pAxOJ5Ayuy61vf3pfix+u3XSplh7MrgJ1gofCsXU4
         RPH6BtwDExUHV2+OZrN1sAQ2GGjhOCdj+y3kd9qLhliqV87+clCD9oJQNtktclLU3ssx
         Cz7onMiN1DHmUgFZiHVJbL4CxI1vxdaArnG50b93k+Os/7aERC7l8AWz3nbSmBgXPtnJ
         A7+A==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ba/sxEQgzHaxnyqIqWvjJ6ikKfZxc47xBXtGB3gRuEiNQ8M49AjTXs5JV+0T8ksFnsceLrHa6847lj77@vger.kernel.org, AJvYcCWygF1GGIf0vnMPgmDAc8SJiS3DrmXzJLDyZisyWZFw+N5AJDIYe/cq3mi96hlLL5oYuKjN8n5cshM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOghvCk9zD9fYCXPynwMYQOHGWS1+ZMOoXE9fK6zXHVfWVaMaH
	8r5h4Vgg37YSs9QvIYs4oFUuaMfXDI6ST8+/ULVc2+JNsPPP68sDQg3s
X-Gm-Gg: ASbGnctxf0LGRA1HD/b1z07KLbKVFDnrrPFaM/7UuCGQIjrteU4BDdpEZQIl63eZpo6
	pDXhLKPqmXhKWmi7ind+Gvr2WOgCIN4i6ckPBUcHNqvM/6vBHwxs7eoCM9TL2CY2KYteRk9ugcH
	crrBDlNkmkDB9nUF9pLS4lD8mXvb1ZZP02/gtf13thfICs89TLtRHo6Oa37C7vbWl1pvkgmL8Cn
	0wfXf6bQzMuXHXk7plAMKVIZJKOw9GnKUxAqfCmGeSSPvW7JtxwuL3EhqL7L4PjQ1uWCIxWiWhg
	RLaPldrPc+nTxAuIkx27qBe0KD2G9o5OfSyOUjVOz1EoiIzz+swHK3U+Ng==
X-Google-Smtp-Source: AGHT+IGzUPn/3RyJWEZm6FIIuvUJxbJaW5nf+G1KJHFf37qmTL6hLA8x+1vlGpfzdBfwPsu1dTn3rg==
X-Received: by 2002:a05:6a21:3990:b0:1ee:e24d:8fe3 with SMTP id adf61e73a8af0-2162189f499mr18239254637.10.1747664787849;
        Mon, 19 May 2025 07:26:27 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:27 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 7/9] iio: trigger: Add new API iio_trigger_attach_timestamp()
Date: Mon, 19 May 2025 23:25:59 +0900
Message-ID: <20250519-timestamp-v1-7-fcb4f6c2721c@gmail.com>
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

This new API is used in `iio_poll_func_register()` to handle the case
where the trigger writes a timestamp directly into the consumer (i.e. early_timestamp == true).

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index d6b0e1ec4153..f394933b9d0a 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -288,6 +288,15 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 	clear_bit(irq - trig->subirq_base, trig->pool);
 }
 
+static int iio_trigger_attach_timestamp(struct iio_trigger *trig,
+					  struct iio_poll_func *pf)
+{
+	/* RFC */
+	trig->consumer_pf[pf->irq - trig->subirq_base] = pf;
+
+	return 0;
+}
+
 static int iio_poll_func_register(struct iio_poll_func *pf,
 				  struct iio_trigger *trig)
 {
@@ -302,6 +311,16 @@ static int iio_poll_func_register(struct iio_poll_func *pf,
 	if (!pf->timestamp_enabled)
 		goto out_request_irq;
 
+	/*
+	 * The trigger supports grabbing timestamp.
+	 * Just request raw irq handler.
+	 */
+	if (trig->early_timestamp) {
+		ret = iio_trigger_attach_timestamp(trig, pf);
+		pf->timestamp_type = IIO_TIMESTAMP_TYPE_TRIGGER;
+		goto out_request_irq;
+	}
+
 	if (trig->trig_type & IIO_TRIG_TYPE_POLL_NESTED) {
 		bottomhalf = iio_pollfunc_bottom_half_wrapper;
 		pf->timestamp_type = IIO_TIMESTAMP_TYPE_CONSUMER_BOTTOM_HALF;
@@ -395,6 +414,9 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 	module_put(iio_dev_opaque->driver_module);
 	pf->irq = 0;
 
+	/* RFC */
+	trig->consumer_pf[pf->irq - trig->subirq_base] = NULL;
+
 	return ret;
 }
 

-- 
2.43.0

