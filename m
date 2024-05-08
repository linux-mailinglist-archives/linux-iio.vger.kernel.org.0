Return-Path: <linux-iio+bounces-4880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB368BFE25
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EE0283838
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184B84D3C;
	Wed,  8 May 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFFmNANC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F67E573;
	Wed,  8 May 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174003; cv=none; b=NJ3Flk3fI7X19k6Pgdlv5X8HDtX3rUiPlBYwqZ/uVRY3um3XQI5i429P2l3RLt1qpLcv3yp66jGG9IylpJtvFjNjxwfSLlQxwmUVmtJFMRO7BpzKKIZvU6oTMyNrzGMPj0RroPsIkS1SsHcGZrKwqX0nPiVT7M9rVGehBzi4KlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174003; c=relaxed/simple;
	bh=8ZjEBstzzUZOFpwRTIZ0cxsULvTEL6ice7hRMQ0ZpJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abKZ49nEwJcJ6XuUCjigUKYW1Jzh5+WNHwYE0ySuQqSdKZ4tdalWHkI13dv8fWQvtEn83SzTGbG+WUf5Y0HJeJDoISMHoN2iZuEkoEyawzd71V9iyZdLGTThIzIlNY5e/ikUc35jHGPC+fbIUiYJEV5Ev7wp8KKtEn5P3tCRf1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFFmNANC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so4727175e9.0;
        Wed, 08 May 2024 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174000; x=1715778800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsLyyy8j5G4b/HhLyl+d8G98qlBv+azGHzBJ8yf9oS0=;
        b=bFFmNANCNgF5TbvEdv5oCJCsMtbxaiFSCgqb3J1FmYYvajP3V8nU+U7TnuJz4WjRYT
         sfzNg2GMJ94HoBT/9iW5IgO4EIROZGqWfexjYv+Kw32NESllTaFN867oUoxPTZ3Bx2Ma
         OOYxl30qLlVU1JxVqwmYZyTQnY6m/tdJtgJlPQptuxzwax06VhaWCSr6zrrr/hkNjxuL
         ShQ8nt0LPP9hcJdELk7UtC5B0+3hi6k9LEt62rWoHCqnHYOBb2Y7z66gbTeSz/mM5zGK
         CflEGrRSDZ5/Id3djQLsa7ru3PiqU052P/MriCVoEtKGx78tAWHtnBIed4GvRL9zCTs/
         TZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174000; x=1715778800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsLyyy8j5G4b/HhLyl+d8G98qlBv+azGHzBJ8yf9oS0=;
        b=h4mmQMhMewBKQEujG8avTKCzxba8OAyf0e+0KdWl+uON+sc2iN88uYXfz0hkrcAuiR
         nGxK9ibc7cgQERktw35jRsbr2rM7XpR5wAUWaY0Qnzc+POt6jM5qyTxJEvi37CaFAvel
         aykZkPvxzlBaYpu0CBHSUTgt+tyitf7aIhIrtWVJXIVnXl9kDKsSBqcAwMuphXSuSV95
         IAefJotSYIRbrvWoxkpSUNcVJIJbwx8O7pqTtoa5nM6iFr5pJW87+F+eUzmxL9z4LTQO
         ixcUsk1bkoLBWiXcJO9H58da7KvZBo1JbtYaXzvl1Tf6YO7ye0J7t0g/WsgL71HWJW+9
         no9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQURVbgnHmyx8QovJ6jAWiyMvyCYSmgxvEIu1+bI4cb2I0Bg3FUMFeQIEts6sea0o8mGMkHCTPq91YTu5M30WwU9yopikxulZWM92M3yygv+KJDecIriCFUdkkEDea3NUws8kI+A==
X-Gm-Message-State: AOJu0Ywqc/RNN9iu4/ZTMrRLapqMuoecbw2N/maQzAZ/G7LYBo1mAalI
	6LEJl8nirAYO0rZpocKu5RO8YoRPOhw6y0ZXwuTxXN/1rCA0nngMkuS0bFsjzBc=
X-Google-Smtp-Source: AGHT+IGBAQOQZLk4a7tBOUwzCp9618SLe/6YH6bUZ17GIF/ysZSxDbA0iVpIGLUIQYGLS22WG2YAGQ==
X-Received: by 2002:a05:600c:3b0c:b0:417:eb5d:281b with SMTP id 5b1f17b1804b1-41f2db24c81mr51179125e9.17.1715173999743;
        Wed, 08 May 2024 06:13:19 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:19 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v2 5/8] iio: imu: adis16475: Create push single sample API
Date: Wed,  8 May 2024 16:13:07 +0300
Message-Id: <20240508131310.880479-6-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create push single sample API reposnsible for pushing a single
sample into the buffer.
This is a preparation patch for FIFO support where more than
one sample has to be pushed in the trigger handler.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v2:
 - no changes
 drivers/iio/imu/adis16475.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index f9455ecb348c..ab955efdad92 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1249,9 +1249,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	}
 }

-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+static int adis16475_push_single_sample(struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
@@ -1340,6 +1339,15 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	 * array.
 	 */
 	adis16475_burst32_check(st);
+	return ret;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	adis16475_push_single_sample(pf);
 	iio_trigger_notify_done(indio_dev->trig);

 	return IRQ_HANDLED;
--
2.34.1


