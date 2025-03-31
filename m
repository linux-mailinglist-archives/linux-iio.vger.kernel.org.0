Return-Path: <linux-iio+bounces-17465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95FA765A0
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B031889869
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63C1E51F1;
	Mon, 31 Mar 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luF/nWhI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1513B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423438; cv=none; b=Pr9HhJ5O45HPJE/AKyzCHa+37Dk43t3axnu3FmJs83U1JlHpeLOOMbbHvrqrGiEoxgrkGDGfeZQIYgg0L/rEP0ax2RK1bs143tkG7yeFGouGUpOgdwlaRfEMXjp4Hw4a9Yr2cQeWmqLncTtRx3AGmmt3Ls/Ddxi4gYRQoi623PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423438; c=relaxed/simple;
	bh=63bsLeNRCvs3h9uskeEtJydLXLceBFgeQFJiyYQhQvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXaOM3cpvMm4zaXMYG6FPG2kZ8vA2WTVPGe0RU8fZIKcEZpgTjPD45h63J875/YJ5ZDoXNlcOCwJm9j7yqREnT0jOyopUsN0Tq10f0ev5mcCmTzencwdoxs2Guq0doJtKQjVYAa9PJgx1ReREU4eIA/tm7m2zR0vKXm+s4jKb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luF/nWhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2708DC4CEE5;
	Mon, 31 Mar 2025 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423435;
	bh=63bsLeNRCvs3h9uskeEtJydLXLceBFgeQFJiyYQhQvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luF/nWhIZSLoTCu1nzxx5o6aQXXCqm5RcrxmDoHl6MhPpWD9vSpi8pqrBvAO4pSJM
	 cG5LDLR0q4Mj6RtIlvgCwNgFBFYQoOTjcr/vQgW6yLHkwd3nNYlyCffz5fwPV4Rx0d
	 BFBE+r9rkbjtlnpCIaLKUBE0JRGq3ZhbZccdIcKU5S7XLfghtf+Li4OhLpCGniIJVS
	 NrSUfxTI0VTWwiQDXwfu3vQVcIzdbE/JeJQS4uqdFe1HwISZ1Go+Taz04zu7cSZZ8W
	 qT3exbO8j9RoweuSDniHhGFrxmC4U72rqlH5FsTdT7c01uyW2qFFBNE/HKrCHJ4TTY
	 ECtN/M+eJlMQw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 35/37] iio: temp: maxim_thermocouple: Drop unused mutex.h include.
Date: Mon, 31 Mar 2025 13:13:15 +0100
Message-ID: <20250331121317.1694135-36-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There are no mutex related calls in this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index a1c213d5c469..a13efde76397 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
-- 
2.48.1


