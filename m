Return-Path: <linux-iio+bounces-8315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0594B01A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 20:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4D28473F
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76A1422A2;
	Wed,  7 Aug 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDyoeSt3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358485654;
	Wed,  7 Aug 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056994; cv=none; b=q0iQu4ecE850RWp2VgxOhGiAgTt/jjVT+DHJR3HM4CebHLLhWfL6RgyYgvAlAxnnsIcq+0T/fGX3DtfCRV+8aPATFv7giqAXyigBAbtkJR8TzIfDJnVGwqS4pOI8vreWbK/GZGkLBhDeNciNn5/Ekq+btTsQC0uJ+t+exZPfxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056994; c=relaxed/simple;
	bh=lsuc/lshZOg+DuqIVnQSssFUNUA+HZLxp3IIAp18gFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxUI45cjymvLQokRNepNKsrGUVEtktTBM/SAqkJ4+IkDnxBiMpO++ZvXl9irTfZGGgki9V9qSRVr2oE2dP/4Hfl+Ak+7qhe4RHQ1QlE730Y2c6wvlmD2vEdYkOjrHoysLfUNda6bV++Xbt5/JAFoTWY0BOq21qK5Nhk58/9AvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDyoeSt3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso134110a12.0;
        Wed, 07 Aug 2024 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723056991; x=1723661791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxxFMGONyiY5lwMQEz9ipuTf1/gIzS+3OZW/D/IQ/z0=;
        b=gDyoeSt3XmH3D7+Nw3dZOP9sAuYoVuhGgmY9cyfYlrmIomGQWiO7v6HbIEPfBW3cfq
         q/kI8T3jIyYAgwLPonTgqJWa5Oj528+01tew0pjOudq0VOq+Ipr9QuB4IpafnBDlkfHa
         qPaYUmj03MnRSVrvUdyGG2+VrBHi/wWVVuVggHunCQhe43akEVgZzvEq53po6Fy5AHTk
         BXKmgX69qFMCeOC5qtlo9KLVHhmNugtnP/SsH2fcTrWfB4vUJFeHnbbDAWvWxpruI1eP
         1Shew1tMOcOWInyaa0gzbk1cwmY4BOZdO8JLN8I88++1VdWzmPUdy5RpGgOQuaXFsBc+
         goVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056991; x=1723661791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxxFMGONyiY5lwMQEz9ipuTf1/gIzS+3OZW/D/IQ/z0=;
        b=bjc3/XAiIaUCIm7Wf8h8jhQJbF7mKQopw1IkUR6iMqH7smpLYZeXD61CVZC2VdWDjC
         Elcjp2jqB3okhemj1o1rg4D5/UaJACKssvrN4QulMSIncy55vr10mqwGFBcqgMk/g5U1
         uZ/ijBk5+s6ikR2mRU9w8tgfRZ+s3uSoF9Bcq9Bk7uYTid//9RTTzquC65vpRpB77IRr
         zqyQtVnmEpROXLomrOstdapmHES2xR4prgx8dW61q52DGtaka2S9YYrkMjR2bgLiDhei
         dd8hF+UNKhhArSeDRtkxTv+wua0kxmUjEy9OTn0KhiLBVwGS0KhTAfFVuR5U9aNUpo4f
         vVZA==
X-Forwarded-Encrypted: i=1; AJvYcCWAQDOKdINuXdJFp1rEDzkHAMz5lEHZ+Ya459677vZvheEUMI3M64zY/w7s4wv8t55WT7tdDOS2xVvO6lhFQAPoOsFr4twu+L/BqUfR83+l5mLnyYaezSC17b0KvIL0ecC7BhsLwlWx
X-Gm-Message-State: AOJu0YzFWkpjhuenXM78vsA7YuL51KQM3LQS2kdbsvEDOcrLsUU5Q6u+
	ycekNsFdKY3CrSiQOxmF1o4vqERnny3ooD7cRUX02bhUfUjESOc8+a8L1XPH
X-Google-Smtp-Source: AGHT+IH+Zv5ByLmXrFLeRoWJ54QRqBaPdE+dpeb7ewU++CROsHLBRoMPYFuimEgJkdFqV54K/P+gRA==
X-Received: by 2002:a50:ff0e:0:b0:5a2:3b8c:b4e with SMTP id 4fb4d7f45d1cf-5b7f59e04c3mr12466376a12.31.1723056990768;
        Wed, 07 Aug 2024 11:56:30 -0700 (PDT)
Received: from localhost.localdomain ([151.49.208.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba51da9c41sm5482270a12.36.2024.08.07.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:56:30 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v3 0/2] iio: fix bug with triggers not resuming after sleep
Date: Wed,  7 Aug 2024 20:56:17 +0200
Message-ID: <20240807185619.7261-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.46.0
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
        + Simplify code
        + Remove unneeded code protections around SET_RUNTIME_PM_OPS()
        + pm_ptr() to let the compiler drop bmi323_core_pm_ops if !CONFIG_PM

- V3: patch 1:
	+ Add pf->irq=0 that was accidentally left out

Previous patches obsoleted:
https://lore.kernel.org/all/20240727123034.5541-1-benato.denis96@gmail.com/
https://lore.kernel.org/all/20240725002641.191509-3-benato.denis96@gmail.com/

Denis Benato (2):
  iio: trigger: allow devices to suspend/resume theirs associated
    trigger
  iio: bmi323: suspend and resume triggering on relevant pm operations

 drivers/iio/imu/bmi323/bmi323.h      |  1 +
 drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
 drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
 drivers/iio/industrialio-trigger.c   | 27 +++++++++++++++++++++++++++
 include/linux/iio/iio.h              | 17 +++++++++++++++++
 6 files changed, 70 insertions(+)

-- 
2.46.0


