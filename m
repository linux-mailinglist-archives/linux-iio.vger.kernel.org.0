Return-Path: <linux-iio+bounces-12790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39669DBC7F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D53516462F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4A1C1F15;
	Thu, 28 Nov 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al3W15UQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1405AD4B;
	Thu, 28 Nov 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822374; cv=none; b=TATUHUNNBs5kF6nBV1DEsSWCE3/GktFlqa49dfqYMR0e9DYJ1x39WoGj9Xvx/Jb1v36v9NEqnLXXcdMp0bkXTsLBI6qTSDB54vyYg5Q+czuwmi2TGv2yxyXchA3PCjMNP8zj602ol1u5uYLu5hLRQ9AMviqzHN5gSTI5urTPPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822374; c=relaxed/simple;
	bh=r3/j2p657hi/STl1rDuuDNNqSCQQyvW/yEJ34GyKdwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hErMQ+aChTB21MvK87C0fTtkXB43A8VITPxWkOKE0LwlIc0HUFbIXUFEfo2vvtzNv1ay4Bq2P2pLn8XhUikNZ/9tMAR3zpSK26E9l1cRspDTD9ETqhQ+O+KHhkndWzKxOLgYe0CNnPFL5DNoSH4iKIcKWoo+8/Gob/JISAgGBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al3W15UQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38248b810ffso918195f8f.0;
        Thu, 28 Nov 2024 11:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822371; x=1733427171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MM3cPgigB7/ZIHb7sDZRIP3WiRholKgCPOgojtdr81k=;
        b=al3W15UQaJEyUKiJgFaIe5MX0Ec9VQy3dPeBaBORWuKmat1KFOgacm1No+UkRj8fo3
         b4dQxm8W3mDxqIG7kdpvcpKTzBKMNRvFYOtXJeQ37qMMkinxPomWWr7+XBjm8t4SiOr+
         jSvg3kwRuAzYavbKp3vv6rIm/azUfnBv0Fj7LmPRz5Yl7iRHKPed3YhZqO7eg8SinlCQ
         i5LnnIObmdp2c6aacmLR5XenH3OfaYe08QYnzP2ea4YUvQUtKaGSKATtNvwFr/474wel
         Nx3nkZZQy41HnSo2RpNuO3gS5W89MShtH9K9zsVTM1fNeVVs0vUA0K9OnKoPXFzfsuRP
         Bh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822371; x=1733427171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MM3cPgigB7/ZIHb7sDZRIP3WiRholKgCPOgojtdr81k=;
        b=UmT2Eg+ztHquv5EjcnXRZZQRNVIYykgKPlTFc1VrYuqUxo9roGVfMmDcmW1BqQpkZd
         O/T/AdoN0wKSjgn8cuBe4OwU1dBuIu0deGvrhazYyPZ+yoRkUI5443W3DpWTLHhCUO5D
         Sp+JcZFGc77g0pHyeO3MVM2dXDmG0yqbmRhUzAI4ElP6JIbaiV6JMMgdSZfuuQpacycu
         5CW4jK/VxCT6aD2jDfzjtnpqGKF/FD8dHDXEw1NgIi0/e7KloJdreDfrvr5r/i+KDghY
         sAIdqC4QV2Yfe62t+afGtjj6KLYRdGy/vykicOO3H1dZHDnRwPvGQ7DGhhgNPnzJQB8J
         En4w==
X-Forwarded-Encrypted: i=1; AJvYcCUEPG3A48EXfkEnTBRfHcu/1oIkvT/OznJHFf2Apm5uec5ksNbdjD3dnUcATF4/NDX9jmUqW7l1+ORd@vger.kernel.org, AJvYcCW+E0M/29SWocWR6Lj7MZ6PkWlj2z/uh6c0WTUA2i3bWgDDQ5f1ePbY5d71X1FYwUcio5JGBurEhEqU@vger.kernel.org, AJvYcCWGWkhdgepBtA/U7L6Zl8NhjQANhkMOOBmoY8LWteomfYka5eMu0i3vi0Q+DHdn5hEIlWxYeT/MnaknhkAU@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmSUp+Kd/d2PJYu95vuGUBElcLArbBiJXNivW9s8CrZRK+fPo
	yNU84Lbv4BAZ33pKme2qQEe8Gpc5H4yRalQYbzkK4795L7IT+PX/pP1YD6BA
X-Gm-Gg: ASbGnctyHteXycEfxvJA3w9PvYOSDpbRdn98qFATCbwv25QZc34ymlCBTSuy5ZhYSnl
	7ZrDIMugwOuGkMmdh+a+ip2KHNlnAXWWMp8zY1k8kft/p31g+Ts1vj8nBrugnDh2napfefapDkz
	wsQRfW4lZQ80aRG5rwRj73aWm4KXju0hc0CB4URb5wQhl34gi34AzYDGjd5X2+oH1gffhrsuYiw
	ynF4NKdmCcmD2TIJKmtI9OFXf0pbUaUa7NzMwZfv1Pn4lYt9XrUQrTR579V57g=
X-Google-Smtp-Source: AGHT+IHxR6EGzlWcELXhpkhHSxIj4C5OwW4QUHev8N4rIisy8ng/MLP2oihCOtpve+kdLsFvl27VAQ==
X-Received: by 2002:a05:6000:1866:b0:382:4421:8123 with SMTP id ffacd0b85a97d-385c70e1b13mr8197154f8f.59.1732822371018;
        Thu, 28 Nov 2024 11:32:51 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe40csm30557855e9.10.2024.11.28.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:32:50 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iio: chemical bme680: 2nd round of cleanup
Date: Thu, 28 Nov 2024 20:32:43 +0100
Message-ID: <20241128193246.24572-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  dt-bindings: iio: bosch,bme680: Move from trivial-devices and add
    supplies
  iio: chemical: bme680: add regulators
  iio: chemical: bme680: add power management

 .../bindings/iio/chemical/bosch,bme680.yaml   |  62 ++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/chemical/bme680.h                 |   2 +
 drivers/iio/chemical/bme680_core.c            | 117 ++++++++++++++++--
 drivers/iio/chemical/bme680_i2c.c             |   1 +
 drivers/iio/chemical/bme680_spi.c             |   1 +
 6 files changed, 176 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.43.0


