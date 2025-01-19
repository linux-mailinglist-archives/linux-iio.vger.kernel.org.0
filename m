Return-Path: <linux-iio+bounces-14484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD735A16361
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F157A1D53
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E791DFE30;
	Sun, 19 Jan 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMQbpUIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871B1DFE00;
	Sun, 19 Jan 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307930; cv=none; b=LJ9cNeERysuLCPVFHTgjyX/bzOk4Be8LfKK/OK50H4mbu29HQqaeym61Kc03t30ehDaldmF8+AdooV7VRQoAfJ2nlCZR9nuvBUJeR6hG/fQ70nz6dHsfVbKBToYie2fVfZxyJG57p7lokP/xt9YkLLMeRW6OL+//JIi01rzTnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307930; c=relaxed/simple;
	bh=X+gik003pUjGH6EpnT0g65+Tv7caOm3rtNdVQvkAvo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lN9OM13JyHbYFP/vo4O9N0XyJEoiZGJF52zbLx9lwUp2qrlmgawRiydDZ6uxaX+rGLnOEvlSt/d+gwyZckGeN4yh22NwWRwpJmfbiBWttVqTuSYQ/0uDCyTs/ck6fYKSKqdBAiHX6ibwViEGMJIMXj0laDTPL7uU76MUX3EgHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMQbpUIM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3863703258fso3093694f8f.1;
        Sun, 19 Jan 2025 09:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737307927; x=1737912727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxDF4yAopoLdBEL5nQVbQt/glTNfJL6eHs85UPYu2Kk=;
        b=bMQbpUIM4w0+EuCA2r9KizqFRpkF9bAyBHscaWMHtv4C2Ar4ht2nKQt05kJfwb40N5
         LHa1zqFY/M5pSZHhvVdI+yC88q60vpQ3cDMBiyn6KxZEWq4g/jLWNqcWwy+d5QXJtcZo
         zBzsta/9h6M89fuK0/dsAD0w3f3gmOuDbxXrtOaQVvvHjCk1C6TrP8NRzGG/Z7zs+DId
         uT1wO1Zh1JgRWwWazHgrbA7qSMGW2xfayXC2mnizMsoww9iXAMt+/wR1o18PECvrpeET
         KJSfhZc2KnR15ZAwldufNqvuSwLYW7+n1/k8RRkv2WTo9G+8VI5xCOXGMucrPDzRMujT
         eaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737307927; x=1737912727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxDF4yAopoLdBEL5nQVbQt/glTNfJL6eHs85UPYu2Kk=;
        b=k6yTrwSbTR+Cumnl2mqivE1oIhwCkC31LH1AhIw57pqh6ZoPdeXp4FqsHaUkEbGxO+
         w6jokYNA3UXpzDgO3hqv2i0oduFWfCNxRDH3CLcjmh+UOCOLnIONEddyfj8E2ub6GP1E
         hoscuJbVSQHBiKfhDYTzaQ1qVUw+amjMwwFNhWkF1BIj72X+hUQCX3WkH0y+piIR70JT
         wOGhU0bXgYFb6brS7+dXWu2WKa8AQjM06FLpkSz5swqM7qIUAfj5AoYfPs0JYlL4OoCZ
         0+oghlQ0E5LFnaG7ryv9AhyTuCal4s4BYTs211SC8HiyZ8UCC3pCmXXkcw+48ZRT3tqn
         Ma9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGGIQx7ciyWgJ7Ph24sOZyQPf420f4SP8tEjVLHSAnrbS/Biz7C1bPdVdrshGAUd7+Rl68MaQeFKEGv0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lBdkTPZpPIuqdzez8OV3xlHpqs89o9/dBU29VCV6TUoof5FZ
	zevihIE7f2FkSS7YHX0Qvcpk2T2SRMMcym6kOXBseQzIEVo79OgC
X-Gm-Gg: ASbGncslSBxL7r7hEVGkfzHq7aRh27gnYHXo06hwfERZyBr3ZMfovuCDw0UEDLBFWEB
	tXa2VsUJbpSNjADdiyRlMK9ImLls1UPNodMVm/WH84KGpLDWk34XZKQfd1449EeUvBLXGRUs0K+
	P5Vg5Wb2M/4KYNzhyhQfq3GzlPcXsnJGTTZ9vM3QvnmGqcL9u8mRHUWFLomYI3FPTk5rn27d/Kv
	KYA+C/AB0IspZsn1NmT+YWLfpc7G9CyrY/vyhKvoD2l////kkJlfd91c4U5dDdOj8cyDcGh9+b/
	6EUUgYrY9VkDxuUutdzJVtoENLsx4QLAtROJHEBno3gBBEA3bxby48IAE1T2jjABbo+rnAUHPbU
	ZXsXMnXoL9K+9+9UN
X-Google-Smtp-Source: AGHT+IHiHKGPVHL4+kMYagH7WAwlxrDjocOjUkkfCjpEfXUKaqTtM2J4Ws3uQlpiUOibbwBCr1/ZhQ==
X-Received: by 2002:a5d:6482:0:b0:38a:87cd:6d67 with SMTP id ffacd0b85a97d-38bec3b45b2mr13792669f8f.0.1737307926894;
        Sun, 19 Jan 2025 09:32:06 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-ec17-b16a-8f4c-782f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:ec17:b16a:8f4c:782f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32221e2sm8299423f8f.36.2025.01.19.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 09:32:06 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 19 Jan 2025 18:32:00 +0100
Subject: [PATCH v2 3/4] iio: gts-helper: export iio_gts_get_total_gain()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-veml6030-scale-v2-3-6bfc4062a371@gmail.com>
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
In-Reply-To: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737307920; l=2057;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=X+gik003pUjGH6EpnT0g65+Tv7caOm3rtNdVQvkAvo4=;
 b=ln80pnS3pjNe0ucuGTPw6sKi8kFjTROWG1/2w2NYRzDOJTURvD8QBTcCh02+uqaOASlKZhI7s
 1oP17rQ9258DgwwK4n70+5ahRv9rFq50GDPT1OcvnoT/+VjwqGa0He+
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Export this function in preparation for the fix in veml6030.c, where the
total gain can be used to ease the calculation of the processed value of
the IIO_LIGHT channel compared to acquiring the scale in NANO.

Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 3 ++-
 include/linux/iio/iio-gts-helper.h    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index d70ebe3bf7742906960c6af22102682c5b8dcdfa..6ec434338411d09fffa1db52046a7df9b34c89bf 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -950,7 +950,7 @@ int iio_gts_find_gain_time_sel_for_scale(struct iio_gts *gts, int scale_int,
 }
 EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_time_sel_for_scale, "IIO_GTS_HELPER");
 
-static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
+int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 {
 	const struct iio_itime_sel_mul *itime;
 
@@ -966,6 +966,7 @@ static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 
 	return gain * itime->mul;
 }
+EXPORT_SYMBOL_NS_GPL(iio_gts_get_total_gain, "IIO_GTS_HELPER");
 
 static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int time,
 				    u64 *scale)
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
index e5de7a124bad6eb65414df364f84e81301b0690b..66f830ab9b49b566d549c7b5b8291d42a0825b96 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -208,5 +208,6 @@ int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
 			     int *length);
 int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
 				  const int **vals, int *type, int *length);
+int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time);
 
 #endif

-- 
2.43.0


