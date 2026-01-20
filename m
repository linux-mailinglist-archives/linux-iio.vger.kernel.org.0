Return-Path: <linux-iio+bounces-28033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4339D3BF1A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB564F1F50
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41637F8A2;
	Tue, 20 Jan 2026 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3KAM4V+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600C36BCE9
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890087; cv=none; b=E/hx+QQLVIer+sX4uFTtea428jwrk0Ih565mF7M8pqnj/kBQAS4XdtSTdvN7Qz4s8oinMlCW/kF4PQqU8UuVk7QbUE0TC6GG32rOHEWdpEOO/+AuCwzZKfHXUIT9j36+2YS3rCQgGdk8xCKR4Zzg5ZIoTetvu/C6NVhYtaVDFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890087; c=relaxed/simple;
	bh=R6AtgfHNFuyoDu3Dt8So6HbHkHEi4svHf3KFVpxGpRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2zVvXFgrfJolvfSsL3Ke/NekPoLaIc7xfhWqqucXwerv5HI6iVux7C9X93sEmt364U9PajK/Zd1HmJ2lR9LC8SBn7G3FSGC2RY6yKXbcc1UFXwbJZJKYj01q3oOae/CUNLtNDxRGwMBRF1eD9wg6ChPd0m5Y9fYe77mnALdWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3KAM4V+; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eea6f90d7fso3533518137.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890085; x=1769494885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvaFKco8z0TcIBUmMpdNSTwRtZj3x2smNoAu0imBUvA=;
        b=C3KAM4V+GS5+Ez8w/HTF/une3gdoJQoiYI996ruNMpSlB3VSGoopswE0qLXLdA9wt/
         Yy3QBOq1WqUp5wILnxd7KY7ZwtKnM5Go98nx14VZGDm5DeqKx8w/hwTRtZh1jsaXIX7U
         atfQdpx8NP6E2JZ9rKmxb0Q1B++OLN/sAEMtjlX8lxG16z1OB+3WkQsAxjVt2JJ32aoU
         HGGW+2JJReQsF5jt1r5+qbbFJICdyUOCgzJ9MVi81q0bDofrR20d/Y5sXIVAdpxS0lfc
         tqrFI/UrZ+IPiBfBF44zsQUf/m7FABvnVcyFwRlaYtY6tRuWYMiyBWNiP9MxHEYM92d/
         shPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890085; x=1769494885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RvaFKco8z0TcIBUmMpdNSTwRtZj3x2smNoAu0imBUvA=;
        b=AzmxP6xTA90dcbe4YdFEW/4WF0WvgRct2haaHi/P92LDQ2CWY7DJUAuL5W7DNxG1SV
         dq+Dj7h1iam5mgiFaY926f7Hd5Oz0nq/6pYnCn4fUQKQruUGMv+G/4logzePVCJkkhIr
         lKMYPFGSzwrWiorNlzllEXhTLboIUXXytJGqjglLrwRsVEOYk8TEdASob96NeX7VbpbR
         xW0s77PfR0hS1JUS15t8Z0FGm4ucicVfogBNcVE9Yy3pdpvvhtgN6/4gZQusLnI5wtn5
         zjbvhdE8MmK9Tl9G/KrFXtu7i495Q1CYkUZQeFQQmrZULTnUek5YLfm0fwK+HaBcBcB8
         cr0w==
X-Forwarded-Encrypted: i=1; AJvYcCWFnnxgE6c1YuPSgsWxIxr9xArWemYHzTW8aaOglAUs2x0Pqt5Rz1PfSWWb4m+ZjoS031S2YetPWBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPWIvrtPn6xVDjg+Twe/LE1m5loWReSof43a5ntTWcnf69PlYP
	5Og7aSdAGcDN0ysgArLKOrQl2HgqKnnGer1hKo1DsUfGng6T+hTX0hQq
X-Gm-Gg: AZuq6aLIvLsrmLBuwFIxdJ76UnznLxG+EVl2+O5CAYXZN3mRa+B5Oire8vjryotnZSa
	B02tWulR4VIDYIyPPZ4rGgoa3uQ4HlrbM3FHPmF1jEjVSxLjojEKgeOq78VRsuHHJW9j5JzKi1/
	5w4YA36B52rxhP2vX8Z+SbfDMOs/68Us+lC8m4WKEGI2YygKRxef4m2K6vmF+fUclJOEMC3NTpP
	NGc1zN+KtO+hGP21yGSG2u3fDE/LomjGy3FLrUM/wOIeWK0MdPFqtTwinnVOi3yOO7KKyzn2H/i
	JjKl5Zh9YGoHLz8kX/36WmJrUEdcfGtwMlXbFB5IhdqjGUwNlqgTTJUD9JiDHcWeTniR8ashx+f
	MHh+DgeUV/8CgBqwWOG3ktYIpV4dGNkahRwXNTf6PDcKA/MoOC06AhhSM50GLSdG6YyJEuG5E9I
	8p4b/UKnn73QVj
X-Received: by 2002:a05:6102:c0c:b0:5ed:a24:1a98 with SMTP id ada2fe7eead31-5f1a55e599emr4178016137.44.1768890084657;
        Mon, 19 Jan 2026 22:21:24 -0800 (PST)
Received: from [192.168.100.253] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a6900c1esm4057944137.3.2026.01.19.22.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:21:24 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 20 Jan 2026 01:20:46 -0500
Subject: [PATCH v5 6/7] iio: health: max30102: Use IIO cleanup helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-lock-impr-v5-6-d4d22347041f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=R6AtgfHNFuyoDu3Dt8So6HbHkHEi4svHf3KFVpxGpRY=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJn5cld4PVkXr+ucZnJwyS918f2KXWyhifIiBqXPPnDtW
 DTBSOlmRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzkhzXD/3wb/gNpl18+bNt8
 9Nl/N9u7+uz7G8+HMO85r9p15cMGEWmG/9kLLLl/R1kvsVLoET5XJW8pd0Z0ekKpYf/HXzz/F61
 3YwcA
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


