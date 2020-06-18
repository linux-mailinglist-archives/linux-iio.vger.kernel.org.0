Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F131FE15A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jun 2020 03:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgFRByK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 21:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbgFRB0H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA2E2075E;
        Thu, 18 Jun 2020 01:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443567;
        bh=vVie/ygbR0DLrb/Ebw/E2vK9WDMcdwM+9xRJs4xgTwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DacWbn9n3iSQRZH7aBEwEIWg3ZEMFFEKti1NG6M3iNhb7UDlWTXXqs1UBsjQjKrGJ
         QHjHr5nLYF6TU0WrE4mqZqWQUp77kVmrHjBgMh2+LTaWLROQDM8S79CSbNgw0wJYXM
         PTBgHZ7xq+IA6i68Yv9OdOl88bwDN6E6PZ7hZxSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 005/108] iio: light: isl29125: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Wed, 17 Jun 2020 21:24:17 -0400
Message-Id: <20200618012600.608744-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 9b7a12c3e090cf3fba6f66f1f23abbc6e0e86021 ]

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
the poll functions.

For the predisable hook, the disable code should occur before detaching
the poll func, and for the postenable hook, the poll func should be
attached before the enable code.

This change reworks the predisable/postenable hooks so that the pollfunc is
attached/detached in the correct position.
It also balances the calls a bit, by grouping the preenable and the
iio_triggered_buffer_postenable() into a single
isl29125_buffer_postenable() function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29125.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 1d2c0c8a1d4f..4802cc031a0e 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -217,13 +217,24 @@ static const struct iio_info isl29125_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int isl29125_buffer_preenable(struct iio_dev *indio_dev)
+static int isl29125_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct isl29125_data *data = iio_priv(indio_dev);
+	int err;
+
+	err = iio_triggered_buffer_postenable(indio_dev);
+	if (err)
+		return err;
 
 	data->conf1 |= ISL29125_MODE_RGB;
-	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
+	err = i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
+	if (err) {
+		iio_triggered_buffer_predisable(indio_dev);
+		return err;
+	}
+
+	return 0;
 }
 
 static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
@@ -231,19 +242,18 @@ static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
 	struct isl29125_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		return ret;
-
 	data->conf1 &= ~ISL29125_MODE_MASK;
 	data->conf1 |= ISL29125_MODE_PD;
-	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
+	ret = i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
+
+	iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
 }
 
 static const struct iio_buffer_setup_ops isl29125_buffer_setup_ops = {
-	.preenable = isl29125_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
+	.postenable = isl29125_buffer_postenable,
 	.predisable = isl29125_buffer_predisable,
 };
 
-- 
2.25.1

