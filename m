Return-Path: <linux-iio+bounces-2700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E2859105
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A27F28276A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04487CF28;
	Sat, 17 Feb 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQYgg+0S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE541CD1F;
	Sat, 17 Feb 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188186; cv=none; b=WYu9zfT0fepojLkxCrOmGunFJ2/fHLlf4jmFeHyBOZXInjQZFoA3GtTHtHZPqR6xYUu4Eh2DKdo1JwwpcB1f0yYLUwrvaMX957pYgSg/U8TuuPezifJDznNeP0xpHj6SBC7ad/r98Pk3yFeGzkDaXGhdyx7q48KT/GG4N50ap8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188186; c=relaxed/simple;
	bh=N0jvlRJfzZySjVKsLODu02WxglO2w1qtYRVu2tHb/G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9691c5FXL51M6+ASrWPdB839oZ/Fy8wRZpajnZzIkxNCYDuCU2lN9r/D23Pbi/dmRjpbGZE09WJf7qNZIXwOfA1eSiei48W0PckvZS43Hdooki+7GLxuwSi/6qZ3whb2hVn4MIwxZxtC7x0Lw8ejdMuswgx2UHLyyreOu7/mO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQYgg+0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39295C43390;
	Sat, 17 Feb 2024 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188186;
	bh=N0jvlRJfzZySjVKsLODu02WxglO2w1qtYRVu2tHb/G4=;
	h=From:To:Cc:Subject:Date:From;
	b=pQYgg+0Scf8eTOWf2qK+An6ABSn4FpQe65KJ1oJJBoB1DrCac3jLpr14hmNnsLXe+
	 Yr5jdfIxMn4EHLnivoi2zxGCxcm2zni8JI57JTuy8sZo8HRWVkfysbWHvDwIap0/Xu
	 cp74yZHhNB/2CMW2gFn90KNUlSs8k81HsaTo0k50tIIgz/lmWrUbFdmb6E8Xmlco1Z
	 12ZIa4541b8LCEaVW/RwQ8JS06BjfP6TDCMDKg+qigOL9aiJU1saLJo0EiJCQ1XsLU
	 UCvkJQhKHAGSIWOVSeUonDeNfXimNt7ZSxDjUj9EzqZhoSvvnJsHVnhhm1CJVFibmA
	 IQpBn1BJg7smQ==
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
Subject: [PATCH v4 00/15] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
Date: Sat, 17 Feb 2024 16:42:34 +0000
Message-ID: <20240217164249.921878-1-jic23@kernel.org>
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

Sorry for the rapid resend, Andy noticed I'd messed up creating the v3 patch
set with some updates committed in the wrong patch.

Since v3: The updates to alignment of device_for_each_child_node_scopd() were
    in the wrong patch. Move them to patch 4 where they should always
    have been. (thanks Andy!)

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


