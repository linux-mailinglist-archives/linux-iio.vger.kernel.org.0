Return-Path: <linux-iio+bounces-11830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4C9BA03D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A53E1F21616
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D618A6C2;
	Sat,  2 Nov 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoFHyrPV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0199EAC6;
	Sat,  2 Nov 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553208; cv=none; b=L+ptELXZ58/Lj0M2DpV2+37h/Qb8mINej7HTQyog2IodpF0xMbl7p3wmCvHTjkAJlHmKEbRe9NudkvSEnX/buo8LisdsUoDP/9TWt22y8IA336UH8UDTkg4xJcPiVx9lB8rL++N7eQs5UfeSh5MFvdnd/hMYQ6NAg34wKiNoLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553208; c=relaxed/simple;
	bh=S16CU1D0YIcAF9GTokw/Hnx0GbZHxQxdi4GH6n4T+M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0+v29I+/COLG+dJckzLj3gpICLKemtF+rDG955tK/Aux9GHit6NEk18PxujzqVz79unYYw2Kro/w0DaNrL29ApCtl5oBzG9X2HqxGVCpCoG4TxHGaOQnipHH4MEv8VMMKYkVjGyf7dtaFu8Ok7btaOAvgH2P0ovpxvMR6Szm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoFHyrPV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1834300f8f.0;
        Sat, 02 Nov 2024 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553205; x=1731158005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBRrJwPk1oG1SlGfUn+HZNQhT1F+nrA4IfBNE/rOFJ0=;
        b=NoFHyrPVaRMU0misoN3NdjtLstxGdeMcjtYTepIQeWn5lsxsuKtjo+SCEuXnYjTPGs
         xbN7c4DOGm8jUotbraS8vm3xxGrEuZAKl/X/Wr0uOO0E1P1oNFQPtCLdHcdD8ZgQ4enD
         nFw45XCIDl/H1wJchsqjQlo1ZZKpBeV2rXwtEU9WTLKF7AU+C+TU7lXfFIPXKCoANOIF
         KqJBMSeL+9sUIvoxRW8ba96P97F0Olxb25HDvApQ8vWMe3WaFzzgIzjC/v3xnxNa4MO7
         4Lv87GqcPKFNJGdvZdpDUaI+wjjQ50oq0+8M18Jd/o8uQXHlGu4Q1n7OCPzXLestnnPE
         3rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553205; x=1731158005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBRrJwPk1oG1SlGfUn+HZNQhT1F+nrA4IfBNE/rOFJ0=;
        b=TRhXZIht5M3kvr6Z3r/WgioWERhHz4dzqjEcDLckCbJSKCtodJeZEFmemS+UwlO5bb
         wbI7+W355DLx77o/QlV7GajBepgEUHvCAGNU9LPLXI0r1kvrz5seGTek24xCdxNkN7yY
         7vPo0Txp6hpPKY4jc8B4MJH4rkOFO8MO+nV8x6tEK1gKbaD33fAAn9Iiprkawl6cXI98
         MeXh0EvQ+hz79VVoeswwoRys8CnOlTh3jniqyjCzfvvkxRKkzMRK6zXjxs/k26NeIhBl
         QuDRwu5HLosG+mYh2/l8ODHC9ib2FbivxI6PiSBqtUWkDngUF1pmhkHAocoyy6+NLT8b
         Gvew==
X-Forwarded-Encrypted: i=1; AJvYcCUDqOopWS6kLujaz1iz1qeaB/5FWrpAJcxib9UeCntBC5AJxOSBHixUWU9AxRTw8JjkItRlgcq5I4kU@vger.kernel.org, AJvYcCWAkC9U44pBMIBMdsrw3KDRTbAWgPsggzyWAugSgSsu7mrN/X0NuiEgd4BhVLmpFthHQ71tg9IdekIr@vger.kernel.org, AJvYcCXX09B1luMdi6jVeho6yqwmaBFmEqG78aFPuKs+mglh+XcaRPwB/9o/gh+jdbS3tkncwWyN+obTutA3gxcg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OxQPEDz6y/g1ZjDWJ+b+EphIQIKUbW6+mc5JnmeaU+ewAYu8
	wMmjX4FRetCimEizRuROjYVN8qus4vEvGwDpz13h141PhujEHHkq
X-Google-Smtp-Source: AGHT+IFFUbfdRzfCPmwl2sVXz12G0TPe0ppOo64+yIkeRG73N35+Xi9IlxhZ5ejU6v6yxjbI00Junw==
X-Received: by 2002:a5d:5224:0:b0:37d:53dd:4dec with SMTP id ffacd0b85a97d-38061137a3emr17884676f8f.15.1730553204777;
        Sat, 02 Nov 2024 06:13:24 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7]: iio: chemical: bme680: 2nd round of cleanup
Date: Sat,  2 Nov 2024 14:13:04 +0100
Message-ID: <20241102131311.36210-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:

Removed applied patches 1,2,3,5,6,7,8

[PATCH v3 1/7]:
	- v2 4/13
	- Set mode of sensor with enum variable and remove macros

[PATCH v3 5/7]:
	- v2 11/13
	- removed regulators from being required, adjusted commit
	  message

[PATCH v3 7/7]:
	- v2 13/13
	- removed unecessary usage of runtime PM functions

---
v2: https://lore.kernel.org/linux-iio/20241021195316.58911-1-vassilisamir@gmail.com/
Changes in v2:

Generally, the patches were rearranged according to comments from Andy
in previous version in order to be more consistent. The refactoring of
the ambient temperature was dropped for now because it was a bit more
complicated than I thought and this series is already heavy enough.

[PATCH v2 01/13]:
	- New patch

[PATCH v2 02/13]:
	- v1 1/13
	- used "optimized" in commit message to not prompt for a fix.
	- added documentation of where this sleep comes from

[PATCH v2 03/13]:
	- v1 2/13
	- Fix indentation of array and removed extra whitespace.

[PATCH v2 04/13]:
	- v1 5/13
	- removed extra check inside the set_mode() function.

[PATCH v2 06/13]:
	- v1 1/13
	- removed indentation fixes which are fixed later since code is
	  changed in those lines in later commits.

[PATCH v2 09/13]:
	- v1 12/13
	- removed unnecessary debug messages
	- Used struture instead of buffer to push data to userspace

[PATCH v2 10/13]:
	- v1 13/13
	- used better naming
	- made channel index to -1

[PATCH v2 11/13]:
	- v1 06/13
	- removed device from trivial-devices

[PATCH v2 12/13]:
	- v1 07/13
	- use devm_regulator_bulk_get_enable()

[PATCH v2 13/13]:
	- v1 08/13
	- removed internal usage of dev structure
	- added missing header in both bme680_core.c and bme680.h
	- used devm_pm_runtime_enable

---
v1: https://lore.kernel.org/linux-iio/20241010210030.33309-1-vassilisamir@gmail.com

This patch series is continuing the work that started on [1] by
improving some small issues of the driver in the commits 1,2,3.

Commits 4,5 are refactorizing existing code.

Commits 6,7,8 are adding DT, regulator and PM support.

Commit 9 is refactorizing one macro to attribute.

Commit 10,11,12 are refactorizing the read/compensate functions
to become generic and add triggered buffer support.

Finally, commit 13 adds support for an *output* channel of type
IIO_CURRENT in order to preheat the plate that is used to measure the
quality of the air.

This and the previous series [1] started with the idea to add support
for the new bme688 device but due to the structure of the driver I
decided that it is better to restructure and improve some things before
adding extra funcitonalities.

[1]: https://lore.kernel.org/linux-iio/20240609233826.330516-1-vassilisamir@gmail.com

Vasileios Amoiridis (7):
  iio: chemical: bme680: refactorize set_mode() mode
  iio: chemical: bme680: Add SCALE and RAW channels
  iio: chemical: bme680: Add triggered buffer support
  iio: chemical: bme680: Add support for preheat current
  dt-bindings: iio: bosch,bme680: Add supply properties
  iio: chemical: bme680: add regulators
  iio: chemical: bme680: add power management

 .../bindings/iio/chemical/bosch,bme680.yaml   |  62 +++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/chemical/Kconfig                  |   2 +
 drivers/iio/chemical/bme680.h                 |   8 +-
 drivers/iio/chemical/bme680_core.c            | 375 ++++++++++++++++--
 drivers/iio/chemical/bme680_i2c.c             |   1 +
 drivers/iio/chemical/bme680_spi.c             |   1 +
 7 files changed, 423 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml


base-commit: c218214db564ca7d6885fa5859541a86197856c0
-- 
2.43.0


