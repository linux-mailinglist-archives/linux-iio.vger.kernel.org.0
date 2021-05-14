Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084A5380A34
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhENNMg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 09:12:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23292 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhENNMg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 09:12:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ED17JA018629;
        Fri, 14 May 2021 13:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=7fC04BucLpGRD/n2GA1XspszHQIl4ZHLmE65wctplAY=;
 b=Q8HL8oJDlLSH/LMF6fpUfBnDb2UpqrVz5qTgJrOQK7f0FHB9AXACy4Yl/C3r4iPFI1st
 DqmqznPjv8bnG7F60XUc6xJ21cxy8GyFWSbT8ll5/H5SpX4zIWb4SnQ/4dkyCWNVlX2x
 O6QS87ui3Wb0eBpaPabaSNuu/ssPZAUNhaOA/ZIDPx/8BPyAS7xp2CNb2L7gP9++hYN+
 U+z9g18cVX34o5RMXle7MMJTsuyEnDaKAZoAhIT+aDURnNmTsg5SKJQwgvgeMBc/9Qzu
 QabLzhPSsyZWEwjV9uZxR+kT2pebGi8Z0IbKJuEtxeFm/z4YTS5eCGsKGt0t/UdDECeC QQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gppjgp89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:11:10 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14EDB9kO188514;
        Fri, 14 May 2021 13:11:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38gppe5mqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:11:09 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EDB7oh187959;
        Fri, 14 May 2021 13:11:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38gppe5mgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:11:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14EDB2fJ015206;
        Fri, 14 May 2021 13:11:02 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 06:11:01 -0700
Date:   Fri, 14 May 2021 16:10:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] iio: light: tsl2591: delete a stray tab
Message-ID: <YJ523y0dhc1IwCOB@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ52r1XZ44myD9Xx@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: AKY68wcUczUoxFVjFD-8bC0o0aQH1_9J
X-Proofpoint-GUID: AKY68wcUczUoxFVjFD-8bC0o0aQH1_9J
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This return statement is indented one more tab than it should be.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/light/tsl2591.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 26e3cb6c4ff8..39e68d0c9d6a 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -451,7 +451,7 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 					    sizeof(als_data), als_data);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read data bytes");
-			return ret;
+		return ret;
 	}
 
 	als_ch0 = get_unaligned_le16(&als_data[0]);
-- 
2.30.2

