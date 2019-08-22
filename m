Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC498B35
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 08:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfHVGGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 02:06:16 -0400
Received: from ox4u.de ([212.118.221.216]:45541 "EHLO s1.ox4u.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfHVGGQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Aug 2019 02:06:16 -0400
Received: by s1.ox4u.de (Postfix, from userid 65534)
        id 255FA260127; Thu, 22 Aug 2019 08:06:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on s1.ox4u.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
        autolearn=disabled version=3.4.1
Received: from ws-140106.systec.local (unknown [212.185.67.146])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by s1.ox4u.de (Postfix) with ESMTPSA id 7A95C260122;
        Thu, 22 Aug 2019 08:06:13 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iio: core: Fix fractional format generation
Date:   Thu, 22 Aug 2019 08:06:07 +0200
Message-Id: <20190822060607.25339-1-alexander.stein@systec-electronic.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In case the result is -0.3252 tmp0 is 0 after the div_s64_rem, so tmp0 is
non-negative which results in an output of 0.3252.
Fix this by explicitly handling the negative sign ourselves.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v2:
* Support vals[0] >= and vals[1] < 0 in IIO_VAL_FRACTIONAL
* Note: IIO_VAL_FRACTIONAL is untested, as I lack hardware
* Note2: Currently IIO_VAL_FRACTIONAL is only called with vals[1] from
         in-kernel drivers AFAICS

 drivers/iio/industrialio-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 245b5844028d..247338142c87 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -568,6 +568,7 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 {
 	unsigned long long tmp;
 	int tmp0, tmp1;
+	char *sign;
 	bool scale_db = false;
 
 	switch (type) {
@@ -593,11 +594,17 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp1 = vals[1];
 		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		if (vals[1] < 0) {
+			sign = vals[0] >= 0 ? "-" : "";
+		} else {
+			sign = vals[0] < 0 ? "-" : "";
+		}
+		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
+		sign = vals[0] < 0 ? "-" : "";
 		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
 		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return snprintf(buf, len, "%s%u.%09u", sign, abs(tmp0), abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
2.23.0

