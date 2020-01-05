Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB1130530
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2020 01:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEAKj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jan 2020 19:10:39 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37699 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAEAKj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jan 2020 19:10:39 -0500
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 71EC31C0004;
        Sun,  5 Jan 2020 00:10:35 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 1/5] IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
Date:   Sun,  5 Jan 2020 01:16:35 +0100
Message-Id: <20200105001639.142061-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide an of_xlate callback in order to retrieve the correct channel
specifier index from the IIO channels array.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/ingenic-adc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 39c0a609fc94..7a24bc1dabe1 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -383,6 +383,21 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 	}
 }
 
+static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
+				const struct of_phandle_args *iiospec)
+{
+	int i;
+
+	if (!iiospec->args_count)
+		return -EINVAL;
+
+	for (i = 0; i < iio_dev->num_channels; ++i)
+		if (iio_dev->channels[i].channel == iiospec->args[0])
+			return i;
+
+	return -EINVAL;
+}
+
 static void ingenic_adc_clk_cleanup(void *data)
 {
 	clk_unprepare(data);
@@ -392,6 +407,7 @@ static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
 	.read_avail = ingenic_adc_read_avail,
+	.of_xlate = ingenic_adc_of_xlate,
 };
 
 static const struct iio_chan_spec ingenic_channels[] = {
-- 
2.24.1

