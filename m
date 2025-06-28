Return-Path: <linux-iio+bounces-21046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D8AEC868
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B22817B32E
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4308A21ADA4;
	Sat, 28 Jun 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QXCT19Pm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110EB1F874F
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126196; cv=none; b=G5F4eGOfcIsavUBNoP72NdgWjCrsw7bt05504bdHTujWpUlqdGWBPFEBxGw59kh3e6Zv/TgPB7ZdxRV0T9Pw7vfgchbV1AsmL4w+HXJ8BxAU4HVsxSPquCZUn+tHrNVEJ1SmjcDSjohQmldzIHSnwIOWlK5xoPkQ70G2A27eym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126196; c=relaxed/simple;
	bh=MpmkYzDw2ENeKfdY7gFPxkRwKR0kz2gYSaXwL/jPWdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T3JUFBYB5bwogoZLcKZLEbnKXVxgBKTaqqzYeNdqXoImi/Rt/uw1VvAWBKQh5uofOmbE6+VmLtqYsZ6ZKufuDHxF8Pkd02xJLCCgcL84KinR7BKyddNc4PAPjuprcL6Dk+8LPae6plAiBh6h4XFejbk0g5cO7wQxIB42rEqPPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QXCT19Pm; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40a8013d961so1038494b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751126192; x=1751730992; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDtJDztfcuj1J6VjhwWfrKLId4IVubmJY2qVBXZS7iY=;
        b=QXCT19PmxYf41lGlYdqwH7aXfn6qaLTQVDWfW44x0nGPx6QFRS81awof9WtpveIgCr
         pyxyvWqaSMFUC+OXdGDZOqYNUblFf8zjEC4V09pM9jPa6/6KAHiM7s9rhdyg5wiSKlV3
         8URhUx1ROzvS/gTtKB/KVE/pmQt9lMv/P9JqMbZXu7hwc7xh1UsP/JxqD89Tk/BZDURw
         PHBsJ4L8bFLWjgKavp4guvatwggOlYJ8Zw+TIxUlYYZV+oOtf1RAZMzcqrRyrY7u2I7P
         Z+GbPc7cuUsTbw9xtnscOhS/iPF6hyVhZ3lwbOjgqk/LfQysEFaccUZcfsG1+fTN+zGV
         XTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751126192; x=1751730992;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDtJDztfcuj1J6VjhwWfrKLId4IVubmJY2qVBXZS7iY=;
        b=SGfslZOy3HPjwn7oNrjOHCuNOKtwoB0rY/uzH+F30ntM1rxFqvC+9YnoNpHsK/wzqy
         QxpG9l+3zGZbjHL8m9C3AI/fBWFnkyfHfrpJ1tZw2GU/27QOrXxsD2+iCK4x4Fb+mWeA
         kAyzwAIbaXpUsZJ4Iygv9ueys7koIUf7GtjehQXow21LplWS+ClMuWxjgesncIYv8AeT
         3NcMR7KCVaeBzTdvitHkdoVh6yvVOVM5ZOhzfk1b9U1gCsllPgPVdb2hCNt6sLEEbzVI
         Jlo9Sd4FQKm+iAHYexWYpvPIRMfsD+8B7v7RREWviSz/Ilj8x1tN0EnQqdadQ11XW541
         UCoQ==
X-Gm-Message-State: AOJu0Yz0l/A7OIdomoa7CmYVgIf9bcDL9ye2gfFcttD8nhUddGkt+gtj
	gBI/gKoKA60ZO8cXp4WNqnPji068JppGZUhhxabtUyd1anlciFkLCqZET3JrLk8qM90=
X-Gm-Gg: ASbGnct9fp3bXYFzhxLuvFRHwcYTeu2T2gc4+e6PbfMI1C9ZLCwW8qLVdLV4DSQ+tia
	hIm5lZDZqAKivg23N+yIyT8HA3KYZbr2PW4/lM7yQBdJZ0eB+zEy8WvwlNqoHbT5/SjFlz2JIgD
	5Qnyh2Xulb/p6nh1WHfE0RYQHZrKGoMbxFaXWs2hpPrOys1NHYxMON0/MTA+1j9VH/UE1lo6/OV
	v+Zf9MfY54S3v50Nxt8jjHyGX2ll+z0BAe4WpaoBRGo2A77Qg2a/SvIhduIje2/5TEu1DgO9whW
	Z7eGMqgoyakMCwwGYKG0jXtUjXxBQlKC1untMeFZfnOSP4RgfpRnwRcsE58VJQS4xXac
X-Google-Smtp-Source: AGHT+IE8h9gJsbwwdHyrIwOBBihC6aQCDDOTYFgRQ5JMP3F/o1/9spJJsCVXPSCaS3Y5KzrGeyHKZA==
X-Received: by 2002:a05:6808:21a7:b0:409:c6:c147 with SMTP id 5614622812f47-40b33c327f2mr5841613b6e.6.1751126191825;
        Sat, 28 Jun 2025 08:56:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322b5900sm868652b6e.18.2025.06.28.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 08:56:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 10:56:20 -0500
Subject: [PATCH] iio: accel: adxl345: make adxl345_events const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-1-v1-1-a32d96d01c2f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKMQYGgC/x3MPQqAMAxA4atIZgNNUVGvIg79iZqllbaIIN7d4
 vgN7z2QOQlnmJsHEl+SJYYKahtwhwk7o/hq0Er3atAjikR0MeSC3hSDhJam0Su1dZ4s1OxMvMn
 9L5f1fT9Kt0ruYgAAAA==
X-Change-ID: 20250628-iio-const-data-1-b198d00f4d1b
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MpmkYzDw2ENeKfdY7gFPxkRwKR0kz2gYSaXwL/jPWdQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYBCny0MAg1Ay3q0OSsM9GfcGSfk1cUjugNqoY
 sewWD3tvwqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAQpwAKCRDCzCAB/wGP
 wGTlCACIh85BEBXiCKOJmKZxfXKPdb60mpqCaG4k9c2cpTtzpJ/HWlfTlKpWBvva56GRZWxhokm
 qRfwxIg4B7QjT0z6mfgBo1K2OFRxaR1Oh2lX5ZuejhLvu7iteLDX4gXPykgoaF3QYvuQtDwk8gh
 1HmXoNcIt4ZjYRm+TPw17286K4k9WNtvYE7nJR4E3cL3FsxkYT+FXvU6d+Ch5H5RRSxAORzVJT3
 fc8f1UJRRvY0Uq+dhV++WWb7x6RTIC4OwyHmedfFPJvuu8k9mslIEz9ms4NJf9jUZ/ZxSrCcQ36
 J2GAmlIC7QIlMagfeU4rpP93rsAw228sMiU/JkQCvj6wXUe8
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct iio_event_spec adxl345_events[]. This
is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/adxl345_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 45d71940c5ac3e042265615fe95238b9d29855e2..e21ec6c15d15e7342b12226dc8fcbb091324e353 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -143,7 +143,7 @@ struct adxl345_state {
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
 
-static struct iio_event_spec adxl345_events[] = {
+static const struct iio_event_spec adxl345_events[] = {
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-1-b198d00f4d1b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


