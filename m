Return-Path: <linux-iio+bounces-28032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42368D3BF17
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC966363C23
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83137E2F2;
	Tue, 20 Jan 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIOrgQEu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8C37A49B
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890085; cv=none; b=r/uRw45iPARlzw8XaunIa8x9g1i1a8jqagoWF2rd6wKsvJRycMc4ENiGa02SEpcYVTT7VkJ4EAx6HXKDBb2oF4bJTZP77tWYIhapBvVFi1byFbW/q6tACXqBFOtPeD+L3rcPh5O8yz81LX9ph+abTlpevmaMdw3Tlyp2Xu5+MP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890085; c=relaxed/simple;
	bh=3P+X2YeLcPjCXYTP9cibJrgBqh+scSiCbpaQGpGyBmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WT3/9VWcllPBtWJAPyWG+nOM4HHMl3z5ICsjvrhDHvnZLghCPzRbupHtIiKrAa1LPHbEaFg7VJf0Q4vNjnXBLD2KppPJH3T7us+sdcRKR95GZ9xIkiiCS9j/2BcrSLSvf2kb8SdbTzBwo6gjTnqqze6BQXzjz/CBRRS3iUwOvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIOrgQEu; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ee9fa419f5so1074709137.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890082; x=1769494882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTnTVRGv/a3yeACWeWEj6KZeE3Y99K4b2EX+Zi7IhJ8=;
        b=UIOrgQEurYEnRyBFnKR9+ame2oPrvvlZap5p+VRjNJo/qHI13vEZsXejCcPJXQmZuB
         9LKhFLOlUmjONFKgR6FDCr1ctzO0Vd7CB5sGsw7A6kYzTNzr2axYBs5cT75rwRmtsyGn
         0GQ/exnNYJO1kaKGIBlcCQV2UsYXHnKqr3A+dmQ7W4Q5VW6rpXZzxqnDiuEi360DYRPq
         aUtIL6Mf1jbXmD1udF3aj3//QXjHebYL693fdPKpUfBBrrN0Q5g9PVlw8O8pUTFco/rK
         hyIZWSw446TwCNPV4MumRW9GwZgHkrPEEtY+YTTNqrlXRZ40/+Z/8CzMx3EO5HZPSB9X
         5PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890082; x=1769494882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XTnTVRGv/a3yeACWeWEj6KZeE3Y99K4b2EX+Zi7IhJ8=;
        b=KkLm25gZN7sOu5Eptx+83Mkm6vx0OG6E/jty1LSaGNIRoFnYgcAVx+eJZDO/4TY9Y9
         DE5xnhC8XfTMEvLewEbaX3xOSEi7qtC65FHZ/p5RD4t7rHmRlYPr4hHEW+joB/DNfa/J
         Zc4aACEd2BjlFMKVKABULA7iA2LRZmdOkh+RI8ugK80Ih9Z4CCCkfeeDOgxMsRplFAFP
         qy9ltCFHTX3b+GtwHSnLLhdCutYsTLjAQ++pWSWFJtGygl9JcgakZFc3xpcF81zpf39j
         lzD8uvao+mmt5+Cg/TKs8isBH8tEjgU6dneDy9QPULyzrQfkFZpx0A8LUakcLcPEwtD+
         K5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCyzBGPPGSHIGxFBelfwsK28GjA20oEn/IfaksCfQPvfn/J96JDM0ai95Q1uTKR1PtZBvMvl3UkFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsULv5x7P9cbl6IA8q5uGwINDwY2/qIxRn+eGVA54oSZjU1cZU
	qSDSxUeeLj0mRiPAXKCsc3u2YjZ60Zore+/Qsx+4O96ZOlg+Faa7S+RN
X-Gm-Gg: AZuq6aKpYiNy3EGw7NnHq9u/5SOmUhZBZtQq9CmSD3+wxkZS/v5J2OnIsFPmGb6AxLq
	8wnf8U/6RkhaE/m+AbpyWfBxZ4VYBJePVrvt0CEKUbqGQtgMNzaj78OgrNt0KDui18BwernfD5d
	ybvmQt/gcS4BZwCz3gxlh1UT5gBOoKyQ6TgxYlHzWWl7g/FifHX2LLJxbZdO1dXEuutnl43x75E
	s1xcI0KMElhv+Q/2SaydnMPSET0tY1mMUv1/3zxA2rClID6spQyPwNluLNcnSxs9AhkjRtqt6y0
	mDwdbsz5NXeXDb1XJyrzkVf/+BCP3F91l0QraBTyDu9bwy0WRW1WLUdhl1lUR8t2zZ4xyzfVFbu
	LKrJBxhbCYdCCkOUrB1cyax3+O18vJjfzOKQx3a8WmxZI9E3H/nX5Yr46CQqLDkLIYcqVEH9YYU
	3APWW2bm3gWaqR
X-Received: by 2002:a05:6102:c94:b0:5db:3cda:cc3b with SMTP id ada2fe7eead31-5f1a55a2fddmr4131102137.34.1768890082354;
        Mon, 19 Jan 2026 22:21:22 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:22 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 20 Jan 2026 01:20:45 -0500
Subject: [PATCH v5 5/7] iio: light: vcnl4000: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-lock-impr-v5-5-d4d22347041f@gmail.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
In-Reply-To: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=3P+X2YeLcPjCXYTP9cibJrgBqh+scSiCbpaQGpGyBmA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn5cpcjX77/P+Ht9JK3564ce7SMe8Lsi0pHqwPPnlObq
 T2hfbLQwY5SFgYxLgZZMUWW9oRF3x5F5b31OxB6H2YOKxPIEAYuTgGYSMZJRobuqjUF4rn7DC7P
 CjnyrLTDRX3vzVluW1fdeMXzP5qTUdSVkeFtxctSkflfmh1+PTm1+ExoaSrn3e2fs6fKu3Px555
 Jj2ACAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release direct
mode.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 49 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 4dbb2294a843..a36c23813679 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1078,20 +1078,17 @@ static int vcnl4010_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	case IIO_CHAN_INFO_SCALE:
-		if (!iio_device_claim_direct(indio_dev))
+	case IIO_CHAN_INFO_SCALE: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
 		/* Protect against event capture. */
-		if (vcnl4010_is_in_periodic_mode(data)) {
-			ret = -EBUSY;
-		} else {
-			ret = vcnl4000_read_raw(indio_dev, chan, val, val2,
-						mask);
-		}
+		if (vcnl4010_is_in_periodic_mode(data))
+			return -EBUSY;
 
-		iio_device_release_direct(indio_dev);
-		return ret;
+		return vcnl4000_read_raw(indio_dev, chan, val, val2, mask);
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PROXIMITY:
@@ -1148,36 +1145,27 @@ static int vcnl4010_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
 {
-	int ret;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 
-	if (!iio_device_claim_direct(indio_dev))
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
 	/* Protect against event capture. */
-	if (vcnl4010_is_in_periodic_mode(data)) {
-		ret = -EBUSY;
-		goto end;
-	}
+	if (vcnl4010_is_in_periodic_mode(data))
+		return -EBUSY;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PROXIMITY:
-			ret = vcnl4010_write_proxy_samp_freq(data, val, val2);
-			goto end;
+			return vcnl4010_write_proxy_samp_freq(data, val, val2);
 		default:
-			ret = -EINVAL;
-			goto end;
+			return -EINVAL;
 		}
 	default:
-		ret = -EINVAL;
-		goto end;
+		return -EINVAL;
 	}
-
-end:
-	iio_device_release_direct(indio_dev);
-	return ret;
 }
 
 static int vcnl4010_read_event(struct iio_dev *indio_dev,
@@ -1438,14 +1426,13 @@ static int vcnl4010_config_threshold_disable(struct vcnl4000_data *data)
 static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
 {
 	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
 
 	if (state) {
-		if (!iio_device_claim_direct(indio_dev))
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
-		ret = vcnl4010_config_threshold_enable(data);
-		iio_device_release_direct(indio_dev);
-		return ret;
+
+		return vcnl4010_config_threshold_enable(data);
 	} else {
 		return vcnl4010_config_threshold_disable(data);
 	}

-- 
2.52.0


