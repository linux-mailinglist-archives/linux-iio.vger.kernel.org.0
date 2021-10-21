Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC94363AA
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhJUODO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 10:03:14 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:42370 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUODN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 10:03:13 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 4D76F44A024E;
        Thu, 21 Oct 2021 16:00:55 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@protonic.nl, Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH] iio: chemical: scd4x: Add a scale for the co2 concentration reading
Date:   Thu, 21 Oct 2021 16:00:18 +0200
Message-Id: <20211021140018.3051213-1-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a scale for the co2 concentration reading. The reading is
expressed in percent after applying the scale to the raw value.

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 drivers/iio/chemical/scd4x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 09b34201c42b..b063b378c7d5 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -352,7 +352,11 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_TEMP) {
+		if (chan->type == IIO_CONCENTRATION) {
+			*val = 0;
+			*val2 = 100;
+			return IIO_VAL_INT_PLUS_MICRO;
+		} else if (chan->type == IIO_TEMP) {
 			*val = 175000;
 			*val2 = 65536;
 			return IIO_VAL_FRACTIONAL;
@@ -501,7 +505,8 @@ static const struct iio_chan_spec scd4x_channels[] = {
 		.type = IIO_CONCENTRATION,
 		.channel2 = IIO_MOD_CO2,
 		.modified = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE),
 		.address = SCD4X_CO2,
 		.scan_index = SCD4X_CO2,
 		.scan_type = {
-- 
2.30.2

