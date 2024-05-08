Return-Path: <linux-iio+bounces-4885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364308C0180
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 17:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674451C24166
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420112838E;
	Wed,  8 May 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc0wP+GV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2A84D30;
	Wed,  8 May 2024 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183657; cv=none; b=ng4piZCcr9vojFtdunavv7qKCMahMnBW/tbw89UndgHq8Dt1vTOY7MpRh2xCEwezcO1tx3UVlKO4bvdeocTitbSWvz92MzCLKxuIWJbZfaTpAYuRYvqrSjw2B893j2gdjX3b0X06CfQMnjMnnNDYlrcFmUfXbuOgbEngW5DgyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183657; c=relaxed/simple;
	bh=Ew5dmPZ+RT1+yxAGE3521IVcxlD9Bk2UpRemXqAaf8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V1L/g2OOUieB+xPFYXudzaCEQja7ot4rPq/P71HvuVWZuN/IpEjZ7gSGrFio/af58kETCb0q4py7P4cu8C3Ym2i6g1NZecaI7nJQx+PKTPglCZwIBCjj7iZfQYNTT6rwvFFCgxJOMUDjIXu6GV+TqCQs3BdwUYY9N/gDOxH4Thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc0wP+GV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a0168c75so1204348466b.1;
        Wed, 08 May 2024 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715183654; x=1715788454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cln0XHavbSCYQSNhIzrP83D1DhQuAwb+RqJP98JjwjE=;
        b=Gc0wP+GVK0Z8dlacjwC/88h+CkOykyuMbtn8Q5J4I6QpEUd5pvXiCIzRViAoU5ekU4
         H0ZkztaFM+8vQIeVpt0J7zuVfetMZfL39BGUSEjTkNot9ImVHGy+jq2RnGl+1MFizY2y
         iNorXtar79tvnTnyiqa66MstmG8tt9cE+i+wbnxAtq40dMR8oCgA5G2lVTjpkVpsfyiV
         A6fNgcS6nMLnZbbx07MicYgvhNRyMuiJOJMI3WU2ms1jlXN74WlMn/x1++mCuwHJ6kvW
         XV1qI/eWBlANfpS9Gqv4+oic02FrggH+stzIE8I/3eNSrf3HV9OnydjnqbhRtLdQQ/uV
         N2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183654; x=1715788454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cln0XHavbSCYQSNhIzrP83D1DhQuAwb+RqJP98JjwjE=;
        b=QC7oa63uuMvYRmh9LCpIpLlYEuxJ8IgrBpf7w5oLSWF4QsMht+EXmXCWGJoV2EDyAO
         zv+aiEKHYZJdJtSKVLG1fRCSnf/rzrH/4sOd8/evR1AGG+bZQaKPUB6DLekOQABhwy4v
         a4/QclkBwAK9ogCil5tvN+ZMlXRYyCYh6TfTqE/UO1/TNpmKHVHK4zesC59bboXTeYwx
         J6VfnxF1mf40CFfYB2b879dBb6gDhg1u0r1PhIv5wHCYj46hIdSi0kQxFwixfxYgAsYv
         82Lyb/hm4pye5ElomsSOcYY52PTF2owgTAzwv2iV4DbNyRKPKZsnyNax0DNHfY0AcVZa
         zcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiGmZik+o4jcXpXL4IJeUZyqLc8fOva9XgB9OZHfteiSsI0xOG0e+98ZZda+hCEeI040fIZTZyW/kQm26PsNvv9j9HPzG2kEj1h9EYTaggA8BTSFzEtTmj1XJKF8tc9IaiSReH63GP
X-Gm-Message-State: AOJu0YzuW4msY3q0RXQVT3CBRf4ehu21dVdnPonj8LLe4uAnMpsdU1Mn
	TA0/8lKrFxdigcsOo8379uhcshXsJxG03vHTrGV9RPVmlkY9nqrf
X-Google-Smtp-Source: AGHT+IEidUUp0RQd1l7RwffMdcN0v+6acyb19SLGsg0PhE+Fpf7CeEVmqx73kZy9vhw1WfheOPpbyA==
X-Received: by 2002:a50:d78b:0:b0:572:7e9f:c124 with SMTP id 4fb4d7f45d1cf-5731d9b62b9mr2071405a12.9.1715183653814;
        Wed, 08 May 2024 08:54:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id v21-20020aa7d9d5000000b005700ef75274sm7699628eds.33.2024.05.08.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:54:13 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: jagathjog1996@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH] iio: imu: bmi323: Fix trigger notification in case of error
Date: Wed,  8 May 2024 17:54:07 +0200
Message-Id: <20240508155407.139805-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of error in the bmi323_trigger_handler() function, the
function exits without calling the iio_trigger_notify_done()
which is responsible for informing the attached trigger that
the process is done and in case there is a .reenable(), to
call it.

Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 5d42ab9b176a..67d74a1a1b26 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1391,7 +1391,7 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
 				       &data->buffer.channels,
 				       ARRAY_SIZE(data->buffer.channels));
 		if (ret)
-			return IRQ_NONE;
+			goto out;
 	} else {
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 BMI323_CHAN_MAX) {
@@ -1400,13 +1400,14 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
 					      &data->buffer.channels[index++],
 					      BMI323_BYTES_PER_SAMPLE);
 			if (ret)
-				return IRQ_NONE;
+				goto out;
 		}
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
+out:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.25.1


