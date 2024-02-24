Return-Path: <linux-iio+bounces-2989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B318624F5
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E25C1F21F42
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6B18021;
	Sat, 24 Feb 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue8QLXMv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF11392
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777956; cv=none; b=Yyt/RQuuwgJ7vhtZ0vTXmQTP7BjraH5hYcXr8F9AvHhllQM6mldE2MaG72x59srOb9YywAhK7LxT9uR3cxVZoNNKo8zCCfh8mW48aKLk6MPnl+Y2AbotiM9KwZd/ukeC8gZCz/O6PngjfmTdxMn1HptqYo0D2FV791+I8DsHLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777956; c=relaxed/simple;
	bh=strZS6afU+qiYFELLY8OPzhk6LAVArVb4JZuWTpBTUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJ37AvhmEYHj84s2FRfmPxgrYjZANIG78C2gfLesLN5DEqPefR13XiDLXfKmFme7j1Cehl1Fyuyu9EsYKN4k5zeELcgqjylP1alEs6q7VT3moGDMVA976RvFR0tbK0imDow33ge3xKOCMXkFYvrVfi+MCivexz6qRcspflW9cTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue8QLXMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE63FC433F1;
	Sat, 24 Feb 2024 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777955;
	bh=strZS6afU+qiYFELLY8OPzhk6LAVArVb4JZuWTpBTUs=;
	h=From:To:Cc:Subject:Date:From;
	b=Ue8QLXMv25hNa2toLrZSVR71ZbJKgwcaGwo1rGLMZS11qDpn91MINuvHoXPhDbq/h
	 OeuT+C8/XYXip8PBxKpLybW52TYlqrPogfjS8oP85EtEp/AUQ1873mR1VyhN5so7mH
	 ne3+KhIna5l1PNeobEGLTKmtSlSjKFTevh/ExMQdqafU7XJjyswQbp2z78qxCgv79R
	 UodkONAD5mm6eCxljXC8BU4WGRdgKHFNcNmc5GXi4bYH8zq0z5FYazhAHdonZQwh4Y
	 k+0s/9icbr0lCQbAWSgNTF9FPHyCdKn16AKiyRK5dIXc7pR1Ds1+ceqJWkUO3M8rMZ
	 V7zK6WOpd4Dsg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
Subject: [PATCH v5 0/9] IIO: Use device_for_each_child_scope()
Date: Sat, 24 Feb 2024 12:32:06 +0000
Message-ID: <20240224123215.161469-1-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously:
[PATCH v4 00/15] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
 
The infrastructure being used here is now in iio.git (currently exposed
as testing for initial 0-day testing). I also applied a couple of users
that had received positive reviews. I split the series up like this
so that the infrastructure would make the merge window if reviews on these
take a little longer to come in (hopefully these will also make it)

Some of the driver changes haven't received any tags or specific feedback
yet, so I want to repost those for review.  Andy and Nuno gave some
feedback on other patches. Resulting changes called out in specific
patches.

Jonathan Cameron (9):
  iio: temp: ltc2983: Use __free(fwnode_handle) and
    device_for_each_node_scoped()
  iio: adc: mcp3564: Use device_for_each_child_node_scoped()
  iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
  iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
  iio: adc: stm32: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped()
  iio: dac: ad3552r: Use device_for_each_child_node_scoped()
  iio: dac: ad5770r: Use device_for_each_child_node_scoped()

 drivers/iio/adc/mcp3564.c         |  16 ++--
 drivers/iio/adc/qcom-spmi-adc5.c  |   7 +-
 drivers/iio/adc/rzg2l_adc.c       |  11 +--
 drivers/iio/adc/stm32-adc.c       |  61 ++++++-------
 drivers/iio/adc/ti-ads1015.c      |   5 +-
 drivers/iio/adc/ti-ads131e08.c    |  13 +--
 drivers/iio/dac/ad3552r.c         |  51 +++++------
 drivers/iio/dac/ad5770r.c         |  19 ++---
 drivers/iio/temperature/ltc2983.c | 137 +++++++++++-------------------
 9 files changed, 116 insertions(+), 204 deletions(-)

-- 
2.44.0


