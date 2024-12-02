Return-Path: <linux-iio+bounces-12968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A739E0BF7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21370282C49
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6D01DE4D8;
	Mon,  2 Dec 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsJhKomj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E61DE3BF;
	Mon,  2 Dec 2024 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167427; cv=none; b=dboRTdo+7iTyoP+/97wEQmvJjlPkPeiHfgWdqpFYIDJxXBbMcAafu6llgHb36QMWKDcNNIign1+KQ61FUoWws7bDUdJVMRubvEFbeQ3HEgH+udADnwVIKoMRYmYdymwLolHKPGXyON/DLYGrrXhEGydBc784uxcSE3OgxImwDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167427; c=relaxed/simple;
	bh=4Oa4VegWAegyaTKr1OmCwheDlziE8RsG2Fn2v1W8GQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WISFganB+4XSUxcOscT+lNhD6cr0DCDQ5OiF55R3wQHxJPRUm+0Iagw2obCUgesQ8VlX0S0Rjl+o8nfFyBAplFwWFWw1jzGFxd0QULgffFICqL7u1hqHX2OeelexrLIkEHy3s7++mXhmWh4+LO4jJqbF6GmO+kfmD48EEVEMuOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsJhKomj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a83c6b01so40753165e9.0;
        Mon, 02 Dec 2024 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167424; x=1733772224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2xlagNSs/n68wjChaazhkpy5KeZi0HFp84+ebzxe0A=;
        b=gsJhKomj+ap4JHaBw9aky2rkkHQ1GKbRg5FwzfrN+6O6IbI0lLhJpS4tRBAxmT6nB0
         TLKyIdqH+0ZobeLyRnKXrKK02rd7Amw+0iHMu9TRx2Liq68wMbs1EQPxzyaXLwqkyDhX
         EHOIcnUThz/wxG1W1Umy0RLF/LltlA+2AtmaFychP2WB2l8xcnPiibt0vkTVQIFAVqsk
         SMdQyL9GSLZVVSSBt1DSdKpPzwGvyu9GJJt4MFi5DiLgQFw3t1cvwEUiQHKdCys1ohyB
         j536N9OLGDChhpfBwtxuYYtZY6YsBdqYdJ6YdWvxk1Y14M+HvbpuTUaE7CvSvSyWIPGM
         VTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167424; x=1733772224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2xlagNSs/n68wjChaazhkpy5KeZi0HFp84+ebzxe0A=;
        b=J1X60iF85dKavBWE5V/dMiVGr7kzRwFEfae/qwp+Z1mI9Y/lpwKUN9ExekCzJUjhgT
         iD88aJCOBEI4YjMUK09OQlI/NyPssa79sbFicZzq0NmeXZJzQQlcxnqm6/z6a9wTa0eO
         oEdZGI2GJaxTbLpXQ7dowR1jJjj6zDO2TaEhI3bVBgRJBxwflu83eLdqfGmyWAwV7XwC
         gTyafIwHS1db1259+bZ5mxW56LR7bMlzhhyEAUm0nfLzyXSm7DyqhfnKG2pOxPD6LLXt
         AE+hII7p4rWcKQfZToxblQGF3PrTL4lC9GSJj+M3HqwYXrn/ARBIxyxDPKBwBwmtjIkY
         CvMw==
X-Forwarded-Encrypted: i=1; AJvYcCVC5bZuWr9q10dxv43Bh+BCFhJP3nAVZflNWl9UPfJASZ015k0u2spdTorOcKnbSpEpu248t8BKu24z@vger.kernel.org, AJvYcCW6SggawIe9i59hrW8VwceFXwRe/I6CaLpvZDV2dgTD+eEH0E/AJriRnBnKCW6uoR54hu2jYIM0+574K7hF@vger.kernel.org, AJvYcCXL1LtZq7EJq/ib9a8X/P4ynhNPZj9LKPHpvGAK4GiGs8+4R6eDkyKzwOvGJWX6rsoW+NMFdFGxMDZg@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwvp4jQjyIfqkqfBhdBlo5D4IE1DfrUGHh4ZDR/aY52rL7zMl
	ryGYRZK52L7+gYj1iL0X57vfsqvCUwbuBAGrPmlOWRRQf+JmIanlytParLaJ
X-Gm-Gg: ASbGncvX2XDCP0Ru6fqzQPQfmRXUmFgf/4obythbJp5TV0uf3dg/ibURdti0BwgTdGE
	5eSZcbfRNk3xUNxY7Nt5pHjYHmS7Y3tFGNFzIhpLfMi84fJOssDkl8bcYo7hNs+xMlhZgXPdZMR
	SrPqrSLTQr3g5kfN99H3SDkHPxmW9W4cGeSumEb0l9/pt4vyR5tMpBD2fCA6K0NVnVJQctdiYL9
	S32MeDkIq8rJIbaV1J9tjeEHLLZt4Itpm8fRxOM6sMjDDl0SqkuOQqNEf36lCA=
X-Google-Smtp-Source: AGHT+IGBVdsLfOi1dW35VMunQiekF7LRMOLyuLk+WDGtBa7P4UJpuKtREyeGcNvCDp+YzUFUD6VHEg==
X-Received: by 2002:a5d:5e8a:0:b0:385:e22e:288f with SMTP id ffacd0b85a97d-385e22e2925mr10589587f8f.31.1733167423779;
        Mon, 02 Dec 2024 11:23:43 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm832609f8f.20.2024.12.02.11.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:23:43 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] iio: chemical bme680: 2nd round of cleanup
Date: Mon,  2 Dec 2024 20:23:38 +0100
Message-ID: <20241202192341.33187-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:

[PATCH v5 1/3]:
	- Changed name of sensor to "co2-sensor" as it is already used
	  by other chemical sensors.
	- Added reviewer tag.

[PATCH v5 2/3]:
	- Removed unnecessary macro
	- Added reviewer tag

[PATCH v5 3/3]:
	- Replaced pm_runtime_get_sync() with
	  pm_runtime_resume_and_get()

---
v4: https://lore.kernel.org/linux-iio/20241128193246.24572-1-vassilisamir@gmail.com/
Changes in v4:

[PATCH v4 1/3]:
	- Changed description to include the move out of trivial
	  devices.

---
v3: https://lore.kernel.org/linux-iio/20241102131311.36210-1-vassilisamir@gmail.com/
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

Vasileios Amoiridis (3):

Vasileios Amoiridis (3):
  dt-bindings: iio: bosch,bme680: Move from trivial-devices and add
    supplies
  iio: chemical: bme680: add regulators
  iio: chemical: bme680: add power management

 .../bindings/iio/chemical/bosch,bme680.yaml   |  62 +++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/chemical/bme680.h                 |   2 +
 drivers/iio/chemical/bme680_core.c            | 125 +++++++++++++++++-
 drivers/iio/chemical/bme680_i2c.c             |   1 +
 drivers/iio/chemical/bme680_spi.c             |   1 +
 6 files changed, 184 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.43.0


