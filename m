Return-Path: <linux-iio+bounces-24767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47CBBD78A
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17EE4E9FA9
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F61FBC92;
	Mon,  6 Oct 2025 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVIYpl/d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2411F63FF
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743663; cv=none; b=C9wUGS1MVxsOkw5MKegJeGsMPl9yJdhvPKkto4F/1MeZvqhM7DF3lAuIWAE8oGv2FSgpebeSDnwbiLt0FoBan0/1LCmRyf5/tgv6faaMuuaxp0pBc5oQR8PF/m9XiD2qTqLGT10dng6yhc3NOQsRgrbUKvrJrudt0ATFZWLG4Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743663; c=relaxed/simple;
	bh=Z2qL2G+4Pt/JBQNoW9f3BZJBj8XLBewwJbcA7Rq3T+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDbn7s4JkP9bJqyB0/4pLt9/eljzlIGcfkmQVVO76FYsSbe9eQeTJ3BReqyXOjjznSjWwU3ZmlnmEe3XaRaDsfKlylBQf3G8yJVqgPym1xp/YuDwUV/L2hdH6E9sxKnbwNL5+lY5lxqWCma/gLhWxABbQi0vV+dAHFvuFmJez1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVIYpl/d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af9ebe337so3056637b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759743661; x=1760348461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAUwicTxdfaUf8jTb+YjaOImEhUo4muFZmK2662yA8M=;
        b=BVIYpl/drJI1SuKvis74OyoEq7UacSzHjeq3XiPx0Jfg+N4O0mOj4d2hdqAxTCTOaq
         xl8oM24u2/5AmFrsHj8kYuB9/xSj/S8TezBnuTZQMaHul6B7a4VPILPQ9z+kQyjAMLoa
         7HUvn8uJpjpoUovRNpkaL4uWsafDETBJUm4wz7SCtuQKdGLvATjX4t0RLpy1jU6wSZ5h
         +APYNON1Ojy2OirCFERyuS4PPPh+mff1b3bkGe3GquBMkD71aiA47ASYOXj/QafH9vGf
         D4gEy+ArYpjdAXmoknDXqtp9rYU7lfEKCkTvKT9QfR5vc2hvgc7o+pny1itsnccGitvi
         sJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743661; x=1760348461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAUwicTxdfaUf8jTb+YjaOImEhUo4muFZmK2662yA8M=;
        b=TffSOdKSf6cAQxqWPvlQnmDjinnZbCYwtJEx/7NmUDZDLQbo8Ffror8c2c2UhPV1Vm
         8qzBwL33/McrmGPyoI+kCKs4FKNdRyNHUTtHfb006xLbwitTZ6FJ0+8w2Vd3svIjkDjG
         lxFiBjyz2pYJfhT93sssnOx6U2Cyb/faOJYgZAeqpMMcvVLAcHsvijSMzSJQnQwRLK1f
         7Kbww/fjSaSEcbd59RpT4kDHq8DZaZQQHHtG4tJ/Ev7lZVfI63r/9BvJn4JLXIxy6SUt
         kFSzu2+XJ6VxwOjYmGMbSfDx6t1UWkSYDWvFk+knO02ZQ6vmaQOoYUW08BkG5Lx1hKoI
         YPaQ==
X-Gm-Message-State: AOJu0YzsfFzepVkwEEw1X3aI9kaJTJpGCK42MM50/hErc054JuHvTk8D
	T3ygFQFbyjq+luUJbnzBrXct80zjI1ykZffckA3RpDqb5bXDzTN0XcRE
X-Gm-Gg: ASbGncvolQ7Zq+ftPJGdCag0yaAcT1reXmr9lffQqBpwEhUPNCoJHtu/JYsmTWUNgb+
	FXgjIg3jDB1Wk6obn4cHE8/76msYWanXmWL5x/iDkX/5tNmcDhHb1zZmHICddkOEhN+OYyczHDR
	68e/VhWd/gP+1cR1cSR0kjw8qGOmhJstryEQo7AXjDe+aW8sq3xRQzfHE1NkZx9vC74/UvOWVah
	wSzjFKrlkmTZaKJMsQOQtUbqdtBrmnWCL9/gVjsBTh1bo+jFXFgvRq9WDus/kLdtkPcYQNakx3j
	6H8QC//yRGn3xFThehzLHEJq9fsJhvJzY5tjlN9AeCtdN7fw11bofggjpYKRn/UYVmlqtV5NV/M
	Y9G5Lq6M/JYMZ609Vm+O7BqaCtazTfbtLF2NeT9h+ZcJVst1o
X-Google-Smtp-Source: AGHT+IEsX7CrV0iVNGjA8nFm/M9lXva7xfdJR4uVQ4bFTbEaIpEB6yg/z+Eg6Y82ptLaz0Aib51+2A==
X-Received: by 2002:a05:6a20:939e:b0:2d9:c2:5ce4 with SMTP id adf61e73a8af0-32b61dee96dmr15699402637.7.1759743661363;
        Mon, 06 Oct 2025 02:41:01 -0700 (PDT)
Received: from ASUS ([119.63.139.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b609be239c5sm11325778a12.19.2025.10.06.02.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:41:00 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Taimoor Zaeem <taimoorzaeem@gmail.com>
Subject: [PATCH 0/2] Remove ad9832.h and ad9834.h header files in drivers/staging/iio/frequency
Date: Mon,  6 Oct 2025 14:40:23 +0500
Message-ID: <20251006094025.259440-1-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes ad9832.h and ad9834.h header files.

PATCH 1/2: staging: iio: ad9834: remove empty ad9834.h file
PATCH 2/2: staging: iio: ad9832: move struct ad9832_platform_data to ad9832.c

Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>

 drivers/staging/iio/frequency/ad9832.c | 21 ++++++++++++++--
 drivers/staging/iio/frequency/ad9832.h | 33 --------------------------
 drivers/staging/iio/frequency/ad9834.c |  3 +--
 drivers/staging/iio/frequency/ad9834.h | 10 --------
 4 files changed, 20 insertions(+), 47 deletions(-)
 delete mode 100644 drivers/staging/iio/frequency/ad9832.h
 delete mode 100644 drivers/staging/iio/frequency/ad9834.h

-- 
2.51.0


