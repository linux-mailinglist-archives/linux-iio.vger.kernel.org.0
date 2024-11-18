Return-Path: <linux-iio+bounces-12371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3769D0F81
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 12:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60D51F22413
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C43198E99;
	Mon, 18 Nov 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J5qMl5PO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B418198A22
	for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928813; cv=none; b=b8KGk7XHffy9Id/mtNtn5+m8G2OLDeqB4HB9fE3V2oPrwgjlxTSu8WI6JAmAPoZJA6JakWSI2HyBcBj/Tcg3RHmypq+x3+p+/MKkFOvUZtUM/qmnnhJB3jeLcps8QYgjBXj9HvoyZDafq1KPlMUO9sDhr34lqTikWrz7jmhsZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928813; c=relaxed/simple;
	bh=taB01eCfZkXY2/zAVcsAhVy12b7owx5SdJ89/qjr/H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IB+80XnP89VQdWkVD0auG22TzPXJAXW+E86FF++FL0aTa8Azlttiq+j8zURI5MgNPAUf1mea+Y2izCS5esgwCLG32+rGv7TgP2xQzY/in/jMMYckDLNo1jqIf8stHoFFudYChtNpNHU6DbiO/187e8y28rwLq7lbp91/UWduR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J5qMl5PO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d866f70fso35363705e9.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Nov 2024 03:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731928808; x=1732533608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0suO+NMg+KxGa/CoRMpBUyl3jMJZcYjbvv2OULh9bpw=;
        b=J5qMl5POkJvfy1Zf03Y56TRMTtg1t36us3D7p8BWukEBNZIKxoBbl9ZYADPW8yNnTt
         2XUK4Slh5s+GPj0HKTAU0I1zLaPc17GvhGtOLcJ9pxzaueDPaBPaVM78/xvs3xD0wJ9i
         cnobvNtCY46h6pyxpSuMcllPKX89AMQxF7TiRlLVE8vx4aeATm/jIEUsZTTRJHtuzKe8
         5GlR6Rw7zCr8DWRUYV+v90AlZpqx/nsmkypsMvN3QTLx9v+za1a7UklHVliXRvYts962
         5wb90RFggE05yPc4xzoZDeztLRQmduq/fbT7CkUBsyeXjqDYenzVix8UIM0v8bEnD5fD
         nrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928808; x=1732533608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0suO+NMg+KxGa/CoRMpBUyl3jMJZcYjbvv2OULh9bpw=;
        b=W15ZSbmlsOFF2QQEVccgAXypyKFNRN+SRbKuyT9KpMh61hVepBYprOBLHFPMA9bZiv
         cMua9RRbqppuNahPDI2nGdDAL+ALP8jvWf7GlQdEWs57tj/9AfAk0oKOsA2hXJmjpkH9
         cZciX/G6Tl5BZOgV4mHQFVOq0RuEx3hgvI4HygEwZPcUXlJaPDgPH435qOzv/ar582MW
         GT+5HUssujsJFsBaQKpIGpkuTpu8CU0httIwVsqUty7tOF3poV4Iy8LxrMzm17djsSe1
         hDoXAheAFiULHeO3Qo6vh8N4mtkTH2+cXEpjxjasX4uS7vNudum5Or5DwdW4xiq/M2iL
         /NNQ==
X-Gm-Message-State: AOJu0YxBbbDttg+k6/6NuPyaK2yd8x5JEoLU56zS4XeIn7ZzyIyAbvXc
	JvGGaTAiPvROGT1GWsq21Kgaugl7PXhjdI3zYT4th4rEnaAA70/qhlhrOfi6HpnEw6E+AMEs4uY
	p
X-Google-Smtp-Source: AGHT+IFWXnWn29v3c4nfMP40p2WpAsAyrVHPjUU7m+yRw5WbkDvSxpYkSLSmIpM5YHOxh8XoN1NpjQ==
X-Received: by 2002:a05:600c:1e14:b0:431:1d97:2b0a with SMTP id 5b1f17b1804b1-432df74e9e9mr108291585e9.15.1731928808432;
        Mon, 18 Nov 2024 03:20:08 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265c9asm155016195e9.16.2024.11.18.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:20:08 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ad7124: Implement input validation
Date: Mon, 18 Nov 2024 12:19:54 +0100
Message-ID: <cover.1731404695.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=taB01eCfZkXY2/zAVcsAhVy12b7owx5SdJ89/qjr/H0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnOyLby74EqkNGvhPCOFuRldQkCi4CBgB5udnkz 8J6yUwNlKyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzsi2wAKCRCPgPtYfRL+ Tn1DB/4zf5Lw4+ZIdstpStgP2qAgpam3zbxZbeQAuPSscv0NuwO1dkumoe6l8577rGOertoXJQB DGskmt3EJ3+Yy/YUAkPeKAYOXBJTfzoGVoHwzwDW6J3FyHQ+IQWnUXlYReNqxvWwz0PpeJK0BWM vKaMzDl+wzBN4spMHnvzubPdtar/1mVWeS3j4Co+ywnu2K8INBtxciPhKzixikLki+EDd9Fezc7 AmbQp0wZMGJdhfA4L97HBbu1GGd69AkZUIcFrEWLcck32u0CV70xfg/uMBXNS0SO01hY2kh4/1L t3fyaxO7Kja7UIslBavXdsN+vV7CwSPTBTEbLBS+DzSi/MPK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

(implicit) v1 of the series can be found at
https://lore.kernel.org/linux-iio/20241108181813.272593-4-u.kleine-koenig@baylibre.com.
This v2 bases on v6.12-rc1 + commit 64612ec9b909 ("iio: adc: ad7124:
Disable all channels at probe time") which is already in next.

Changes since v1:

 - reword commit log of patch #1 to honestly tell that the maximal
   number of logical channels is a limitation of the current driver
   implementation (and not one imposed by hardware).

 - Make the driver explicitly fail to load if > 16 channels are defined.
   v1 only limited the maximal channel address which then later yielded
   a probe failure on the first channel exeeding that maximum.

 - in patch #2 fix "passing zero to 'dev_err_probe'" as reported by
   smatch + Dan Carpenter.

 - Fix my address in patch #2's S-o-b trailer.

Uwe Kleine-König (2):
  iio: adc: ad7124: Don't create more channels than the driver can
    handle
  iio: adc: ad7124: Refuse invalid input specifiers

 drivers/iio/adc/ad7124.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
prerequisite-patch-id: 617af17fc377a984762c61893b9f2a92ae62213a
-- 
2.45.2


