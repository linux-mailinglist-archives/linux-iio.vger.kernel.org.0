Return-Path: <linux-iio+bounces-27916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA9CD397A5
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B752303F0EA
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879341C8616;
	Sun, 18 Jan 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Ybyc6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5723EA82
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768751114; cv=none; b=Yy4EGDGgwnr06vhMYmluucNtg6Ai68zJxD5AMb6tVFHkpdVKTFiomSHHzO/CgcLiVyUwOvpTQbC1hq1tQDGoaxLzXmEKpLFhwW1jWKEXpOzyiiAiIGm62oUjlspU8Qs2/TYgctvOR+5NixuxaWu/wFiWwrZ6UEIx7zO4WGOIaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768751114; c=relaxed/simple;
	bh=3P+X2YeLcPjCXYTP9cibJrgBqh+scSiCbpaQGpGyBmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGFHqgC4T5C2iHxwrM+VtT38ivgStfj2VG2+KdzzTsF5w2XzDpxifR5o0bmFJpLwwXmXYeCbgXdRvwVtFK6EYF768CRRwlB+SFwiN5li4zSzydGOZa01TMqrJDr+p5q89BDXkM8OFGv0j9kNVoTe5gAr2O8Ycfed5mmXaWLrx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Ybyc6Y; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5636f0cf5c3so2641629e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768751103; x=1769355903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTnTVRGv/a3yeACWeWEj6KZeE3Y99K4b2EX+Zi7IhJ8=;
        b=P5Ybyc6YfqnlyWmGy32VNdiMLlZNTCT7BlD2kw4748c8ZeqqdO93cA9+ElL+zOW3IW
         QREGobPBHoEnBE13Ijo9yEeBgG2XOWcx2PTj6kfbP20vrpKGbZwK/BkgC4bR98/ZES29
         pG4zYSTvDz6XPFUSELXRCTl0L64MlPes5TMo/KBA526xyLEYkx2jN5ahxUpzZmwwTBvv
         sS/MUBwq4NLxUTdrBu08EOXD7vSS5UoSNf2bp64Vjlw/9M/L/OU9D2o9Aq57iRoFZMrF
         A6d6GCHmrNrTdZ02cusxE25QMjCFLKjgA5UmcdCCmKFrnhBv4vMi2tP54/IgpXrFmvWH
         RznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768751103; x=1769355903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XTnTVRGv/a3yeACWeWEj6KZeE3Y99K4b2EX+Zi7IhJ8=;
        b=Ow7q4tulKlN+FAXktCqKnd3qZffWnETObFTzTeCTUKriW3ox/Ye7iljfZmf1llqVMH
         20ptZ5yL0H9ZeJfLKgzT5zkqgsNUNyFHonBEshWWycN+f3nbNWhgpeh8W8cUq70bBT7C
         B/OPT6ZFLf7ItLMnqvrAkysPSE/Wtukge7Ggk50ab/qRqRhd1Lbn44v+7AtNpgRUfR+V
         lZRjwdRps2ltsQXGRGJF0nrpkz7ehXXx/5b0JbewRhpEm2mci/SiYEl3BD2clsh8nQKg
         RKSaLX6zMICjLvOhUDHsEregvW/CGD9VJDWTmJAEX1/5Vhybb3IkFlPN90D6Rau+IZwA
         cO3w==
X-Forwarded-Encrypted: i=1; AJvYcCWjA3SV+Luyv0bNwJ23DrxcwN7tCPaqMPWCLH3TOj0ip3mGFI70cpkOULfrbCky2JaV+rXg9a6EgHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdKYPnVGYvd+sTnnmoTC311H0EB+NjjmjtDDkBwB6eBkC304S
	kWmWu624wC7mWI13HRYJkpqrjNu3UTrxmJKBnzDh/QQYQCHjy1iqRH6d
X-Gm-Gg: AY/fxX56ytn084W+7696OsBB5AOqRBcjZHMMttd08s8a0Rib5IVxYyb/wwzqPwcX6cV
	JbYnR1TTrqYJ4GC/ygMY0Jb9ttNjzk/sRFIXXsTce9nl0lyubC7kmC22syIkJXUwpPQIKusKv4n
	G6sYQGeZ17PLUO767e+eZVn43WW8ke8Ovcb3bEvaghmnbSFNzBKI6jZ3BNpKCU/nvzkvew2KLwA
	sA5senbLPNgTfq4sClxHz27WjhBRabNWEJt4WpWaVcXGx8mw2v71N0ebuKUU4kePurfpAEaCqRv
	7Kj9Oo3b6okbZ2Yg+lCCMP8r6Wwj6FzpQJZnJ5nZBA2Vjk9s1uM/HGnGPUhKNFmtIVFiLNEJBtJ
	CHkjWo5xZnhu3ABAystBXV2yPWtHH8P/YFfCYwPLLSqmcfsvBwNCLakTrEL/xV/Xc3cTW2T4B9G
	yh7mwporGaAtgU
X-Received: by 2002:a05:6102:a48:b0:5db:cfb2:e610 with SMTP id ada2fe7eead31-5f1a55dce21mr3189064137.41.1768751103410;
        Sun, 18 Jan 2026 07:45:03 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6d3ca2esm2832731137.10.2026.01.18.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 07:45:03 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 18 Jan 2026 10:44:32 -0500
Subject: [PATCH v4 5/7] iio: light: vcnl4000: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260118-lock-impr-v4-5-6c8d0aee8ed2@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=3P+X2YeLcPjCXYTP9cibJrgBqh+scSiCbpaQGpGyBmA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJk5/z8+iJ4RHnlk3snQuump56fLnmzP+yR1+31BpOonj
 oP5N49ZdZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBENsow/I+9cd2l0P+rrurq
 RW/ydxrGWMhMORSpfOQDu0CYocvuLQcY/opzLnlwkuPZZJakczuqJ/W/OmoQ9l1TeGnI5QPW4gn
 fH7ABAA==
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


