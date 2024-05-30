Return-Path: <linux-iio+bounces-5506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA28D4ED8
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9D91F25DBF
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAEA17F50A;
	Thu, 30 May 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gGRQ/DEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C82187542
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082072; cv=none; b=SMiTx0HrFFRab/C3+Nrhrmky+Qp9sj73HFli+/PABwWB4I25Pzg1loqkR7MVi+t4R+wFLG5J9biYEwephJt33kq7L/bpxtxeogZvX8A9GfeRvmND0PrE9Wn4q1nGZfkKAK7JEmJGsyRKEuOsssX2iMtoEauyPJC551d0mRtNNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082072; c=relaxed/simple;
	bh=DY1EeagIOvwFMlI+7rFTIpnLVX0E678JEXnN9mdCJIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCkFFMkfiJ3JrYAVzdok4f88LdfFvxX4eKywlFfVTNJW0ltmqX12yVxr7EdYIEWaQmWuomduNpc9Jd0rGwcGdNlLNjl0LCA6hw6mCQi9vundSL+Y7Kmdcb34en27hO45hQgwe2ohk+pTnNJuMfTaF2g6COqkGfnsyFZIXCW2/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gGRQ/DEb; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8f024a75cso570299a34.0
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082070; x=1717686870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etE6dgY3ZZdPAacneXLnj+Gq8AOjqNZk3KGQXXeWybg=;
        b=gGRQ/DEbi0NqlwgpRoPz9DSzkWT3wseQbS0BKn+LnURYP0WYJ6GZ98uOPVpWjPLmi0
         rojs1O0hCNNk0H2TrEJD9n7q3ncvmkWRVWnWHrLcXfBLhl9KpJs/NDD9qNhr4XRVM52P
         JI6z23QvLPnPa/946ltbv3FGNyvYE88dMXI/caFJCjzSp5y5U8f8lAUedEHGlFG7CW1t
         KCgLEEl646xPRVwtspYkFVcrRD6IfNJaGlF2cbDYiWLweQ3pMVeoN1YtpgpPAJlzQu2j
         HfzMTgkcwYemv6xgz1+x2ct+6UqvaDAXu6jZPjW450SFUqRSoLfrD7vq74KN1kaU1LCp
         yA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082070; x=1717686870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etE6dgY3ZZdPAacneXLnj+Gq8AOjqNZk3KGQXXeWybg=;
        b=knDhD1tNcxo8TVQI6Jcj+hbu1N4J264bI55zFDlM/H3zjM9nKkclqTW+qoEvbrxGrf
         0AUWoo3nhU9vgOJJkaDXwXDuvKHqQeIOcSZ/aBKU+IWJVI8k8BsbFLIUNzQQvXIJvtho
         72UOrl1Or5IjAom8oy/FtQNgCLQcOX5dCuWztfYbSzLObRYHHjmvkhVV1j5LjJnB3uw6
         IH8qpsr2ydHNzwsSGS9YnJoNRARrpMC+4kpzQ8XSo3WVaagWp9vSmUUdgt+ojIFs/3KB
         DmzcmEv7UMwi2SLH8ZSPTZbJ/rVhNckEZzqB1e2Q7d9itVmCbO5VaOzFop+gihZfbiwJ
         p6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRywnDw0768CBgADddhenr68nRMw5ETmHV8FXLkeCuEJdnBxdJ1Az36q4DiabliVksR4/QUOjnJ256O35/HYpDlTqsz8N4HoIv
X-Gm-Message-State: AOJu0Yyu+zUYI40MKIdYPzY32HfQUShxxRptMxvdCMPvZiGyrJn/j/18
	efFXL5pJtJqaWb3C1e+Pm/sRv+J+emz7R45tO19dzEGPd3DASzH0JNe2T9ULoRE=
X-Google-Smtp-Source: AGHT+IE/h5aelZG+YZNL4s6+2Bhy1f8X4krqjpF70XwmB1I5d0qIYdIKpDRbeTfsgSEchn0kRq6ecQ==
X-Received: by 2002:a05:6830:3b0d:b0:6f0:e71c:6065 with SMTP id 46e09a7af769-6f90aec54b8mr2744897a34.19.1717082070067;
        Thu, 30 May 2024 08:14:30 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] iio: buffer: use struct iio_scan_type to simplify code
Date: Thu, 30 May 2024 10:14:09 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-2-cbc4acea2cfa@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

By using struct iio_scan_type, we can simplify the code by removing
lots of duplicate pointer dereferences. This make the code a bit easier
to read.

This also prepares for a future where channels may have more than one
scan_type.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes: none

v2 changes:
* fixed spelling of dereferences in commit message
---
 drivers/iio/industrialio-buffer.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cec58a604d73..08103a9e77f7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -366,7 +366,8 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 type = this_attr->c->scan_type.endianness;
+	const struct iio_scan_type *scan_type = &this_attr->c->scan_type;
+	u8 type = scan_type->endianness;
 
 	if (type == IIO_CPU) {
 #ifdef __LITTLE_ENDIAN
@@ -375,21 +376,21 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 		type = IIO_BE;
 #endif
 	}
-	if (this_attr->c->scan_type.repeat > 1)
+	if (scan_type->repeat > 1)
 		return sysfs_emit(buf, "%s:%c%d/%dX%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.repeat,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->repeat,
+		       scan_type->shift);
 	else
 		return sysfs_emit(buf, "%s:%c%d/%d>>%u\n",
 		       iio_endian_prefix[type],
-		       this_attr->c->scan_type.sign,
-		       this_attr->c->scan_type.realbits,
-		       this_attr->c->scan_type.storagebits,
-		       this_attr->c->scan_type.shift);
+		       scan_type->sign,
+		       scan_type->realbits,
+		       scan_type->storagebits,
+		       scan_type->shift);
 }
 
 static ssize_t iio_scan_el_show(struct device *dev,
@@ -694,12 +695,16 @@ static unsigned int iio_storage_bytes_for_si(struct iio_dev *indio_dev,
 					     unsigned int scan_index)
 {
 	const struct iio_chan_spec *ch;
+	const struct iio_scan_type *scan_type;
 	unsigned int bytes;
 
 	ch = iio_find_channel_from_si(indio_dev, scan_index);
-	bytes = ch->scan_type.storagebits / 8;
-	if (ch->scan_type.repeat > 1)
-		bytes *= ch->scan_type.repeat;
+	scan_type = &ch->scan_type;
+	bytes = scan_type->storagebits / 8;
+
+	if (scan_type->repeat > 1)
+		bytes *= scan_type->repeat;
+
 	return bytes;
 }
 
@@ -1616,18 +1621,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < indio_dev->num_channels; i++) {
+			const struct iio_scan_type *scan_type;
+
 			if (channels[i].scan_index < 0)
 				continue;
 
+			scan_type = &channels[i].scan_type;
+
 			/* Verify that sample bits fit into storage */
-			if (channels[i].scan_type.storagebits <
-			    channels[i].scan_type.realbits +
-			    channels[i].scan_type.shift) {
+			if (scan_type->storagebits <
+			    scan_type->realbits + scan_type->shift) {
 				dev_err(&indio_dev->dev,
 					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
-					i, channels[i].scan_type.storagebits,
-					channels[i].scan_type.realbits,
-					channels[i].scan_type.shift);
+					i, scan_type->storagebits,
+					scan_type->realbits,
+					scan_type->shift);
 				ret = -EINVAL;
 				goto error_cleanup_dynamic;
 			}

-- 
2.45.1


