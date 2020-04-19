Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57FF1AF92E
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDSKCY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 06:02:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55290 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgDSKCY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 06:02:24 -0400
Received: from p508fcedd.dip0.t-ipconnect.de ([80.143.206.221] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQ6mC-00069Y-0i; Sun, 19 Apr 2020 12:02:12 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        xxm@rock-chips.com, kever.yang@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v5 2/3] iio: adc: rockchip_saradc: better prefix for channel constant
Date:   Sun, 19 Apr 2020 12:02:06 +0200
Message-Id: <20200419100207.58108-2-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200419100207.58108-1-heiko@sntech.de>
References: <20200419100207.58108-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

As suggested give the current ADC_CHANNEL constant a distinct
and consistent prefix.

Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
changes in v5:
- new patch

 drivers/iio/adc/rockchip_saradc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 270eb7e83823..29d7f6e4057e 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -118,7 +118,7 @@ static const struct iio_info rockchip_saradc_iio_info = {
 	.read_raw = rockchip_saradc_read_raw,
 };
 
-#define ADC_CHANNEL(_index, _id) {				\
+#define SARADC_CHANNEL(_index, _id) {				\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.channel = _index,					\
@@ -128,9 +128,9 @@ static const struct iio_info rockchip_saradc_iio_info = {
 }
 
 static const struct iio_chan_spec rockchip_saradc_iio_channels[] = {
-	ADC_CHANNEL(0, "adc0"),
-	ADC_CHANNEL(1, "adc1"),
-	ADC_CHANNEL(2, "adc2"),
+	SARADC_CHANNEL(0, "adc0"),
+	SARADC_CHANNEL(1, "adc1"),
+	SARADC_CHANNEL(2, "adc2"),
 };
 
 static const struct rockchip_saradc_data saradc_data = {
@@ -141,8 +141,8 @@ static const struct rockchip_saradc_data saradc_data = {
 };
 
 static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channels[] = {
-	ADC_CHANNEL(0, "adc0"),
-	ADC_CHANNEL(1, "adc1"),
+	SARADC_CHANNEL(0, "adc0"),
+	SARADC_CHANNEL(1, "adc1"),
 };
 
 static const struct rockchip_saradc_data rk3066_tsadc_data = {
@@ -153,12 +153,12 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
 };
 
 static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channels[] = {
-	ADC_CHANNEL(0, "adc0"),
-	ADC_CHANNEL(1, "adc1"),
-	ADC_CHANNEL(2, "adc2"),
-	ADC_CHANNEL(3, "adc3"),
-	ADC_CHANNEL(4, "adc4"),
-	ADC_CHANNEL(5, "adc5"),
+	SARADC_CHANNEL(0, "adc0"),
+	SARADC_CHANNEL(1, "adc1"),
+	SARADC_CHANNEL(2, "adc2"),
+	SARADC_CHANNEL(3, "adc3"),
+	SARADC_CHANNEL(4, "adc4"),
+	SARADC_CHANNEL(5, "adc5"),
 };
 
 static const struct rockchip_saradc_data rk3399_saradc_data = {
-- 
2.25.1

