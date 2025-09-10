Return-Path: <linux-iio+bounces-23935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D63B518D9
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA4A7AFC5E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F854321434;
	Wed, 10 Sep 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He1uySlx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303A320A23;
	Wed, 10 Sep 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513232; cv=none; b=W9r+uAaNTGE0l50sjgt+lJEo3amQJtkyEnPv6VlAyoXC2bfJObTNewpIVVxLktanzzXdnFcXRcKIIbK8xFR1ZRcJYGlocGobay0Q9XVKc1zsFDs8Cw9f+OZXauKUSNAeXzY0QvlooVDxuuyklzR5pHx/z34DqnBoUXbCHnHOMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513232; c=relaxed/simple;
	bh=e1ghvNIVEDhDOpiSBJL+3J1+vjBTLBp51nImUjAA7s8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gPgsQIOkHXRTnYloJqHf3SDBH7zxUWTKNjKJ32XVmh3ikEmXwOLbfPyzqACvLVCZC/bzKQ/m8lMExEUkBA9aWVgcT3P8zGkpJ9fcSMVeKM0DBP//SwfO4rHv1CXGAXPu5n0a6EnON2RSTut8CI2eEtrPzw7ac6cpPTdEN4bfWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He1uySlx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32b959b4895so4777569a91.1;
        Wed, 10 Sep 2025 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513231; x=1758118031; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9a57p4h/5p2e5Uiw/EL0tS6w+eEl4IpqCuOC0vO87Q=;
        b=He1uySlxgYkGvcSc4nHBzhAljJjanFqR4T8fF873xMSqWlZtKe5u4PDgeVLEXZKcqc
         uE0ki8tzgDootZWo33eUAI8fAGC5l9iZsaaS56+kHlu4jFGdKyhNb99eH4k7ohbkbv8z
         koYtEk70dH4OhWsMClAGITG6ZWKOxYOezlg28N5RSCwpGQ8KUu76a+Z9DmWvkrQYNxfY
         k9poGc91OlUJtZzBb03ezCoiYd0cvp/99ZYRxq6gHSl5DkamfeOxrFCgpltFwfrgGySX
         NXAFakwGi8D4l+NhfBEK5MLElYFAC60ExWHPaa/2+SxDI8O4XuZekTHnKFUHfs2bzGsl
         nmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513231; x=1758118031;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9a57p4h/5p2e5Uiw/EL0tS6w+eEl4IpqCuOC0vO87Q=;
        b=X4G1oTHT15l+BCR7Tk0anwLrSPEIt4IZHNz4WmOvlrsNh+3Ygsk5G4xWEu22dK4LGD
         sMhffMuiMxkBTWe+nyfvFw1dVtly3H4Q+I5LFxlaIfZ1uiGgcPdsOuPPfrkfLqYF222X
         clymVe3kIxNAgWlNBHr6+awK7UWM61DbwoyS8UUYgLUUUy9W7MWbdwzJ6LNZOXUTXRTT
         5KXZpyj8b42TSbCqt1nZPaiuUKA/yykr2VPFR3V1uDlhmkjnalhoh8Ottr0EySWe9Em3
         6rC8htPwZIDp7qVDecJSAa8bc7P+vsQ4xSkVltGHqTeBsPfIsor7RanlHmmw8eA1Su+R
         H6DA==
X-Forwarded-Encrypted: i=1; AJvYcCVzipFnvOjJNaW2tRd60u9QX32vNXIOMiwSaCjUQrL7rrsR2UcUqV1nmhlhVInKx2f3vZTQgyf8IvHHx9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9uQDd1Gdo+ZEzAw+/J/VMjA+1Z7ewcmbk2ONwro+IxxEpVsL
	P5UYTh4UEYBn8b7rjOVqhrIW0UJ8/OajdhQ32p0K5jeEhK+AgBe7BwrU
X-Gm-Gg: ASbGncs/SYQbdXKRhWMF/tP19/2qK+NkNZbC7rjB8Lb5bVNeZzV72D2Wr7OVp8QLg73
	SyU34Pyb7yZUJXNJBNtEw5jJ9UkCZAvymNWWKO58ek4lObzaU0BF12CDdgVTi2Vq5NSDy0ETxa1
	eADaGeL1u9YzqQV0jSJNrMhK2KBC56YGbIDegMp4B9elMwWsZOlS7aBjuWDNA9KH/gZJJscr+Z3
	iQj2SYRSZh5S33mexkXCV7JsialQR1S5wevNH9mOYA33sIDgO7E9g8yQJSSFZ2bXP6jXWsyef1s
	D9fnlzS4k41BJGKGsXRouU09Frcdhv49/yd2aqCZCe41Q/xxfMA+p26UQ6PSewbKK18i94IMWAx
	vRr1vnhunYwvBbEpOMkRyYvwYeOrt
X-Google-Smtp-Source: AGHT+IH7i3rHW/35HWjyAxYyVURJ3m0CgZHufcD5q/iHAAUpeyd5wMB/QGMt1OJxzAeiwSZeKg77ZQ==
X-Received: by 2002:a17:90b:5105:b0:32b:958a:51da with SMTP id 98e67ed59e1d1-32d43f13e9amr20895830a91.16.1757513230665;
        Wed, 10 Sep 2025 07:07:10 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:73ce:c1b3:ae9:98ce:970])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb2f54acsm2760204a91.2.2025.09.10.07.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:07:10 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH 0/2] iio: magnetometer: cleanup unused
 IIO_CHAN_INFO_PROCESSED handling
Date: Wed, 10 Sep 2025 19:36:48 +0530
Message-Id: <20250910-iio_chan_617_rc5-v1-0-924091d374be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPiFwWgC/x2MWwqAIBAArxL7neCGD+wqEVK21f5YKEQg3T3rc
 xhmCmRKTBn6pkCiizMfsQK2DYR9ihsJXipDJzstHUrBfPjPeIPWp6CFdjM5oxarNELNzkQr3/9
 yGJ/nBZV5WoBiAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Gerald Loacker <gerald.loacker@wolfvision.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757513226; l=899;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=e1ghvNIVEDhDOpiSBJL+3J1+vjBTLBp51nImUjAA7s8=;
 b=YaTJg3d8TH8gupDDSqrSAQrYBwIag8ZbvYuVuiRIQ0wGeDphem0+cnAaPnbvWl7XLc9p4u2xr
 C1D+M4UoRWRCQJlbs9C8ltVOQOr4ezx9GPRJh/29AcEkW6B2BAWoTB2
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

This series cleans up dead code in the magnetometer drivers by
removing unused handling for IIO_CHAN_INFO_PROCESSED. None of these
drivers set this bit in info_mask_* fields, so the cases are never
reached.
These changes reduce code paths, improve readability, and make the
switch statements easier to maintain. No functional changes are
intended.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
Dixit Parmar (2):
      iio: magnetometer: als31300: remove unused IIO_CHAN_INFO_PROCESSED handling
      iio: magnetometer: tmag5273: remove unused IIO_CHAN_INFO_PROCESSED handling

 drivers/iio/magnetometer/als31300.c | 1 -
 drivers/iio/magnetometer/tmag5273.c | 1 -
 2 files changed, 2 deletions(-)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250910-iio_chan_617_rc5-59be964d7451

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


