Return-Path: <linux-iio+bounces-10711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554429A3B30
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38EC1F23FC5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD57F202F67;
	Fri, 18 Oct 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZEfnDiN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D420262F;
	Fri, 18 Oct 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246625; cv=none; b=GrUVR+ODjW5itMpvAY/1oVSM8yl6FR0KPiFiuKbDw4CBccfzo28g9LCcqcArknAbMqixfFP8iNHt0QeEsluPdC/P6k6DyiQ1EPCDaMEYGoZo5JezUpAl5mwUkowfbNXEP6n4wxDk3C+hdZYRbgJo7wYQpCKXtmMees0rJJyfWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246625; c=relaxed/simple;
	bh=zPhyRDG9F+zgzh0+HIEmtXBb7OQBzROgLZ7mJASXsvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ji5U242up16IbWqr98Ru3+w63BRvhY5UEx1DWRFW1F1Sh8plnkqO6W/vIdw6/7W5RXHl2VG3r3se3+VrfDcY7NBVuvqHwENvT2KC2lFa0oTM+HT1BdUrF71l/c2NLUL6VNNpWMrDA1zNsrkJUkils3uwwzSTJolwgRtinY/qHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZEfnDiN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so19132635e9.3;
        Fri, 18 Oct 2024 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729246622; x=1729851422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yg5C99O5lFsD3GMjKIKiUiVjWoF4T1zlBP/PbUaocsA=;
        b=KZEfnDiNukXZzeCNsmYRTFp4l+1S0hhJ6MZA9fycmEXMwCOd0IckNeQojiJHTHY+4l
         jXgTw49k3+7dFTc5AZqCk9apqimEn5Z1uw0P2A4hiYuVEcWcFX6ogesGtj0Tx4FKYM9d
         0BLHzVruluyvhWhjVnyojwwspo0qGn+ocpnSu9FzSh1TWbe99zB6h/hV/OyLvqGvmNPh
         WBcIorX6oTa38vcMREvKALeagQmoPEQIgH9+FZXUezhjAFpMETH8MMZe29HCg75lq8l2
         vLkly61mALj0m4VNibAMgansStrONoY5nujcG3D0V/Ia5g8hsyQmJTJ5z4rhlxcJJl7o
         OsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246622; x=1729851422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg5C99O5lFsD3GMjKIKiUiVjWoF4T1zlBP/PbUaocsA=;
        b=l0QNUKgLikyREu+doQ/NeE+9q656JGwZ3IRjlqOh5FYJl696ePbRBoVj2jcriEemVH
         MIgYb5ZSJpUOr/bOTSijO3WaNBgCWIDuOl4lsV9eN1vsPOpg5jszgDHmyLlGIKrQFIO9
         SIXcgH6JpACyRbdAGZFsCK2+wLG+2PFmtuAOmp6qz5rnpZ2ZhOuOazxMaWfpbgxiULiA
         TTTUVA7RnsFgvCVGYtBvlDuPYVU0q1JBxZ1RitUW9DsA8ncja5sOZwa+HZVwmvkZOHeE
         78MvCYzsyzeZRRWzz8OOAf28/V8/+B3dOzzHqoycycSDKY+HPYQcIWudIOc943PkimmG
         0gmA==
X-Forwarded-Encrypted: i=1; AJvYcCVJH6/7dbfyrXffsX62nC8cwpeuLpDoaeBiRnFGDY9DbjC9vNXNXAE6yD5dAJekMEILtvbfyP3kcsEPWuQ=@vger.kernel.org, AJvYcCXU6UTTZfbV9a47G3wYtAew97yrXWJGT7+YUdUZNZalrKeUQJJNkV7iC1vBzXMUWIeBxyRibmPzc/4=@vger.kernel.org, AJvYcCXjJ+mrn/81FbqxWlKCV3fLjV3ZEnPcdIrNcWCbI/tMe+OY5VWUdR/HM7b7p/iFOp5KjsZXoT7rWt/Uug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD+OOQzEuCF70sDmhFP4CeJExmjhgOF8NvMMlyoNW1R+7aSdy
	MV28v2Js7JgMg6kzzqsMmf2+WuguTaUAk6xGecn+Bf/voye2wuIjwwwBgZ0ggf0=
X-Google-Smtp-Source: AGHT+IEeLVJ7h84WQ4/+u3k4S9ShFi1dHNq8ZcXPQUIGtlWymZVFe8HnRUMIjBIrqeVsPikZlvPQ7g==
X-Received: by 2002:a05:600c:3d99:b0:431:588a:4498 with SMTP id 5b1f17b1804b1-4316164dd18mr16051385e9.14.1729246621980;
        Fri, 18 Oct 2024 03:17:01 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf146e2asm1512707f8f.116.2024.10.18.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:17:01 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Fri, 18 Oct 2024 12:16:44 +0200
Subject: [PATCH v4 5/5] iio: as73211: copy/release available integration
 times to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-read-avail-release-v4-5-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
In-Reply-To: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

While available integration times are being printed to sysfs by iio core
(iio_read_channel_info_avail), the sampling frequency might be changed.
This could cause the buffer shared with iio core to be corrupted. To
prevent it, make a copy of the integration times buffer and free it in
the read_avail_release_resource callback.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/light/as73211.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebbbb37fdfb252b67a77b302ff725f6..c4c94873e6a1cc926cfb724d906b07222773c43f 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -108,7 +108,8 @@ struct as73211_spec_dev_data {
  * @creg1:  Cached Configuration Register 1.
  * @creg2:  Cached Configuration Register 2.
  * @creg3:  Cached Configuration Register 3.
- * @mutex:  Keeps cached registers in sync with the device.
+ * @mutex:  Keeps cached registers in sync with the device and protects
+ *          int_time_avail concurrent access for updating and reading.
  * @completion: Completion to wait for interrupt.
  * @int_time_avail: Available integration times (depend on sampling frequency).
  * @spec_dev: device-specific configuration.
@@ -493,17 +494,32 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 
-	case IIO_CHAN_INFO_INT_TIME:
+	case IIO_CHAN_INFO_INT_TIME: {
 		*length = ARRAY_SIZE(data->int_time_avail);
-		*vals = data->int_time_avail;
 		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
 
+		guard(mutex)(&data->mutex);
+
+		*vals = kmemdup_array(data->int_time_avail, *length,
+				      sizeof(int), GFP_KERNEL);
+		if (!*vals)
+			return -ENOMEM;
+
+		return IIO_AVAIL_LIST;
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
+static void as73211_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_INT_TIME)
+		kfree(vals);
+}
+
 static int _as73211_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan __always_unused,
 			       int val, int val2, long mask)
@@ -699,6 +715,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 static const struct iio_info as73211_info = {
 	.read_raw = as73211_read_raw,
 	.read_avail = as73211_read_avail,
+	.read_avail_release_resource = as73211_read_avail_release_res,
 	.write_raw = as73211_write_raw,
 };
 

-- 
2.47.0


