Return-Path: <linux-iio+bounces-27915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6193D397A4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C0A303E40D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A41DF987;
	Sun, 18 Jan 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lolg1dOg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77912DCBFA
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751113; cv=none; b=T9ylLmOQqrufcF+vBNQ/7qajsm6YMxxi+4hMhTkCRUM6SK/rvO/T2faffvF8otx4iTppmL0no8s8F8mhmpp+RFsIgI9vgWAKiMlnqszYJOJNpOd766Vg0+8lvnAFt4/N1WSTJx5+1nEs5z/rEI6ggfPV4I0ah3ICWwma/pSg7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751113; c=relaxed/simple;
	bh=R6AtgfHNFuyoDu3Dt8So6HbHkHEi4svHf3KFVpxGpRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHunoZJIR6/MUIzkcfZZVsGVbBFAKpKWWHfw01grdtWtTVuuqkqt1ynHBWGijKBzVoRKEts2cYVvflUhKnsrdBs80Ipi2NvavzD/6nxG4wKtSTJ0eHKxhQBq/fVENE3q3lYixsldRXB37zWmYKepb73vTRAHF1yLxZk6gJ+q25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lolg1dOg; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93f63d46f34so999459241.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751106; x=1769355906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvaFKco8z0TcIBUmMpdNSTwRtZj3x2smNoAu0imBUvA=;
        b=lolg1dOgWJd47bSmHyJzpBaZPk1JVQYIa37zmHPlOGAFugA8zTiino2Sx+L5Tia2mw
         CKF/fT4DyzsJpUf7BtCZzNeXCZuPpdjH9rT3KvlL0I8Q/0gHXik827k7ZM8QwOwYFcCC
         Pp/yhbN5SyTsAr9c7WE4OH8H+w47CJq7nuyT3Nn6wff+ScczZXTlDdu2kx7vjJiz6K71
         +FypK5gJFxH5z9xwdDiz65SFYVq+DNbOazGumUEW3neLFeIVXdcivt3cmk4QjEx2Dtjm
         5OKUk9MO+2mSc40a/zSwKs9b9jjK/3TJPt2IZsdvQvaZBEZW/ZSfd88bxMw8QCdRzYnk
         wZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751106; x=1769355906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RvaFKco8z0TcIBUmMpdNSTwRtZj3x2smNoAu0imBUvA=;
        b=bV6JgeWIUvYUYUruIGTor2qVorZ23yARVYd5XzbxxkNZ+OwnJLChhmgiErIwbnYDIL
         xwGh9FFaNV8qLFQtzumczPK85PWm5PAEa5CXk4DWV/iNxoMtHJwEl5rDzE5/FMTlqqo+
         YLRa2xAoe6xpfLnnrTngMnyhVjggdLKXZHS+OqDyP0/EOf9gZcZIgXbgq8z0U5cqY13J
         36sIqduoWl5y5DopNQP09EIup9YX7WTu9/3kjFkwer5Uw37FzjUsdFWwXP3FGSKq+sWN
         Moju8XannYUDf07LRZsfO5ow7ZJxxKplShJLv3K1c+QEv6SuCnc1HLE4ZugoN3vwXbih
         +bpw==
X-Forwarded-Encrypted: i=1; AJvYcCXYpNToF59WjUC36OvFfVVhmeUS6OW2B2bHHb1bg427GDSXE0teye/SkJX0tVGY+OKmW22HJ7vtfZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaKq6cry8NS16DOPX5xYeitzWIrAZdfPHPufIYRBp03XtKm7Z
	ZbVtJgeVtXg1QreDBNKdu/0dpgKDJfo5eGN8y6eminypk0ylqWXINYQx
X-Gm-Gg: AY/fxX6taaYr8C/c1EuutOalKFgkzoKh7TmEBVI7ZQ0ErQsYy0wToFS5CQrtGqS8K6m
	naWPkQjIker29UBPVeZtRdurw9GFIZHLIoOzJQg1cX1WRnQ+0ZEBUDuS+A7Fizyr4H18mXzH5QR
	MgzsAVuUytWXSnXqsYJZOToUkzq9WWAx66JzHDSKun8AUPFQ+lV2gSSg2dFXhRHgiP6/6SPBTCK
	jNVvb9Or5VQGWiuhe9N7+TRK9Q1sNeOGYMLPEoHuEIIrgh7Xypb0rruO2BZ/bBbhXu8ypqcF46n
	zKWORV7c+bqerxWFgg/RD209u0hu6n/VY66UY0Z4ObJYjCskKmDLgeDUGb+P4VWuQNSpQD26Pec
	2Qb8ccEufblryfiDX+gHM5K5Do59lcJuIfPYeueHo7WFfFzeRwoXCOLH0gTVWt4W+ACYQalQAdg
	fg1gxMWj9/NLBE
X-Received: by 2002:a05:6102:54a8:b0:5e1:866c:4f83 with SMTP id ada2fe7eead31-5f1a558c2e5mr2344860137.35.1768751105696;
        Sun, 18 Jan 2026 07:45:05 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:45:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 18 Jan 2026 10:44:33 -0500
Subject: [PATCH v4 6/7] iio: health: max30102: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260118-lock-impr-v4-6-6c8d0aee8ed2@gmail.com>
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
In-Reply-To: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=R6AtgfHNFuyoDu3Dt8So6HbHkHEi4svHf3KFVpxGpRY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/z+KsaetvqNpz/Jty55VRR2Fgt/erzJ7WWW/qmtL6
 owrzOY2HaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCR83KMDLN6GFbuZXgb8nTK
 hNfPlVgneCdYrJYODnP+lLol0mPd3R+MDK1liWf0Ek7wrZlqLGdVseJgb7CSX1n61T05E3JfMhT
 f4QIA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_GUARD_CURRENT_MODE() cleanup helper to simplify and drop
busy-waiting code in max30102_read_raw().

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/health/max30102.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 6918fcb5de2b..47da44efd68b 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -467,44 +467,29 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct max30102_data *data = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		/*
 		 * Temperature reading can only be acquired when not in
 		 * shutdown; leave shutdown briefly when buffer not running
 		 */
-any_mode_retry:
-		if (!iio_device_try_claim_buffer_mode(indio_dev)) {
-			/*
-			 * This one is a *bit* hacky. If we cannot claim buffer
-			 * mode, then try direct mode so that we make sure
-			 * things cannot concurrently change. And we just keep
-			 * trying until we get one of the modes...
-			 */
-			if (!iio_device_claim_direct(indio_dev))
-				goto any_mode_retry;
+		IIO_DEV_GUARD_CURRENT_MODE(indio_dev);
 
-			ret = max30102_get_temp(data, val, true);
-			iio_device_release_direct(indio_dev);
-		} else {
-			ret = max30102_get_temp(data, val, false);
-			iio_device_release_buffer_mode(indio_dev);
-		}
+		ret = max30102_get_temp(data, val, !iio_buffer_enabled(indio_dev));
 		if (ret)
 			return ret;
 
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000;  /* 62.5 */
 		*val2 = 16;
-		ret = IIO_VAL_FRACTIONAL;
-		break;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info max30102_info = {

-- 
2.52.0


