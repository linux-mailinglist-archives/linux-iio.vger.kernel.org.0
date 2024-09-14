Return-Path: <linux-iio+bounces-9528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664DC978C1F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 02:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2C6284D7C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564B1FB4;
	Sat, 14 Sep 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a//oSMpX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5C23AD;
	Sat, 14 Sep 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726273748; cv=none; b=Ti7AdC5qVJS8u/OjC1qy4e2JG1qyac4ScvuHsiJErBikuHbX6HM1NA+fw7KxlKJPWTZTHYcR8vhb+XINeopWJthpVD51gea+WcNEqrI9Bf456xll22i/Z3nj9gETDC2bON0rOG2KnP6PnlPI6oNxCAlTTgHxfdX3L2oLjv2kuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726273748; c=relaxed/simple;
	bh=tAqlyK2vfqcDZjFC56vZdZtCXGSnFLuxJO4smkEQQwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IDvroO5Am2GB+ILAa9qUdmkv44k4rYfOEOcXMzIZmxPpp7tf8OADwDl8/yxG+LtVFzbs9yhRJDKJvsF+GUGaNuh71adctrORw2rMwRUVZfK41bWKgTGsGHbpg5YjMRCNvR3s4zel+4Va8ZSfiPb4gMTalZNU7jpDLddJgsdYYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a//oSMpX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d4093722bso356793766b.0;
        Fri, 13 Sep 2024 17:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726273745; x=1726878545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5uhsut5itNMeHypTSh6e89lNKhazYzcG5L09IqE3Co=;
        b=a//oSMpXqt3dB9ZKSiRH4+q0EPeHFfS3lHYXpLR68/7CwdtOZqtcWx7G/Q2URv7mBO
         y2xKbZhc6PSb96GMs91787A8reWPFy6r0QTwu5uYu7IBUmDgIB1SOH4m6AySQDduEbRE
         qZyM1IzBqdxF653Etmr3SqcY5kf4fLI3lsk2U5XOxsYIjy/LrwkL3EXQnC0JXY/FaUeR
         CkDu5yzCCfRNhNhucdesH5iS56UFUTml78vc2PXLZ3RcEPBn0U4yyC2NHt+WXE7rMTJQ
         UKUhaLtBKGTdyyASVkRyVeLmhPpr6GygVYUkrz5RIS0vQFWa1Yia2sFwOjDFM1Xgkqjy
         fcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726273745; x=1726878545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5uhsut5itNMeHypTSh6e89lNKhazYzcG5L09IqE3Co=;
        b=gCXY/ooJsjSy7ge7C2oh2c8z3v0JBUAdfu+9rzgwJ2IEyoJeJyGCh3hpsEdgOte/pR
         ZMwnvBlhmLIeAN8QzO12OLUTxH95wIro4hDMnCdDpdjsMDuxPlB7z7DJxcUiP/sRmk3d
         OfCRA6v6/AXx7Ek81RWwl0C+DbMjJr0Tn/zGPEgUTY/9FR1Um8a42Npxl5JTU+1iMlNZ
         0Yzo7erxMNUDdC9SPbKUgwq3Tk9sv1QZhC2yHcezAIn/PCo+GfgyMwxqUYBis84c123d
         8Ei2leAN2Y8ApLjNre8W+tioW9HylUmfaowWufnsvegFrud/zgVZHttwRpwyudC0HmoY
         SkUg==
X-Forwarded-Encrypted: i=1; AJvYcCUZzvjGM0LQ5xQPCwB3oMrM5y0LjhKy5tIXhpid9Vy+EeqRNxsxE0RA8J9i13B+JXsbG+9ripXiZ/pc@vger.kernel.org, AJvYcCVHH3dUTg5Y28KfgiDLZqqxV9rhxHGKIh4wh8t24mdxwCJwCNm7TKtFeNmLx91S8N6swgfTUew1cJx1@vger.kernel.org, AJvYcCWKwjd/0KjcQbeDNnQzKc8y5i7q1GYTVfsYgn2WZW+dO1BaIpKBatikh2oF+HtMtaWNWX5ahnBrVXnPqlB0@vger.kernel.org
X-Gm-Message-State: AOJu0YywnTehQm5O0GoLHnzfKyTvAAYDjdpkgL1pyon7rLPdzqTzuF8l
	XrqlnFh1sBJu4xMsUIsCZnAONqzkmtSNpBRuXvXFIANHVjE0px5p
X-Google-Smtp-Source: AGHT+IH7gGoQgj4HxaeIRCdJCT7NkPQkdkZj2vWGXrHwbwM9Og/GNhGZlaN2i53X+30se5+licOWpw==
X-Received: by 2002:a17:907:3e94:b0:a86:a866:9e26 with SMTP id a640c23a62f3a-a90293b16e3mr862751766b.3.1726273744238;
        Fri, 13 Sep 2024 17:29:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43f4sm15157666b.80.2024.09.13.17.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:29:03 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v7 0/4] pressure: bmp280: Minor cleanup and interrupt support
Date: Sat, 14 Sep 2024 02:28:56 +0200
Message-Id: <20240914002900.45158-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Changes in v7:

[PATCH 1/4]:
	- Use 5ms instead of 5000us in comment
	- Use USEC_PER_MSEC
	- Move parenthesis to make checkpatch.pl --strict happy

[PATCH 2/4]:
	- Remove interrupt description since enforcement was added.

Added also review tags for patches 1,3 and ack tag for patch 2.

---
v6: https://lore.kernel.org/linux-iio/20240912233234.45519-1-vassilisamir@gmail.com
v5: https://lore.kernel.org/linux-iio/20240902184222.24874-1-vassilisamir@gmail.com
v4: https://lore.kernel.org/linux-iio/20240828205128.92145-1-vassilisamir@gmail.com
v3: https://lore.kernel.org/linux-iio/20240823181714.64545-1-vassilisamir@gmail.com
v2: https://lore.kernel.org/linux-iio/20240725231039.614536-1-vassilisamir@gmail.com
v1: https://lore.kernel.org/linux-iio/20240711211558.106327-1-vassilisamir@gmail.com

Vasileios Amoiridis (4):
  iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
  dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and
    BMP5xx devices
  iio: pressure: bmp280: Add data ready trigger support
  iio: pressure: bmp280: Move bmp085 interrupt to new configuration

 .../bindings/iio/pressure/bmp085.yaml         |  22 +-
 drivers/iio/pressure/bmp280-core.c            | 580 ++++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  43 ++
 5 files changed, 612 insertions(+), 41 deletions(-)


base-commit: fec496684388685647652ab4213454fbabdab099
prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
-- 
2.25.1


