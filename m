Return-Path: <linux-iio+bounces-14583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38795A1C455
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD9168669
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E37080E;
	Sat, 25 Jan 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IiwhHhXT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441F42056
	for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737822382; cv=none; b=ajNs69ot708JvbNC0yBnjql//Me9NBwM6VeWJs4Ylhh698ub+S8EWwZBXuUzrMJYd9BGqAlZJ6xg3XZEj2fP72//fHNCfsVMTvBIbqx6ZfA8RghgLI8asK8SGVcYFSVivY9Q7ABNU6jwwJLUqt3lI3TAFvJRrJiy2H+mGxgL9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737822382; c=relaxed/simple;
	bh=88NW+PmINLS7mBj2Miwa5PbMWVRW7QyrbprMJpmBW9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TjCXlOcl+AroJFfAKipbeD8yDJ3xjvlWO33zUxQdIZu7h+N6+jW7cx3dXqy7z52h8PxfFcIHnC6R2WcQqLW1VGBQwuDg0TrGN/7BTJnA1lOM+eBoljHf4V5PCYXw9Mfc8AZ8sz29Lw46EHWe2s7VewhSjmw2mMo970VPOtmnLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IiwhHhXT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3862d161947so1641235f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Jan 2025 08:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737822377; x=1738427177; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Xj21xtqCyZEzSK9EsgQ4oHpa78SvWziaGz8zFLpug=;
        b=IiwhHhXTYlUGUIA5Un5OUbfGzqi17QEKO1z+tfk0xwaGoY1EaXgZLEnJNJkPCFbtrz
         qvssTE4p+uFL1w1u4FbSMoKr0Vk7o1LLmRDdBNXEPFe0nkgaYQR0xBsJZmZoHxClbtY+
         ICSYm+WnYk3GqgJQ2SfhpdcZj4B5ODdOzYbzbsHyMHMofXfFnt93zOm2V11wKz1ZIFy7
         CAaWBDoSZOWqYvD5URjmil8Kd0mLmhAFNCh5+ZGd97i2nUxMlEqxZf1lChMjLwgPTmxL
         1f8J7UzXyy0tAkYqs7uZt9SJpQ9rua5Fu4MO+EgrOXPX0Ml90lT8C2CH+ITh/pJ6l9jL
         7/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737822377; x=1738427177;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+Xj21xtqCyZEzSK9EsgQ4oHpa78SvWziaGz8zFLpug=;
        b=ji7hS6J6xsPAfgfdj/WPoNed9X9bNA1rVusYBwKF1yWCm+0G8vUJKGbZhCmuPWorwf
         lqGYX55kYc5gocjYtsIwh6txgOBGu1Cn36a0NDZvhoXmZlkwD6cgdBk/zMMg/39d0uu+
         N481cZ75CKJ+GBqfQvrEcfaPkVeHNXpIdDiAmXynEogHLNq7UjuJNVCDZE+PNrckAWdD
         IZJrm0E2PAj2EiZG8nOFEpNFt1hwmt7Qa906DjPnuH4+thDsMxm0DvFvvfedjzT95QGH
         9+RO+wcULEk/JBJidfymE//mDwMreVtfPMmCcmO4Cb1EIUPkb+1EFNoe3hvVFd4DIIX9
         QEgw==
X-Forwarded-Encrypted: i=1; AJvYcCUhqh+ANkHyi+HSqt1AySnIZyHz8v/XwLwh5IecHLU101O76PgOHVoN4a2Gz2W0AppoowE8+ZVxoPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0PrjwxG3GowQjhlEHULDk84CnPN81Cte7PbZqPdFDPG4UC2O
	ew2VbXMlNkC/gd85H8Zhgbs/8gFfh7nxdPb2lKzoRX+VTegTgEpULiYpWndO1d8=
X-Gm-Gg: ASbGncuxsv5bWaARsq+KS+u3rVQ5vYUrrg/3XfHofVcgxzumwgO7DRkoOz/SrzWLZko
	ccKqd9QjuXumLKOeW5cYYtwb0ObQSNhZEf/VhZo4KlNJL8J8Fbd3LSXCw9COYYdYvk/2xTQ6MkS
	ZC3n4MI5qbhq4wY3Vqf6nWvbSGRAqrkbDVZU+FV28KKpbCYMTJi68wQ3fzvaZuF++FqKATuUwFZ
	hEhDsMiuv9rVggc2ONgocjqt6lqD5IzXbcHTQeq1yUitOkKiLA5fneT+QVmQwSlUnAnqgPHlaRs
	OBtM126nqgnYaf3HdL+01OGwdImkL2Khl4u3ufrCSpM7ULf+byIS49JBgaie
X-Google-Smtp-Source: AGHT+IHXaWRaLinV8OCxb0g1XcYAiC/N9s+xhH2st74bzDz2CMLQdQMY29B3CgPXVNOXi6i8RT82tg==
X-Received: by 2002:a05:6000:1a85:b0:38b:ef22:d8c3 with SMTP id ffacd0b85a97d-38bf57a69b4mr36086193f8f.35.1737822377422;
        Sat, 25 Jan 2025 08:26:17 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c403asm6008843f8f.93.2025.01.25.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 08:26:15 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sat, 25 Jan 2025 17:24:32 +0100
Subject: [PATCH v2] iio: dac: ad3552r: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-wip-bl-ad3552r-clear-reset-v2-1-aa3a27f3ff8c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD8QlWcC/x3MQQqDQAwF0KtI1gbGyEjrVYqLqN82ICqZYgvi3
 R1cvs07KMENidriIMduydYlQ8qCho8ub7CN2SRBYqgk8s827mfWsY5RnIcZ6uxI+HIl2mtTa3j
 gSTnYHJP97/zVnecFigiRI2wAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Clear reset status flag, to keep error status register clean after reset
(ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the "Error
Status Register" was dirty (0x01). It is important to clear this bit, so
if there is any reset event over normal working mode, it is possible to
detect it.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 9d28e06b80c0..a44b163f3183 100644
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
base-commit: 0e5dc6cf754b65ee7f945a100ee2984a1c591239
change-id: 20250125-wip-bl-ad3552r-clear-reset-12aba63a08e9

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


