Return-Path: <linux-iio+bounces-11581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF079B54E9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 22:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBCD1C228DA
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE19209677;
	Tue, 29 Oct 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jC/KVKI8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700872076DA
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236743; cv=none; b=adr/QSDKVwfbyrxAj2+GwVg2jQNvA+eqK4LB1rAqPcX1XlzvKN/p9fFYnIK2Vdnqfw9WmgnZYQY2jW3o+SFO75a3p96yJGZVh2PolUuVGCQTddBEomaQ+vFQzWdnfPEFGT9W0SPbTD7xMgLHNRV6o7lmhzblYLcntk6zrpvBGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236743; c=relaxed/simple;
	bh=nyRP91hJ2h28G4QDpbeuqnCAv0dQZ+JWN4ohEZnCg9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iFeAPBs+NoRxo8MsHjq/8tCjXbBEBbbV1u5cqpC8FtD/7xRSJjNVRb5hCJA8xAZ0fyZO/nnA+eIFNe1Xhk0Ak9+USRIDCa+36xAS52zKMDRy+w00OupGif+ZzH9gcMCkuvqtMgsT/5DXChTDlckA8HQZ25EAE9xtJ4N1P2ggzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jC/KVKI8; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e60966297fso3354627b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730236739; x=1730841539; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRQx5N+DwrT4EUE73rmqbI0LhD3xdcyP7bdqkjI3R9M=;
        b=jC/KVKI8rfq8hPcvUY0gpc0jFKZZ7BheQj1pduMujp0CbHCsx5qIXTFBFZ1a5FLQO4
         ZPBeeSJiSL+hW+tLGYCmOdr32FGrDfaGCXtlpe02rUr1qCCtTwXjMXWNK/xwMjqmNBqY
         SkwVSRnkmQlxkAZOHug5preANFLEritSqBIyy5KJgkh3tYI3scs2Ynewzmes85yguwfO
         t7H05zL19phAhfX30CkpTpH8WawQj408P4AvBXZimRLgl867leApmOx+S4ry5ExJ4eid
         pmkb2D73SiNgaJ5l28hPxQFsKEwj2nrfFRqy3CzYg5nM244WIj3LiPaXdQJIlZCQnq8N
         NIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236739; x=1730841539;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRQx5N+DwrT4EUE73rmqbI0LhD3xdcyP7bdqkjI3R9M=;
        b=ud4vna7C/JlxcnB7LD7x12PV6tz53e41LvVePhpT3ECRNH1f3tkGja78S8Ub3NRG2D
         Kex0kchQSNIr2teVw6ZkqPdCptzJi2HweB3cntu2hKXqDfqIEq/E2g66Zja8d3+Lrmvo
         GmrptqyFw7id++5IZXBJxk01CFHm5od4Z3SNtm+ri4LjfBdcC/ozsPG14hOIQX95BJp6
         GS2ICMYWhYFgknxSD+lgH/tg9zGcV0tnK2ZhjwbznSYrKcAs5jdXFdryr/4QkQfVudY1
         XJ24y7Cy5JVhM3j2rN8zj7how1OaEUMythp2dLBGR9weJ5JEbzWKiXjO+sUQPEIiPGa7
         TSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPwrtSY9toRv+IlgvML8LgMZOXhclh1F6ZigpbsHw5Ceeclp7KgwsGF/RgDQxLgIIo7BriTYmcxbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmpbPNJQNJtZ9JL4mC+WyKoKyMEgAF/Qx7+InoGDNGaERRPYa
	LN+S7uZISNfZ8UqyCAlo7r4i0025iK5JAVoCp5dnDiAfjnWAhjEDEIDWBSuTjXUDSuskQ+IiH9I
	n
X-Google-Smtp-Source: AGHT+IHarjmcG5SOG2UGfwxdr6/AxJKyyOUJZwOiJi9PYkdpyAMO388rpte7wKVQUeAKOJIsDpfwDg==
X-Received: by 2002:a05:6808:14ce:b0:3e6:1fb5:8f50 with SMTP id 5614622812f47-3e63823e27amr12237373b6e.5.1730236739578;
        Tue, 29 Oct 2024 14:18:59 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b87ecsm2280559b6e.54.2024.10.29.14.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:18:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] pwm: export pwm_get_state_hw()
Date: Tue, 29 Oct 2024 16:18:48 -0500
Message-Id: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhRIWcC/x3MQQqAIBBA0avErBNMCqqrRIjlpLOoRCUD6e5Zu
 /82P0NATxhgrDJ4vCjQeRSIuoLVqsMgI10Mgou24WJgLu0Mb3f6+KU0GGWIKqK0ifWL3ppOD6r
 lPZSD87jR/d+n+XleHq5AvG0AAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Guillaume Stols <gstols@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Calling this v2 since it is a revision of the first version of the patch
from [1]. I have split it into a separate series since the SPI offload
work will likely take longer to finalize and there are other potential
users of this, like the ad7606 driver that I have also included in this
series.

[1]: https://lore.kernel.org/linux-iio/20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com/

---
David Lechner (2):
      pwm: core: export pwm_get_state_hw()
      iio: adc: ad7606: finish pwm_get_state_hw() TODO

 drivers/iio/adc/ad7606.c |  8 +++-----
 drivers/pwm/core.c       | 40 +++++++++++++++++++++++++++-------------
 include/linux/pwm.h      |  1 +
 3 files changed, 31 insertions(+), 18 deletions(-)
---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241029-pwm-export-pwm_get_state_hw-8bdf15d9a408

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


