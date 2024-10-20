Return-Path: <linux-iio+bounces-10825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645A9A55F5
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 21:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CE51F2232D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB319644B;
	Sun, 20 Oct 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfyObKub"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3D1990A8;
	Sun, 20 Oct 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451550; cv=none; b=aUuGjhd0CHmLv3CHOTK6BYjslydEHYODrUUCnQMYNm+YGzwFrGA65zjABKKme/aU9bb1J9YWq0XL3EMghMYzaXgJGPXUJJmlHWrlA99aYQwW7WVmaYQoCaOnM183bDNxkwqQ83DG4e6iLoTomt+G629hrdI6N8nV5gN4kuQFmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451550; c=relaxed/simple;
	bh=i8au2tTyl+TZJnNky4a259WdCcwNgPybYwXiwc0iy0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B6LCwCD/DY/F/PYosTkFVhxkaWbORAafBnBdLH645y+Wkh6LH7Rf0jOF9v2CyEF0RH+2b1WZbNF27UQQ5nM2YaXpaaLDMo//jX1mAYK6wHJ4t/zWwywitMy1Tyi7Wu85kQlZGFhk0P0nzn57p5h6lYMBEZrtYrnTPny94wKMjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfyObKub; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431481433bdso39291135e9.3;
        Sun, 20 Oct 2024 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729451546; x=1730056346; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YTlFE9y0ioXpBTOeyys0wnNuvycwpmvcV0ld9ft1sg=;
        b=LfyObKubBreXTEuQULlSJHTHLIKSwzRWqk8HWq+ZYSlCIPBjG22pS3y8eDd/E9zzVS
         OFHQvz4lQF7w+wdlQv7Bguk14MsVdcBhtGEgGuGhHmrZA3/YEpfwr84BUgR31SiTLxPe
         5B/TYqbB7jxjpaIlVwLZQ8a0PS2LdfRbsSJW1pT09YidnjOlphSYG+msD594aHVQeBfr
         t+BhXMcQAJcJgaM460QK952HHWW5GPUwAnk8X02wWOVVNQjaLNrzOS96fYaUoO1gY2km
         Z1bLXyocfcckM9mmqa8EKr//hQmA3uboq2Sb4fjo8HSLPx/HQqM12v+TBlfRDau2kpDe
         +caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729451546; x=1730056346;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YTlFE9y0ioXpBTOeyys0wnNuvycwpmvcV0ld9ft1sg=;
        b=rpEw0pA0De0AWaiEYhvY9H/PMhzsRG5i8RIpBvqyopJx+KpnfmnYYg6wPEJlzkyDuM
         pt/IbummLuTZ9+cxrEXsCUdVv+tKi7UdSQFCliDRqFNONiiizuMdW2fwK1j7/HINb7At
         TnRiTtvGvv43pQhXUOORFGG1KjLIwys9oShrBp9CFQK/g+/x1pFLuBXyFC/q/TA6RW6Q
         zJuah1+4vO3ko5j20NKlk0hY2ZRARy6BeYHx0hm1t7YcdNspiCKv3wiQRqC5JXa2YU10
         4+IwkYMXn7JtN8Os6kUqkSBkoh8aaZTzk/Z0K2H8yhYEFTOItWBGsd8KnANyFc6iUxxr
         DgWw==
X-Forwarded-Encrypted: i=1; AJvYcCVf6WsmB4QtZTmD9l58iDBcYbEZQuTqyHPUMtJk4uxm4IZW5BKOEtWat85sjCkG2WV0/U3IEMzPFIir@vger.kernel.org, AJvYcCXr1JS2qrX8PWhydFX3YK80s7a/TN0Guey54ssPHHrcE+KoiXICKaUuUAgGBA6uTFwb4Qb2aPpIAppgo8tE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/v1rf1xKQgS9CfPqCdXsRLnPsbhpQgH0lcpLMybyAkET2QbyI
	hv6mJ4xOdt2moIHjoFLbczmixyPdUfAwKsW2Wrl8lqxLB1u5V35J
X-Google-Smtp-Source: AGHT+IHQI/nVv/AGRuFjGRqaU0I7eAI6IZqLNPv63crK6t7y5algYa2k8nMJ4UC2qvvVBhVBwcHypQ==
X-Received: by 2002:a05:600c:4e93:b0:431:5ecf:2a39 with SMTP id 5b1f17b1804b1-431616970cfmr56988475e9.35.1729451545912;
        Sun, 20 Oct 2024 12:12:25 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6b9f-98af-2a5c-6ed2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6b9f:98af:2a5c:6ed2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57b8e0sm31589775e9.12.2024.10.20.12.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:12:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: light: add support for veml3235
Date: Sun, 20 Oct 2024 21:12:15 +0200
Message-Id: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9WFWcC/0XMQQqDMBCF4avIrJsySdRqV71HcRF1ogNqSlJCi
 +TuTaXQ5f94fDsE8kwBrsUOniIHdlsOdSpgmM02keAxNyhUpUS8iEjropWuBBrdqLqitjcE+f7
 wZPl1UPcu98zh6fz7kKP8rj9E1n8kSoGib7G0DarRkL1Nq+HlPLgVupTSB6FIfCygAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729451544; l=2030;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=i8au2tTyl+TZJnNky4a259WdCcwNgPybYwXiwc0iy0w=;
 b=1MpQtsi3sZorBQ6PYaLZ3MfJnXFIyRiHsgCShnUKSC1tHVcL1yXpG8vNkCY0ZEB2HJkAxISz+
 ccLIy3+GyttCdh2YWe6No9qdDW2IhV91Rpzt0htCKHxRf+otvsTJdeg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds support for the Vishay veml3235 ambient light sensor
with I2C protocol interface.

I attempted to add support for this device in the existing veml6030
driver, as it shares some operating principles with the supported
devices. But given that the veml3235 has different register addresses,
bit arrangements, and limited functionality, it ended up making most of
the driver kind of device-agnostic.

Instead, the proposed driver is based on the recently updated veml6030
with multiple simplifications and a few clean ups (e.g. regfields,
right definition of shared-by-all info masks, which can't be modified
in veml6030 as it breaks the ABI).

On the other hand, the dt-bindings can be recycled as there is no real
reason to add new ones. From a dt-bindings point of view it resembles
the already supported veml7700. But if for whatever reason new bindings
would be preferred, I am willing to provide them in further versions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Rename SD/SD0 bits to include register name.
- Switch to dev_info() when checking ID.
- Simplify val/val2 handling in veml3235_set_gain().
- Move return -EINVAL to the default case in veml3235_read_avail().
- Link to v1: https://lore.kernel.org/r/20241016-veml3235-v1-0-b904f802daef@gmail.com

---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6030: add veml3235
      iio: light: add support for veml3235

 .../bindings/iio/light/vishay,veml6030.yaml        |   5 +-
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml3235.c                       | 540 +++++++++++++++++++++
 5 files changed, 562 insertions(+), 1 deletion(-)
---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241007-veml3235-0a38265e9bae

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


