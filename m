Return-Path: <linux-iio+bounces-24672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313BBB4E9D
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A01C172728
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8FE27F18F;
	Thu,  2 Oct 2025 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO62vc4I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01808279DC2
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430538; cv=none; b=hzZZed/rM2qEkldJxAamPV0EkCpodiFloaowZbqOeFusc/zn7yzM6mqNgmWnutm4L4Nzp8akzdTqNO9MGiotqQziWnzF75T7n5EpT0aXADu2XtqIBmvaE9Fdm99768khCN249hk83XtKgRUwj39WiKzlLb9YX6hARsgoFNVbTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430538; c=relaxed/simple;
	bh=wujo6oR6KRs+dKd5VCfSi/HrfuVzG23TWqKEr0OV7js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2LrQqOU1ZmiyGLE4AbXVOvLOJmigDcptnHOTDjRnDZSx6xtpkLydSdKRH2FW25ADEcyflzxR7v0AJhvSOiV7plbskW/tpZ6xNbURQNHrFL+bg7jK0k6IMRi+9vldwbPDG0A6LZte1X9xVbWS0WcevtniN9lRUoAqDJQ6mYUntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO62vc4I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7810289cd4bso1445565b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430535; x=1760035335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUZYODvSV6S3UG56hxwOik5nzkLbs7prF1klJbRcNxE=;
        b=KO62vc4IrA5cqetuPs23pSSYMP/d6bFJVYX5tuZjUpeyyaYmyxpDm2b/4w0ZnhEBIZ
         kqAkSTpqhU5cWj/MsHd7Wky9RPkPxyiF7IDMQFrMUjXzFlv0PaN2imQqSnXDGgL9acFf
         CwPiignzd+Wx1Eb9UMuOZGfe9eVWcsFnIMKUTKA9J1BEjUCIudaQdIcVGahuO6dOSeD6
         u+Xkr/GHnxJNNTUTWrD7S6lj/5hWCUG2ghwy8EM2UzIUHbJUHjH0IwrfZET4KtRJx7IV
         Si8m8jk7sxt2EQGrYKe8zQ3kxrJvL/yrbxAKVW7q6O5ZW9RkUq478oHkTuy0K610DHQp
         Lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430535; x=1760035335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUZYODvSV6S3UG56hxwOik5nzkLbs7prF1klJbRcNxE=;
        b=YeeGfW5onwGwQmC2sjcbbKWvo/A96z5FwYGM5iC5PAlKp1HHcjq4oJVPTgH4hg6HrU
         wocdDDwd02xpqP+dUwzzGSaAWfHN2OzKJhiBSefNjtGs0N4jsB0PNF0JTFaK7qyIWAPq
         mofkxV/xZfc5V7UcS3KrbwRjCVXSZFS6SUBV8tI1R7FSqxgevqLXbvV/m6hxPOskrgXn
         2LACh9ouFh/DVznOZa5Pu0FgEw9ZK22bh8lwXjAUvzgoIx4swgNy6EmzPZPNc43F/ovn
         /T5lgNQ3aCNuxxnIPNK1lyLU69b5z+tdjpI+gQ7Vz0q0A4gUBLBKtbh0hLeINbytZrS9
         UCSw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4GxjkeOCRuimuVpZiwSncUvsdtJ6XLZgWkqD2BitbFc6f5acjtBcis1LALFNigp13D+PDXTJV0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhi7REt0J9tHaxTCHJRo9hY+veAqOb+nqP4EdaLuBOoy1OU6S
	VROFe2eG0fg6IuW23FueR8c5dmkV5rsWdLfR09mBTd8OMrGOVIM1zn+T
X-Gm-Gg: ASbGnct0TY4zkTvfxT7K8DlFS8kAHaFj76LNpYDmYFZ8U/k/x8LkpfDR+xOJZGiSG1b
	GpzkTmPqPs/7vGzWZrDytd6HDwFjP0vLMGZ2/Cr4qbPU+mBWSDGm/Id8+o3mNArB+Iypf4D+HTF
	LKQrLbKsKBalt+876emZ5iXprjsNBoP7dQfVi6t3Ma5jutAxzv7/Fqqwc3rSkk8fWmqUm3zFDyt
	Ds5Y8cqFPe3aZ4+KdKD/WB7G3Sp1KpJ1dVH5qOiHHEXQ0IshSNuCphthTsKzWreiR9WU7EYEYCp
	joOsb9T5wxs12hu5h6Ydx72+bdeo3ZKY/3YaIend6hQRpx1d9OmwhsCwqY/saHK8RcDjasfuTlW
	QophRGlDJNAJCyfYFHY3dr9t/K3+1r1/6wc0/L/z062tXba74vXGBgjZg0OFT7yDEzMc=
X-Google-Smtp-Source: AGHT+IEP2vjy7P17pql5sZfYw/KjKSGAfQViyYu0lFY3uTuOnWp8xnin7dh+GmQxvjNLW8IZDmVSbA==
X-Received: by 2002:a05:6a20:72a3:b0:2be:81e3:1124 with SMTP id adf61e73a8af0-32b61dfb9b6mr569531637.2.1759430535216;
        Thu, 02 Oct 2025 11:42:15 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:14 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] iio: accel: bma400: Rename activity_event_en() to generic_event_en()
Date: Fri,  3 Oct 2025 00:11:05 +0530
Message-ID: <20251002184120.495193-5-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function activity_event_en() configures the generic interrupts
GEN1 and GEN2, which are used for activity and inactivity detection
as per the datasheet. The existing name is misleading, since the
device also provides activity change and activity recognition
interrupts. Activity change interrupt is not supported yet whereas
Activity recognition interrupt is configured in a different function.

Rename activity_event_en() to generic_event_en() to better reflect its
actual purpose.

No functional changes intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index a0e994f9882b..41e95291b36b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1190,9 +1190,9 @@ static int bma400_steps_event_enable(struct bma400_data *data, int state)
 	return 0;
 }
 
-static int bma400_activity_event_en(struct bma400_data *data,
-				    enum iio_event_direction dir,
-				    int state)
+static int bma400_generic_event_en(struct bma400_data *data,
+				   enum iio_event_direction dir,
+				   int state)
 {
 	int ret;
 	unsigned int intrmask, regval;
@@ -1337,7 +1337,7 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 		switch (type) {
 		case IIO_EV_TYPE_MAG:
 			mutex_lock(&data->mutex);
-			ret = bma400_activity_event_en(data, dir, state);
+			ret = bma400_generic_event_en(data, dir, state);
 			mutex_unlock(&data->mutex);
 			return ret;
 		case IIO_EV_TYPE_GESTURE:
-- 
2.43.0


