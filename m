Return-Path: <linux-iio+bounces-21851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D153EB0CDA2
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 01:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D91A3A63BF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 23:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8F235BE2;
	Mon, 21 Jul 2025 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZvPYGopL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F602AD0F
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139807; cv=none; b=Y2hniA2qtzNEKUVp6i22tKtDD+LkaadL3qFz73J+1JGkqserAFYZPwOYb943/XG2SWpgYJpmPw4BdJtiWPktAwmyXxQZo8Xrz4azP7s2SWAkdzludjii48P+t7jldTdiqPH9DFC/ZVLYiTX2eWB9v1TZT3vzXXngyVNnxNNiXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139807; c=relaxed/simple;
	bh=PPvaW0EnMm8pKkdbsd1mRRlh8QM9vSbRder81ICwCrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GqjYACDNDM148mFkI3ABvPk5y1tG1RZziPLbeUHd5b41VglQIKdC7T2K3VV2ahwitZe3KgoIUIAs1f76vFjrfJReQvOcaU36HnMhqa8JVwnzFlm1TGK9IN+gGXxdOQUt8YvIEH7TgWZ0kR/jcFrW9ePYdhwlLPOxAtTc5NV906o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZvPYGopL; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-615a68bd0efso1111373eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753139804; x=1753744604; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fMbRTo7KXOrYlWOyPpNSRios5M5iB0JnRGzKt7FxQs=;
        b=ZvPYGopLeCpmQvB2cAmIStm+MwqFcFYsJ+7mmFCOpzvt+HkhWIr5uNYUclDIpGuuLv
         MjzG6oeVeDhSf/k0aWNHXUQLeuuCOM/UdILGq98MIg97P5Lgi/A4V4QVDp6VVQAA5zob
         CqyyJBOdEOvzsSahLDIQOYWXsRe4VOqDZQ7oLTlJRmCbU/QmFzOJmAPnQuj7/WTrGq81
         1Ezg83Z1lxb4aK0h/zkyM13DrRhHoPxUzjpK8VnEhUIqYZZbc2vk0+hfkvupNOyHACQu
         XO8olmkf1qS0BnHlZpTj0GJc8V7sQeN5U2mmQi7Zc9v2jB0ZDf9XWz6GKg/g2DcGyRgn
         O0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139804; x=1753744604;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fMbRTo7KXOrYlWOyPpNSRios5M5iB0JnRGzKt7FxQs=;
        b=CYk5CdPV7bMEVaSthZQT1hyNxAAS6F2ufSXM/z+H5qk/zrtUspbiPhkpY13GZRyahe
         /4FVJwmmfm/bftZMEwN/aTqICwemi5igKdAvQRzwGYdaO30PxnS5UcB6uQHiMPodMnaA
         dBgBCFPuYlwLGqaiYiV84jYVrvyJgCwfr4fCjQurchlp/PQjxXmIET6f+oEnDtcZXR5V
         5MAtZbyRb2txfDcMWmBFuP01+vbsSxcLtl+Df5YCHmzvfdzZIXeV/HHtfoNRkg7PmaD2
         Ln8V6myatL/TEQo3HKB0YdIGo48kA5nfJWWxpTSxrmKnmNzfuah5l0/VmzQqV7mKzIsJ
         sTzQ==
X-Gm-Message-State: AOJu0Yzf+2R0iAfYvVtBPiDQP9TIR/71Ri4wq6viKlA2apJuTkHnSKXI
	wZ5n2JIFRuUZwBFIynH4VWanSXyfbwDATV/UiyMOwqCuKimXFjEsVcRQcoBwxy48XnA=
X-Gm-Gg: ASbGncvNR4cQ9aOlVxCwRqpy+VTXdC+x9/wi4bNaWi/3IwfPLRqEqkceB5SoKc5+Z7L
	M4yWaJFDQkHb7IrAEj20N9oJQUZ70R18fY38PXTomH9OB7NIZIF/1P0TlUvlwWa5SZgUUXgnse9
	PbaFnMAu6dUjdKGZqviMNurSa8CvDbUiVQzhanC4bJBLHO+g5+rn/motzRFZa/q01G3NK3eVHLU
	P4oeik1SXxakK47vqbBN725Idm6aA3e1WI0+4KA8zduldWS/XF1HqOI2AdECUYEu5d1J6akAcgZ
	is9v9mfG6HbRkh4yMt44rc3rmZG2FDnawaBWNTGxHL09vPLoOfTCSvtH7FhlVHfIi/sNe4ZMVrV
	yscfh2qDydOFdal+FXyiNT28oc2u2
X-Google-Smtp-Source: AGHT+IEecxK8ISAcxJLFa0bhXPE/Zs+iIDulRIo3El843fns0nvMZ9Ojv3Gl8Q44sHOOoOmV6TO8qQ==
X-Received: by 2002:a05:6870:71c5:b0:2ff:9ed6:2268 with SMTP id 586e51a60fabf-2ffb22c138bmr12748201fac.15.1753139803604;
        Mon, 21 Jul 2025 16:16:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b719cdsm3264185a34.54.2025.07.21.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:16:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Jul 2025 18:16:34 -0500
Subject: [PATCH v2] iio: accel: bma180: use stack allocated buffer for scan
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-iio-use-more-iio_declare_buffer_with_ts-v2-1-f8fb11b8add8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFHKfmgC/5XNSw6CMBSF4a2Qjq1py0Nw5D4MaaC9lZsANbeAE
 sLeLezA4XcG599YAEII7J5sjGDBgH6MUJeEma4ZX8DRRjMlVC5uUnBEz+cAfPAEB7QF0zcEup2
 dA9IfnDo9BS4qlaWlsmlpChbf3gQOv2fpWUd3GCZP6xle5LH+31gkl9y6IqtKl2eiyh9ts/bYE
 lyNH1i97/sPfe+xw+EAAAA=
X-Change-ID: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PPvaW0EnMm8pKkdbsd1mRRlh8QM9vSbRder81ICwCrQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBofspTLuyOLAEWr/Rtwv0BARtcQTKfV4geMYL3x
 GIyUtM04KaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH7KUwAKCRDCzCAB/wGP
 wLckB/9mZiDOtmMb+OKE2Tl3ohXlqcoEcJT8V4niu5WpwweSJtRZrEAIdewuDT+Dtp5zPSEUA8A
 0rwJ3N4tgGzcFzI0ZjCzJjY6gvsA0ePRoC1JPg6yFKT5wX7kAjTlHfY54MU/4r1TlYpaCcvFCOR
 3BU3jFUv3ia0iThm/2CLUBDMnOA8eYiEE7Kz36T9pODeyvZRzpb5YYws5gjRKd0QjG0wowYuvgT
 yz9Fc7Xa6V2lyuo74qAwnXPFT5spRk84+us6k8K97wqyf3WoQJ8tjIWCAbwJC+lyrDdEqS2aSQ9
 UztpHL1tDnb4u/txXnt0pOLhod/uDwcobtx6uPgnkYLJ4lQP
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move the scan struct to the stack instead of being in the driver state
struct. The buffer is only used in a single function and does not need
to be DMA-safe so it does not need to exist outside of that function's
scope.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Preserve the struct instead of using IIO_DECLARE_BUFFER_WITH_TS()
- Did not pick up Andy's review tag since the entire patch changed.
- Link to v1: https://lore.kernel.org/r/20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com
---
 drivers/iio/accel/bma180.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 4fccbcb76e0423bee37463a72c637af80e356a19..8925f5279e627a67c8e2928b10bee04185663e10 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -139,11 +139,6 @@ struct bma180_data {
 	int scale;
 	int bw;
 	bool pmode;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		s16 chan[4];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 enum bma180_chan {
@@ -870,6 +865,10 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 	struct bma180_data *data = iio_priv(indio_dev);
 	s64 time_ns = iio_get_time_ns(indio_dev);
 	int bit, ret, i = 0;
+	struct {
+		s16 chan[4];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	mutex_lock(&data->mutex);
 
@@ -879,12 +878,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
-		data->scan.chan[i++] = ret;
+		scan.chan[i++] = ret;
 	}
 
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan), time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


