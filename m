Return-Path: <linux-iio+bounces-1651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C682D19B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3BF281B0B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F345691;
	Sun, 14 Jan 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp5mLajj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538D2F4A;
	Sun, 14 Jan 2024 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F7CC433C7;
	Sun, 14 Jan 2024 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252831;
	bh=vagUNfRKomqh1O4yrAuG6OACpyweQ7hEa3vAZjeMp4g=;
	h=From:To:Cc:Subject:Date:From;
	b=pp5mLajjoAk3PnKGepNwy0NkELAx2yqYSspnXc9eYMXrS8YYJfAhxKiM7cTlec5Ll
	 TXk/d02TaIXrk+36gbw9snJLR/GjGy0aQ326KciOOcXsHwvkQ/kBkBP/y9B3gZx1nr
	 VNF/GVNlnH6vRC9QjpZZVIOltBJkJqiP5RZuFz/Sh/H3QssZVA1fzb7QqhvHY5HJzc
	 LixP61Z4LSAeTuuRXsD/F6kq9Z6D8lSNCAgat/thL5XrOrE+vVQYV6ihFyhz+RmLQY
	 7gorF1yp2LCvplZsu+kLAHHo352y8XxZi1IMM+EEUUMH/jrv5YdHJrfMUP1Us9b+DB
	 GTrhar4bQaCQg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
Date: Sun, 14 Jan 2024 17:19:56 +0000
Message-ID: <20240114172009.179893-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Chances since RFC.
- Add if (!IS_ERR_OR_NULL(_T)) check as suggested by Andy Shevchenko.
  This may allow the compiler to optimize cases where it can tell that
  this check will fail rather than calling into fwnode_handle_put().

Note I don't have the hardware so this is compile tested only.
Hence I'd appreciate some Tested-by tags if anyone can poke one of the
effected drivers.

I have tested the device tree only version:
https://lore.kernel.org/linux-iio/20231217184648.185236-1-jic23@kernel.org/
which is very similar.

Failing to release the references on early exit from loops over child nodes
and similar are a fairly common source of bugs. The need to explicitly
release the references via fwnode_handle_put() also complicate the code.

The first patch enables

	struct fwnode_handle *child __free(fwnode_handle) = NULL;

	device_for_each_child_node(dev, child) {
		if (err)
			/*
			 * Previously needed a fwnode_handle_put() here,
			 * will now be called automatically as well leave
			 * the scope within which the cleanup is registered
			 */
			return err;
	}

/*
 * The if (!IS_ERR_OR_NULL(_T)) check will fail here as the pointer will be
 * NULL and thus fwnode_handle_put() will not be called. It would be
 * functionally correct to call it with a NULL pointer but that reduces
 * the opportunities for the compiler to optimize out the call.
 */
}

As can be seen by the examples from IIO that follow this can save
a reasonable amount of complexity and boiler plate code, often enabling
additional cleanups in related code such as use of
return dev_err_probe().

Merge wise (assuming everyone is happy), I'd propose an immutable branch
(in IIO or elsewhere) with the first patch on it, so that we can start making
use of this in other areas of the kernel without having to wait too long.

Jonathan Cameron (13):
  device property: Add cleanup.h based fwnode_handle_put() scope based
    cleanup.
  iio: adc: max11410: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: adc: mcp3564: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: adc: qcom-spmi-adc5: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: adc: rzg2l_adc: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: adc: stm32: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: adc: ti-ads1015: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: adc: ti-ads131e08: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: addac: ad74413r: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: dac: ad3552: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: dac: ad5770r: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: dac: ltc2688: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  iio: temp: ltc2983: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls

 drivers/iio/adc/max11410.c        | 26 ++++--------
 drivers/iio/adc/mcp3564.c         | 15 ++++---
 drivers/iio/adc/qcom-spmi-adc5.c  |  6 +--
 drivers/iio/adc/rzg2l_adc.c       | 10 ++---
 drivers/iio/adc/stm32-adc.c       | 62 +++++++++++----------------
 drivers/iio/adc/ti-ads1015.c      |  4 +-
 drivers/iio/adc/ti-ads131e08.c    | 12 ++----
 drivers/iio/addac/ad74413r.c      |  9 +---
 drivers/iio/dac/ad3552r.c         | 50 +++++++++-------------
 drivers/iio/dac/ad5770r.c         | 18 +++-----
 drivers/iio/dac/ltc2688.c         | 23 +++-------
 drivers/iio/temperature/ltc2983.c | 70 ++++++++++---------------------
 include/linux/property.h          |  3 ++
 13 files changed, 105 insertions(+), 203 deletions(-)

-- 
2.43.0


