Return-Path: <linux-iio+bounces-7965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE693DF4E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED63E2836C3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7307FBD1;
	Sat, 27 Jul 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD+qvFA/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994187F48A;
	Sat, 27 Jul 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083460; cv=none; b=tsJ1Y5y3pNzlvMxIjPQdUdSneeeZf2e+PCcDpFDyzy9dIYCyLIoaacpjob3wLBPe3XP0/WLIqOBXXXAVhQ+9RH20bwR2PvtKTZcgVKtLcOc3LPhkrwAS9g0YNzV9w8IRqf6Dua+olUoa9F15hN32IPjcg/q2SElgP6Ujqpp4kZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083460; c=relaxed/simple;
	bh=7hDzJ2eL4+dcC/1UqVpGTE89aJqMEHPHh5OqpE4H+jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DniuoWntWOH2Cap4moolslOrCVgpKcmrc7ORA2Gq+oppsH4bStX5Ia9BwSjUR91xHqaM7YyxHpopUlxrAKoG/l1CjPCRiD4iDPxg7lVYaIsJjswxK23VX3mk+snAK5HMewJrRdImpI+9Emwgha5uoCR50MZ1QeDpnh1qxehaURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD+qvFA/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280c55e488so2565065e9.0;
        Sat, 27 Jul 2024 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722083457; x=1722688257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/n5Yht+juCe8MYSYeZsU2AfwFl1EL9jqs/xXd73qzCE=;
        b=eD+qvFA/SNG4EJ1u8Anz3e3J0f8Xj4QOSAOqzoUUMQS8tW8I8EJ61ZReLzwxumjfqy
         epPCbXVEMgulvjIc5pHaw//K2PQ3gdNUnB6iJNOnLr6CF/Rm66JYgc8ul8W/7RmXdPCo
         1tE9GjKZuJ6wpnvfV9OFTQf8XarIHaDze70OPQ/qXrH/ZMiLa/caVwI9Gi5HZ0oykFj6
         s44wpYpokhKEoZfDUt+cLkbQve3eDWAlBk66VrBMK76Zosq7sp2dAq8KLbFb+KOgOQa0
         eIAbK8vPz5QWq/SkSvdarWrZ5c6Jo2H9ICaT0KkC2utSQgQzVTY2lfj865w+J+ZSPil+
         i5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722083457; x=1722688257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/n5Yht+juCe8MYSYeZsU2AfwFl1EL9jqs/xXd73qzCE=;
        b=wmPOXj6r9JnY+Cx642YTOWATuuRGaamT1yyHTXzu5F+5i2V40JPD40v83JjKpZcBwv
         yoDwnI7WTw3WExxgl35geJ0HCCTPp6/kmYUMMFn6mJSwZmaQq4+TN76Sl2X2nHhSF2HI
         lTy6ta9TlygqTuZCOqVjImUKGS2b/3e9ULZnddxVkNIhI6wSKQWAa/7otSVjaX2rwut+
         Wt51CKJMcNiisxX7KY5cFbhfm8u8HK9TQuKeV8xca1Qm/GHEq5zPlRRH5wDkwCpnkZUB
         WDtnRY7Z3E3SBTA2Qw//chZsUoT36gI8Mli9KhNJsFDtYj6C/wOTeLcwS6d8x++t/+jm
         lg0g==
X-Forwarded-Encrypted: i=1; AJvYcCWyKVhwyfseItWad2aITuUqmI2K594Ps6dzmDPcEAylpy4hnZ+FfqdNW7zhNuuV26wQiUb/a5f+PbOyPkkb/e5eS0wN/ttI9/hEDgB5moltkGvXcfoEWEWisEejRx/N5yyBh8T/82ww
X-Gm-Message-State: AOJu0Yx0kBLyoZseImjMCmsFjpDX571oWGIoyFN5nUHY9ehspHbjidxc
	aaZ3pwgIgJrJFuYaq11yqE9st6Z+zTH8D8q4vN/+dUakE27aKNr1
X-Google-Smtp-Source: AGHT+IH1nVg3qerUld5BcUAUdikWFT8V1+3qZprMvXuk/UBA2ZbTAPGb0dG40LAx+TYG2neJ8odonQ==
X-Received: by 2002:a05:600c:3b07:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-42811d66212mr15497205e9.0.1722083456459;
        Sat, 27 Jul 2024 05:30:56 -0700 (PDT)
Received: from localhost.localdomain ([176.206.92.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm114913215e9.38.2024.07.27.05.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 05:30:56 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v2 0/2] iio: fix bug with triggers not resuming after sleep
Date: Sat, 27 Jul 2024 14:30:32 +0200
Message-ID: <20240727123034.5541-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device enters an idle state (for example ASUS RC71L with s2idle)
and an iio driver has a trigger attached such as iio-trig-hrtimer,
after resuming the device the trigger is not triggering data acquisition.

This patch series solves the problem reliably and is well tested after
many cycles and many reboots.

Closes: https://lore.kernel.org/all/31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com/

Changelog:
- V2: patch 2:
        + Simpliy code
        + Remove unneeded code protections around SET_RUNTIME_PM_OPS()
        + pm_ptr() to let the compiler drop bmi323_core_pm_ops if !CONFIG_PM

Previous patches obsoleted:
https://lore.kernel.org/all/20240725002641.191509-3-benato.denis96@gmail.com/

Denis Benato (2):
  iio: trigger: allow devices to suspend/resume theirs associated
    trigger
  iio: bmi323: suspend and resume triggering on relevant pm operations

 drivers/iio/imu/bmi323/bmi323.h      |  1 +
 drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
 drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
 drivers/iio/industrialio-trigger.c   | 26 ++++++++++++++++++++++++++
 include/linux/iio/iio.h              | 17 +++++++++++++++++
 6 files changed, 69 insertions(+)

-- 
2.45.2


