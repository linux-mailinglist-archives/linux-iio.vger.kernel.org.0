Return-Path: <linux-iio+bounces-16003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB0A422AD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C50719C0E4E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF5C2C6;
	Mon, 24 Feb 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rm7ae4Ic"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D91386B4
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406246; cv=none; b=tT15RWYtQHwcGcMmLw2ZSzdCVC3uapVjQxRUAqwJflgkZMdqETDQg7awU87tFze1oLIJd4/hQYGixOHXNxkqVhryyn748tmrQ+JNASwRaidzfm84ch0Am0+090K5Jspi9YzmP14iKxvq2UQnNH/sKoTPV/KLzf3UyDsNbTKrCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406246; c=relaxed/simple;
	bh=Sna/cdP25sP+SsKshVSh+mxzYypfCfdFEx/giv7D83o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SK+nbYTzcb+URXYyh+aXj1eIUZoodFmS5mH22Tb7bSdioIVk/wNbZVoIOU5ZA0tP00+ZTGNMsADW1niRDxKfbWIANaU9cWdCIBsxDtK2OLrwpM1muHcjkCOYyRKCB9Voih7FbTfYdwt99X7sapG1XdqfEgszAPD/F8YZwv7LynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rm7ae4Ic; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb81285d33so856653166b.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406241; x=1741011041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnm0VZI5epbOo5cjO7E6HFmrYWcVHRmR6DJWjt31Bzk=;
        b=rm7ae4Ici1yaMM/bOnrM6/xgYtM4QxKH0r14+NaI9SwjZzyGtjluNfTbg5TADtZv1k
         Ppj5tEeXYCLhWbv2J/4XTJrKcmy0iW9DLkjSKgJjubWeOSH0f9bEDj58evla3S8hgb1l
         RiJq0PuIsa7UPFRkKoF210uA24SKXxIywUkfG4o/jnpz/jOXThqi/L3OOaan8J3oF1ho
         Vy0OoAN9Rd0OZtCMnB/euFRVW2c+Q4QFzMud1oAFx5pHZ0t1boBN3fdhc2mAejyVkuvF
         KjCKNyX8NActQs/F0YcaLlDJceDDkfO3cpfElp2Scj/qlocibT4l8ye3O+r8erXQFAgL
         YKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406241; x=1741011041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnm0VZI5epbOo5cjO7E6HFmrYWcVHRmR6DJWjt31Bzk=;
        b=dYxsxzCeI7JrzZ8Y3qs06yaTsJk3V+dFTd2JjTrZWlv7ah2aNjZkgDxkrHCdKSSwzu
         i8LlxPnILWLisFbof3awiBMqlC/eIiWkK+bsoz3E2mvc207yZVjRbG8O7iG/X//I/TqE
         J1Qh3BY2zEBQcvRF7gp4RJy7ue5xrtf1geCzEGSl0FbwMdzZu/yrNluOkhcHuZLfV3Wa
         P7PE2MBxtr9aXu4sj3wQwD24i2yyHFfs98McVbGmmZJoQJ5HHC/W0YNXsGxrscl4jjVh
         IkEqOU3Wc2B5QGdV/u5+t2T9r+Iv3tFCgtnT2RJE0+LY2hoSBZPHbVuoVaSvpC4GLm4j
         lK2A==
X-Gm-Message-State: AOJu0Yxtp83eKnpKhfxLx2WeNkmvBRnHqG9TQi9ZkU+2+ATyBVDUYfWN
	xrstcuGNWc5uCLPNBMIwBXmyaZM3vYIudU+Fm9OiyQkYBV20/oUQ/L6x/srkLoI=
X-Gm-Gg: ASbGncvRkEG9+MoRrBw+neH7JJIvi1iS83YO5hNEiXCQudso79F9zSAxX3gouhYY8cS
	x3N0oG6ohUp9+GSoei2SBwXbtA3IpQ396JCCD6NyXnNLUYfqAIzpR2pDEArRrfAPCqrqCM8Vrgb
	sz/3BHiLSTbVKCKVijaM/ToL07/mmmevwakpwvK1MhhmqrbMHWHV4lihg35vfxcMQ0WaiGNacXr
	srLvCWiGsiyMghlc3h+Nx/upNnWXTSJwvEaQqRvCjKgUQF70y2Ny9Zs0Rjz9TNeiiE6sGaTCHjS
	uUQLa/WQgXvxEy8EWaKz52zyzFucHGI=
X-Google-Smtp-Source: AGHT+IGZSyPBQ4EaToJTSXNMzrYjbC4AAW0HHhw6ivPRhfu1XvCpNXkiJKfs4osNjaxAXaVnOBqTrQ==
X-Received: by 2002:a17:907:7f9e:b0:aae:bd36:b198 with SMTP id a640c23a62f3a-abc09e34340mr1269766866b.47.1740406240857;
        Mon, 24 Feb 2025 06:10:40 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaf6ec730sm1369773766b.163.2025.02.24.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 0/7] iio: adc: ad{4130,7124,7173}: A few fixes and ad7124 calibration
Date: Mon, 24 Feb 2025 15:10:11 +0100
Message-ID: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Sna/cdP25sP+SsKshVSh+mxzYypfCfdFEx/giv7D83o=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvQ9tUeOnrHpU1ZdV3bosfs+PdUl+g8cZsy+mlIdMP17h ZPT3Z1POxmNWRgYuRhkxRRZ7BvXZFpVyUV2rv13GWYQKxPIFAYuTgGYSFok+3/HTAeTJOcVP1h+ zje5JGpyMsdi1jWTJye3qt+KMjhm8mtR4nzeTXxzTk/5cOxf0PwqjqZDkRs6QzVkhC0qlW3efHj AtTdyzZzHMpZBU85xSW58lHv9VpfEzqeSTyp12DOO6v692+s1QVAvZ5VIWrN11+7W4iarwBdv9K /EHSzU01ZM2pgY2Ov6epVxWFjFq7mN3+Y2Ciy5WKARI/u3U2WZ5K2L665xzX0kVlIgPynQ9Qm3u 62DfJxIqCyP7vQPKsuOWJ+cauNStSkgSXHvKRmp+8wtzGICJhpmnSIyHxaxq7lyWToJ6QreLwrd EMiy3O6LiDfHQ131zCkV7zxfNsxkZO136zdSbfrMmDEFAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this v3 addresses most feedback I received for v2 which is available at
https://lore.kernel.org/linux-iio/cover.1739902968.git.u.kleine-koenig@baylibre.com:

 - fix commit log leftover mentioning BUILD_BUG (David)
 - s/adaptions/adaptations/ (Andy)
 - drop a #define DEBUG (Nuno)
 - return early in ad7124_write_syscalib() to save some indentation
   level
 - Rework the calibrate_all function to simplify error handling
   (Jonathan)
 - rebase to today's iio/togreg
 - new patch "Add error checking for ad_sigma_delta_set_channel()".
   I noticed that one during working on the driver. Didn't see actual
   breakage, so IMHO not an urgent patch.

I didn't rework calibration to make use of direct mode. That's still an
open question in v2. Didn't wait for that resolving to get the first few
patches out of the door for Jonathan to apply them.

Best regards
Uwe

Uwe Kleine-König (7):
  iio: adc: ad_sigma_delta: Disable channel after calibration
  iio: adc: ad4130: Fix comparison of channel setups
  iio: adc: ad7124: Fix comparison of channel configs
  iio: adc: ad7173: Fix comparison of channel configs
  iio: adc: ad_sigma_delta: Add error checking for
    ad_sigma_delta_set_channel()
  iio: adc: ad7124: Implement internal calibration at probe time
  iio: adc: ad7124: Implement system calibration

 drivers/iio/adc/ad4130.c         |  41 ++++-
 drivers/iio/adc/ad7124.c         | 302 ++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7173.c         |  25 ++-
 drivers/iio/adc/ad_sigma_delta.c |   6 +-
 4 files changed, 344 insertions(+), 30 deletions(-)

base-commit: 66e80e2f21762bdaa56a4d63c79e5aca5f6bd93c
-- 
2.47.1


