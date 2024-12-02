Return-Path: <linux-iio+bounces-12959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA619E0C94
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC22B42431
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DB1DDC1C;
	Mon,  2 Dec 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbnSE288"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264FD1DDA2F;
	Mon,  2 Dec 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163561; cv=none; b=M55q1Jau87tNIejxPg/xnCNzMJdlTVinyKIRohyfgCebWTunwn+sz6wg0LfKt6iiAxsN0rsbpaZ5TDalaNsIOa0ta93YnYyPVarAoRhBaNlVEd3KNlD/LVmTFviGCcBMBHpNbBbwKK9Gse6fQ3LfsPYcjzXo0ZBRRoMEuF8JTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163561; c=relaxed/simple;
	bh=LrBoWxijJ1bBBEyhd5ZBFe5NE59y98eFG+bauKn86ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIXfjRNK398MEtLNCmpvL3cj02HiQKUH3diuokaHc+nKASrFDtGlhwpeRmW2q4vJQCdIineIMdmSXrDsZmTSSlnDb045iU5ns2D++aMLW9EYR9r4ZPugjOpvG4f22tWsCJqlBTAMQPhxia+CZe8wpPOu41zytk/KP2XRmrBlR1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbnSE288; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385eb7ee7e2so948301f8f.3;
        Mon, 02 Dec 2024 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733163558; x=1733768358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eS4xW5bYpSQfreZMUtLuqFHdZm+D+xD9TMB5vunZyGg=;
        b=VbnSE288zbQkvVFjWimhbCGuTyleijirwdTD8sFv4Io2Osqu68xJSu8UnDe+FRk5pm
         5VInLTrdftgqMC3p/iZBst5Oz4PBfPXfaWNV25XpVcB5hIxeIx3ad2GWqjyDa/QJLdHu
         coELpARLKZILbRNUyH6lWNmpRag3Z6V7iFdLdjYAgZWPj4MNVvTAdDL3dUoggAgZRc0A
         7vx3MIFBv5Ezrxo0FK9ZKLV3U0nQyjouhLFE+lI0ekJP1I8oEHXsLtTzh2YzWfRo1WLR
         EhFCaXgMWaQ+MWkw0vZW3Ew+zHvOR0mBss9qzYCvRas6ZHJGwmCQH6HWGCofOiwAfAli
         h9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733163558; x=1733768358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eS4xW5bYpSQfreZMUtLuqFHdZm+D+xD9TMB5vunZyGg=;
        b=ekRxZqbcVaclauWu9okgs/YtzIfUa2f08t/QYJaflia9hew62813fB7ISl9J0XaOZa
         cGpXrUwJG9itD/qzek5YF10pOW/vFaNxo0EHPcOTCPIHbWbcnMIPtQQDAWOU1gFu5mnB
         t8XyI3tqFu14vS2ohnnRT8+yQgb578c7MTAh/HgGEtk8tS2At675ipaEp+pa/C+Ba4WL
         qv40+HUPAtjXmpqXJd24XlXMltmfNaLkzq5nmjK11E/Xut/XWer2qxK+daKIbrI8C28i
         bA6x+UjQ3nxLsSwZOvghkCbfBY9iCdjWEqRw0HNmicNdLLaBOv6SbHskkspc009rJROC
         Dg7g==
X-Forwarded-Encrypted: i=1; AJvYcCU6NiTQznG68mwFxrl2xZ8nIgzIAYd9ksJYM0omoEviuHK3hiJnNyB0zE98hg8k5RE9rKSRu5KLRkfp@vger.kernel.org, AJvYcCWXqhTR01PYz0p389+k7ony0GWZzyLAB3cVmfYu7H5GSdkaCz0KnqW3LVLhEFpQHtpWcXYFOT85f8S9Wroo@vger.kernel.org, AJvYcCXQwFHs7S3DHlX9b8kGEAgQkgZmTCi1uiT0IeWbGWgy1EIihP4A6vXzf5XsjlW/l+0L+SCpOX62OvYu@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9iD96LJjMG/hYrYBz2A2J/D5CTRyTNhLcPFOKfFWtwVvmi8W
	LJR57MJQUgTbI54kuPEEF78mTZb2WoayFOwuEWGnl2L2EUFcLcnV
X-Gm-Gg: ASbGncvVO5Xx3RKQ9cliLzoDEjDjuoAbuFoVqjfTYdWU0d/7cUjAy6TeW3BueRqYaLh
	8JJJe6IiIiJ5T5wquESaZoSjGNyiEDhJci5sCsL5OW7b2wdFLg+U4mTlc/IVITHhci/oRttOaNw
	y61tc7gcTCb7csO3rkhzD4cc3Zq1P5Wmde4dv3lGP3e/lhPGtwvW6ph4C2yErouBDt7LX4ApYzc
	zhbanYvkU5pBMWFmzg0952wb+ksNoSgdx4GWz1hs+Jmx2D3yQ+9bJrDG891eKA=
X-Google-Smtp-Source: AGHT+IF73v4p+/LAaohAtnVHMGc9wjHGQfWa5Frpwp1w/97vS2OPCYBNoiBZhfuKnRgrICJKEUs33w==
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3abf with SMTP id ffacd0b85a97d-385f1ac3c5fmr4866855f8f.23.1733163558116;
        Mon, 02 Dec 2024 10:19:18 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385d7d4d9b0sm11659108f8f.65.2024.12.02.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:19:17 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: ajarizzo@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v2 0/3] iio: pressure: bmp280: Minor cleanup
Date: Mon,  2 Dec 2024 19:19:04 +0100
Message-ID: <20241202181907.21471-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

Patch 1/3:
	- Switch if case for better readability

Patch 2/3:
	- Reword commit message

---
v1: https://lore.kernel.org/linux-iio/20241128232450.313862-1-vassilisamir@gmail.com/

This series adds the SPI interface description on the device-tree file
of the sensor, adds proper self-described sized variables and performs
a minor optimization in time variable names.

Vasileios Amoiridis (3):
  dt-bindings: iio: pressure: bmp085: Add SPI interface
  iio: pressure: bmp280: Use sizeof() for denominator
  iio: pressure: bmp280: Make time vars intuitive and move to fsleep

 .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++
 drivers/iio/pressure/bmp280-core.c            | 39 ++++++++++---------
 drivers/iio/pressure/bmp280.h                 |  8 ++--
 3 files changed, 56 insertions(+), 23 deletions(-)


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.43.0


