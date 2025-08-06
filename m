Return-Path: <linux-iio+bounces-22330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B8CB1C2B1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 11:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB3418C117D
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989F289E36;
	Wed,  6 Aug 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpbXXIeL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3427146F;
	Wed,  6 Aug 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470935; cv=none; b=JBJIvW6HRtO7kzwXmHCzi4aAhJHD6CZVk+cel3N3N4OumCy0YkdB1cGDenRwQ8L2K2OgYcDF2bxYrsXJDfFZtG6bBjhfq3MLLCBt9h0gcnhI3Plx+QLt5KDceYrxNq9ZeJyIKPadcJR+qxYe8KV+sV1YakfPebJbrJeDBepGNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470935; c=relaxed/simple;
	bh=7lv5p+Se+AChgx8CYwn3WQmsWHkKRqi+2VVyzpDOfio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kz/npwXT1XvmSm7X/hSMXTYuPvnUdNgPcjcHsFSwwes4pxVvMHoked7O1hSlKwPneceeE7adhsswmWM/yxaV6o8NQPRUVP/L8F22q7JVRYoKyomcI8tj+8j3J+z+ysm4fN0XqXpVTtfFHOzckPnYgSz78DAAIsS9oWTZIXj2rVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpbXXIeL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so26476945e9.0;
        Wed, 06 Aug 2025 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754470932; x=1755075732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HG7mmjekmBc9iOgt8Q416XE786OOzt0P1MHKqzsnX60=;
        b=BpbXXIeLAsq17a94C+SvotXKbv+0Fy6ji2g5kzJD9qx68SUcKrX/a8vAB3oTmvR6AM
         T9+y3TRZ/6E7YYJQibFUmmKzFddXyTyzPpplK6GXOpegvrBRVHObXDk92qtKvQWsUJle
         CWehfQxBuGHhEDuGkKYfXcrJxYMwcm6YuBcrmQPGaSgGryou6sQo1KU3dIzlGF0wam+Q
         /r8yqMVsGLwn/hde33nY5zjQQ+NpfGK4furG+OIoIHigEJskYL1mn1a+Xo/cBqADB6Yg
         Xxv4fEhPN0AWxMUxfj59gXxttzvrzLnCvTLgJZ+WEUPcUXg4bAh2/hnUEGA1GJeut4+7
         YoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470932; x=1755075732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG7mmjekmBc9iOgt8Q416XE786OOzt0P1MHKqzsnX60=;
        b=Yt55tzZ+aoRHPcONPPgfAnD/J9CMlpsGkDjM2aysMseCjymH2A2CNzUQJqs3EpDroS
         2Gd08APMyfAt3hZ92T0e+dsQyX2/TKn7uA1mDC2xlB8A/8hHpKuMT82wVByUPzXSbcKw
         3RJ4gFSOMQiu73MwYVmaW37beY4JuXMRscQMboBdL2bFhoiqjTTWoghA/8rZ0X8RCGou
         DpSCy3PteuekEAZQ5CnZj6MHPHR+PZfTthKBaXzgLRwukddF19hniur5PORrnY5lBi/S
         Eo8ch/90uKZpTMl+KDnZJeOnmRZeLiiWvRsdKugdxvkk3NDTEfKICr6P3pjmJlGrr555
         SdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvYJWKVAvfzW/tCqhn6kmkBaxEsVOSJLlvuKoNoVv7WIwSbMGtiLCLb2w40BMFdt/wR701Zp6DWYoNqTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTVHdXCaC8EGG0IYYEOBgM4I2WPopK+5B9N+kosOZrR8LZ+fu
	WNVqQhrxU3vy0hclK25k6nB3VbvKRL5ZxZeSYL8NDUZPc5VTuhNIZhxyfbzuoyxy
X-Gm-Gg: ASbGncuztoJNPeZQEzveR4lLEujzhoZHNPUwED31msihLONQqR6vIkAGShcagIr2nhE
	tqLlZwtHJ3ILbeefr/OEEuNjtOmnyXbzcDJA+yguM7bHQH4ntY7x2Tbb/qn+KUmlRDWs9ZluRr5
	5a26BJlCdbVcefe6SI492wtD91ZWmaUXPngGua8+BLTXwkfTvs17zCu9t158bEAHbpqxdCyRbO8
	N17QOyevqVLFVvaBDK/JMCaYMOt6dqPc9Kg6fMdT4+nS+Ykxka/NryD75Ytq6k86rpbvYbQL+wi
	SSvxSPODUUPMT4LfqkUdqCd0js9gXRmzDqPza2hs2GpGwgQnbp2HbVFy/5Kn5hsc544KgVCfVPJ
	yCuWf3vrlVZf00OChTutFpEec/mGi1pfjteMl//CNGFHcbtPGuy7PrH40
X-Google-Smtp-Source: AGHT+IE0oKNBZv95xmsQlOIvZQSingXpyciPeNm5RXnyjXrs6f3thipsXroZ2dVXfWLHxbdk+1ldOg==
X-Received: by 2002:a05:600c:1c96:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-459e7440e2fmr16202885e9.4.1754470931499;
        Wed, 06 Aug 2025 02:02:11 -0700 (PDT)
Received: from fedora.. (93-38-186-193.ip71.fastwebnet.it. [93.38.186.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm22309399f8f.39.2025.08.06.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:02:10 -0700 (PDT)
From: Stefano Manni <stefano.manni@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 0/2] iio: adc: ad799x: reference voltage capability
Date: Wed,  6 Aug 2025 11:01:56 +0200
Message-ID: <20250806090158.117628-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
in order to add the capability of the chip to have an
external reference voltage into the chip_info struct.
And so avoid ugly conditional checks on the chip id.

In addition the AD7994 is marked to have the external
reference voltage as well.

Stefano Manni (2):
  iio: adc: ad799x: add reference voltage capability to chip_info
  iio: adc: ad799x: add reference voltage to ad7994

 drivers/iio/adc/ad799x.c | 45 +++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

-- 
2.48.1


