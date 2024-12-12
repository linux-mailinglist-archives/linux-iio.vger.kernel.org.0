Return-Path: <linux-iio+bounces-13404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218829EFA2B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 19:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877AD1613ED
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82368215041;
	Thu, 12 Dec 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCGav2nS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514513C918;
	Thu, 12 Dec 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026211; cv=none; b=gOKGpwEQViIe0KkGScxTQjhMSZmfK9xuDWW8x9vFNZhY88VY+B5+Ifx1oj6MR462wk9UTqggtussaXz1BGIpv9L9Nk1uw38E75TyslNvjdlyMQuMTgpQt4+mm/40YeHPqbsgSJoN/S6gwXaLNww2229I7Ki4eGehsJwv6tw1tTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026211; c=relaxed/simple;
	bh=nVmvZwWJFdnVkriruA5b1q1Kl81wnNi8Cta76db//QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YJkO/Ftj5FaKSNvLKW9r/I0yubjCTtvDaP81WD8UVb6EsGXviLMycevCnaWi/76ZI+zPLisI3ElHufI7blK2IB1y1va3sIyjE80saB7LKKAsYRNOWW3bFhNQZydNmMZ7gZ0xT/FhZOdHx2INgOPVrrGB7dSHBXbhC2vPg8Zqj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCGav2nS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38632b8ae71so661677f8f.0;
        Thu, 12 Dec 2024 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026208; x=1734631008; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz6iSz+5tmOLQJUpa13HbScZMVtU7bIlz9Le/5dabw0=;
        b=MCGav2nSG5oonwuIn1d6iDgmAAGBSZIGQMYBW3+w6cLQgq+Iq+C2NGuNTUPkF0lvAp
         govXeHcXjjAnvBCij65EiFO0tZtCg8G/2CqtvolbOJ5W4YKcKhYVCEfjeg1bc0ioKStr
         5lAZ/d1LdEtfzOttsGY6WerxrW04omp7HupBaKFSW6Tf3pmXMIXbQJP1mnUGsqwnBu8f
         UDETNyUMVXPuyTYmQwadv0baCqJnE/B4esmJk+ifPmLfjI+aJqzduFHNFOMrLcDHBbki
         V74GKPJf2ZhLRiF8rTV7cWMw3ZFo6TwGwJq3vmG9FcfOarXoURDOtPgwCFI3HuxjC3VE
         HEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026208; x=1734631008;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mz6iSz+5tmOLQJUpa13HbScZMVtU7bIlz9Le/5dabw0=;
        b=Sk/rjFnjPeQqfnzWHl+cRCPdr6GDngjo3ReoVaS7RVVYHVoeOAARebNRNS8K/2Rx+G
         eByspEoUy8H+EF2RmmZ108yZPUL8zSoq11dZJjZ/MlnUjWcXbvq8FCzjyJXsr0hyd9th
         sf9lqZucyVY9u5qSORdz2/f3aE3NMx7s6wF/wRGXoS0dwJ6FdyFnqkyAy7AKSdYk3b9R
         v914Bhve3BrsE0H65cDbAoUiuucgr6Pgl6W6HYmNJUxFpulGXuVQumHsTeSXyDSDWKvD
         bH3MSjhvdgrZhhywu9Ive0R+9S03bJ8d6WqENUw+s+FdywUZ3poJtABMO5pdR/HdCrOQ
         xnJg==
X-Forwarded-Encrypted: i=1; AJvYcCVUkL+I2qVJltNWUuQVdnI7DHnHZNopqQNyTtXP98YRwtRMlTrwuklQglJSmZIaKw6jttWhzNLMmV/ui6yx@vger.kernel.org, AJvYcCW+k/BuWiQHZFkPBftjD4Dymv61zsplFcGV0SUF6eQ9fMwabU/Phr0mcCMi8hpQzVG1Jjmp+PUQ@vger.kernel.org, AJvYcCWCgajodYvd//deLeVKEi7/INUc8PUO5jK6SHMpat2Kwr4R6WASHLEn3va1hbB1ZWDKeEJxU5oVHcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQA/xCLE4HeVxspEI5R0hNrRnJZu3lWWHEuSgmdsOsJX9kS6Kq
	iw9FD0VWg8v5cnUE3bk2oEFBGLrYzPgzms99dhevMTHgLZzQo/m1d6cznQ==
X-Gm-Gg: ASbGncv/T2NxF1/QCaAvH2nIPOZqb5LSzXm22jLT++nLzB/BrhZilAnhXjZ6UZgfZCS
	W5m32yPHRVKmiZguvDNqPJTamKNejDHisPZv8Jky+O13BCdnxy/9PgzH3E6vmmfPL50wq4b90rV
	pmwE7krxePh07UWif8pIlt858W+BSE7leH6jmSLJxqt96uOuuXYkHGprfgFApFrevQntHFyQSCe
	z67MR8XnuGn8HjNrxDqWOfNNcjtp3Pf5tn4l3nabq0glVZTrtgb0unq+LjdkDr58wIUzHScemnU
	rrMXadjARKROuO+6QJZ+k0awYsTeoqdxPBtfhHJhKI4uR/S7O/FYyZQ5wELUGHpAgOt+I2SEMg/
	cI0I=
X-Google-Smtp-Source: AGHT+IELl4V91kjyJm74nxS5biRIQLWxqMNb3KsVnHqWz58LVZMZsxtG/ua6jkk4j2KMCrUK1XxDkA==
X-Received: by 2002:a05:6000:2804:b0:382:47d0:64be with SMTP id ffacd0b85a97d-3864ce9f36fmr4342223f8f.29.1734026207772;
        Thu, 12 Dec 2024 09:56:47 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-9f71-3b98-afd4-ee01.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9f71:3b98:afd4:ee01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dcdesm4566380f8f.104.2024.12.12.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:56:47 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 12 Dec 2024 18:56:32 +0100
Subject: [PATCH v3] iio: light: as73211: fix channel handling in only-color
 triggered buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-iio_memset_scan_holes-v3-1-7f496b6f7222@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM8jW2cC/3XNywqDMBCF4VeRrJuSi7d01fcoRdI46oAxJZHQI
 r57o1Dajcv/wHyzkAAeIZBLthAPEQO6KYU8ZcQMeuqBYpuaCCZyzoWkiK6xYAPMTTB6agY3QqC
 6rGQtJXRKCpJunx46fO3u7Z56wDA7/97fRL6tX7E4ECOnjDLzKEHVba0Kc+2txvFsnCWbGMVPE
 Sw/UkRSZKdyXiihq7L9V9Z1/QASbNMAAAEAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Christian Eggers <ceggers@arri.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734026206; l=4380;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=nVmvZwWJFdnVkriruA5b1q1Kl81wnNi8Cta76db//QI=;
 b=4XXJWzNf3xlwVMU5wFJvTai6GUDitz2R3FodgcYmQJy49u1yO//9bWf5PAT1t1Yu+ebOXi3sg
 hWfMuMpm7zYCw+E1Aaw9cpVkaEiBwlmcZ2K7VhShq82sdYNlpsh8coI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The channel index is off by one unit if AS73211_SCAN_MASK_ALL is not
set (optimized path for color channel readings), and it must be shifted
instead of leaving an empty channel for the temperature when it is off.

Once the channel index is fixed, the uninitialized channel must be set
to zero to avoid pushing uninitialized data.

Add available_scan_masks for all channels and only-color channels to let
the IIO core demux and repack the enabled channels.

Cc: stable@vger.kernel.org
Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Tested-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This issue was found after attempting to make the same mistake for
a driver I maintain, which was fortunately spotted by Jonathan [1].

Keeping old sensor values if the channel configuration changes is known
and not considered an issue, which is also mentioned in [1], so it has
not been addressed by this series. That keeps most of the drivers out
of the way because they store the scan element in iio private data,
which is kzalloc() allocated.

This series only addresses cases where uninitialized i.e. unknown data
is pushed to the userspace, either due to holes in structs or
uninitialized struct members/array elements.

While analyzing involved functions, I found and fixed some triviality
(wrong function name) in the documentation of iio_dev_opaque.

Link: https://lore.kernel.org/linux-iio/20241123151634.303aa860@jic23-huawei/ [1]
---
Changes in v3:
- as73211.c: add available_scan_masks for all channels and only-color
  channels to let the IIO core demux and repack the enabled channels.
- Link to v2: https://lore.kernel.org/r/20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com

Changes in v2:
- as73211.c: shift channels if no temperature is available and
  initialize chan[3] to zero.
- Link to v1: https://lore.kernel.org/r/20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com
---
 drivers/iio/light/as73211.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index be0068081ebb..4be2e349a068 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -177,6 +177,12 @@ struct as73211_data {
 	BIT(AS73211_SCAN_INDEX_TEMP) | \
 	AS73211_SCAN_MASK_COLOR)
 
+static const unsigned long as73211_scan_masks[] = {
+	AS73211_SCAN_MASK_ALL,
+	AS73211_SCAN_MASK_COLOR,
+	0,
+};
+
 static const struct iio_chan_spec as73211_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -672,9 +678,12 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 
 		/* AS73211 starts reading at address 2 */
 		ret = i2c_master_recv(data->client,
-				(char *)&scan.chan[1], 3 * sizeof(scan.chan[1]));
+				(char *)&scan.chan[0], 3 * sizeof(scan.chan[0]));
 		if (ret < 0)
 			goto done;
+
+		/* Avoid pushing uninitialized data */
+		scan.chan[3] = 0;
 	}
 
 	if (data_result) {
@@ -682,9 +691,15 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 		 * Saturate all channels (in case of overflows). Temperature channel
 		 * is not affected by overflows.
 		 */
-		scan.chan[1] = cpu_to_le16(U16_MAX);
-		scan.chan[2] = cpu_to_le16(U16_MAX);
-		scan.chan[3] = cpu_to_le16(U16_MAX);
+		if (*indio_dev->active_scan_mask == AS73211_SCAN_MASK_ALL) {
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+			scan.chan[3] = cpu_to_le16(U16_MAX);
+		} else {
+			scan.chan[0] = cpu_to_le16(U16_MAX);
+			scan.chan[1] = cpu_to_le16(U16_MAX);
+			scan.chan[2] = cpu_to_le16(U16_MAX);
+		}
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
@@ -758,6 +773,7 @@ static int as73211_probe(struct i2c_client *client)
 	indio_dev->channels = data->spec_dev->channels;
 	indio_dev->num_channels = data->spec_dev->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = as73211_scan_masks;
 
 	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
 	if (ret < 0)

---
base-commit: 91e71d606356e50f238d7a87aacdee4abc427f07
change-id: 20241123-iio_memset_scan_holes-a673833ef932

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


