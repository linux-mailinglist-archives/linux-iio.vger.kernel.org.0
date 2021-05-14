Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6D380A31
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhENNLo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 09:11:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16352 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhENNLn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 09:11:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ED2taC015440;
        Fri, 14 May 2021 13:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=BWZS0HN8ia2EZ8/iDhv4qJtHdLFxZrWdNxtzGbJVoN0=;
 b=ocYbePh5J/X9c1hpPR3BUDrT+QM2TqhQy9lZYKDxqBNKca/MxMVEFdBlg8Sh6PLUMvLe
 8M+plEmYrliWXZM7T2rc2cuMEyjeewecvxE1Mqm8GCAderzdz+omUR5CV/qFBr76CxLP
 Qkt9CH+rCta59TQTymgER1T8se4U4GgpEQ6UKghmbqHoqx4whtR6GDBRe2ZuyfUH1Gb0
 /MVeMvT1egGXDSZ+p9orNLesSDds4yScw87JNeZ/EQr2NbGF/P5D77XO/FuPYFezYPmm
 z6xTmGQE7LXiySXikKRqTDOhR3jlUFQVE/wZrI0htFHqi+X5HUVPLkstDSIUux6yWodx Gg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqsrp8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:10:17 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14ED1DTI084169;
        Fri, 14 May 2021 13:10:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38gppe5jax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:10:16 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14ED40Aa113198;
        Fri, 14 May 2021 13:10:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 38gppe5j9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:10:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EDAEuv018893;
        Fri, 14 May 2021 13:10:14 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 06:10:13 -0700
Date:   Fri, 14 May 2021 16:10:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] iio: light: tsl2591: fix some signedness bugs
Message-ID: <YJ52r1XZ44myD9Xx@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: Sb-hFiORgf1OQUOz4XMQTOELAE__bnP3
X-Proofpoint-ORIG-GUID: Sb-hFiORgf1OQUOz4XMQTOELAE__bnP3
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These variables need to be int for the error handling to work.

Fixes: f053d4e748ce ("iio: light: Added AMS tsl2591 driver implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/light/tsl2591.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 2bdae388ff01..26e3cb6c4ff8 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -213,7 +213,7 @@ static int tsl2591_gain_to_multiplier(const u8 als_gain)
 	}
 }
 
-static u8 tsl2591_multiplier_to_gain(const u32 multiplier)
+static int tsl2591_multiplier_to_gain(const u32 multiplier)
 {
 	switch (multiplier) {
 	case TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER:
@@ -783,8 +783,8 @@ static int tsl2591_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct tsl2591_chip *chip = iio_priv(indio_dev);
-	u32 int_time;
-	u8 gain;
+	int int_time;
+	int gain;
 	int ret;
 
 	mutex_lock(&chip->als_mutex);
-- 
2.30.2

