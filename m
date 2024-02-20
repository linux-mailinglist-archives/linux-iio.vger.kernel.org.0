Return-Path: <linux-iio+bounces-2850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9285C98B
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 22:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE561F22BB4
	for <lists+linux-iio@lfdr.de>; Tue, 20 Feb 2024 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095F151CEE;
	Tue, 20 Feb 2024 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yhLt9lOr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B614F9C8;
	Tue, 20 Feb 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464907; cv=none; b=jqh1eFTgv83gb8yE2MpR49BPWqSk1y9jxSSNe12MRgvKCWY62rpukbbb8U0uwX4q7EdYw8+BO0oT20YVbM7SSvZnCrNZJekvjm9I6Sw5jGzgzWGPaElCz4IMnazg5anNSOIZm50/cpq7iDkTH+mxlwmQqmv+9tIh1Md8ogudXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464907; c=relaxed/simple;
	bh=LxTvQq64XK7yAstnWT9q+Hbs0Xz5SnKp4EtEMAWBAkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq/kLG8ceI2A5LBluz4yGBQe6HXSbmhynhMKlz2p/4vleeyhOhwTrViYDMYBGGXck3Dt9jMkyk7pyipQwDOFHkvHOnJqKVTtYEqoOcOqjNDBiwczF8UGYPZDua0ib6sEuRPk0pWTt02fFdlpVEZM8lCfLFWFlE5KYlNLgny0EYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yhLt9lOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A070C433F1;
	Tue, 20 Feb 2024 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464906;
	bh=LxTvQq64XK7yAstnWT9q+Hbs0Xz5SnKp4EtEMAWBAkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yhLt9lOrn5jEf53j1V3Znpz5fkZfm70aLkT1RkTUvLo3O2XirtK8mB2JPNNw1HXMR
	 hi3A0duEW+vhl0t6MIwK81tNLP3h/ZoEknOm9H1nOIS0Ja0fB6yoxyG5vdtcQbmPpO
	 Jk1N/GI5SMowIeH4OHZqi5rfAxbWgin+D7EIaAco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrea Merello <andrea.merello@iit.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.7 175/309] iio: imu: bno055: serdev requires REGMAP
Date: Tue, 20 Feb 2024 21:55:34 +0100
Message-ID: <20240220205638.628806459@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit 35ec2d03b282a939949090bd8c39eb37a5856721 upstream.

There are a ton of build errors when REGMAP is not set, so select
REGMAP to fix all of them.

Examples (not all of them):

../drivers/iio/imu/bno055/bno055_ser_core.c:495:15: error: variable 'bno055_ser_regmap_bus' has initializer but incomplete type
  495 | static struct regmap_bus bno055_ser_regmap_bus = {
../drivers/iio/imu/bno055/bno055_ser_core.c:496:10: error: 'struct regmap_bus' has no member named 'write'
  496 |         .write = bno055_ser_write_reg,
../drivers/iio/imu/bno055/bno055_ser_core.c:497:10: error: 'struct regmap_bus' has no member named 'read'
  497 |         .read = bno055_ser_read_reg,
../drivers/iio/imu/bno055/bno055_ser_core.c: In function 'bno055_ser_probe':
../drivers/iio/imu/bno055/bno055_ser_core.c:532:18: error: implicit declaration of function 'devm_regmap_init'; did you mean 'vmem_map_init'? [-Werror=implicit-function-declaration]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
../drivers/iio/imu/bno055/bno055_ser_core.c:532:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
../drivers/iio/imu/bno055/bno055_ser_core.c: At top level:
../drivers/iio/imu/bno055/bno055_ser_core.c:495:26: error: storage size of 'bno055_ser_regmap_bus' isn't known
  495 | static struct regmap_bus bno055_ser_regmap_bus = {

Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrea Merello <andrea.merello@iit.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240110185611.19723-1-rdunlap@infradead.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/bno055/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -8,6 +8,7 @@ config BOSCH_BNO055
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
 	depends on SERIAL_DEV_BUS
+	select REGMAP
 	select BOSCH_BNO055
 	help
 	  Enable this to support Bosch BNO055 IMUs attached via UART.



