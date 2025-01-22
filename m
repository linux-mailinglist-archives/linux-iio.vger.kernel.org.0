Return-Path: <linux-iio+bounces-14535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A68A199E8
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 21:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BBC168366
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 20:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCE0212B1F;
	Wed, 22 Jan 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kj8ditcl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6771AF0BB
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578073; cv=none; b=nMpHVN88rR4n8m4pJwEAjuN/dQdtDtVRg+9c34Lad8yZhHTiPaPpebCS4vYMkiYjl6eJJDlF/KotyKBn07mCDn27w7QfHA3jsEEntiLRmOImIlW0O1lmy2hwBe1X04lzCUTHunyp2W3cZ9G1B/1DBRcvf35teLQ7OrLWeExORnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578073; c=relaxed/simple;
	bh=ch1RpWijp1fWZl4g3Tl+uEfEK7Dd7JeLzPKgYces6S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZjxaD86+Mzpi/5u+fauiKjw8+jLUyIvRHd5W3SJn52eBFPSoovhmcyc5OWSH2OHwCqmD49XcjNKlbysGPXvYE8ZRV7X1rokKZPjp+QeXywvLEGwmrlLcRE+rFfzIIH3imQ2aEQmCufJVlfZUbACuGS0QEZ8lSSt54bHUqYu0S20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kj8ditcl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f664af5so1959725e9.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737578068; x=1738182868; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZACCS8LylR+jGNrwgj7tmUyEA7q5RQFnUSgT2L73P/s=;
        b=Kj8ditclDGf31E901WeFwG3JN/JwbRNqsjkdS3EqCi4JASTyDhE2GF/5qOIJLYNBc7
         vq1oTik+1NhTZhsqGMNHh3GHHROlXzKAWowf8MYly204FaKoYZlgO+iM6fwx3nRTQjFQ
         6xTmDiLMQc6e1rn1/CDaZBeI57WWQDmx4uA98Suk1KlY9XCGU4LcMJDWz5eVbEez8lzF
         1DNMn/v5sltalUpeGlM6Go274S9YYAuGYib5B3FE/R4ewzXofMkXGbgfKOi+Fi3I/9T0
         CDwvbGHhKTR5Om/BHzoTHxKzoVlH69AmK3GSV89nexiC+ngBvt9j1iDlrF2LP/BB/5m+
         QtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737578068; x=1738182868;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZACCS8LylR+jGNrwgj7tmUyEA7q5RQFnUSgT2L73P/s=;
        b=tSXrbR+XPMpkMLulIxAsi8oF4eO6STUbUDXGVjS2AgBkSmi2mTC4jbLVbnP7akToyM
         q78Phiz6ZQBQL1KLWeLZwKHX68syQAoTMoZEKynQjh7zWVvzIEFGLpO8Xol/jRvgoG80
         lTMRtqtdxy8NLiT+0xOiOVHxS16lcO1Un2hhZoCNycEDKKFvx3BcMD6CzRNpS16tJctZ
         7LQebQQOSHvnBcE8clh02XZlXXap27wQtNUx21Kdjfa/qKtdqKTR+d7XgB1DvSW+Aylf
         OJtndZueep/b99p95FxIQHnL3G6NoO2sBaFrWm2qR6nO7wFyhiHctIc64XNs62F0rHrC
         mtmg==
X-Gm-Message-State: AOJu0YylLEWj6Vg7Yb/k5Ac54exk3B21QKzQ7xIuxABTXaT9iCZxZxcZ
	2yk8G0EM4wE3XhZL23FtBWGfbcFqnPARXCqKPxWstzN1x18qg1XRBtf0YAqV130=
X-Gm-Gg: ASbGnculSlAppHlojBXwETPhY5b05n9TsWc+0Ji5HcdyxXQT/4uqkwO3DjjFE800p8e
	AOO6flpnsV87II6Rn9kqG7tTnfHqfnQP21BFxdS3lcDRVcKWDK2N/ed5EMzTKSorYwMJP/NgFwz
	sBKZwoHETf57hVs4mIE7uX2W1xANktThZK2tPndXoYhgWlCzrvorP7nBivQ/2NRmQRJL2abq/oy
	FyjotdN6uvufuM7+9lr7TZYJouXw2jjijT7tvZdpoyMuLCAmD74uDpbhmrLXWuCzKRBv48K9aF/
	6h3JjewgDi7sqwYg5bKUIkoottElbdX2VdCvcxDW/BxPm0zyXw==
X-Google-Smtp-Source: AGHT+IFfpIYSbyOKxwzr09aamyu3D5Zv21dpcFR4HBpB3EKtDYWfBVKCghnORDHXja/NAaWvKl3fyA==
X-Received: by 2002:a05:600c:35c5:b0:436:ed38:5c85 with SMTP id 5b1f17b1804b1-438913df210mr233633345e9.14.1737578067484;
        Wed, 22 Jan 2025 12:34:27 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31af70dsm36652805e9.18.2025.01.22.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 12:34:26 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 22 Jan 2025 21:32:43 +0100
Subject: [PATCH] iio: dac: ad3552r: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-wip-bl-ad3552r-clear-reset-v1-1-04c1760ca622@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOpVkWcC/x3MQQqDMBAF0KvIrDsQJ8RFr1K6iMmPDoiVSWkF8
 e4Gl2/zDqowRaVnd5Dhp1U/a0P/6CjNcZ3AmptJnATXi/BfNx4XjtmHIMZpQTQ2VHzZezfmIqW
 EAdSCzVB0v/PX+zwvLy6QSmwAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the
"Error Status Register" was dirty (0x01). It is important
to clear this bit, so if there is any reset event over normal
working mode, it is possible to detect it.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index e7206af53af6..7944f5c1d264 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -410,6 +410,12 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
 					AD3552R_MASK_ADDR_ASCENSION,

---
base-commit: 07fa5fa97959422bbd663df056c9de0dec55e34f
change-id: 20250122-wip-bl-ad3552r-clear-reset-330bdf2ff56e

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


