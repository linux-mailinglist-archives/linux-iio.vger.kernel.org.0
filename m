Return-Path: <linux-iio+bounces-11920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA929BCFC7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 15:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DD22837F7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577E41D47AF;
	Tue,  5 Nov 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DoLK9FeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A021D86CE
	for <linux-iio@vger.kernel.org>; Tue,  5 Nov 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818469; cv=none; b=D3BHcM14yJDoB1X/NH3EPpCF4RznAJrDbG6/HPGACDy40R9P3heDcbFsb5GBeGlkQGkOWIk45Sv3TM1IGrHD5Z6ojbyv6Y/2DQwKKk9wYvn4mqS2nroBZbJdY7I4yND6GUDe88mmBSeFgbFkZPmwCl989k2TRS7z/Y22k6UJtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818469; c=relaxed/simple;
	bh=Vhywt+l5PYyYBUWugqF8aTPyUhcL7dT24faLo4C9gw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCDFwQESUw4kfQTM6jjsKEBHDvq3tlagnWIO/TW+mRSrzbYK14wnuRiTq5VkADSpXtGTo0fiBbsfhrM4QGn51Z2dbfBAf4UBy958zRppw+0LNpBzjWhYujnqggvwWYcoHbtkk/7GDOBkoCqM9R8DUJ3by3Pd455iuOtW9ngP4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DoLK9FeV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2923911a12.2
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2024 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730818464; x=1731423264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl8Jr9logEH1j60OH8uy/4D263LtrFLGZLsdHX5u56M=;
        b=DoLK9FeVFgkMGhUOwP5GGTT5NQsEN+p+QAjy13sTp8UVOASnIscBuZ5Kq5shsT+lzZ
         DbB9+rxqrDH5iaXgfVptco/net3GSR6oRdcXULtjSMeSn91Jv0vZCbAzVQoiW386TfCf
         WP9ofD6lxNZOq4d8KBwWWE0jrpdXpbqZMv+j2mar56KrUFEKSdsyqa+afNfObqbX2iox
         RnX60J9UBMM+R9F1Y988oGqKjyxjwrtdcTMwaEGuaaz+EyD7x9WP9uiuTkE14TVUAqyI
         sKktxYAGGHZwd1kmmZhJvsBdYa6lDYsMSsZnMhVMB8NYZbLNwDH1GlshPCy1es//O4yK
         RaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818464; x=1731423264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bl8Jr9logEH1j60OH8uy/4D263LtrFLGZLsdHX5u56M=;
        b=RvOsDp9Vl3ioaxThTR88EGTY7ivxey/qBpeU+p7Acbb7kma78aAwg+AYAHyOJ7nxzF
         txHDpET1gsHbx69eTY0YX4OsWtKeZw5WoV6gu6FPKdyg+qBANcNUr8rfouSvmuQVLzjt
         W8oDOopg5BAW59tLv1FP8qCNXIKwSVUmScHeiWdCpBYWqlvrFtJRChmrhWCNKs9EP8fb
         tCoIOgvXUzesKxDUiYbZhBt6rL3QtzJ3qu37e3+poO/OnT7rqgaNOrIcsJiSYBbeH88d
         HZYaaAZtaJm5/a4RIcNCg+Sc7PysS+XSvWM1dfq7MSl6TyMGI9EFIe8AbiazQqE54xYp
         67Bw==
X-Gm-Message-State: AOJu0YxxFgXC7eLzdAkgNxVp4MgzdsEkMkmzOO6CEAsgxujC5mnHkGUK
	dvRa+83ZLQgZaDERzV9V+o7Exx+FjAspPlwAHSyE9aeHsqLphQTtNyo01Le7tq34dz6TzpiwJe0
	Q3e4=
X-Google-Smtp-Source: AGHT+IHv4vQNgFpXsC2P1RQ+e/mvAiNkR6Gf57hy1HRa3vWTFq/NpkLWKWeVr7V3kwvQ6gmoMXqSZA==
X-Received: by 2002:a05:6402:27c6:b0:5ce:dfcf:7029 with SMTP id 4fb4d7f45d1cf-5cedfcf70cdmr4740472a12.7.1730818463595;
        Tue, 05 Nov 2024 06:54:23 -0800 (PST)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe40fsm1382398a12.62.2024.11.05.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:54:22 -0800 (PST)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	bartosz.golaszewski@linaro.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 1/2] util_macros.h: fix/rework find_closest() macros
Date: Tue,  5 Nov 2024 16:54:05 +0200
Message-ID: <20241105145406.554365-1-aardelean@baylibre.com>
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
progressions of 4, all seems to be good (one gets what one would expect).

While one could argue that 'find_closest()' should not be used for arrays
with progressions of 1 (i.e. '{1, 2, 3, ...}', the macro should still
behave correctly.

The bug was found while testing the 'drivers/iio/adc/ad7606.c',
specifically the oversampling feature.
For reference, the oversampling values are listed as:
   static const unsigned int ad7606_oversampling_avail[7] = {
          1, 2, 4, 8, 16, 32, 64,
   };

When doing:
  1. $ echo 1 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     1  # this is fine
  2. $ echo 2 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     1  # this is wrong; 2 should be returned here
  3. $ echo 3 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     2  # this is fine
  4. $ echo 4 > /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     $ cat /sys/bus/iio/devices/iio\:device0/oversampling_ratio
     4  # this is fine
And from here-on, the values are as correct (one gets what one would
expect.)

While writing a kunit test for this bug, a peculiar issue was found for the
array in the 'drivers/hwmon/ina2xx.c' & 'drivers/iio/adc/ina2xx-adc.c'
drivers. While running the kunit test (for 'ina226_avg_tab' from these
drivers):
  * idx = find_closest([-1 to 2], ina226_avg_tab, ARRAY_SIZE(ina226_avg_tab));
    This returns idx == 0, so value.
  * idx = find_closest(3, ina226_avg_tab, ARRAY_SIZE(ina226_avg_tab));
    This returns idx == 0, value 1; and now one could argue whether 3 is
    closer to 4 or to 1. This quirk only appears for value '3' in this
    array, but it seems to be a another rounding issue.
  * And from 4 onwards the 'find_closest'() works fine (one gets what one
    would expect).

This change reworks the find_closest() macros to also check the difference
between the left and right elements when 'x'. If the distance to the right
is smaller (than the distance to the left), the index is incremented by 1.
This also makes redundant the need for using the DIV_ROUND_CLOSEST() macro.

In order to accommodate for any mix of negative + positive values, the
internal variables '__fc_x', '__fc_mid_x', '__fc_left' & '__fc_right' are
forced to 'long' type. This also addresses any potential bugs/issues with
'x' being of an unsigned type. In those situations any comparison between
signed & unsigned would be promoted to a comparison between 2 unsigned
numbers; this is especially annoying when '__fc_left' & '__fc_right'
underflow.

The find_closest_descending() macro was also reworked and duplicated from
the find_closest(), and it is being iterated in reverse. The main reason
for this is to get the same indices as 'find_closest()' (but in reverse).
The comparison for '__fc_right < __fc_left' favors going the array in
ascending order.
For example for array '{ 1024, 512, 256, 128, 64, 16, 4, 1 }' and x = 3, we
get:
    __fc_mid_x = 2
    __fc_left = -1
    __fc_right = -2
    Then '__fc_right < __fc_left' evaluates to true and '__fc_i++' becomes 7
    which is not quite incorrect, but 3 is closer to 4 than to 1.

This change has been validated with the kunit from the next patch.

Fixes: 95d119528b0b ("util_macros.h: add find_closest() macro")
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---

Changelog v1 -> v2:
* https://lore.kernel.org/linux-iio/20241031063707.795842-1-aardelean@baylibre.com/
* split the __find_closest() macro into find_closest() & find_closest_descending()
  * find_closest_descending() is iterating in reverse order
  * this favors some corner cases with small values
* forcing types for '__fc_x', '__fc_mid_x', '__fc_left' && '__fc_right' to be long
  * this resolves several potential issues with combining arrays of signed/unsigned
    values with 'x' of type signed/unsigned
* fixed error with previous implementation where __fc_mid_x was used instead of __fc_x
  when calculating '__fc_left' && '__fc_right'
* updated commit description with more information (also found on previous
  thread) + the description for the changed implementation

 include/linux/util_macros.h | 56 ++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 6bb460c3e818..825487fb66fa 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -4,19 +4,6 @@
 
 #include <linux/math.h>
 
-#define __find_closest(x, a, as, op)					\
-({									\
-	typeof(as) __fc_i, __fc_as = (as) - 1;				\
-	typeof(x) __fc_x = (x);						\
-	typeof(*a) const *__fc_a = (a);					\
-	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
-		if (__fc_x op DIV_ROUND_CLOSEST(__fc_a[__fc_i] +	\
-						__fc_a[__fc_i + 1], 2))	\
-			break;						\
-	}								\
-	(__fc_i);							\
-})
-
 /**
  * find_closest - locate the closest element in a sorted array
  * @x: The reference value.
@@ -25,8 +12,27 @@
  * @as: Size of 'a'.
  *
  * Returns the index of the element closest to 'x'.
+ * Note: If using an array of negative numbers (or mixed positive numbers),
+ *       then be sure that 'x' is of a signed-type to get good results.
  */
-#define find_closest(x, a, as) __find_closest(x, a, as, <=)
+#define find_closest(x, a, as)						\
+({									\
+	typeof(as) __fc_i, __fc_as = (as) - 1;				\
+	long __fc_mid_x, __fc_x = (x);					\
+	long __fc_left, __fc_right;					\
+	typeof(*a) const *__fc_a = (a);					\
+	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
+		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i + 1]) / 2;	\
+		if (__fc_x <= __fc_mid_x) {				\
+			__fc_left = __fc_x - __fc_a[__fc_i];		\
+			__fc_right = __fc_a[__fc_i + 1] - __fc_x;	\
+			if (__fc_right < __fc_left)			\
+				__fc_i++;				\
+			break;						\
+		}							\
+	}								\
+	(__fc_i);							\
+})
 
 /**
  * find_closest_descending - locate the closest element in a sorted array
@@ -36,9 +42,27 @@
  * @as: Size of 'a'.
  *
  * Similar to find_closest() but 'a' is expected to be sorted in descending
- * order.
+ * order. The iteration is done in reverse order, so that the comparison
+ * of '__fc_right' & '__fc_left' also works for unsigned numbers.
  */
-#define find_closest_descending(x, a, as) __find_closest(x, a, as, >=)
+#define find_closest_descending(x, a, as)				\
+({									\
+	typeof(as) __fc_i, __fc_as = (as) - 1;				\
+	long __fc_mid_x, __fc_x = (x);					\
+	long __fc_left, __fc_right;					\
+	typeof(*a) const *__fc_a = (a);					\
+	for (__fc_i = __fc_as; __fc_i >= 1; __fc_i--) {			\
+		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i - 1]) / 2;	\
+		if (__fc_x <= __fc_mid_x) {				\
+			__fc_left = __fc_x - __fc_a[__fc_i];		\
+			__fc_right = __fc_a[__fc_i - 1] - __fc_x;	\
+			if (__fc_right < __fc_left)			\
+				__fc_i--;				\
+			break;						\
+		}							\
+	}								\
+	(__fc_i);							\
+})
 
 /**
  * is_insidevar - check if the @ptr points inside the @var memory range.
-- 
2.46.1


