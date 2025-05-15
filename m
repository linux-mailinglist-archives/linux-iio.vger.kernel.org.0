Return-Path: <linux-iio+bounces-19534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBBAB8150
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C5018841DC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481F1ADFFE;
	Thu, 15 May 2025 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b="CVZEwBWS"
X-Original-To: linux-iio@vger.kernel.org
Received: from clean236.mxserver.ro (clean236.mxserver.ro [46.102.249.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19B28C84D;
	Thu, 15 May 2025 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.102.249.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298843; cv=none; b=eZS+MOmenDdwgwEiJj/N60aQb50jxTOJrefGVx+jFJDdUySSl6YTYklTXt/ZffWJJ3MMpyB1whJe3H6jPQL/KsT+Bfvaryudci2HMxwod+sz9tkK0fNWQYojyuoC5XzuJphY+gjJx9Y4K4aKzlZ4Ue/es0GeoC8hLYcwrNS7CVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298843; c=relaxed/simple;
	bh=cRWidd52qz45UTzRBYVqc/bvlG4ksdV/625FmAaW0Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUJmArn9N1RbA1ZlFAh9IMA/U+HYdrBvIFv9tEunzlAeArK/2oQzDNz1hYw6/NlrzhmIoAX5pefqhDqeEE9iClV28jtSv8VhXSheSTq8qYC+NXE31rpBQvS5tdXquUN5RzUtmoCIeLo3JFAZArRvQ29HOpyApPcy+/RlZz+3wrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro; spf=pass smtp.mailfrom=taladin.ro; dkim=pass (2048-bit key) header.d=taladin.ro header.i=@taladin.ro header.b=CVZEwBWS; arc=none smtp.client-ip=46.102.249.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=taladin.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=taladin.ro
Received: from cloud347.c-f.ro ([185.236.86.218])
	by cleanserver2.mxserver.ro with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlx-001Vs0-E1; Thu, 15 May 2025 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=taladin.ro;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9osiAM7EArqlFfuk2KHjpv3HYzglesdn+c5l6d4e9HA=; b=CVZEwBWSBbFK+YvvNXxlW1Grsy
	fUveYrcJOUUeyQai73Xtm2fsSD06D6pN3sw9FX1zBolIrEpzV8iLtM1FxjbQSXv8oPAfiCTw66GGv
	ZCWjLEk4slWdlSNhpTPzfBZnYfVYKBTp4dz+o/UlNECYRnXVUXZk9YOC29AYBom4FhOYVF9hDoL5B
	1FmsJqoEuRktdMq+egZ2i43BP4mXpPe8a3YPLR/0GBFAYMzM+vFu2f4OxbUERB2QAy9kWBXLsaSLc
	e/djPOh3WXVuV4ejrt1no7A6N+W6zYCDuUjqHvR4XYfng4uER3BuJISiv+2mnRqL4S4K2ytxtCg2D
	+/vchoyw==;
Received: from [109.166.137.172] (port=37860 helo=localhost)
	by cloud347.c-f.ro with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <asoponar@taladin.ro>)
	id 1uFTlj-00000006q6u-2GBu;
	Thu, 15 May 2025 11:16:52 +0300
From: Alexandru Soponar <asoponar@taladin.ro>
To: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	jic23@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	baocheng.su@siemens.com,
	wim@linux-watchdog.org,
	tobias.schaffner@siemens.com,
	angelogioacchino.delregno@collabora.com,
	benedikt.niedermayr@siemens.com,
	matthias.bgg@gmail.com,
	aardelean@baylibre.com,
	contact@sopy.one,
	Alexandru Soponar <asoponar@taladin.ro>
Subject: [PATCH 0/16] lib: Refactor find_closest() and find_closest_descending() from macros to lib functions
Date: Thu, 15 May 2025 11:13:16 +0300
Message-ID: <20250515081332.151250-1-asoponar@taladin.ro>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SpamExperts-Domain: cloud347.c-f.ro
X-SpamExperts-Username: 185.236.86.218
Authentication-Results: mxserver.ro; auth=pass smtp.auth=185.236.86.218@cloud347.c-f.ro
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00142511043704)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/l1RxW2J9YM5Z2+IdQaoSXPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5TSx
 S75yz9IFZiY7BarU/NrpK8SEOwGmfn6ucAKqn/OHRh3BqzFaEnAEj4UixLJBjVNiLZt/QXQnOBRD
 +jq1HsIBmHTFdhqXZEtguZY7iGKpkcJnJKaJfT+dw1udmv00tbIRNtoyOobb3xnDyRRylAVTYi2b
 f0F0JzgUQ/o6tR7C8pLPCtTiVLo0r89ClJHDKhDGKgJ+T00JeCnHBmMdB1eMZAyYlfUtEN4pUyes
 jVRntA/J5DcfwvG53FyVviDO9UET3GKmqv1jT0lY+AQz8YX4CVph7ctC7tRH2SPTQJ/0klTuXKq/
 B9rqRWsYzNfBLt79i78aPHyWnIqxGMxPZotYvH/es1vXuByXo2bkrYMqq0x5CzaUoJIoBUQayHle
 UvbvCQmh9x4kn6NeQcRkc6G+OgAcq5x+BzhRyg9rYO6I0H7Q2OEpckvWJAOmdJd77Z9vwc+QHB+X
 +u7aTqYHtT2CBuxNPBc9JM2jck1NnIBf0tvflhq7Xjhll72AYgnW/6M0ftSpvLIx+X1vKami8KF6
 jWQ71uVNIY/EFPWeDmcZuFRQy1vmjjPiYw8fUCp0/qY6cmSW9oUDdvKuTRfTGZ6f8nTXoYFaQ71l
 mMti8uxA0gKVmIzBXtbLDVvAQ/KVNbMOTYsa8ktxPJcneEY5WtSSAN5VcIfsMVILjVAz6RZsCHxD
 lgOJwEwCFaF+62b2lf1UUDu9jECN1V/lwmsioRLmNJoHOZOE/9e5UD715p61XAQw85DCXa0iAPEd
 fYyrF5wMRSLGyY+i0m2IxQLxQUzTb3Mji+CrO1+NTWs5OBXbSDBPqdRoFsq0hfzdx0oxkgNI/jhY
 WFhu7VV+HdWjdZLlmQ5z83qEVVG/6RJ+BW7FmGcwL889DSW2cZWGkIYVQAbHnYkWUz1gRIjAiMvi
 vM7um7t0SVa5NVZ2g1u6DnOpqk1nwAzTSgytNKIH5lfAuQc8I07FTFcjpdfX/Jcr87en7cKbI0NU
 afdkQMG+6qjtXoANVR89VM6f75a5kmRIbungV7ywXD8VtmM8wef5C6IkqMFhROX1HYRo9Sm1kZOW
 saz62DSUUd/fn3Ix/aSqJVglEtnFggTvi4y/qO0sxBxzHDeqqFz43py4SDhdaHkWOGxZQgSAzbb+
 OB/nFYi5VbOv2oY4HXLSfAUu3sMpupaxyWIY+zWFG7j7LacXdPm5MvYnkNWjwSQDaUU9MqYUCeef
 0nlkmUPzlfoLUG4g/XHuva4NQ7gH1kLtR+dZ31Wj92PNDpgLsd6Ddd/s7VM53twrVC8K+lj1c6e/
 tTmd6eMo8njYQeCXryE9YzCFXixhuytCzYpdzLgCyU1NoaLI1a6CFspCMTS3AJKRNkDoiCdr/yiP
 gGFyxS1LuwmPRAQzaEJVYkfhZXq/u54kZVCWtfUf9oDBqtClgM5jH/om1Q6gjkapWNvVA5HRyb3X
 trWYR6vnFpUUmgU46LTsHtrjRqVe/ojyw7bapws3danDDsxD6gvvWu5/Lf1bKbM1VroDfVYPkwIu
 /8x7KhILIr1IfwgT9kxT5f4reZBSMLp/jH4zvQRYQJnl3XNqRK2lK/zP
X-Report-Abuse-To: spam@cleanserver1.mxserver.ro
X-Complaints-To: abuse@cleanserver1.mxserver.ro

This patch series converts the find_closest() and find_closest_descending() macros
into proper library functions. The conversion moves these utilities from macro
implementations in util_macros.h to standard C functions in lib/find_closest.c.

The first 15 patches modify individual callers across hwmon, iio, leds, regulator,
and watchdog subsystems to ensure they work correctly with the new function-based
implementation. This maintains compatibility while allowing the final conversion.

The final patch implements the actual refactoring by moving the code to
lib/find_closest.c. This approach was chosen based on discussions between
Andrew Morton and Alexandru Ardelean[1], who suggested that a non-inline
implementation would be appropriate given the size of the functions.

The refactoring avoids of macro expansion-related issues and proper function
prototypes with well-defined parameter types.

Links:
[1] https://lore.kernel.org/lkml/20241105145406.554365-1-aardelean@baylibre.com/

Alexandru Soponar (16):
  hwmon: w83795: Fix type incompatibility with non-macro find_closest
  hwmon: emc1403: Fix type incompatibility with non-macro find_closest
  hwmon: ina3221: Fix type incompatibility with non-macro find_closest
  hwmon: lm95234: Fix type incompatibility with non-macro find_closest
  hwmon: max1619: Fix type incompatibility with non-macro find_closest
  hwmon: lm75: Fix type incompatibility with non-macro find_closest
  hwmon: ltc4282: Fix type incompatibility with non-macro find_closest
  hwmon: max6639: Fix type incompatibility with non-macro find_closest
  hwmon: max20740: Fix type incompatibility with non-macro find_closest
  iio: ad7606: Fix type incompatibility with non-macro find_closest
  iio: mcp3564: Fix type incompatibility with non-macro find_closest
  iio: max44009: Fix type incompatibility with non-macro find_closest
  leds: eds-mt6370-rgb: Fix type incompatibility with find_closest()
  regulator: max77857: Fix type incompatibility with find_closest()
  watchdog: simatic-ipc-wdt: Fix type incompatibility with
    find_closest()
  lib: move find_closest() and find_closest_descending() to lib
    functions

 drivers/hwmon/emc1403.c                |  2 +-
 drivers/hwmon/ina3221.c                |  8 +--
 drivers/hwmon/lm75.c                   | 42 +++++++--------
 drivers/hwmon/lm95234.c                |  2 +-
 drivers/hwmon/ltc4282.c                |  2 +-
 drivers/hwmon/max1619.c                |  2 +-
 drivers/hwmon/max6639.c                |  2 +-
 drivers/hwmon/pmbus/max20730.c         |  4 +-
 drivers/hwmon/w83795.c                 |  2 +-
 drivers/iio/adc/ad7606.c               |  8 +--
 drivers/iio/adc/mcp3564.c              |  2 +-
 drivers/iio/light/max44009.c           |  2 +-
 drivers/leds/rgb/leds-mt6370-rgb.c     |  9 ++--
 drivers/regulator/max77857-regulator.c |  2 +-
 drivers/watchdog/simatic-ipc-wdt.c     |  2 +-
 include/linux/find_closest.h           | 13 +++++
 include/linux/util_macros.h            | 61 +---------------------
 lib/Makefile                           |  2 +-
 lib/find_closest.c                     | 71 ++++++++++++++++++++++++++
 19 files changed, 132 insertions(+), 106 deletions(-)
 create mode 100644 include/linux/find_closest.h
 create mode 100644 lib/find_closest.c

-- 
2.49.0


