Return-Path: <linux-iio+bounces-9685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FF97D991
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534E52820AA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2024 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9533183CA8;
	Fri, 20 Sep 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWaZYrJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23977183CA4;
	Fri, 20 Sep 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856110; cv=none; b=RlofqJAswpxoN0U3TXGdXy+aTIU/AAOSXIfXE7UJG2DFkkx9Z8GuAd0aG1pRohX/h/nI0ps6dlRJOFL4x8dR6nU6ndlfAoW56c82jkKa4tF8v0SxyDWjviEXSsOHMLf1LbnsPOp5NpvZ/Bl/+JDy2NUVIY7k7+wQd0V0fg6mWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856110; c=relaxed/simple;
	bh=beu+9+UpQG03PNF/jIcJB7TG9fxGlAQdjGIIjD6M/3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fT1g01y0jJsJm/cW5SeyDKalGNYoRWQnryetwtZlJ8fDUNCLPyZSPQgXUM6GnDFgnRH2FGsCH37ufLDaKxqVNLQgpQbuwr/WnmPZruZqqFNTVU3iKQq8EjXJWvCHfzFtOH85m/X4k6L2wZ4C9QEri528YCepyNbCfui49PMXMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWaZYrJ4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2068a7c9286so24917545ad.1;
        Fri, 20 Sep 2024 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726856108; x=1727460908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DrVYfh0GUHIeNtjtpXPhwnD6IAQdD25WTHygPUqIqs0=;
        b=NWaZYrJ4vQUylEM4YXvZfyvCEZ6kyHXepHq2dD1FsMCwTzyTVWqkGefTIPV8gc5X+4
         pskJfIAZTR/5v4TFIYj0rw2XuWXfol8kyfZlcX6uTx9ggoPftzi1Oi5Qpah25hhDBvIo
         //n1S/WMVjP6/nWZYCMqwuZBEo00Nn32HT7sP3HXEqD8BmSaylu7oViMafvpPG/3a5zT
         kb9y/MedpE689H/psirO4jkZJj1PjDNuvHofT8E/zm7OmbuZNWiOEQWm1g7zXTQaHop/
         ySQhnrnavFDlomeofwGOpckepzSI313jyUUySz09OM9FQ8TO4XiZwmxQb/6Z8qOIwhOv
         4Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726856108; x=1727460908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrVYfh0GUHIeNtjtpXPhwnD6IAQdD25WTHygPUqIqs0=;
        b=gBWSKtFQAZzmYz7O50sowXCJDnMofrIRxkz56h9bLZn1mlPjxnvvD7x+cjhmj3ZSRB
         ZtxJTn3au5QlvVhLlKSSFdojZ5OUn5aCZjKzvKlwSScwEX3balwDL6hALPouC0q88lF2
         adFONJATKsZ772dFOvj8ypwhW/TAI9PQ5rFq5XXA2Haz3nsfZeql5JmYq3pUWZq4sQ0N
         mxt9O6e227/zecZf1mz+ELrKKiWl7nwbOIFHcTjx5N47mI5snIMHlwFkd8XxVMvyXZmG
         0svFFk3nWHCP4SJzLinFVJzJKSgV4UBkR7XQ+seDH4aNFIMnLJOUKI/ZIUDF9a8quiae
         j85Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGjvkXAkoLes82m+gdLzIPDZ8r4vvS6qX/0hrsJyL6qQVvhBu/L8vPiKBRdPOLNXEHZq/c3y81t72FA/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1exWQn1Klbva40m4BurpSlCqZSfDOFXdYDWVwxghDfMAbzV2l
	RITvRoBZ2h9yaj2MSBlPriD4LNdngh8g65oEAQEBu0flgDOvIGNMnIqwvZXuxos=
X-Google-Smtp-Source: AGHT+IESoQGFqVchd6MrcZ+jx1GdlgrDcDliGCMznPimRl6aK3ucm8U94FFpZfoJVJdu3w+NjISh1g==
X-Received: by 2002:a17:903:24c:b0:207:625:cef1 with SMTP id d9443c01a7336-208d8339e94mr45359765ad.2.1726856107480;
        Fri, 20 Sep 2024 11:15:07 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([2401:4900:4e68:3fea:f797:939:103a:e084])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20794735863sm97530895ad.274.2024.09.20.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 11:15:06 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] iio: adc: max1363: Convert to get_unaligned_be16
Date: Fri, 20 Sep 2024 23:44:37 +0530
Message-ID: <20240920181437.20194-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converted manual shifting and or to use `get_unaligned_be16` api
instead.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/adc/max1363.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index bf4b6dc53..0801317da 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -33,6 +33,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <asm/unaligned.h>
+
 #define MAX1363_SETUP_BYTE(a) ((a) | 0x80)
 
 /* There is a fair bit more defined here than currently
@@ -391,7 +393,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 			if (data < 0)
 				return data;
 
-			data = (rxbuf[1] | rxbuf[0] << 8) &
+			data = get_unaligned_be16(rxbuf) &
 				((1 << st->chip_info->bits) - 1);
 		} else {
 			/* Get reading */
-- 
2.43.0


