Return-Path: <linux-iio+bounces-13686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559649F8424
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA1F7A16C8
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7E1AAA3F;
	Thu, 19 Dec 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yE8qkoOs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080C1AAA1B
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636330; cv=none; b=mkE5qVqLBSyFuZ12ezfHqiki2sXkI3jZ9qn4NWzVhbjO5aJsUJadX8Bl9kKMnZozsJpE9vSFhmwvBzXSYHVCb+1JVuUdbKKTZfaqLHMKygHNBd0tAgc+gwA1+54KnHeSnEhn2Ub4n/ckdNFb5MzeRcYayfDrtg+vULRz+vfHkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636330; c=relaxed/simple;
	bh=qGC/BoWAnaQ8Zn3EXtW+wr1SCMKYSiupd5YWBUTRelE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QFBYLi4KmES0/NpA0T7Wu0BK++0/xrOK42IFc4Z0kg2tGePEaRCj4ENW9gRE4w5xFSptxJJ1q8lb/fhnSQg+TYMa7LfO93kewKJ+Z03ChZSj92xoPflKXZ6iz4JScNgdKQbwQF3g9ZsYtpXCOubcdktU28HRVMLYpWCJuokltGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yE8qkoOs; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb9bbcc936so567817b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 11:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734636325; x=1735241125; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/QRZ6RsAMP7+6NkA6GPB5HSh+iRysrh91t2ZNaxzXU=;
        b=yE8qkoOsDGxgS0PlYlKV+Q4V959SSjGnTV5a4EdcIJzhdhUVM7W6ZSg0QYnc1d+po8
         P3z2FUvlaPXjA0sBHEy0HqPY+ydzge0uRGrnckOscVlKnN2L/PfyouABfTgy5gBAgjns
         PKMXKCqXCEmNccYbZgA1rGMdSoxLdz+qy1hcp2xJmmn2Dg0zApzR1nksjJ2ccW7BCZct
         YsSOC0tAqoVInRllODoPRC92I21CAdg2juKRxwDckCF1HuChBJFUO6t2BKg3KRxFMxLi
         JYi4fOYQO022CqmxBe7xJtKAo9grP2PwQlupQR4v0JgiijGNyeO/e2OecVVf4oqzCvwy
         IODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734636325; x=1735241125;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/QRZ6RsAMP7+6NkA6GPB5HSh+iRysrh91t2ZNaxzXU=;
        b=bQdopuAJOfJ69nENVypGAAO/7/xVkovIh7fgJxbyo2orfLBNp+zgMjTU8txb93DF1Q
         ZmI2XzATuRLr/WnNehZGyhdVw7aDHLSCDU3ztAEu2MX3PSgWMwIyP//45Ld++uEfqwMs
         icFvhK3Sb6WBM0vV7J6GBG0Rq6nOsKnKWn7Q+aaUYuOOCG02ccKeJCj/hjkJqFjxkfB9
         QClyaG5fvOILbqECv0QJpKoC/phbyiaZnXedBjPxRiyXA7g1ZCwfIik4hsfjSKHZo8aa
         2yZGbKF/SlCS88ezBMjENWrMDD9nLyRUqJRjUIqn1zUXvRFFMsp9BeQQuiLu2UWsqABN
         4alQ==
X-Gm-Message-State: AOJu0Yz6NiHoxNsLRp41Tfojckdmt9YOLP9FEbWGguc0KYfBh+gfU6C1
	I+3VKUxntoGvKe8Cu7NyW9XqzVki8pWwm7Al3YX8Z6NGsz54dt5uZYfVEUxuM8lXBqhPT0uqKZc
	8
X-Gm-Gg: ASbGncs6nkZ3eSN8TZNW2K2hfVmM6tVWtxWhIiwVGw0Hbz3A2vUvL+MimpmpQ7Ja5zL
	kUg0Jh7DrEVHJIJrLyJw/YNx6Bb7bI6KVJSyY9aarxBzLFFcimaPV7mfmsmtieb6uJVxvQnNatd
	Cc0cyXRjJzkW3AJullDQFyMBbkqdAjmehJe4YCKjB0K99I9voIND8gQ+a4Ja1SxLiIqWjfJZ6Bg
	egi3uLNiMrDSmASpYGkL3dt7eUmlm8E8JbA2+DEVnuqRzfd1VOM70St/vmmp0H/5eWUU5fwKGHX
	wQgYVWGbhWrY
X-Google-Smtp-Source: AGHT+IGcuB2CHD/ZsAQtC3oKRln/8TSaKlyXU9O1Ev5Mxj7expaoq9/5GTxoa+KPNf4xkFdEoxOa2Q==
X-Received: by 2002:a05:6808:229e:b0:3e7:b9be:52cc with SMTP id 5614622812f47-3ecdcba56e8mr3058106b6e.6.1734636325122;
        Thu, 19 Dec 2024 11:25:25 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece25014dcsm327432b6e.26.2024.12.19.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:25:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Dec 2024 13:25:23 -0600
Subject: [PATCH] iio: ABI: combine current input sections
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-iio-abi-combine-current-input-sections-v1-1-8dcd8221d469@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACJzZGcC/x3NwQrCMAyA4VcZORuwxQnzVcRDm6UzB9ORdEMYe
 3eLx//y/Qc4m7DDYzjAeBeXqj3CZQB6J10YZe4N8RpvIYYJRSqmLEj1k0UZaTNjbSi6bg2dqXX
 Bke6RyjjnkqYMHVuNi3z/o+frPH/nqx50eAAAAA==
X-Change-ID: 20241219-iio-abi-combine-current-input-sections-c62cf5dbfa9b
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Combine two duplicate sections describing in_currentY_raw.

This went unnoticed until we renamed in_currentX_raw to in_currentY_raw
and the kernel test robot found the duplication.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412200256.OB5Hmw5Q-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d97c35057a034c76ed433e3e6de0aff8ec4bbb70..25d366d452a55293c420300335a0271a28855107 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -168,18 +168,6 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are millivolts.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
-KernelVersion:	3.17
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Raw (unscaled no bias removal etc.) current measurement from
-		channel Y. In special cases where the channel does not
-		correspond to externally available input one of the named
-		versions may be used. The number must always be specified and
-		unique to allow association with event codes. Units after
-		application of scale and offset are milliamps.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
@@ -1700,15 +1688,18 @@ Description:
 		or without compensation from tilt sensors.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
-KernelVersion:	3.18
+KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw current measurement from channel Y. Units are in milliamps
 		after application of scale and offset. If no offset or scale is
 		present, output should be considered as processed with the
-		unit in milliamps.
+		unit in milliamps. In special cases where the channel does not
+		correspond to externally available input one of the named
+		versions may be used.
 
 		Channels with 'i' and 'q' modifiers always exist in pairs and both
 		channels refer to the same signal. The 'i' channel contains the in-phase

---
base-commit: fe2a04fbcbfe44694fcb36ff6212fce54b8f56cc
change-id: 20241219-iio-abi-combine-current-input-sections-c62cf5dbfa9b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


