Return-Path: <linux-iio+bounces-2657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA6858486
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1E21C210F5
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC5132C0F;
	Fri, 16 Feb 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlO9Swp2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716812F38D;
	Fri, 16 Feb 2024 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105958; cv=none; b=bSJ9Iq7JuqLcdePIgdm/UxcMOJykwGH6DW69l/Nh4493JDNXhlJMjT7gJWzcwCgpLhSmb9BZd9aRgdYFgtcIgaAHWASKYGXDqHJDoCJ3oaogtC/IPe36dQ5hLOUw2dQGdo8fgjgo77eAPBYdYVidjfGWwLqmDnb9gliYW4PvDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105958; c=relaxed/simple;
	bh=7iAenK+LGzi38xSQ7b4te+1ZYNPZnwvlbQEyopSw6t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gl+sJywCo6Fh33SEZmGO0DTSr5Vqip+572NeADCK56e5H66LjLVRHyI2fEErglmrgQlqe6G/JBS2BZ0Cb8Za9g7MJWt59JbQ1vSMu0d1jZR4U1YApOzj8a5hiwporYH7pBjHeYAIxx38dUgUyba6nLwVFejOpu4SvOL90z6zs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlO9Swp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0995C433C7;
	Fri, 16 Feb 2024 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105957;
	bh=7iAenK+LGzi38xSQ7b4te+1ZYNPZnwvlbQEyopSw6t8=;
	h=From:To:Cc:Subject:Date:From;
	b=XlO9Swp2LZv7jPq3d+l/PRXfPjw1Cdd92L7U7VCHyLn4Yz1YEP1qGlWJP4x5HSwbo
	 nh034iQ8rQZTLEAdiz404CWaIMdA0yzCQuh1p+I180t9gzoACAHyX21unQHhtiel1F
	 c4DoHP5Uebg4WxFBxsgBuWAYAdIkptNScXp2e2SjIRKFSZMLIPkh6nxdw78TQLuaj0
	 svKUlZyIs1d9wTJpJRDZeGZJyt8RPYCd8v37A6MmQKChfSs3gMzudtJtwm4X5pAQIz
	 9dpaDgRE/O64LLC+XVH51D2YSu0QW8eNuG/d+LrCzSDdhUrdFiWrDSbXw+8tt8vrz0
	 banWHh4nIpIAw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 00/15] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
Date: Fri, 16 Feb 2024 17:52:06 +0000
Message-ID: <20240216175221.900565-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Since v2: Thanks to Sakari and Andy for reviews.
- New first patch moving fwnode_handle_put() into property.h
- Tweak alignment in the loop macro
- Pick up tags.
- scopd -> scoped typo fix in some patch descriptions.

As can be seen by the examples from IIO that follow this can save
a reasonable amount of complexity and boiler plate code, often enabling
additional cleanups in related code such as use of
return dev_err_probe().

Given we are now fairly late in the cycle, I'd expect to take this
through the IIO tree and we can make use of it elsewhere next cycle.

Note I don't have the hardware so this is compile tested only.
Hence I'd appreciate some Tested-by tags if anyone can poke one of the
effected drivers.

Julia Lawal has posted some nice coccinelle magic for the DT equivalents.
Referenced from that cover letter.  Similar may help us convert more
drivers to use this new approach, but often hand tweaking can take
additional advantage of other cleanup.h based magic, or things like
return dev_err_probe().
https://lore.kernel.org/all/20240211174237.182947-1-jic23@kernel.org/

Jonathan Cameron (15):
  device property: Move fwnode_handle_put() into property.h
  device property: Add cleanup.h based fwnode_handle_put() scope based
    cleanup.
  iio: temp: ltc2983: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  device property: Introduce device_for_each_child_node_scoped()
  iio: adc: max11410: Use device_for_each_child_node_scoped()
  iio: adc: mcp3564: Use device_for_each_child_node_scoped()
  iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
  iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
  iio: adc: stm32: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped()
  iio: addac: ad74413r: Use device_for_each_child_node_scoped()
  iio: dac: ad3552r: Use device_for_each_child_node_scoped()
  iio: dac: ad5770r: Use device_for_each_child_node_scoped()
  iio: dac: ltc2688: Use device_for_each_child_node_scoped()

 drivers/base/property.c           | 14 ------
 drivers/iio/adc/max11410.c        | 27 +++--------
 drivers/iio/adc/mcp3564.c         | 16 +++----
 drivers/iio/adc/qcom-spmi-adc5.c  |  7 +--
 drivers/iio/adc/rzg2l_adc.c       | 11 ++---
 drivers/iio/adc/stm32-adc.c       | 63 ++++++++++---------------
 drivers/iio/adc/ti-ads1015.c      |  5 +-
 drivers/iio/adc/ti-ads131e08.c    | 13 ++----
 drivers/iio/addac/ad74413r.c      | 10 +---
 drivers/iio/dac/ad3552r.c         | 51 ++++++++-------------
 drivers/iio/dac/ad5770r.c         | 19 +++-----
 drivers/iio/dac/ltc2688.c         | 24 +++-------
 drivers/iio/temperature/ltc2983.c | 76 ++++++++++---------------------
 include/linux/property.h          | 22 ++++++++-
 14 files changed, 126 insertions(+), 232 deletions(-)

-- 
2.43.2


