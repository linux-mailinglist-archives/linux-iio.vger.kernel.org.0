Return-Path: <linux-iio+bounces-19820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999EAC1F30
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FC016FAFF
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E94223702;
	Fri, 23 May 2025 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b6qvEOib"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A221A314F
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990960; cv=none; b=TbHw7k4xizQO8o30hjypfd0DXXfKhsgI3X9SVy4eMCmUyUoR4fiJLa4vfogcSyZ/bUz+mqKjNrJeYeh0wFkFErhGnvyRMZO4Qu7B23ku3hLMb74AZlW2ma1QNuurxAzUHU2h+7girwsenUD/4FXy023YikcOhc6XIxlb/X/BQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990960; c=relaxed/simple;
	bh=doHa3YCIp7tiYkIZFxkhEcU1OgURBbT38DlkZJp+GiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MVCISAN/qJ/ZJoo80mYIjqyGhyJfGrGA/qu1OfQT2Tgz0sqMvEZtb841LemUJjj4LNvaEZWhDaiM2fL/KqgdI60xhEmMsNRY3QTD0LnwRsrmPM6YaitM/tRVqKv9wct3suogMiw408LEyMhOmEZbZgUZBERFEM9JkZBttgdJs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b6qvEOib; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-443a787bd14so4829205e9.1
        for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747990956; x=1748595756; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwpmZ/tlJQz9RMWlTCuaFzjUWCjXgU2MOzG6MGDKtac=;
        b=b6qvEOibUsIMLdOh5JMfovPVaCWt8EQM2qnmSGVzOcNGSjfMv5IW+IeNuMkhvOYnUF
         rXQ1SbPgyErM34FF2JINJRivOY6J+3o6rah3mP9fOtC3GGeb321tV6w8fsgDK70RsoDT
         RgdZdPv73MN6D6ZtpBqnAES/E4bMfCBbMEYJHW42YRlC+hdB441PpBHzy+GnBRzYxrm9
         ch/4oaH1BJscinqYauPHRfQk6Ie3g0ex5k1fObKhDgI60OtWJvhj2PwkMPZX20eblkhZ
         pNAWYfPCH4HyCVkcGgw1P91UC8ehged4TryvV0LgCjCjWQ5xOXsFeQOeHe6fF75M7kXm
         trgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990956; x=1748595756;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwpmZ/tlJQz9RMWlTCuaFzjUWCjXgU2MOzG6MGDKtac=;
        b=awqDTQN9+VVD0879T/OGQP7Pgu5HzoYFGNjna5r82hc7a4Et3QuUvDHmREOLjJBQGr
         +AR1EgOo1wShYkXo+sUSTV98lU9wu0gY/lQoB3wplSUAcxWu9gmlEMjO6XFL9phgfBrW
         NWye8hjBuDIpDLLFmb3eE/y8ootdXDj9TWHPU420a/h6OL4J5RelkHzROuCHrQt/QzRL
         53soEatMvce81NKmkQ5sHkY7RMWy4v1FlWQIHXNOqn/73e+Wq6kDXxzo/UPRHgrgcPgv
         Kayah2amhhuYhBrWBX6vyNNiWvpBQN47BymzTnjaDYSSGDnmwoBCyTt38Sx1jNdaIwZc
         /WcA==
X-Forwarded-Encrypted: i=1; AJvYcCWuVojxhQh4ga44Q/p5cod5hRMtdJ85h6POYKjD18s6hpSeMa6tLs8c5h565R+x1hADUaS29ezZq5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPkw7oh+/jjf8IF8mqRxg8zEQFe8YeVcP7zUvgnhB7QzWtQa4
	CwktS1mrgNYMgrjkS1lVydGYuF1JcpG56LGH0+AROqm2WkQ3oHNIyD+NgCShBV1+bxLfPbbdYJF
	sIWHh
X-Gm-Gg: ASbGnct61XXDdMpAK5gXbZ8O/VjfD1Tr6VHHt/xElIpYfn6BFUKdYl+/qRFtt2AQv82
	wf5+f+ficPB2B51VW7IZFLouhZHUPqJHW6N/dZ0vBazAXXQbgd/jFx9tyySOqRSSluOfRnU6tXE
	RyvfXV/0iK0mo8px2vfxgEOW7OP7ORwRfyru6Ia6DwC8hRZhtTyMzZgyQfszJOuLIppah6eEZ2K
	DphZH6U5X9AH9wJoL6U9Vh1NJNoZygLaC8T9FlyAMg3Lhe10mUpXZs7qZ1kC7PylWGVHe7pNHBf
	RArVK8+mY/iumcZVAq2bp/SS3ex+LkgwE0Va7MELBahi/4PpnFS1bSUeajBxk0wDnHiTsA1T8A9
	RB2CG6kEb0zVREo0aSp3J9hCGFTn6olULl5BXB1d+qxYitw==
X-Google-Smtp-Source: AGHT+IFAj3aiPAt+YEDjIex6r9cadMUgoqd5WzJcO+3jJTN41Tv3VWf1ELG4ndyEe2vGuLIDmHFUlg==
X-Received: by 2002:a05:600c:b8c:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-44b58a9bb3fmr22411595e9.5.1747990955983;
        Fri, 23 May 2025 02:02:35 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f24b6471sm134043205e9.24.2025.05.23.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:02:35 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v3 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
Date: Fri, 23 May 2025 11:00:50 +0200
Message-Id: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEI5MGgC/4WNQQ6CMBBFr0Jm7ZgyWCSuvIdh0dJBJlEgUyUS0
 rtbuYDL93/++xtEVuEIl2ID5UWiTGOG6lBAN7jxzighM5Aha06mQRcqa0mxlw/6d0RlF7C0RDV
 R7wN5yNNZOfe79tZmHiS+Jl33l6X8pX+ES4kGq7MLoa4de9NcvVsf4pWP3fSENqX0BaOZI927A
 AAA
X-Change-ID: 20250408-ad3552r-fix-bus-read-1522622fbd2b
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=doHa3YCIp7tiYkIZFxkhEcU1OgURBbT38DlkZJp+GiM=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwsAyTKrz+tGjS2qs3fBO1HPSca9d+V3SY8KLUa1KbX
 vz2zUdMO0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExktzXD/wqN3lWL5RXcvyjM
 zlIyeMhfpOlZZiN42dTj2sTTkdb3JjL8lV1wtKxyhviPTdUzn/6y+OEsp/th/561Nkkn/6zr2qp
 lxw8A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

This patchset is intended to fix a random wrong chip ID read, or a
scratchpad test mismatch, tests done in the ad3552r-hs driver probe. The
bus "read" operation must always check for busy flag before reading.

First patch fixes the wrong bus read occurence, second patch reorganizes
a bit the busy-wait polling code.

NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended to be
applied after the linked "ramp generator" patch.

Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v3:
- fix axi_dac_wait_bus_free(), 0 must be checked on poll, not -1. Someway
  failed testing it here initially.
- Link to v2: https://lore.kernel.org/r/20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com

Changes in v2:
- invert patch order, fix first.
- Link to v1: https://lore.kernel.org/r/20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com

---
Angelo Dureghello (2):
      iio: dac: adi-axi-dac: fix bus read
      iio: dac: adi-axi-dac: use unique bus free check

 drivers/iio/dac/adi-axi-dac.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)
---
base-commit: 6fb85f14853ddde06d57030c753168402bf69cd9
change-id: 20250408-ad3552r-fix-bus-read-1522622fbd2b

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


