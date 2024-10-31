Return-Path: <linux-iio+bounces-11668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208D9B74A7
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4B11F246F5
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D7146A6C;
	Thu, 31 Oct 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oYghIvJ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D11465B4
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356653; cv=none; b=UGy3I538GVwEURgxoqojQ4Zi4IoXHWhpOjKUmUeoK4StWK3hy5LhESxeymBSLhF0ejwfaeCaWSTmcysEv9JYTlgGH6mw/78cOQ4ZdAe0CE8KM4+mTewxjc1zhdfE5PcuHA0vF8RoM2KzsCaAU2YuU75BL0pJ7+yxc5GfuRGOoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356653; c=relaxed/simple;
	bh=xCkN61jM/BrCdbL4Pz4KNYD6K9ICFtu9SXk1cceUk8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niBvQC1nZvuDpQ9I6u/RB7gzA87Ceyezl59r9ZQnO0J69LvLa0LBPawFaD471BxObUL6hc6Kf/3L2cKZCG5LUv/kvVLRYwxV9M0oqHZRK/CBa7ym3Xf4tpzzu/qvyGzZm5szmD2rS+6o2LrXBTwCw+nY1XK4vBanvBK7wiUIcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oYghIvJ3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99cc265e0aso81599066b.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730356648; x=1730961448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Syc8iitwhxNiY8yHoqGusrkhrZH6UffjY+VQu9TJp80=;
        b=oYghIvJ3NS8nb1Nys5ehaQCz1ezmMcMAnNuqphk9ZMzSg6vjqyaFUi+62qmTg8NnAD
         4a3zkQgZU5lTOweQZUmaz87nNQd7R6svkyVM+UF3LjQMP2XAmjAsJBsuuUfjiOhf5/Gr
         +PnP43On7U2pPfedlzURggghS/GvuGr8zG4SuZHQsXnaSuPlg3bqtgzd6qOokerDPBm3
         vfQHxX5BOI6tRl7jxUcBV83/o1ulbkPPxTz9f63XIiAZ2c/n5XUug2ifKSImXYOS5E/j
         NM8KeWr3fMMf6ZSbmQnumhQIG/LkbyzB+MMF8E+ZQ7yEJSR+jPVaJ1EFsFzmhqVkNZ70
         ygKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356648; x=1730961448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Syc8iitwhxNiY8yHoqGusrkhrZH6UffjY+VQu9TJp80=;
        b=Ao+yoj/PjyoFomCzba0jJ4Xt3YgNJ9CFytHnGPEnAgRGLtRC8mSsscDjwgs5Gn0muT
         crbPq9UReeG12aamJLNKERg+HBlrxAnUHE9HA2X1pVt1vEyOlw5Dks822rZ5PBYPznh3
         qEe24fuXkf/Gwl0a1edwdRP6wxnocWx9uxCRd3RZlxG/+g8wclXzGa4l8vmd/IH0nXf8
         hDkgSg/hP/mQmJB4H2+wJqXUwf9YLDfou9fvvRCwdkfvlzAH59NsOyxZ+qjfI5Z6v0r5
         Ck644LTxjjdYfmRkHS5QBYWph8FBmNGrSO7GkLBqvMznDcz0mOYMui/w2wHcBIehFWSP
         lt9Q==
X-Gm-Message-State: AOJu0YzJjmDR4TAXKV2KCiC6W24D/eoqsJ6SYucCLgfIlymp3961yAHr
	i1Q+Kti30Xn+pYMQzPRGNJs+X7hhoIbNEkwuGUBhW0TdcYCb0WVVNBKWMirVpnlVEc+cVRszpid
	l
X-Google-Smtp-Source: AGHT+IGnbIX1lkd61zgCFdnE+m/KJRDYqhD8kH6Jvzw4F9FfgkHmBYhi0i+vGhPTKoZ41FDMdz9vvQ==
X-Received: by 2002:a17:907:7b8d:b0:a9a:421:720 with SMTP id a640c23a62f3a-a9de61d60f6mr1816381966b.46.1730356647566;
        Wed, 30 Oct 2024 23:37:27 -0700 (PDT)
Received: from localhost.localdomain ([81.196.132.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5649405dsm33386366b.10.2024.10.30.23.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:37:27 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	bartosz.golaszewski@linaro.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 1/2] util_macros.h: fix/rework find_closest() macros
Date: Thu, 31 Oct 2024 08:37:06 +0200
Message-ID: <20241031063707.795842-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug was found in the find_closest() (find_closest_descending() is also
affected after some testing), where for certain values with small
progressions, the rounding (done by averaging 2 values) causes an incorrect
index to be returned.
The rounding issues occur for progressions of 1, 2 and 3. It goes away when
the progression/interval between two values is 4 or larger.

It's particularly bad for progressions of 1. For example if there's an
array of 'a = { 1, 2, 3 }', using 'find_closest(2, a ...)' would return 0
(the index of '1'), rather than returning 1 (the index of '2').
This means that for exact values (with a progression of 1), find_closest()
will misbehave and return the index of the value smaller than the one we're
searching for.
For progressions of 2 and 3, the exact values are obtained correctly; but
values aren't approximated correctly (as one would expect). Starting with
progressions of 4, all seems to be good.

This change reworks the find_closest(x,) macros to also check the
difference between the left and right elements when 'x'. If the distance to
the right is smaller (than the distance to the left), the index is
incremented by 1. This also makes redundant the need for using the
DIV_ROUND_CLOSEST() macro.

For find_closest_descending(), the operator was changed from '>=' to '>'.
Since the iteration is happening from the highest-to-lowest values, the
'>=' comparison would (for small progressions) prefer higher values (as
closer to the given values).
For example:
  Given array 'a[] = { 10, 7, 4, 1 };'
     find_closest_descending(2, a,...) returns the index[2] for 4
     find_closest_descending(5, a,...) returns the index[1] for 7
     find_closest_descending(8, a,...) returns the index[0] for 10

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 include/linux/util_macros.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 6bb460c3e818..60c74770b703 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -7,12 +7,18 @@
 #define __find_closest(x, a, as, op)					\
 ({									\
 	typeof(as) __fc_i, __fc_as = (as) - 1;				\
-	typeof(x) __fc_x = (x);						\
+	typeof(x) __fc_mid_x, __fc_x = (x);				\
+	typeof(x) __fc_left, __fc_right;				\
 	typeof(*a) const *__fc_a = (a);					\
 	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
-		if (__fc_x op DIV_ROUND_CLOSEST(__fc_a[__fc_i] +	\
-						__fc_a[__fc_i + 1], 2))	\
+		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i + 1]) / 2;	\
+		if (__fc_x op __fc_mid_x) {				\
+			__fc_left = __fc_mid_x - __fc_a[__fc_i];	\
+			__fc_right = __fc_a[__fc_i + 1] - __fc_mid_x;	\
+			if (__fc_right < __fc_left)			\
+				__fc_i++;				\
 			break;						\
+		}							\
 	}								\
 	(__fc_i);							\
 })
@@ -38,7 +44,7 @@
  * Similar to find_closest() but 'a' is expected to be sorted in descending
  * order.
  */
-#define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
+#define find_closest_descending(x, a, as) __find_closest(x, a, as, >)
 
 /**
  * is_insidevar - check if the @ptr points inside the @var memory range.
-- 
2.46.1


