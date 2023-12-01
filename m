Return-Path: <linux-iio+bounces-531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9458980076F
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDCA2818F8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88591DDCC;
	Fri,  1 Dec 2023 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiVF9MGq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7EC193;
	Fri,  1 Dec 2023 01:48:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1a496a73ceso25226766b.2;
        Fri, 01 Dec 2023 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701424091; x=1702028891; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Guu0Z50m2NZpOq4m9gWLYS84w8ajfYt4+lCW/K6tb6g=;
        b=RiVF9MGq/8Z8UXLSLe/CtKb1vkdkKR37P22KHWQ4T56fakhIHvojOVsDzMW0Veujzk
         5uu+1rrBgg0yvgbiIY6t/sq3y+QbfPlzd+2AWfEkaF1xC9XTWv3VFwuHThlD75q71/BU
         9eK83jZGsss4pMN5k0wf9XmnbIZaH34O0GSRoTRazuNUX9ktaOfNdo7P2v1a5iytS6oD
         KXiF7XgJhH8ikn7G19YHEUBhDko4PjgUKYflsie3FtPJ1iZIH0jgnjhLsjQYuqOD4H4u
         mZ0YQkbkVsaYBQRXNEMwZgy9PbpgnTxdKHsx2x1M89IKXK93v5lRPBHDdc3b3FyO/GrN
         rYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424091; x=1702028891;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guu0Z50m2NZpOq4m9gWLYS84w8ajfYt4+lCW/K6tb6g=;
        b=dvoGCG3xAMf3CGlhDylk9WC+jR3OevPSqHjdz+d0QuXN656ofBgKVQuDxgVZ8I9SYl
         VDkVkjQda+hJommxonBhi5E1RSPuxSKrKNHzUbjD3s/C/5YH+0+NMl8Q1VsyItH+V2wW
         3IU8qRgdHCBgjpWhQJKTwEMIMyvlh0+y1RwO4heuT2Yq/NETuQwB2gV5G6Ros4ynfl3E
         FPL8kPtD065T2IUrRzRASUwuHTPlPSMNukQUOxl3ssVLEF4Bmo2EOOIq9SuzVaHkaziq
         UyZwmHCP8lglcB0630498oSG15QbMVrvw9UPjTXkoT0hEdZzqObh0ijUkezULkNeNNjA
         HYlg==
X-Gm-Message-State: AOJu0YyR8xqzT3rAPQa7ypvKmali1Re0o+otMUc9F8CpR6pjPB8OldbH
	03oxiBWx/+zeeP641o58iUI=
X-Google-Smtp-Source: AGHT+IHGZMB+1B1VmS3RpdNwho4xsETrc+UfNZcwqsNeG4+lcNfzZ3TFB0Z6zyJz2szncVeOdsJ3Ug==
X-Received: by 2002:a17:906:2c52:b0:a19:a19b:78d2 with SMTP id f18-20020a1709062c5200b00a19a19b78d2mr661399ejh.149.1701424090832;
        Fri, 01 Dec 2023 01:48:10 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064a9800b00a0cd9d89a00sm1690019eju.151.2023.12.01.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:48:10 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 01 Dec 2023 10:48:03 +0100
Subject: [PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range
 checks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-mcp3564_range_checks-v1-1-68f4436e22b0@gmail.com>
X-B4-Tracking: v=1; b=H4sIANKraWUC/x2N2wrCQAxEf6Xk2YVN1svir4iUNkY3WNeyQRFK/
 93o45mZwyxg0lQMjt0CTd5q+qwOuOmAy1BvEvTiDBQpIUUMD57Tbr/t26/suQjfLRDhIeacMqY
 Iro6DSRh9wsXl+pomD+cmV/38v07ndf0CceiHRHsAAAA=
To: Marius Cristea <marius.cristea@microchip.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701424089; l=1792;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=nIPr2xEMTLh+1l6N+HRiGtOkvXXVgwfQC5WjZjTJ+xc=;
 b=htgQgbGNIqqGqd+4j6SV19bIeaKy11mDcMt1CI7CJts4ZLKGRfdnJaKHauDzx0lIZtsEq3obi
 r92GtNj4RJMC9YJ7pvOdsbYiFoHuJ0NWZid0s0K2UEVxI0RkSLDXXvq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The current implementation uses the AND (&&) operator to check if the
value to write for IIO_CHAN_INFO_CALIBBIAS and IIO_CHAN_INFO_CALIBSCALE
is within the valid ranges.
The evaluated values are the lower and upper limits of the ranges,
so this operation always evaluates to false.

The OR (||) operator must be used instead.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This bug has been found when looking for use cases of IIO_AVAIL_RANGE
and the fix could not be tested with real hardware. The issue and its
soulution are rather simple, but still some testing and confirmation
would be welcome.
---
 drivers/iio/adc/mcp3564.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index e3f1de5fcc5a..d5fb1cae8aeb 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -918,7 +918,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&adc->lock);
 		return ret;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
+		if (val < mcp3564_calib_bias[0] || val > mcp3564_calib_bias[2])
 			return -EINVAL;
 
 		mutex_lock(&adc->lock);
@@ -928,7 +928,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&adc->lock);
 		return ret;
 	case IIO_CHAN_INFO_CALIBSCALE:
-		if (val < mcp3564_calib_scale[0] && val > mcp3564_calib_scale[2])
+		if (val < mcp3564_calib_scale[0] || val > mcp3564_calib_scale[2])
 			return -EINVAL;
 
 		if (adc->calib_scale == val)

---
base-commit: 994d5c58e50e91bb02c7be4a91d5186292a895c8
change-id: 20231201-mcp3564_range_checks-221708838130

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


