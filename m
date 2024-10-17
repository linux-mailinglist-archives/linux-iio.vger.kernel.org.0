Return-Path: <linux-iio+bounces-10699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF7D9A315F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39B21F21BE5
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD7F200CAB;
	Thu, 17 Oct 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCqcteMq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D0200C99;
	Thu, 17 Oct 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207831; cv=none; b=s6iFzviHxso+Xt/w77Jj7DUwIW5O5J0n5L9COSdY48eHvKTa6oQUocBr+x8mrfkJR64Hc75Nhbim0hxlXvS6AUL7lufHUg2tiAYR6gHhjrkgZQn6RcrQwwmowIBcL9n6FSb4FzgF6ax2+virO3dMt4ck9NUlV9V9PGMO2Ib5AUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207831; c=relaxed/simple;
	bh=wbS2QSzGrLusTV40IRem7JWCd9ti9n1b1HtVLNpgbcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3lvyPY7ApDdqWY07ZHecFeLZ2LxY/EWAiGQUXqZTe+k/Yy9gosqy5eUgRy8dQlT4Vs3c6T+T48w7YWNpgaPFwn+fYRSI2hVSni3keheEM1kbnTsFjXiH7AaheJgHPj0PykMXf63OjA5w00afBSMu6GkCjMLdmUIOlHTosaxbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCqcteMq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d50fad249so1051353f8f.1;
        Thu, 17 Oct 2024 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729207828; x=1729812628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oImBXYrGL+AId7ckxyLrsdII2x5sH+lo+UZehY8S6+w=;
        b=dCqcteMqNlUWU/ofmTGOcEQuw8rdoVV0xhC1rnRU1PcO6Cof53sq7Mfs1tDok8OTQi
         pay5u0hz2k3idbkEg6WnUine5pWnucVI3QlWD2Ulrt0NQ8Qma5Ta78+875Cch7yBNjJS
         ULer2gYCnvsPDm9DuDjwtacewRP6BZPj2czFfX44fKdJN1LgA+n049gPFLaLH/cqncIJ
         WOfg2GW+A9G5pt7RbcPUUaBa8wrfpX8YjzG21fK1sRQL3mh7ii6tCljQnN3g0uU+x9vh
         j743P0fZ2PJgr2Ia6GQ0gvs6Z52cf25uNtxHV1e9VbuJtux5d7EYS40k8ZcNYlocziU8
         sniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207828; x=1729812628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oImBXYrGL+AId7ckxyLrsdII2x5sH+lo+UZehY8S6+w=;
        b=VOWFEzT5DPiQECFPeIFnN1PfDzo2EOrrwwJKsSMuIv8Ua1y0iQTA9/Vx/WKnqfliS5
         FcRhGVaCnRSVx1CgZyemZs2WVQAFJyyosM6jBct6V9a25AmiY9zDvfzT8BoBaJE2MqS/
         wCb+K2Nda2PUuA1RqPKq9qwEUhBvm2NlCCs39dlQoVMP9ZsgzyKZZoDIvhh+kakXFkVQ
         aDx4YSXE4gm+zMaOCgIwGm8TV9ojF5OG4tPDbHdzFP7cVDQXgQNOj9cV3o9IIka/mOfP
         +Sg7n1E4GhfXrLFYZbUNVilPxsvDBWwcWvv/cYW3d5HkJpYw5r1OwB9ZIvkc54or2tL7
         OCgA==
X-Forwarded-Encrypted: i=1; AJvYcCWE3LkpwQUFkf5NMnOvDKH8uu6Wf/KF0Tw+OYvlAUKsSuSNW/8AtFdIzaibcQrsx56uOyeVuP0L4DpG@vger.kernel.org, AJvYcCWzh8f/byw7AZGF+bKx/7w78m4TqBHrLL4Ly3a/fx5oTssMnuDnbtb7tA9XIzwIha0PqzCBIN5nXwne@vger.kernel.org, AJvYcCXbQJbDqE3qw8XcfJ7eA1Wi2deLDyRHV8tn7ISSqEIi8HPZVx98Vf8KHsq2BqEarWYsHOhKyHUoHYyiOAcn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw898BBwx/b+U9YVpB1AgTzMEi8bRulwn/53NspKGl8TyiXaFkC
	89JV9bwvCeYM5mYUNWXA1ZX//X59ARUho/p2MPr94/1MrPj7hR1kAJ6twFCP
X-Google-Smtp-Source: AGHT+IHGgZsq7+suJd7ZG5KvzAdQlkRdO8iyOPMunLlciYfXOtL64kR/O6M//R8K7R4VDTxMMwDotw==
X-Received: by 2002:adf:e948:0:b0:37d:4846:42c3 with SMTP id ffacd0b85a97d-37eab6e36f4mr323628f8f.22.1729207827661;
        Thu, 17 Oct 2024 16:30:27 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:8661:df0e:b445:43ef])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ecf06d3casm306939f8f.48.2024.10.17.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 16:30:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	ajarizzo@gmail.com,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/4] pressure: bmp280: Minor cleanup and interrupt support
Date: Fri, 18 Oct 2024 01:30:18 +0200
Message-ID: <20241017233022.238250-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v9:

PATCH 1/4:
	- fixed warning of uninitialized variable that was generated by
	  the kernel test robot in v8.

PATCH 4/4:
	- Remove extra lock and unneeded reenable function since the irq is
	  being reset on the first read in the irq handler.

---
v8: https://lore.kernel.org/linux-iio/20241007194945.66192-1-vassilisamir@gmail.com
v7: https://lore.kernel.org/linux-iio/20240914002900.45158-1-vassilisamir@gmail.com
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
 drivers/iio/pressure/bmp280-core.c            | 536 ++++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c             |   4 +-
 drivers/iio/pressure/bmp280-spi.c             |   4 +-
 drivers/iio/pressure/bmp280.h                 |  43 ++
 5 files changed, 568 insertions(+), 41 deletions(-)

-- 
2.43.0


