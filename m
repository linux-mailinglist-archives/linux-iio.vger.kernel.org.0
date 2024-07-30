Return-Path: <linux-iio+bounces-8048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC94940AFD
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46541F236F1
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441A19007A;
	Tue, 30 Jul 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O024y+Vm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410E18FC6E;
	Tue, 30 Jul 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327132; cv=none; b=FdQ/6HzddBIsCRGljRDf5FANy5+jG0SxF7+augouv9ymrjgaOtdUfEJRailF/7aMt2QPD3uxQi+LrlMJzoRa1zRqkxq2q+D1WxCT28D+Kq7ZfeosdSQOZWFmD8djQNfspEcYzosUmLG53zAbR24pfoZrrNeWRiBufD5tdPHzhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327132; c=relaxed/simple;
	bh=uvCA3vMRvf2oKOY/2qXBXSD+olAd3HyjFosE2dK543c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HCUzm9Ezp+qGUstp9YzSW0x3Emn0vpJVl7zeMSmibXi4sIJ0SSxCSoHV6pOFJ9lZL4r/+X2+P/q+YUsBaqJF9wlMz22Dfs8X6koIGdfu88mpsCqiMwhndkGN3efsMdvyu04WYpDjikEhVb0CSRdBuFInTbQQljYCtPGIuC7PE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O024y+Vm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so14863515e9.0;
        Tue, 30 Jul 2024 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722327128; x=1722931928; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGQNm2vWbhJ8TmMN9dbkhKyrMwfPMKPGQqmk0Kv30R8=;
        b=O024y+VmXp2D1nR5UjOlCTQLyAfirE+GBze7Nq0kfj1CoMe0iwwdMwmG4ww+AWaYah
         dLiLCSinAadCzMh/7qxMGLNbnP6xCQ1MiJwZPHh20PHnzIlfoJM5/gsXC/6bmtUOpnnW
         mHK7CVzC+wq6nEOiEoO24TfnaFU86gVRsH9T/xdMkNRaVzk5TqJZE7Go4iJNxYNzcQiu
         uL9L+78Z7lseSU1r37mN34LQ9uESO3sqmgf26CaNcXv6rT0EIF/padxavlLQt9kuQbaW
         PDJWlHsUwGyl9QaPB3TWx58JzenQ64+OyEyCwHgxXDibpJ8MQptN/W/Sr43EFzr/XMm5
         AJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327128; x=1722931928;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGQNm2vWbhJ8TmMN9dbkhKyrMwfPMKPGQqmk0Kv30R8=;
        b=GsUAG12O4zggcMK54lUXHoq1drNrCzEb6tnOeMVcbVnUkfN/DbV0BYkNKEEeh5qMEh
         WHISPUj+jmOo/tP25qK3GnngJpjKi1uYtUNK3VcM6ovU5EtotjndqdDeLH8vlXnli2Jw
         rGGB/IEMSm1+9BaLjwsGFtFR7XDwXgxNl7Zzs/jYgLA44gmbpobzs3vTkrrUKY/ai+P/
         bdIkCv02yUqQYIeLtyNkTWUCxVU4amiF4v4rMQNmGHki97Ozo3AvYMQoJ+JTM6OAMsNy
         UgYhumVWdDdG4bCFsKsNSiHBKchnsRs07cDud67gFBwcVth5DTcf5Yok9gJms5uQXSw7
         XVmA==
X-Forwarded-Encrypted: i=1; AJvYcCVb5pO2P5YUgi5PqdeasJOb2N23RdtDUM2WcIUfCkA+WTX91ymlAvQRA5ZF7bLD0D4acSPHuqopOPDdWNpPj87SIE7iq4FgdArS3xkl
X-Gm-Message-State: AOJu0Yzo+28X+kpMcLitzXlI4FeMyd7jlQZ0UAyIk3ib8auzlpJbHf3L
	uRyBTUh8Fkrfsss/vEWr9H5bUTc5A7UsRYTLQQNKXxCp3O10IoQX
X-Google-Smtp-Source: AGHT+IGuauepkw/mDw1/n4vnZ3tnpOMrYo4mgehWgHSLu/JK2EmQ9+ws/ADB97h9rBnPsFiudc3vpg==
X-Received: by 2002:a05:600c:3b17:b0:428:9a1:f226 with SMTP id 5b1f17b1804b1-428243e1b22mr7763835e9.1.1722327127868;
        Tue, 30 Jul 2024 01:12:07 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280fa9a30csm135477155e9.30.2024.07.30.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:12:07 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 30 Jul 2024 10:11:53 +0200
Subject: [PATCH] iio: fix scale application in
 iio_convert_raw_to_processed_unlocked
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-iio-fix-scale-v1-1-6246638c8daa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEigqGYC/x2MQQqAIBAAvyJ7bsFUsvpKdLDaaiE0FCIQ/550H
 IaZDIkiU4JRZIj0cOLgK7SNgPV0/iDkrTIoqYy0akDmgDu/mFZ3EareLrbTUltDUJs7UpX/b5p
 L+QB+EmNRXwAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.0

When the scale_type is IIO_VAL_INT_PLUS_MICRO or IIO_VAL_INT_PLUS_NANO
the scale passed as argument is only applied to the fractional part of
the value. Fix it by also multiplying the integer part by the scale
provided.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
I found out that after iio_hwmon switched to
iio_read_channel_processed_scale() to convert the power channel value
from milli-Watts to micro-Watts [1], lm-sensors started to show
unexpected values for the power channel of the pac1921 iio driver I was
testing. It looks the issue relies in the
iio_convert_raw_to_processed_unlocked() function that only applies the
given scale to the fractional part if the channel scale type is
IIO_VAL_INT_PLUS_MICRO or IIO_VAL_INT_PLUS_NANO.

For example with a raw power value of 71, a power scale type of
IIO_VAL_INT_PLUS_NANO and power scale value of 9.775200000 (mW) the
processed power value would be ~694 mW but when scaled to uW by the
iio_hwmon calling iio_read_channel_processed_scale() with a scale of
1000, the processed power would wrongly result to ~55678 uW (~55mW) =
71*9 + 71*775200000*1000/1000000000. This because the scale of 1000 is
only applied to the fractional part of the power value. Instead it
should be 71*9*1000 + 71*775200000*1000/1000000000 = 694039 uW.

[1]: https://lore.kernel.org/linux-hwmon/20240620212005.821805-1-sean.anderson@linux.dev/
---
 drivers/iio/inkern.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 9f484c94bc6e..151099be2863 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -647,17 +647,17 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000LL);
 		break;
 	case IIO_VAL_INT_PLUS_NANO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000000LL);
 		break;

---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240729-iio-fix-scale-287b7630374e

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


