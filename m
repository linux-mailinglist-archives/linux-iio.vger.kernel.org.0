Return-Path: <linux-iio+bounces-13478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFD49F2096
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8B47A1019
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A561B21A7;
	Sat, 14 Dec 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1u+59pi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA91AF4E9;
	Sat, 14 Dec 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203672; cv=none; b=lGI43rDABiM1p9njRNYvQlWvuov3Icf9VCHZxvTlnTwNOd6YyumsqegogCJ6C2rzr2khfALJ23kHPm6FdZ7Xahcr2WpQQ/vCBuGG1h2ZvqfTBcv7u9sQmvISF5OT2V+wR1svSpuBo071Gkg8De160WHxSFiDpiNOQ1HQwZHYgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203672; c=relaxed/simple;
	bh=EuAoXJkr4Jzzz+frBaadhQ1pyRZzObhO4q6GpwZFgLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa2SyqM+uShrk6mJRGeN3LOFMRxqfZ0mKvu2qWUInyuvzCpzalNpr0DfMNpQO212f9iB/+CuNeR9Ew61uBx5FGiID0ky3ySBTomdTBe7nPp6FkXdQ53VUiSAXsE1nWGccwxbfNIwwsweST7TISfJHCY4t0lsHu8DDxHahq6u3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1u+59pi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa68b513abcso461638466b.0;
        Sat, 14 Dec 2024 11:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203669; x=1734808469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssKHXloSLVEciEiYQug6z9x1MF9evD27GD823pmZQZw=;
        b=A1u+59piNDGLewVgsCywd4/63DjubzKFHxeMNcvrPapnJFUzQdu0gAXSMXzJETpKaH
         Aa9jp4UvBGN6BZVGAdvDOWF5J46oUdDnw27GOK2v/O4CYyc45HqWXuf6VmEHmAkJ+bcE
         Cm1f0FCHeSYmQndHnVeCIiaetGfToTASfr56xD7ZFvNO63o+NqaWbP0va5n68v0wpPkt
         7iEucm5cHcHzQidU571oCR0j6GnLFh7DltkxvLyk/X2yRzxPENa4Q/Qz5yBfeiOLkM6g
         HDIPOl18wZrwXJE7EItXFDC3dWYOFcNaN+zUucHXlu7l/nfE2TGL2JKpnI6dDKxy6dI5
         Cvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203669; x=1734808469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssKHXloSLVEciEiYQug6z9x1MF9evD27GD823pmZQZw=;
        b=n0+RVgB/XHV0H0lYsJ7ycV4LlaFQ39hjtgVB2kYTYfx50x8u9bIpADAViD0i1EXZT3
         Yg0xW4xLW8uwO5Qhjg+9GoahaokUx+Ftz1+QGigUOoHDKkrTKf4NxstkpoICAlRpArRn
         VivuAw+DL6AMwlDdp1YoVY67StDVBWZOrustP+9JfAH5dcR2JMHV5RLZ6ADHQHtnynS2
         nh94WDCMUfk6+9Y5vRGQ4fqyeRzEqpGFsOEQl1/mjJ4ZZ3a8ZqHE+S2Lu32s4AbKGH7W
         10yeFYQO9xtuUFFeFcc2jJd6QcwRUSBgCgIbDUaSm5vyTb1sJSe3mb7/zYbAANBKB45S
         3Ntg==
X-Forwarded-Encrypted: i=1; AJvYcCWPaDuuZIjBf5XHR/LbQUqnFkdM4zUPlr9x29H4O+JbotF6M/wGSTDlV0ZFBBmxKAR5kw29C/t8sY8=@vger.kernel.org, AJvYcCXjePju2WELpFZ431dmDzdM8mhE01/ywITPGougbZ8P4V5/JYDDfJXfrbvDyyat2DnFpayZsFSXujQ9jDFP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bXGeFEhsBw9+raAHIy9y4eKOyzBBcf6SViNNaFOrJYBBad0D
	ZEotEbDR/PrSQFvBBzB3w7X2q+BawSsoJ+HJYoOo4X7s+PMMRf3U
X-Gm-Gg: ASbGncvOiib3q4uZptBPX2Rpc2t8uIanLAds5YmdTnQle5dg4VJg4fJ7jfMZPvGAQuN
	GjLk0RCOrE/HNbyV8YmCijaYjonRo0JLBS/8nxPBRNS9wqr+wIT2qCUf/IdZh3hO6W0OLrQ5mzJ
	y6IBTxp2crZF8LkcoN+m8U7NHhPCD8GwqjrciHAWvAgNSErEmuivGV178cCEy6zBdJQMCWRN/bx
	SNffyBDKNyx2uW5sq1VDLIIH7UNud1FRSxwNQu2QXjMrPU+Fz93KVDQUy2F91n1AW2omw==
X-Google-Smtp-Source: AGHT+IF1uCWSJhL4G1Uzqik0exYPqaKOHPTlT0UxqL4DKQ8CiE7prahYTA7S0in/ca6ialOMzeyy7Q==
X-Received: by 2002:a17:906:c28b:b0:aa6:b926:c102 with SMTP id a640c23a62f3a-aab77e825ecmr658191266b.43.1734203669377;
        Sat, 14 Dec 2024 11:14:29 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:abde:dd08:a767:d63c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab963c54d2sm122818766b.190.2024.12.14.11.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:14:29 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com,
	jstephan@baylibre.com,
	dlechner@baylibre.com,
	jackoalan@gmail.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v2 3/4] iio: common: ssp_sensors: drop conditional optimization for simplicity
Date: Sat, 14 Dec 2024 20:14:20 +0100
Message-ID: <20241214191421.94172-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214191421.94172-1-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop conditional in favor of always calculating the timestamp value.
This simplifies the code and allows to drop usage of internal private
variable "scan_timestamp" of the struct iio_dev.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index caa404edd9d0..6b86b5315694 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -8,6 +8,8 @@
 #include <linux/iio/kfifo_buf.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
 #include "ssp_iio_sensor.h"
 
 /**
@@ -70,7 +72,6 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
 int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 			    unsigned int len, int64_t timestamp)
 {
-	__le32 time;
 	int64_t calculated_time = 0;
 	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 
@@ -82,11 +83,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 	 */
 	memcpy(spd->buffer, buf, len);
 
-	if (indio_dev->scan_timestamp) {
-		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
-		calculated_time =
-			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
-	}
+	calculated_time = timestamp + get_unaligned_le32(buf + len) * MEGA;
 
 	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
 						  calculated_time);
-- 
2.43.0


