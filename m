Return-Path: <linux-iio+bounces-21203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3252AF05A0
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71430447611
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD801262FDC;
	Tue,  1 Jul 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeRkm4pp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C02222A6;
	Tue,  1 Jul 2025 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405861; cv=none; b=q1u8kuoufCFFjIPVda5ca7ZT+UrrfYkrT6Qfy0Kz+5QTyYGAtgQevkNPxw/SK/wcDMoyCpsIxkeeHzYcQzn7AEjrWXbj9nDrsjwfkt21+q8P+3qMbqPUhs4KCeHF822xWgnK5y/7lPQ+m2N/kqvAN5szrj4IZkIdWB0YvbAq4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405861; c=relaxed/simple;
	bh=RBrBJDYsVF79vNES6HdjOQZFA80yLkTvQzskeuiR2SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxPnGCojAYA1Jz8jfsgbRcSdQYIeTz+HtFM8AjBzkLDVtGCRWI8EUgYT5WZ+sQAyBTPHqyye1lvZKbT++q1mPA6xSU0waI5Uordc+rkMYgujfAQSHUU7e9gOl6U4xk0jJysRU0EE2NVxDiFqIau1MXIDwrodsDj9yVehcYdRwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeRkm4pp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2390900b3a.1;
        Tue, 01 Jul 2025 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751405859; x=1752010659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIwkG47eiVJtEDBigeiy1r3RJ+0ncwP3pzakx6X+Zhs=;
        b=TeRkm4ppx+UuCR9+7HL+DiaWTqdGS0V/xBjbhOrN0X9pCPLtgsStrAP54Pb/kmdVNv
         T1Di+U67zKmcMSCzPEUOOR+WrOI5U+FbigedHbwn/wU+Zp88B0e2grfX4d7eX4JzfHXI
         bk70JZGUbu6jmDVhw+mFDy4Qlh2imm9pfBbvEBEVRHoKhun0OlKF5Q1BOQIVguD3jD0M
         4CFrVuROmXh1HTk35xn9z4QMABr8GtYteZ5m7NimqcT9Sji1FwEbvaIvf100yOwPLb9F
         ZJLty4Vqke+8Um4hTEa+MgSizdV2JfzE9Ik50/kUCmcK1e5EZ0GZBY/ucgFTgDhXQbQ8
         PY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405859; x=1752010659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIwkG47eiVJtEDBigeiy1r3RJ+0ncwP3pzakx6X+Zhs=;
        b=YzkdbRF/5RavB8RDGWHsp8/U5ofJYMYPbZWJ3OMNGD3zj1utmJCOgXJYdcmU+tUbxZ
         InvFbQnjs07y1TBE4k/Qs/cDEDqvTz5VRpQnZ7YTarP32MQT8h4JbRYZLQQXPCq6eG3v
         Ua+lrG/ivz2aiO36Ta3MogLDySvlS0vhEiwXK7elrjNEXBnZ3gyxyhj3tHKp+31/9wbh
         yrhIBXld/FKwxdgAT+lG9OCLRuWsrps5uPHtquiLTqqaZd1CqEcTYPl00MM2Azqofl0f
         yKvHNP/+gokzzu2C/WBtBo/G38412pXsKVOkkUBxgfdm+f621TGehsumEePAcCoBOM8C
         E8jg==
X-Forwarded-Encrypted: i=1; AJvYcCWFXA+AV9ddh7e6TNFg9UH6XBb+9EZGvIgUFZ9KXBsDSk5eJSqQkZadqogLBti/5DXO+8PIbEWRHv8=@vger.kernel.org, AJvYcCXu+wt3IpYo4818NBeucspmUUR+5IHioZvFKGosQLKUEX/vAcGQq6bCpsZAWM7KQzqLlTbuBMefk4QaupBt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7Ui6YfVZXJ0IHSJT+xbQf0bfNd2EhdsevSW7ou4fE5nh2lbX
	rwCmzQJP2dy6DY9wVN2GnT4CPInpHo9RsGQB1gHDE8JUIZaMUIavUs55Ol+yvGjaYq0=
X-Gm-Gg: ASbGncvFD7W53QutPYqZ9bFxPD80Fo38pZ7e0QCMWzBErrkFzJ3ISuBNtrpT9A9m+h7
	10hsn+Swp6fZTHgugfa4VplE4iddhkXRdQUdQrdx5p3DB7wT5SZytIYpKonIJThRtygzzDhxGIV
	rnZV6BsjhJhAjHOLEtSLLEXG16bkTnS4WfdxzdTynK9R4OJnxzYHiNtkW1qrI+LY0J94I2fbZP6
	+HBk2++zkO70c1ipxNsUP21nvGztUprHKamdbdsMSUTdfvUO9iOEjUfRzTSRo5lFQ3bXXgyJ8rF
	r+aK6F2gb2oVf9N5yvzWO1w2ounw7rtNjyM3xWB0Z/4AevekgxPwCoXWxyGvnn7Kyq0MMZhMA5Q
	Ryr5rh6gY/Q==
X-Google-Smtp-Source: AGHT+IEmoGmvj6/jFiFEIH6q5tn3IKuIyGYTyKHwocESrbG6hPyhKHJ0KsJo3W1DKHQ1TFuzMd8Zjw==
X-Received: by 2002:a05:6a00:2308:b0:742:a0cf:7753 with SMTP id d2e1a72fcca58-74b50ff23acmr523284b3a.3.1751405859269;
        Tue, 01 Jul 2025 14:37:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:632c:d5cb:2b3d:e72b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57efaecsm12824125b3a.161.2025.07.01.14.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:37:37 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register
Date: Tue,  1 Jul 2025 18:34:05 -0300
Message-ID: <20250701213728.32064-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avg sample info is a bit field coded inside the following
bits: 5,6,7 and 8 of a device status register.

channel num info the same, but over bits: 1, 2 and 3.

mask both values in order to avoid touching other register bits,
since the first info (avg sample), came from dt.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Tks for the tip, @David, I didn`t know those macros.
Best regards!

Changelog:
v2: use proper bitfield macros + change at commit msg
v1: https://lore.kernel.org/linux-iio/20250621185301.9536-1-rodrigo.gobbi.7@gmail.com/#t
---
 drivers/iio/adc/spear_adc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index e3a865c79686..ff7fb13fe947 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -21,6 +21,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <linux/bitfield.h>
+
 /* SPEAR registers definitions */
 #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
 #define SPEAR600_ADC_SCAN_RATE_HI(x)	(((x) >> 0x10) & 0xFFFF)
@@ -29,9 +31,9 @@
 
 /* Bit definitions for SPEAR_ADC_STATUS */
 #define SPEAR_ADC_STATUS_START_CONVERSION	BIT(0)
-#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
+#define SPEAR_ADC_STATUS_CHANNEL_NUM_MASK    GENMASK(3, 1)
 #define SPEAR_ADC_STATUS_ADC_ENABLE		BIT(4)
-#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
+#define SPEAR_ADC_STATUS_AVG_SAMPLE_MASK    GENMASK(8, 5)
 #define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)
 
 #define SPEAR_ADC_DATA_MASK		0x03ff
@@ -157,8 +159,8 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
 
-		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
-			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
+		status = FIELD_PREP(SPEAR_ADC_STATUS_CHANNEL_NUM_MASK, chan->channel) |
+			FIELD_PREP(SPEAR_ADC_STATUS_AVG_SAMPLE_MASK, st->avg_samples) |
 			SPEAR_ADC_STATUS_START_CONVERSION |
 			SPEAR_ADC_STATUS_ADC_ENABLE;
 		if (st->vref_external == 0)
-- 
2.48.1


