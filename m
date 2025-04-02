Return-Path: <linux-iio+bounces-17564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898AFA79925
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 01:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FAB170742
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 23:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614651F891F;
	Wed,  2 Apr 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dpH1DHpc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBA1F8742
	for <linux-iio@vger.kernel.org>; Wed,  2 Apr 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638187; cv=none; b=MPKItYPokuvFEozbyJNndx72fOibNhA51iA6+ZNlNI0x1Nz8JBHyzgMlh7S7Wj5Iwsk6g3HShxO0EpfQfybw9tACPyEx0yjHr0C8Mmq/zvEGTPxeOVSVnYky+o7cz0NvTz06YC0C/8OjtCPJz6xg3zjFWWoYiQHmjMnz0Xl6D4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638187; c=relaxed/simple;
	bh=uiizrBkkBTqW3XgNsdY+NKHr9C+xFnQzIJMmto1lSL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uLI0Wl/WOHo6C1iY5ipT3AKwSoS7sRKzaJjL19GO2O+/rZZPTUzRWUS/G9UfTUhpiCTPy+/4+lMGrWldxp58Ov02BJj0MOYAyeRZfMp6PRMrLgbLuUpTWgO6WM3Ia1jzmlNN2Omh18iJ2cYvPE3LXM5/nE0THeLd9NbymiF60qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dpH1DHpc; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c40235c34so136876a34.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Apr 2025 16:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743638183; x=1744242983; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U84fsGmbM0MYlvtDoSFJcWVBHsJh/MexnRXMIlE8VF0=;
        b=dpH1DHpca1nitaWCr18zuw/64GnG8wadNesVW/dntc5vV1MnXG+zfR+YzlftRCoPFR
         vcSIltzhihU6rcgc79F71KTPsms/2qI/ZjfM1Qi3D/zU5M/5P96z6TK1+jjWK0EEifaU
         vZEQ1NYkkDUojDuszZkLxVlGq3/HrQMuvLUGXYFNWpwKObh9anTzUGOgvBl8Tl79FnFs
         GcPsplnsqWTkhDxLsD2AAHflF/dlGDL4t4ZMGcSQ6DmhayFP8bJ5WjsRMqhhAx4pk5w6
         3+akVkD5S0VjJ1SyyHlNR/XnukD8qa+lSWO4ZgWhfBEIN8ugtJLj6EQpssgAsu/nKwf3
         SIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638183; x=1744242983;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U84fsGmbM0MYlvtDoSFJcWVBHsJh/MexnRXMIlE8VF0=;
        b=MBT1BHdT7kXizI2XS2PWWpFJPP+FuaXiWCBMrtCfK+wyNAAKg4o9HpXwTp7+uPCHkd
         roQdrQhqkdYtKdai2Q69zfA0zuDatioA9sbTlhmJVrI+NI4fc2oo4mHtm8/x7V0v0U0t
         x2OBoGZwyN7Cac+7W7BQ9otSgDVRAeXZYPFvh9Nt1CuruRrslHiCReCzQMHUd0gDQfpf
         JQM7+33c0vvL0UKSoRNBg92QrhWzSiIgVtR7mEbfrwVz4uDxIm8b6MQH3DwNFbGkM5rd
         K3eWrIWIqSeh/huyYEXt3JjLTuENAKMskq1YSIHMmIB+AT6cX/AAPpbq+tUQ/ep5Rp76
         Xbag==
X-Forwarded-Encrypted: i=1; AJvYcCVlml4US4+vxHF17yd+ks+U9vbJNVctj+RRGMZfo7GnK+GvBDZ17IMORDJmla3KOtDw/qcY1M4+eW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrX/2DtUe1YaNraxmmp//JFjL0TyMC+xVfWTNJFNbySEm7KVA
	E62tGPeqzi72/88GCXhiHRVy3SvCW5TDlvTk+VOCKc0qwd/zApQr5GkaX1TNnEs=
X-Gm-Gg: ASbGncuWOEhMWWySJt3xMEvueEHQBHMcv61QN1XojfsyMT8dvRT/DrW3tuhZQo/aTfB
	9Y71nVwesMDsKpv808a4Lwfrdn7FDtWK0QDsYr6fty/DX4NKyDcJgshuafw+wl0judH1Gx3BG00
	eGWcRc/wP05zGjuZuHqV2oqkO31ldTiuwGtxAYYiBSHhEhvKXM9Pe1SgBwgueAYnxcYkGk+SuYw
	v4/yOBzdTrYvzGEnAbTt/uV927426+rqRIdA0S08EfxzxD0EXKTyulJwYL6gqCv5cKKUfivHAHB
	/fRDouF7T4naS0tj0cPYpzENt9pr8NaJSDYlaUzLoIjG93K7s4nOoifyY730kBfQt+nVOMoU2ju
	U
X-Google-Smtp-Source: AGHT+IHxwavlcu3eVlrKaPi0mNNmlbrWHSl3n8JBOTFFwrww1D/K6A1MV5UrnbV0rAf1H/jNtJ/cAQ==
X-Received: by 2002:a05:6820:1849:b0:603:fada:ac47 with SMTP id 006d021491bc7-6040b699933mr372311eaf.1.1743638183135;
        Wed, 02 Apr 2025 16:56:23 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6040c58f694sm46205eaf.30.2025.04.02.16.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:56:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Apr 2025 18:55:58 -0500
Subject: [PATCH] iio: adc: ad7380: fix event threshold shift
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-iio-adc-ad7380-fix-event-threshold-shift-v1-1-ad4975c296b2@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAI3O7WcC/x2NQQrDMAwEvxJ0rkB20qb0KyUHJ5ZrQbGLZUIh5
 O8VPcxhYNg9QLkJKzyGAxrvolKLibsMsOVQXowSzcGTv9JEHkUqhrgZ83gnTPJF3rl07Lmx5vq
 OqFlSx/Xmpri6MNKcwOY+jS3+Xz2X8/wBsgAs0XoAAAA=
X-Change-ID: 20250402-iio-adc-ad7380-fix-event-threshold-shift-b614db1a307f
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uiizrBkkBTqW3XgNsdY+NKHr9C+xFnQzIJMmto1lSL0=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn7c6PQwT/FsqVTGfQ+Cy2P7sFYLqv9X/lN5muy
 RCBYSwd77yJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ+3OjxUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAPjig//aH3rHftvitgIbG1fMeJqdqD5hG4fTb59GJse2Wm
 nAdW0NWgLl1M0OyQTrlAAKqLPB6NTx3Ewb0youn4YLBnQCGwWWD8AwBkbzl93uPDZn0dO8VSPdL
 pQ/Gh91TFDZjXM1YehCUPc+3o/9NAhTjip72kktBi+KbTaTbv1uQSwsauADVjNcF3Fgz30tCYKV
 Fb0NW3SuidglwqTWn6+cnT7KYjOtB/ruuI16GvT1IjEa0JR8EPFpVdL8CCF5ZZxSfKu56zbAzg5
 Y0k4THWlgpk2/Jj0tYlhNCmRN/7QjwDd/nAPl5p4LjewYjFFzs/3b6RM5dAG7ACQLPpP78ryCpM
 85wL3OCNA6SW7Il7qJi1V8AmsSq3h/nCApdWlQNnfDA5SKmLwj/ipmvoXu/nZ+TOEDZ3yolDMD/
 3x2nUCIJqRoHL2A2q8St7bjyXOPi6pierP6gELmyxbnkvtkb7iskE6jZDs7YpT7PaT0w+fw0CYO
 1C2UqcJCYii4AO1EjnXHolb6IX3n4I9boWzZJO83rioQXqUICb2BAQPIh6TghTLqsuNMq7if/KB
 kD5LhYswrsc1UxhuZVGgoGUssAf8lAnWDsvKZ8YXA4rLLsD7XPwO8gWlnbyw2noUEtXWpBQa+Ip
 UFWCkcmmI84VN/ozIbiZwLqo6tg3rtqwalsCMOtjfhrg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add required bit shift to the event threshold read function to get
correct scaling.

When alert support was added, the write function correctly included the
required shift needed to convert the threshold register value to the
same scale as the raw ADC value. However, the shift got missed in the
read function.

Fixes: 27d1a4dbe1e1 ("iio: adc: ad7380: add alert support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..f3962a45e1e5b88cebf712cc867fbb576d3ca058 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1611,11 +1611,25 @@ static int ad7380_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int ad7380_get_alert_th(struct ad7380_state *st,
+static int ad7380_get_alert_th(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
 			       enum iio_event_direction dir,
 			       int *val)
 {
-	int ret, tmp;
+	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	int ret, tmp, shift;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	/*
+	 * The register value is 12-bits and is compared to the most significant
+	 * bits of raw value, therefore a shift is required to convert this to
+	 * the same scale as the raw value.
+	 */
+	shift = scan_type->realbits - 12;
 
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
@@ -1625,7 +1639,7 @@ static int ad7380_get_alert_th(struct ad7380_state *st,
 		if (ret)
 			return ret;
 
-		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp);
+		*val = FIELD_GET(AD7380_ALERT_HIGH_TH, tmp) << shift;
 		return IIO_VAL_INT;
 	case IIO_EV_DIR_FALLING:
 		ret = regmap_read(st->regmap,
@@ -1634,7 +1648,7 @@ static int ad7380_get_alert_th(struct ad7380_state *st,
 		if (ret)
 			return ret;
 
-		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp);
+		*val = FIELD_GET(AD7380_ALERT_LOW_TH, tmp) << shift;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -1648,7 +1662,6 @@ static int ad7380_read_event_value(struct iio_dev *indio_dev,
 				   enum iio_event_info info,
 				   int *val, int *val2)
 {
-	struct ad7380_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (info) {
@@ -1656,7 +1669,7 @@ static int ad7380_read_event_value(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		ret = ad7380_get_alert_th(st, dir, val);
+		ret = ad7380_get_alert_th(indio_dev, chan, dir, val);
 
 		iio_device_release_direct(indio_dev);
 		return ret;

---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250402-iio-adc-ad7380-fix-event-threshold-shift-b614db1a307f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


