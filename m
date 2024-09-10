Return-Path: <linux-iio+bounces-9421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95197289B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 06:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508741F25019
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 04:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF6176AAD;
	Tue, 10 Sep 2024 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeDn4jKP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA0170A18;
	Tue, 10 Sep 2024 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943903; cv=none; b=b2Bd/+ZMnm49ADG8lsMXnUbvtvF53B/W92hOEAJPC42DJs3jaukGewEL3zhst9c9xlZAdYTmA6YkcsgUL+ncGXNNYUK6I1zDAK+I78KD8HNPbj3VZkpf32gk5cdG8nskYe8ppVDLwIbToznLvrK4l6IPzGcBIrb1+GaDSiqgWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943903; c=relaxed/simple;
	bh=ZY51vahykKTtxNfMnqXqfEr+7j9AXVcEUZUVgG8ugUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC/oP7BzICXZhyF0Dh5BhuiR6aA9Ik1FC0t9HdlB9IaDVp4FWNbuzG9/e3R3mWaEWyW2vtJVWMrkHTjo+P9bIvoo9QJel/5tfSvOGhThdcI8wc2s520XSAcLkz3tNL8PMzCYz/eowEllnvowPMK+tUoCUBDwZz/3VMEqINZzU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeDn4jKP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-207397d1000so10768905ad.0;
        Mon, 09 Sep 2024 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943901; x=1726548701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq1aRor6Vaho4Co3OEdp8Mb4+CwARpFfzv0gXPyBQ1k=;
        b=jeDn4jKP9HWYva4/lA0ilQj/HjRNLvj6Z0QRMArKHA2Mqp6RJmOzzjjdKxiAXdouP3
         7fd9L31o9OSDWbiXYqc5RHkI5Fa2aq2323nEllgQKCzCcHUgQWjUbygqj+Lmji5db/GC
         p2h0UjpzTzUsLuy2HYTvX9sEJ4JL7FuFRDw2pR/Y1ZysZ/ry/zqL1bJE8ru55b4aHjnT
         rW4PV1gR4hlmYgHy3MiwxpcskRvODzCiKx59FFWcstF/nuEwb8zBS6OjoR59RlNnyBTs
         oJkccVRsFycFlrke20uUiOyKbKQlvmNLuA0tN67KaZVvmw1nninL1HVHvpmgSLUmeyC2
         5YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943901; x=1726548701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq1aRor6Vaho4Co3OEdp8Mb4+CwARpFfzv0gXPyBQ1k=;
        b=gF8Q+ZjMGCBb1Cwt/ZrnTG4oYLnq4CdbRNUicVZNnfBh4ChAL1JGjS3ZusZSfEiE3B
         5y2lVDV/LYJW6rIzYa1XHrPgfLGjyF6XJDOsUIJe+wNrvg5mHRIKgy/dYH7PSmJel9Xn
         qF46n86vEkTGCiEmw3kd8ECu6IhQjk9vIpffsgBryW/h5xvp/ZWBB1VZpjAFwejkVdmi
         ZdAj2bA3Bx9a4nJwS+hs254VuvXj5wuLy0YlsfAK57E/TlaosIbpzlodL9jxtTWV3QoK
         3xAEYOc+MWMBAIQ8Tv6DxkFJaGTuV5m7Chbtvzoc5gZ+OXnwditwTQ+zDxEOzdWjrOqX
         j6LA==
X-Forwarded-Encrypted: i=1; AJvYcCVSMoWiYa5okSGxqReSPwXAr+vb3n3CXylLlakI6VcqdOyX8hiMbff9w8LPXS3bG4VPlu/Kv2Qfb/XzFEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrdLb7XVzbuaha6AHdNiiDaYmjagIPR+BZ7Rqfsgbp+3tbYBD
	Vhbz/7QN+7KANe52P7KSrpGuj5xI+XQOJgpRu3i2xIi4mUo/449Ud85strrhIN4=
X-Google-Smtp-Source: AGHT+IEZFwA12SIFm4/ZJZb50Z3cGWmZmxx61tP6cOq6CPke2qTl4zvd13Cb4Nu06pNhKGdVa2HUWw==
X-Received: by 2002:a17:902:ea01:b0:207:1845:bc48 with SMTP id d9443c01a7336-20743c55a5dmr24473455ad.30.1725943901018;
        Mon, 09 Sep 2024 21:51:41 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710ee70a1sm40882965ad.121.2024.09.09.21.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:51:40 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 2/4] iio: light: ltr390: Suspend and Resume support
Date: Tue, 10 Sep 2024 10:20:27 +0530
Message-ID: <20240910045030.266946-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for suspend and resume PM ops.
We suspend the sensor by clearing the ALS_UVS_EN bit in the MAIN CONTROL
register. And we resume it by setting that bit.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 73ef4a5a0..c4ff26d68 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -432,6 +432,24 @@ static int ltr390_probe(struct i2c_client *client)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static int ltr390_suspend(struct device *dev)
+{
+	struct ltr390_data *data = iio_priv(i2c_get_clientdata(
+						to_i2c_client(dev)));
+
+	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+}
+
+static int ltr390_resume(struct device *dev)
+{
+	struct ltr390_data *data = iio_priv(i2c_get_clientdata(
+						to_i2c_client(dev)));
+
+	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
+
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
 	{ /* Sentinel */ }
@@ -448,6 +466,7 @@ static struct i2c_driver ltr390_driver = {
 	.driver = {
 		.name = "ltr390",
 		.of_match_table = ltr390_of_table,
+		.pm	= pm_sleep_ptr(&ltr390_pm_ops),
 	},
 	.probe = ltr390_probe,
 	.id_table = ltr390_id,
-- 
2.43.0


