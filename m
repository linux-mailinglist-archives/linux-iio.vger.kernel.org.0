Return-Path: <linux-iio+bounces-1369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1778214A1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0667DB210C3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280B6FD7;
	Mon,  1 Jan 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRVat1xW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E66FAF;
	Mon,  1 Jan 2024 17:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC83C433C7;
	Mon,  1 Jan 2024 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704129987;
	bh=NojOBF8KejmCGbJn+3upOovqjyQ7bILC6z97ixwOBts=;
	h=From:To:Cc:Subject:Date:From;
	b=dRVat1xWXPF7aDjj+CZQQ8wXWH3KvhkWP4aEp5Mu8d/VTRxeSZNRKtiv8KDHK15hP
	 QwL0y25EYjtFijQaVLZoIiC6QLFi3RkQBEwf3CLL9v39/91V5f31/W8LXSv+LaW2GA
	 bjIX4/ZulL99jcLevCV+oR37V8rMmD7nwd3/v3zev9F3/xaGLYrLtX439a53nmXpeB
	 DKemsL7rMHwGC2VL4le/36tZxAQB0j9H/B3ntKS3Dc0oQJOtJHOo8MnZM2bIOzjWLq
	 /0cIbDxQbetaJ13zTlbXGw6WDR7PjKpkq6ru6QlUJmu7/PZvt+3zTvxxpEZXTp3/0I
	 1VqmvhbQSRRcg==
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
Subject: [RFC PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
Date: Mon,  1 Jan 2024 17:25:58 +0000
Message-ID: <20240101172611.694830-1-jic23@kernel.org>
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

RFC mainly because it's untested. I have none of the relevant hardware and
haven't yet emulated the firmware descriptions to test this.
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
 * fwnode_handle_put() no automatically called here - but child == NULL so
 * that call is a noop
 */
}

As can be seen by the examples from IIO that follow this can save
a reasonable amount of complexity and boiler plate code, often enabling
additional cleanups in related code such as use of
return dev_err_probe().

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
 include/linux/property.h          |  2 +
 13 files changed, 104 insertions(+), 203 deletions(-)

-- 
2.43.0


