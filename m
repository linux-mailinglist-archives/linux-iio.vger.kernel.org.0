Return-Path: <linux-iio+bounces-13867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F649FEFB6
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF8C1882BD9
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39119CD1B;
	Tue, 31 Dec 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ICLdY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FC196D90;
	Tue, 31 Dec 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651543; cv=none; b=TecK6vV5PglKTHGGc9cCLX+EhhFm5jJhrEE4+XHGV1Uj/SDBR0h0ktyKK8TEKJf+QSV5kBmJIx6vcpHXnvx/EO71zfjokAvzeYntqeoiyYgk53BDm4ayrXpvPRdoi5Bv5YbV+x/1qBP49FdqcsKSVVwYD1pyz2UCnDdIoe1SN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651543; c=relaxed/simple;
	bh=pA4P+kWaLB2hTvkWd5iXIVwhJd7Km3gvKoA4e+fqrIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JH/pr+CIl2iW6nmsEKnV+fcq/Vh4/Ql68VwTlA+od7FN4LMvzkEKzGoLKMZsne7TRuPxiy6SihpGPtnnZOEPM7pfm2wpZDHyG2E8bL+GUkuPAmbAoHy4mu6O5cMtVKB4Q+kmgs7i5i8N8ScgHoqs2ZK62nP/LfUnSreODTCaZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/ICLdY4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso15360129a12.2;
        Tue, 31 Dec 2024 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735651540; x=1736256340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VqfX3ZNu7cE4naHQV4kCkKc4MhT07Sxz02F6k8JamE=;
        b=Y/ICLdY4qZuVqd8gyA3xI0g3mCijdYQK/KS95KOSStLhUm3yzTtXVYmX3leA7QX5Ww
         5RXGxOsSuwVK/W+7XaJ5l9RP5bPcSfq3vOLNvE2pw5M/oOipi6kS2/oUPJfYw3bPhSax
         UmppBbe1rb496Rop3SrrFVA5FkuOXKlEK4TiHb74o2st5Ezm6vp0HTtLTC/ZgjmmHLkm
         UC4kWuJQAqx1BFlc3MuKqaBtkWBcY/jk/kiwN7nkpUATpfad1YlIU9KPUG8VMbgBsXWV
         SqLx5/dBJC1hg8mbMC+dJo4NbLmY8isNb/aqsye2Ts8L/k+AYcqbm81f65OMC8AKOn2+
         wjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735651540; x=1736256340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VqfX3ZNu7cE4naHQV4kCkKc4MhT07Sxz02F6k8JamE=;
        b=bLADQi1q6EeobKG8vsuzL1h0Ihm2eAI7GgOLDZ948zT89DywCnCecd45ZRfK0T7Z/Q
         M+s4zhV09eglzDuuwMoP/opVxgL6gtpeoZklavkIj82KJo+6LI44xTuxWF8UeSDf3kp2
         rfuRLJne/XLOYv9BJDej4wnu5KSQvkCpBEZ857nLBMl8hm1tTfJLx73QtIWnO+LhJKJg
         vcfrk3MooUA01E1fx9KrnjZRvJzudh5MGS7+uvzOY6xw5nE8rVLLxSyCsh8yhZNBw0IV
         yvlNEvO6FAEzmD38mgVmbZQEJgkS526IDxymAvlUyzjwky01EBPOyFeLzLBtv8iWsXvb
         5ZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlCuLmAyUrWhMGT0+5W6udlLWMNN06IsQyzk2OAuaDM5i45V4Rx/3WJ9Qf81OIxoW4yudnEtvmuOninnyJ@vger.kernel.org, AJvYcCXQ3QW3lYgZu7//mvNh6S+pR0PhAO4KHlYlLC6mr7ln4V5w9J92WBf1B/cPItebJrtEKjx2fQsDBwM+@vger.kernel.org
X-Gm-Message-State: AOJu0YzFd1HwqwoHwQiMAqN+Edhi0gjBX3NOcHL+cIo3mpaviQ1KrPcO
	Q5iiggTK8ROh/DEHKomVttZxt4h+OOi5+/ROthFLusIO+tz8WzPtTIGVCmUoB+Y=
X-Gm-Gg: ASbGncs0qxmNYJIIsvDaDoupG5m8iMEi3V1m98ZjWZA1THulbdaCUFLoO8moXjnSHtU
	7BFofCXYz9S/ozz0VjRkOBc6JlBnFDiOSnLVougx79y4j5KUbm2OegPx+A2eoEfQJPY7uF3I3i3
	Mb57Tz2WVMu2UpB/3Q6mx04N3W7j3X2IF8jy3YBSJ4m0lAT/pBT3OQht6w4hP3t6AFztAsmkbNy
	cS6rBqEl+gGXFKQE0UNwNeKuftipEF26j71iZVLK1Ed9ZUS1jjG7ZubTs9dz00NTensZLsDsHE=
X-Google-Smtp-Source: AGHT+IEkHl00nggOQGkGQ9ndQmvKX/Xt4MoQG4QCboqjD9VK8h+KD3UQX7I1rg8Xv/OJscybd0Qmfw==
X-Received: by 2002:a17:907:1b86:b0:aaf:4008:5e2c with SMTP id a640c23a62f3a-aaf40085f90mr773523466b.2.1735651539599;
        Tue, 31 Dec 2024 05:25:39 -0800 (PST)
Received: from localhost.localdomain ([90.156.117.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae71desm1569345766b.89.2024.12.31.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:25:39 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	krzysztof.kozlowski@linaro.org,
	lars@metafoo.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org,
	danila@jiaxyga.com,
	icenowy@aosc.io,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org,
	megi@xff.cz
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/2] iio: magnetometer: add support for Si7210
Date: Tue, 31 Dec 2024 14:25:11 +0100
Message-ID: <20241231132513.6944-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds support for the Si7210 Hall effect I2C sensor.
The driver currently supports the basic functionalities (i.e. making
temperature and magnetic field measurements and changing the
measurements scale) but I plan to add support for some other features in
the future as well (e.g. the digital output interrupt).

Antoni Pokusinski (2):
  dt-bindings: iio: magnetometer: add binding for Si7210
  iio: magnetometer: si7210: add driver for Si7210

 .../iio/magnetometer/silabs,si7210.yaml       |  44 ++
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/si7210.c             | 412 ++++++++++++++++++
 4 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
 create mode 100644 drivers/iio/magnetometer/si7210.c

-- 
2.45.2


