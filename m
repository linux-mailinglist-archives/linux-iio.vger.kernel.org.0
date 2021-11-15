Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E479344FD90
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhKODqu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhKODqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:46 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE428C061746;
        Sun, 14 Nov 2021 19:43:46 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id de30so15425422qkb.0;
        Sun, 14 Nov 2021 19:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7D4nEFouFzhdepZfuhLsdMRJne14BoWmzVnF0SIgeg=;
        b=ab7lWP2hi3/tmDgXMkXDpXKnReAlfU0aGPgFLrE4wXiRZjludYe2nzHOCqZ+8YvFbW
         ISIjUj2+/3p4l98kPnEkxGU7US4zylEFV5R/FxUf8uNWx1cB3fz5c83paGcdSor2skDe
         XKMuYF4slMF3rVYeueLGaP/4po4DXbGARtE/G5yHnbOO4mqSrzk+uE4wm/mH7dYh/sJu
         vkqMNNtfoQ6feAjJETpnq2wGW8x0sgVgvtfkGReHZoQEbI0jxiQBq/OZ8EM5Lu2y/wu9
         3IV3bAExA/MNe2XTsbjtObU8Y6a6QvhskA3TZ7/vBFtMbBqiLqJ7B5Kvh7DO5V+L2457
         ddWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7D4nEFouFzhdepZfuhLsdMRJne14BoWmzVnF0SIgeg=;
        b=4Dj6Ei3ojQsbOId5cHNjCWvPLPHQYomSI6XFH7YNg8mctuaOCrE1FupFd2yEW1fQj8
         Jw1+el0FS0wyUUE0BZP8BYHMxDtfNTJDuhPLJxQ1cj3XcK3SIK5O0OvhMOXxQuBrnr5f
         lAgzn6LpHzjGVDjzaW3lNevJK6V/65yOZ5S3LUas+79BkZn3k80U9lq7KOrVNYtfaqv+
         IbAbiuJNELu7A8OcWOM2FzKYxIxSCb035V4eZV+KFwcbL8/IfaoRoRYzU5PZ72UDwdeL
         z/+VJ6BUxjhuCvRDZxqmkq9CaUSVgjaKPEpAuo4TVlLyEq//A1L+Plm/TS2At98u7vw7
         6wnA==
X-Gm-Message-State: AOAM532dA6zzFlbvWwzWc7Wfd2VtTyJ/iyxJSqhTlOdQq8lRy/Uqcjyx
        2b1lqHdZ5u0u1uhOT1/x26E=
X-Google-Smtp-Source: ABdhPJzBIXabjp14B6f4yQsRpcDDVHg49EgufMADMME53jbWIEAAkOZd+o2SFTNfG4X+KpPiz89HBw==
X-Received: by 2002:a37:b781:: with SMTP id h123mr26806238qkf.491.1636947826032;
        Sun, 14 Nov 2021 19:43:46 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:45 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 05/14] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Sun, 14 Nov 2021 22:43:25 -0500
Message-Id: <20211115034334.1713050-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index d0669fd8eac5..2c25a6375f99 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -22,6 +22,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	unsigned long long tmp;
+	s32 rem;
+	u32 mult;
+	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
@@ -40,6 +43,39 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp *= rescale->numerator;
 		do_div(tmp, 1000000000LL);
 		*val = tmp;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+	case IIO_VAL_INT_PLUS_MICRO:
+		if (scale_type == IIO_VAL_INT_PLUS_NANO)
+			mult = 1000000000LL;
+		else
+			mult = 1000000LL;
+		/*
+		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
+		 * OR *val2 is negative the schan scale is negative, i.e.
+		 * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
+		 */
+		neg = *val < 0 || *val2 < 0;
+
+		tmp = (s64)abs(*val) * abs(rescale->numerator);
+		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
+
+		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
+		tmp = div_s64(tmp, abs(rescale->denominator));
+
+		*val += div_s64_rem(tmp, mult, val2);
+
+		/*
+		 * If only one of the rescaler elements or the schan scale is
+		 * negative, the combined scale is negative.
+		 */
+		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
+			if (*val)
+				*val = -*val;
+			else
+				*val2 = -*val2;
+		}
+
 		return scale_type;
 	default:
 		return -EOPNOTSUPP;
-- 
2.32.0.452.g940fe202adcb

