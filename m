Return-Path: <linux-iio+bounces-14669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB561A20A1F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AEF3A496C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9241AAE13;
	Tue, 28 Jan 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eseJ9fUi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930D1A83F5;
	Tue, 28 Jan 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065703; cv=none; b=MChd8WHi5XGkiFpRgo8M8kjIMgXZHqtmpsgwp20S9akn2Bev16DTZhKkHKWi8JlMo/1LeZwShvgkyLd5AGGoML/GlMUazubLbYzHBbjdpz4VYktRiDwL6Zlj09Ex8ilEQixhrp/sNGv2YAYTbbpjT1flZHl4XHX7Pz/z3BZYAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065703; c=relaxed/simple;
	bh=7iT/vlJ7lXh9ywQynj9AdKB3+QbbMRgx59VT4fMBGrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBWpwAlXIK4b714r+tTaESzhtETfxWYV5aPwSQuMYFuuub2MzRJTo06NoKQsl9TeJSpPepcAHUNgFIuhpbZ49TmMQWF/VY8p7zYDereZzwKrDgF95EvOdRCinQTH7EdUMkFPN5+xEW60tk5Y6gHKADkutJZQA56L1QycTp7s1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eseJ9fUi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6647a7556so108045166b.2;
        Tue, 28 Jan 2025 04:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065700; x=1738670500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYYgaTb6xqvrloCELcHIlYmxEn6xsQKeUcT+235aVsM=;
        b=eseJ9fUi3FREl8Man7Q4YvndkSwTyzsVsDyEJF5hgk351LSFBL2+r9sFC4rKnWfTMm
         0LZpz1g73JmGLJBYiV3AdseLl+yuTwjFNMgF+/35s17u7Q/7YYAL7XkrYDKzo8irkauc
         +mbgCwerK0jIvcPeKaEsLtQWyNTMrKmsCpuIobVHZgSegV/tAgYuIoJc6q/Mv4fVKjSu
         FJdVnuk0RBJLWl5BlLNS9+O+ATWpzC5n8l9bt/CuyKyQWDfUkrb8h3Wd9xWyus7HFwdR
         TYGvJVVMqb3lSCGv3jz4N5dZOQMZm7wfK+PTPd3DIP5E2TQj0AJmazPoh/D1qpfsQjg1
         qZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065700; x=1738670500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYYgaTb6xqvrloCELcHIlYmxEn6xsQKeUcT+235aVsM=;
        b=wsE90n3DtRFxfGx/Get7xwLdrLjKAXTYnNnVsApsgJOmVs4XimBFJfzfaRV0y3sX6a
         N3Vb4/DP8KQ1avQh7A/kEdjOoYHMiWLcPZ0ObHyPDOi7VeVS8kon8kbSE4GdydKANZ7O
         9GIyKUwJz5AqYeRjuBulzIHP2jJUwz6yFWINj01F3Y4pyvlhIBdae7NOV2Lm34pqGhfs
         X5HKE5JC7UEnrUfu7k0nM8Y8Im8VUcEIa7s5CVNZuqGhHifGihnWMxFnkVuBRHGqOrGu
         UKQ7V543HyV6KgXdGeUgKHevzxAZIE6gYYf3TrsZAeOzhABUVkU6fsX3REzG8FYQCOkb
         xpkA==
X-Forwarded-Encrypted: i=1; AJvYcCUNVfEcw4mPA4XWHMHnBIAxqiiFT6k3rX5+c2C+66Ug3wA/BB1GOTTDavyM5Ub7tux4OydtIMNHxP//Lfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAx3mqHXTu7qYoc/uOtppAeNKDS5Il3K8DiBcDK8QKM/ZxDlw
	/ucLRdcAAqoPn9inVUOKYLHzBcbAT8zXkPbePafbohBVIPYHVFYb
X-Gm-Gg: ASbGncsMXG0RTVh+V7pCyZUQfnjo4+T8Y+2ZuaPckCBrUCIdNC6qqcf2AagYL/xOyyS
	RUEQVigiNvigGUV7oIY3KGqe3CasOLolTBY+92u89cormuydt6JsNenKK8S14kIRy6grVDU5xwL
	pZFZEZJUWeSs4bZ48XYHNtxU5qJUG9pOv7MqDmcaJylWRRh0BL8UQozTEf2l8GWwg36raijH6KH
	Xol88tc+N6HNytum0krtK3DrUZ5Dgvd+MCKYGJ/nx78hQEASN4e4TJGRU6blsooCc1a7uKemMX3
	IQmy5D4CJYjYqtF1qUljIHmp5eK6Ea4q9ZsBZluubhf+AbKljzxJDVEK5EIZFSvnGTwUaA==
X-Google-Smtp-Source: AGHT+IHtXm8zxX3d8GaRJZI0ZACALmRTB4xKRR4ZQzp337Jy5Ck26n4IZDs2S/pvWw+mTH4XwKymsQ==
X-Received: by 2002:a17:907:3da3:b0:aa5:3e81:5abc with SMTP id a640c23a62f3a-ab65152babbmr1053882266b.1.1738065699967;
        Tue, 28 Jan 2025 04:01:39 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:39 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 07/12] iio: accel: adxl345: show tap status and direction
Date: Tue, 28 Jan 2025 12:00:55 +0000
Message-Id: <20250128120100.205523-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide information in the iio tap event about the tap direction. This
can be verified using 'iio_event_monior adxl345'. Reading out the
ACT_TAP_STATUS register is also in preparation for activity events.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0d991f3ec10c..7831ec511941 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -800,17 +800,26 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 	.predisable = adxl345_buffer_predisable,
 };
 
-static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
+static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat,
+			      enum iio_modifier *act_tap_dir)
 {
 	unsigned int regval;
 	bool check_tap_stat;
 
+	*act_tap_dir = IIO_NO_MOD;
 	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
 
 	if (check_tap_stat) {
 		/* ACT_TAP_STATUS should be read before clearing the interrupt */
 		if (regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval))
 			return -EINVAL;
+
+		if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
+			*act_tap_dir = IIO_MOD_Z;
+		else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
+			*act_tap_dir = IIO_MOD_Y;
+		else if (FIELD_GET(ADXL345_X_EN, regval) > 0)
+			*act_tap_dir = IIO_MOD_X;
 	}
 
 	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
@@ -835,7 +844,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
+			      enum iio_modifier act_tap_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	int ret;
@@ -843,7 +853,7 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
 	if (FIELD_GET(ADXL345_INT_SINGLE_TAP, int_stat)) {
 		ret = iio_push_event(indio_dev,
 				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
-							IIO_MOD_X_OR_Y_OR_Z,
+							act_tap_dir,
 							IIO_EV_TYPE_GESTURE,
 							IIO_EV_DIR_SINGLETAP),
 				     ts);
@@ -866,12 +876,13 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int int_stat;
+	enum iio_modifier act_tap_dir;
 	int samples;
 
-	if (adxl345_get_status(st, &int_stat))
+	if (adxl345_get_status(st, &int_stat, &act_tap_dir))
 		return IRQ_NONE;
 
-	if (adxl345_push_event(indio_dev, int_stat) == 0)
+	if (adxl345_push_event(indio_dev, int_stat, act_tap_dir) == 0)
 		return IRQ_HANDLED;
 
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
-- 
2.39.5


