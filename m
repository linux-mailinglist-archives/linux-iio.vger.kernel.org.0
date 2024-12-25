Return-Path: <linux-iio+bounces-13797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D89FC63B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 19:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F518832FE
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9631BF804;
	Wed, 25 Dec 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8x0+iBJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77F1BBBC9;
	Wed, 25 Dec 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735150429; cv=none; b=e07b1iUmvN8fZ2+ohL3xRzovPyHsxBxbNPt2MuTiwsvaKR5F+1Lg8hiKmaeMMfkv/Mp9KBd8Fi4L6Y1DLORbmnKtgUQynLRT2RhJy+WCXB7WVodrCbaRJPi3EJfrHj+Qi2ixeA5j4cFC/HNGaTxtZtiinjHS7U80QB7OULh3bEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735150429; c=relaxed/simple;
	bh=wo26MPasJSxpEXKI6bj/8PzZDxtrQwJnBbZ7PVj6Dxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXQNWbb+xU6dc5kPZsquQpSbL55oO/GzIbVhg+osX1KO6ZRAoicken8qMp1jpyyTrJvkTjoFIWt7drzHVuATRYx0knUPVbe8shQtjvUC3cApaYGeqQxfeP897iPZMJoS0k7SeL7GWyD71fCmH4/lcha2uv6qnbJtO0lEfaREJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8x0+iBJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so1183740a12.2;
        Wed, 25 Dec 2024 10:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735150426; x=1735755226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVmzYFglhbWVJo29AKC/1HcZCKPPQeWX0Z8Su8VQcMk=;
        b=P8x0+iBJILNHMDrKCJUKcivuRrCZ+vRjA44Za4DvhPiUC8j7UGAxeBNvQE7C/EjPNn
         pg/dddas2/AxqSzgMEFYsuLiJ+lKGIOzThkX/M04DvW1tBkX2KfihI2VU6MlmVo+cL/O
         EvMvpn4U8SF7HVXuqKUlSIRuTcVHOZEpHweEdMbk3bUYOWEmTO/RyqMWkZlsnoxGdVS9
         BHPM1O4hnBPftKhWohG1yoGQxAF/yGcAIeH7Hr65W7tVtfLAlFXZB91TMKSRquT/HELz
         HKrMNQlGMUUfdqZscqDnhWKsEmlgCCIK6mmhrdNglOTA2S+MsaA6d2jGy0xmeacJjVBy
         FPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735150426; x=1735755226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVmzYFglhbWVJo29AKC/1HcZCKPPQeWX0Z8Su8VQcMk=;
        b=a/ciDUFtmjEDxvvolVJPvQ0wNZiYPyhLMax4SuWPjTp8dN8VHQZh2iVxJg1t9SF2FV
         ZtzbCPqsyfLZeuI8OhvNk9qS9Qpg4vevgif1afb0Lh0L+U0nhEzZZOoUTpYUcXHNK4Yc
         5k3L/A19K9vfMxZQK+U1ehYqF7qr9ADu8c9g5KT7u5oI3D4QhecB4M71ZHg9O3vfRf5Z
         uso7AJ01rQChfKL+azBNF9KBNUZktqDUggMA0oR/NfHbEJ9d+HQJqyU/LiNNOALAV/PP
         68eYJlZB2de/4Uaq6F8smXcUN+q76oLeGuwG0ZSsRCVHU3Qu6ETy03tz6YRfABhsiktT
         ufHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgryrAfUkVEJoUpO9/r9udDZhWroI7HB7Ff+3E8SrKksAZHfXA4o7O8bmdld0syCLbthSaqlqCPlqMYJa+@vger.kernel.org, AJvYcCXXKop9CJWezVadmUWIclyLfq02lPtuVpsglvv1dmWY2+qNE6khGOu2xrEtoedhtc55sbOUHgNPCLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPhnwbhyWfMaS246TMc8i4q0/fzlFW5rQicp9wUMe90KPeglh
	hSoYzYjqhq0VmbNmyFPLVVnrrk4jN8ZWKD062iY2nG8/xC9owO8QH2XVmQ==
X-Gm-Gg: ASbGncv1xBthqixtw/CdDZfDcW2Zlxbcbz2EnSMbRT4ciPAXOiJ2bjKSQdb0hfiYlSk
	F575k17sKQMYsm+mqRjxze2HpDmB5Q+/QL2vbaojgx0CRG5jtBwg8I3sownZc90/PNQJumN8aEX
	VxeuDTNzRg0Lnqzk+gnvNl8tbFb4gcWS3hWawWd23w5+g2pfBxfXwD8tqikzrps8xujsgP7zxK0
	MZ2bz9iarl/rP/Z3CmVvCagEZwoWuLeT8h++1UsmZHG7jL/Z8lhW6TjbIAoAPyiu9Le+SpYe9Z1
	AUw1gk8O537Edn9DtbYkCLyMNpoPNsfDsOY=
X-Google-Smtp-Source: AGHT+IESkMO0HKzi6Lf3GyzkrmBPK7xs0U8xmn0IEeqxlLAk7HfjldVAZ2+pnBW9qIBBVn7sPEfsAw==
X-Received: by 2002:a05:6402:350d:b0:5d4:35c7:cd7b with SMTP id 4fb4d7f45d1cf-5d81dd8ffb2mr7601691a12.4.1735150426501;
        Wed, 25 Dec 2024 10:13:46 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm7721141a12.88.2024.12.25.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 10:13:45 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 1/7] iio: accel: adxl345: add function to switch measuring mode
Date: Wed, 25 Dec 2024 18:13:32 +0000
Message-Id: <20241225181338.69672-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241225181338.69672-1-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the powerup / powerdown functions by a generic function to put
the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
several features of the accelerometer, it is recommended to put
measuring in STANDBY mode.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Please squash with a3fb9f5202c3de0ca84848a475f59a0e0584d9fc

Just introduces a cosmetic simplification to the already applied
commit, under the same title.

 drivers/iio/accel/adxl345_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b48bc838c..27d70a1f0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -153,9 +153,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
  */
 static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 {
-	unsigned int val = 0;
+	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
 
-	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
-- 
2.39.5


