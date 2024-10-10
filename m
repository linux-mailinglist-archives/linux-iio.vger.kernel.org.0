Return-Path: <linux-iio+bounces-10416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621D99940F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6C91F25171
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9303F1E2830;
	Thu, 10 Oct 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j13sf6yM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061718DF9E;
	Thu, 10 Oct 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594043; cv=none; b=CrZbY+AK6853wnfvNbajg7x9awEVlwzui+atzPrjxkHQVqlNSY/8E0PEjEvYSClbDSDuucn6vkIurQshG5bWU8iwxgWnvgv0dFxF6N7iTauWmnNnqSpAXEgEo8t2vwNxb/YBO0csf70s3N67w1rDrcB8xIuAApFbfTst/a86Sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594043; c=relaxed/simple;
	bh=7bAsfej3F3UOQITbTD5i+PrHVQoQ/kGGgYNcoLQiNcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2kReUAz7XR3LePgw/Oqxx0NnvgX5IZK4N51J6YQsP1t9sCvWqGiplpH8Xy71/HBQmWWWu3VRMLIbwPjhA/cu3BSVoVo682x3gvOv+db5mQ4fusG9LOGglU8Dqjt6iATJHTTbkFdJG4yNQL2Ndz4PXBJrMlpy9ywSLqxMStUnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j13sf6yM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a995f56ea2dso218353066b.1;
        Thu, 10 Oct 2024 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594040; x=1729198840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMaWiHE3pYIgk6DYKKitsC7ifQt/kUwZ8x7Uml2F/R0=;
        b=j13sf6yMCjExi5CQPAvm8UrO9if2Xuog9a68WdR26UJN/nGSf1lF660atdZPhJrPLu
         XlGpPlJZoBxSDe56CuKmEKnP2Dh3eb5dCmU4dt40FWXXX3rJrDWvlQVv1McDAzJjbkna
         r+3c2PJ0Ll3IAPy1YLBe37P5BeVyD1tCJCgMWAPnjkGTn2VI0ZtKgX2rGgg/uObpQrRp
         X8seCbOLKd/8vd+6wbWNVrjUoRS1TWbTH+N8i05xAELW3j3sYQdQgWPmsEp2WbGZE0nj
         ekJxOOvMs1rx+94rdC4WYARcXUj9lg/H4q4TZ8U7f9TWXWFn3eu1lR5HUg8mOkpxk3QD
         NDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594040; x=1729198840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMaWiHE3pYIgk6DYKKitsC7ifQt/kUwZ8x7Uml2F/R0=;
        b=PkiWKg5LhxUhYUER9R1u558S386n0qXB3hNdb7WpPfqVk6A5lIAQzJ3yU44qzoI7XX
         GRnQt/00frNzWIVZwVnllHHqOvTIr89P+TLcO1c6C+ofK3ojf0yaWCY3YqiuzqAr8ABe
         Di7qlF8+m2HFKffPNk2gyvxNbVXITLkCwlDyexMRefPaz5zyMos6on8Lb1qFm4LZ8R+Z
         tD6hZIQg9enZeIwY6L8St3Afue95TcY3Ap+MUATfoQFzbCuc8HIcn9VysI3+2nv9Y1cV
         Ci/AN1q63uBE8QTXxSOxKJ6Zea9j0rlYf4Le0U3zlq9rlIz9V1cUWVVhP0Ane21R62ed
         wKgg==
X-Forwarded-Encrypted: i=1; AJvYcCWNy7++HFrkgD8RvObjVaOttcurZCW+eRatOa9itPkt6o0k+I44opwYQGccEpXjG8La2uyLquvJObWK@vger.kernel.org, AJvYcCXEOoMP0Kr5FiHtzwm+KIYbdIZ/zmoix6SvYeNx7fcHioWx2f28Onyy0Na7Fwjx6UPTCvemHD+r+gLK4U4W@vger.kernel.org, AJvYcCXfVBLnQewQvcj0vSHMAHeIvcTDYbuKbMemredj6sTx1G6cJ6u6+9MBYKRlVEixshVOd1/BUeLPhh49@vger.kernel.org
X-Gm-Message-State: AOJu0YweXJxSHjpn1K4z12Fz4144S7i2NObyLs4jrwrq5rWeD7OIVUFA
	Lrvh25LndIIbvqGVJz7N88/C2i6BA3fHW4fis/QcL9bMp0VtDurc
X-Google-Smtp-Source: AGHT+IFXEiXNqJDX6cJ33qjqkWjyf7pBsT2sKMjO4XnJp1nYMnxIWO0lM8XP5UD5UNDdq9ZdwuXfIA==
X-Received: by 2002:a17:907:7288:b0:a99:4a8f:c83f with SMTP id a640c23a62f3a-a99b9302719mr19547666b.5.1728594039916;
        Thu, 10 Oct 2024 14:00:39 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:39 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/13]: chemical: bme680: 2nd set of clean and add
Date: Thu, 10 Oct 2024 23:00:17 +0200
Message-ID: <20241010210030.33309-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Vasileios Amoiridis (13):
  iio: chemical: bme680: Fix indentation and unnecessary spaces
  iio: chemical: bme680: avoid using camel case
  iio: chemical: bme680: fix startup time
  iio: chemical: bme680: move to fsleep()
  iio: chemical: bme680: refactorize set_mode() mode
  dt-bindings: iio: add binding for BME680 driver
  iio: chemical: bme680: add regulators
  iio: chemical: bme680: add power management
  iio: chemical: bme680: Move ambient temperature to attributes
  iio: chemical: bme680: generalize read_*() functions
  iio: chemical: bme680: Add SCALE and RAW channels
  iio: chemical: bme680: Add triggered buffer support
  iio: chemical: bme680: Add support for preheat current

 .../bindings/iio/chemical/bosch,bme680.yaml   |  64 ++
 drivers/iio/chemical/Kconfig                  |   2 +
 drivers/iio/chemical/bme680.h                 |   7 +-
 drivers/iio/chemical/bme680_core.c            | 554 +++++++++++++++---
 4 files changed, 556 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml

-- 
2.43.0


