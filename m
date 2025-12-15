Return-Path: <linux-iio+bounces-27102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37845CBF7C2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 20:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 516E43012DF8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68212DDA1;
	Mon, 15 Dec 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYkNVEcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FC2D1936
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825701; cv=none; b=rk37zGu58uDaeat3I6VMDRbJ+eqSR+lk+Xgz7zfVZUMqvuAYPSTCXPNPn6lMwGJirjrBFPgcoPCRlmKJEI2RM/MKnlaaxUY9+R0tLVa4eEFdmVjaONU4pTxbSXUMf0aXmqdCvad0e+xCfdSVZeVfqDPB2HV2+Takrge3534fvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825701; c=relaxed/simple;
	bh=TOl7QzXz9ynV1zhHHmuLrwdm34hK+gmILh1FdigSRcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6ryQf7wGcDp7C57RlOZJ+pshs7JkEMpzX2r6uAd1i+P9rUcTmuOSUhJ1JggmJUmLbaajJggV7BS4Ykedt8TDrqEOY+b//yX4Q1TZaGIbqOFFmh7ons42rylBdloqtn0RdHSe3ncqyJykF4C/xNQ87zTn+Vsy7SfOxFo+aIszck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYkNVEcM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34abc7da414so2644012a91.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 11:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765825700; x=1766430500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q44xMSPr/951RTwQ3DJqY5TH3wRlFesNoG+392y++54=;
        b=bYkNVEcMJmMCgZF5Cv+ZEz3XnexrBWmD3QwDB+PzYY1Hnk5uPqoTyG/mQIuhwnLzrh
         0XtAVUBqvliVk/kdX/ZzmYLM54liJwAQsYuwd2bU57H9Ld4MWN+D4Jg+/l02BIf0L9GA
         USuQE9wZnC/zKBwhOjB/XZ2Dpr46AVuXLxZKSV1IfmVq74EsyYsU5pmffkbakr8xU/iW
         x9CGZ+msRq/uDxUvbZEkXEa2bwiLgelDfP9rni+TDAqc+cnuSiz8W2wr598tUCBo+hjF
         QJxXA2dFyCHkL+dkpLNu0dOAcTuR2bbIl9gPTqf5ELeV2u6rKsBnRTJIocA3QdlsPbuy
         Otzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825700; x=1766430500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q44xMSPr/951RTwQ3DJqY5TH3wRlFesNoG+392y++54=;
        b=lViw1j+ZwAnUeN0ay3p5vJDJhRcB/Lf7tRo+ribA8s7w9DBr+idIwIP2wmDYaLmhvs
         lPDY/o1CFD7SilmJlXGVB0fw8mHQvCX9krB/h2665Qk0il/+O6loByyJ7U1Wa/7781/k
         AE0LtyDgMgnKPNeH0NjTZnxxlhk7Xyzxs3xjVfd2ukTgaiFUGZRu1G8usxu4UHA8bs+K
         hwUSllbp/TxTKDDlTLCiSKAyVXJdyenYHJv0hLEilCYJ0s5znJiIOJzAYesIQlcml1lp
         HPkgKhV+Hue15PUIuG84kBD3TZXk6VzMKkIYMvy/SmxRhBapgtffx0VPlB4SkK5c/4ce
         /VxA==
X-Forwarded-Encrypted: i=1; AJvYcCVqvuEOLKdIV45fkW8/VQtxbdr5HwUbr8vfOI1PmdQcPK3MpOUkii7ORUvAZ6dZUfHTyCvP5/ret+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxeNvn+zMfKzAqt5HVpRZ/2gG340wbPs3RoYO4sSt6KfEjGEY
	ZeI42H3KQWHfAhxtiXrraPgPEjHxZux4uuUIG1lTxdchokHwsKxJ2SqI
X-Gm-Gg: AY/fxX7u/aFBbCtl79jo3SruWM5g3YnSzfgz+0rfrxRtSXCU6xxkZINWthrEQdXjIXX
	kZEBHYEnVNO4xSdnQXvWVU7588GJtnvyn4OWuebpN1IUDSK5gxFDi5uxuDdulSmliEkEmIp5ZiZ
	BIfXKY2ycWyIYluBPpHMR7QW0HvEMmHzZWYoUbO9X6XppGVftHe9gfmNWe8aYDf8VpzCiQUXkyR
	qP/jUxVEW3tKk4JACopyUEfvRaChAthywiHSinFkqVVvbSLp4ahzbsAREMptBs0/+4+JhkyKvav
	duUGbjz9sM8nhMuHmIwEqV4ct/tSZf8Svxre1iN180JNVc92rplrWyg00Ac5mvxkF/kS9WgaYZn
	XuBLdo94Rl38ILTcMJy2gR8eLbYph3nPA78h5KCHB3uLcvWPQlKz9kRF0+8tlv4QyOQfu4vU4O8
	Pw73JiRfqlHaQqZ8RmZ2M+Us5slCB7p05Zzlwhf4xBWm02zbtPitmA/whQsAzubezg1CnuWZUzO
	73WXDpwE91qXLo7/ixlLWW9R7aArjA+UlqCbpoFT1nqrky+q2Lk+a5PKPV6OT3jjCQHRdPV
X-Google-Smtp-Source: AGHT+IFOG7pmCyZDxSiXKnSyEk6MUYtinjZH97/IuvCjWcHbyd51A0PKmfIxl90xfHb5Co8/Lvuuag==
X-Received: by 2002:a17:90b:2749:b0:340:bb5c:7dd7 with SMTP id 98e67ed59e1d1-34abd6c6d69mr8988926a91.5.1765825695058;
        Mon, 15 Dec 2025 11:08:15 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2948d1sm9958875a91.9.2025.12.15.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:08:14 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH 0/5] staging: ad9832: driver cleanup
Date: Mon, 15 Dec 2025 16:08:01 -0300
Message-ID: <20251215190806.11003-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the ad9832 driver with the goal of (eventually)
graduating it from staging. The main change is converting custom sysfs
attributes to IIO channel interface and adding sysfs documentation.

Changes since RFC:
  - Split unrelated changes into separate patches: whitespace cleanup,
    guard() conversion and dev_err_probe() (Jonathan)
  - Changed channel type from IIO_ALTVOLTAGE to IIO_ALTCURRENT since
    this is a current source DAC (Jonathan)
  - Kept single channel with ext_info for frequencyN/phaseN attributes
    rather than multiple indexed channels, as the device has only one
    output (Jonathan)
  - Phase attributes now accept radians directly instead of raw register
    values, driver performs the conversion internally (Jonathan)
  - Added read callbacks for frequency and phase attributes
  - Added TODO comment for pincontrol_en noting it should become a DT
    property during graduation (Jonathan)
  - Added ABI documentation for new sysfs attributes

Tomas Borquez (5):
  staging: iio: ad9832: clean up whitespace
  staging: iio: ad9832: convert to guard(mutex)
  staging: iio: ad9832: cleanup dev_err_probe()
  staging: iio: ad9832: convert to iio channels and ext_info attrs
  staging: iio: ad9832: add sysfs documentation

 .../Documentation/sysfs-bus-iio-dds-ad9832    |  41 +++
 drivers/staging/iio/frequency/ad9832.c        | 315 +++++++++++++-----
 2 files changed, 270 insertions(+), 86 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-dds-ad9832

-- 
2.43.0


