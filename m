Return-Path: <linux-iio+bounces-2741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879C859830
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159ED281274
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766486EB78;
	Sun, 18 Feb 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ0EORyO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EF1E898
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277623; cv=none; b=jUVsH0Lfilz+dVK9tUmwkTdTIkHjexL7Xuaq3W98uwfbrooTGat9wFRrnyupMbe6tO3cJDwVkTw/J2kcG656ngOVgPJaqqgCfSJWOx/Jv1CdAmrQrk3UXpjjqOdnCAG+uLcmIEiuww+iSAJy1GheXr8ldzjL2diWuKYf05C5EnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277623; c=relaxed/simple;
	bh=2EeMz1RG7098w2PrP8N7GaoxBeqqfms4se11h+YFMxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFMSPo5HrDLmUMrvhWb0XiqxcfE1s9nv7l55NR6l6FTs0w6emS08WG8NjbwAGyow0hDJU2SyM11xGqQGQhcDzEuPJ/Pc4x8Q2/jSXMOTrTQr4xo6XCNkqWB6MJC5nB2YdWKhGRaDbuMHd5330GWtRZQ3MU+cFle7V/jgUNhFVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ0EORyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BC9C433F1;
	Sun, 18 Feb 2024 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277622;
	bh=2EeMz1RG7098w2PrP8N7GaoxBeqqfms4se11h+YFMxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ0EORyO2KQP+mNnTHniN8ubp8dcUr+KuZOW+TXobJMaTgn2ygpiOpVtKH5jaeTvV
	 eZ9QmKCnJcWNZVSKojf5kMNEcPmx2wsIQeMYZxdbYBUBQpkH162q91eda2WuHCjpg3
	 BgvgPNZEDqffgHBywr0boV1+QWsg4ma3TZ3fzJLnCAVrPL1ynMFlT1fVk7SVqNrf+w
	 ZIWZ6m1l5vrPSc6KZTvpTRiazqN5khDHKQ3eqNleUZ2mcP1B1bCvK6W7wuk9DTCtnp
	 kBk04jQUW6cGtYpF3JkXElV7Drzx8uvhvU6b1CzTXLwR1RNZCtLB1gGrJdLyeDezXV
	 qORqIC8FD2rNw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/8] iio: accel: adxl372: Switch from linux/of.h to linux/mod_devicetable.h
Date: Sun, 18 Feb 2024 17:33:20 +0000
Message-ID: <20240218173323.1023703-6-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The only of specific definition used is of_device_id table and that
is found in mod_devicetable.h not of.h

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl372_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 75a88f16c6c9..787699773f96 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -6,8 +6,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
-#include <linux/of.h>
 #include <linux/spi/spi.h>
 
 #include "adxl372.h"
-- 
2.43.2


