Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4ECAD21
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2019 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbfJCRew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Oct 2019 13:34:52 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38941 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733118AbfJCReM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Oct 2019 13:34:12 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CF894FF809;
        Thu,  3 Oct 2019 17:34:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 1/7] iio: adc: max1027: Add debugfs register read support
Date:   Thu,  3 Oct 2019 19:33:55 +0200
Message-Id: <20191003173401.16343-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191003173401.16343-1-miquel.raynal@bootlin.com>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Until now, only write operations were supported. Force two bytes read
operation when reading from this register (might be wrong when reading
the temperature, but will work with any other value).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 214883458582..6cdfe9ef73fc 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -309,8 +309,11 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
 	struct max1027_state *st = iio_priv(indio_dev);
 	u8 *val = (u8 *)st->buffer;
 
-	if (readval != NULL)
-		return -EINVAL;
+	if (readval) {
+		int ret = spi_read(st->spi, val, 2);
+		*readval = be16_to_cpu(st->buffer[0]);
+		return ret;
+	}
 
 	*val = (u8)writeval;
 	return spi_write(st->spi, val, 1);
-- 
2.20.1

