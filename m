Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5233ACB06
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jun 2021 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhFRMds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Jun 2021 08:33:48 -0400
Received: from aposti.net ([89.234.176.197]:41166 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234529AbhFRMda (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Jun 2021 08:33:30 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/2] iio: core: Support reading extended name as label
Date:   Fri, 18 Jun 2021 13:30:05 +0100
Message-Id: <20210618123005.49867-3-paul@crapouillou.net>
In-Reply-To: <20210618123005.49867-1-paul@crapouillou.net>
References: <20210618123005.49867-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The point of this new change is to make the IIO tree actually parsable.

Before, given this attribute as a filename:
in_voltage0_aux_sample_rate

Userspace had no way to know if the attribute name was
"aux_sample_rate" with no extended name, or "sample_rate" with "aux" as
the extended name, or just "rate" with "aux_sample" as the extended
name.

This was somewhat possible to deduce when there was more than one
attribute present for a given channel, e.g:
in_voltage0_aux_sample_rate
in_voltage0_aux_frequency

There, it was possible to deduce that "aux" was the extended name. But
even with more than one attribute, this wasn't very robust, as two
attributes starting with the same prefix (e.g. "sample_rate" and
"sample_size") would result in the first part of the prefix being
interpreted as being part of the extended name.

To address the issue, knowing that channels will never have both a label
and an extended name, set the channel's label to the extended name.
In this case, the label's attribute will also have the extended name in
its filename, but we can live with that - userspace can open
in_voltage0_<prefix>_label and verify that it returns <prefix> to obtain
the extended name.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v3: Refactor code to make it look better

 drivers/iio/industrialio-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 81f40dab778a..a19938b0c3a6 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -717,10 +717,13 @@ static ssize_t iio_read_channel_label(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	if (!indio_dev->info->read_label)
-		return -EINVAL;
+	if (indio_dev->info->read_label)
+		return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
+
+	if (this_attr->c->extend_name)
+		return sprintf(buf, "%s\n", this_attr->c->extend_name);
 
-	return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
+	return -EINVAL;
 }
 
 static ssize_t iio_read_channel_info(struct device *dev,
@@ -1160,7 +1163,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int ret;
 
-	if (!indio_dev->info->read_label)
+	if (!indio_dev->info->read_label && !chan->extend_name)
 		return 0;
 
 	ret = __iio_add_chan_devattr("label",
-- 
2.30.2

