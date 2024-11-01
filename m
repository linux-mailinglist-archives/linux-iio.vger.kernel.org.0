Return-Path: <linux-iio+bounces-11820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A69B9AB9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B61280FF4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5A1E6DC1;
	Fri,  1 Nov 2024 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VXZON77B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479671BDC3
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499440; cv=none; b=EzgWgYWwFlgK/7y6yS9SyEB0gHuTHiCGQWDDkmXbxHme+Jl8nALJFsVk0dxMZUnS/PJLeuv95hat2ppoI3NM2VUtK0VaiTH21nKexJZWVzMdaTK0Y71xR65hogfri1DT9Ztgd2TXyUqOU5gRX7An1g2PMUdNQ5L52bMjTIyW1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499440; c=relaxed/simple;
	bh=qpBwNRsWZTRq3EZaHQ8NpNNe8Fwjn2USTGTYV9vPPtw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=brTjquDMOZOq4MkAWCSXJMqPIuqF/Xrisyjy4ekoFkKkUsp9oJyJ6vdvaVKeOOqJ1noMD/qDq2SBSiA7c40d7Xyw+qdNN/07QSHzOWHEwSJZ0lArk/K1gXdo76wNGVLoT/9ng3dNits4mxPQDpIbGUYNA8pOzKmQ5I3W8W6adcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VXZON77B; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebbed44918so1550578eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730499435; x=1731104235; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CSzoY79/k3ar2QWQwbWZeVE8xvuTeHiY5zuTR39kF0=;
        b=VXZON77B5e/S4dAtGCzzaP2vOaMGS0GPzknosRskv80oqvxioz8Sh/IdRJdy2Fcn2F
         LWdKzQI4Wf6xPR5TSo4evXVCl6mpC1qMUZxhlFFLxxvF8hCQASbljDtG18H+g9lBxd0V
         lYoVBtUVzDN9mr3HIHVXm0VFjbhRl3ml9iZl9PNicvteolaEO8Ubk5Oo6anuT21FNzUw
         vtT9PBgHHrX/jUfAUFzJJJc5s8uRp79O4aqFP22Q9eBsZyBCnnriYG10G+QitfSuwvK6
         JLFsCK0KiZxyNueD16U4AKIBOsRLjMcCANhpIFuET77yRN/mPb0E3LDTleJMHy/QPjgm
         GOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499435; x=1731104235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CSzoY79/k3ar2QWQwbWZeVE8xvuTeHiY5zuTR39kF0=;
        b=AvHFieMBwk1RfIZdGbW/D5Pc6ZHqS9tHaLqjEC1NPj1sEsAnWU2n0vCD+IKHcG19XO
         02LTattnUMY4P+nPWRFTqvxTOQNTMwZVwr045aF1a8M9Oxr72MwHI+AgZ+z+ZIGGOZrI
         MXlgsZMISso2qDUESO7JN5SfmmBTszI3Gztu7Lj7VJTtOhRjrWb8YNPEtBeZIBjE6Noc
         z9CYGaQhhKIcQU3P/lRhauAuVB7pUadoLe5NoqXEGyd/FBr8tLMhYZBKtX0H+wJlhM5K
         Y7Fpfj1EUZIeZ6O3IOVsCSo9Pe+HrVpEvTfXh6PQ8C0rLYRfWccbvMVxcpMnTRdCE1PO
         hBSQ==
X-Gm-Message-State: AOJu0YyXpeKVvJ3Roe9uiRMO3Yo/Ti1rg3UIuPdhYJqeADB69c3oKljw
	BdU2CNugPDhaFCJmJt7ev3PY/d+A5dX9HhRcsnNY1Ga3Atr9gfm/JJI4n8GyF0Q=
X-Google-Smtp-Source: AGHT+IGHg/nF3y2Cw9wNMLYCxmg1VqIRntcfx6/ejw9ZiK9DeVF4/Ni3eBqw7YqXBPFvTqT5AFuANA==
X-Received: by 2002:a05:6820:1a03:b0:5c4:144b:1ff9 with SMTP id 006d021491bc7-5ec5ec9271dmr9857795eaf.5.1730499435397;
        Fri, 01 Nov 2024 15:17:15 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec70698049sm789817eaf.48.2024.11.01.15.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:17:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] iio: finish cleanup of IIO_EVENT_CODE macros
Date: Fri, 01 Nov 2024 17:17:07 -0500
Message-Id: <20241101-iio-fix-event-macro-use-v1-0-0000c5d09f6d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNTJWcC/x2MywqAIBAAf0X23IKPIOpXooPZVntIQ0uC8N+Tj
 gMz80KiyJRgEC9Eypw4+AqqEeB26zdCXiqDlrpVSipkDrjyg5TJX3hYFwPeidDNpmvtbKTre6j
 1Galq/3mcSvkAm9I7E2kAAAA=
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Since [1], there are only a couple of users IIO_EVENT_CODE left in the
kernel. We can clean these up too. Then we can make that macro "private"
do discourage others from using it in the future.

[1]: https://lore.kernel.org/linux-iio/20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com/

---
David Lechner (3):
      iio: dummy: use specialized event code macros
      iio: accel: mma9553: use specialized event code macros
      iio: events: make IIO_EVENT_CODE macro private

 drivers/iio/accel/mma9553.c                 | 24 +++++++++++------------
 drivers/iio/dummy/iio_simple_dummy_events.c | 30 ++++++++++++++---------------
 include/linux/iio/events.h                  | 15 +++++++++------
 3 files changed, 34 insertions(+), 35 deletions(-)
---
base-commit: c218214db564ca7d6885fa5859541a86197856c0
change-id: 20241101-iio-fix-event-macro-use-cb374ab30c99

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


