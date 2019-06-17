Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5207F49614
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 01:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfFQXud (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 19:50:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727821AbfFQXud (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 19:50:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HNkde6030437;
        Tue, 18 Jun 2019 01:50:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=STMicroelectronics;
 bh=7BYuCmqFsjN4/SGOI0yJD9jgeKOgv7Z60WwKmMaj0cM=;
 b=cIwyV0aKnw4n/lj2PWi1yUl9kAk2Ns4BuatghTkxE++WtaOcWcv8S0Ygi1FJOIdtobyQ
 cxb1IlqX9u3Bor7esEEJ+3m15V1sl3IWJLqT6z3ZMNBfJhqTjfGYaSZkQRkpbFMHmgo5
 TScEUxa7byAL1H89FhTFKFzweciXK77JIggIfheE0iyDCVj2rx6WhDM98nbadsCJ7Rj4
 aXOJPubl77sXFdoPm6R54ObPaOOGIW7sfkUMkX6OO8DaRarzeLbQ8PtNfJFTNPyrZcCn
 un4uJe1dgXXsL7usb36gNkZy1w3+rAxRWW4RpRd4hlnlDxUe0kYHDZcl1av4C32zcyJS hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t68n3k381-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 01:50:28 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 40BE831;
        Mon, 17 Jun 2019 23:50:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node1.st.com [10.75.127.4])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BDA8127A;
        Mon, 17 Jun 2019 23:50:28 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG2NODE1.st.com (10.75.127.4)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Jun 2019 01:50:27
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <denis.ciocca@st.com>, <lorenzo@kernel.org>
Subject: [PATCH 7/7] iio:common: make st_sensors_write_data_with_mask() inline
Date:   Mon, 17 Jun 2019 16:49:43 -0700
Message-ID: <20190617234943.10669-8-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617234943.10669-1-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG2NODE1.st.com
 (10.75.127.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of changing all the references in the driver, let's make the
function inline.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 3ddab3ca0a4b..fe67349309de 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -26,7 +26,7 @@ static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
 	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
 }
 
-int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
+inline int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-- 
2.22.0

