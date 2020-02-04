Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E814715188C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 11:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDKLD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 05:11:03 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57940 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgBDKLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 05:11:01 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014A908D023221;
        Tue, 4 Feb 2020 11:10:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=bynwKHOvmYrMdBjWIN3mSQft3h1Fd9t3e5EyZkaHA9g=;
 b=jb6ZJy99dPXxMR+ZgY85UOP7tZ1hkEEGmJa+dqeER6ysYB89DgS7P1KsngOwjBqXeR8Q
 qBGTNSpTE107VY0DRI/TQgLa0RN5m53AFg8ckzb98qAY+DiY3+Rj+8ojoW1ICZAQ/Zdh
 PqHYXGh3je0EzRCa3qDtwuEQCyk6JgKOHacr47iYXbgMBTG/H/w1K0XL5m6j0qBvlZ0k
 y4fUojNS4A06PF4db/dRnVgFrv/5QbWaSUvPX2i55L+a2h0sjLtN9UE6WCfEJGNS0OJ2
 vfWEeKmxSUxUcOPMPfo8fPhkOo9CVgUXUemqs5Au3cYsbHpzVyKXVn6ebMra+RCrx37H xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xvyp606r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 11:10:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9C95910003A;
        Tue,  4 Feb 2020 11:10:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 884552AD9DC;
        Tue,  4 Feb 2020 11:10:32 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 11:10:32
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <olivier.moysan@st.com>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/4] iio: adc: stm32-dfsdm: use resolution define
Date:   Tue, 4 Feb 2020 11:10:07 +0100
Message-ID: <20200204101008.11411-4-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204101008.11411-1-olivier.moysan@st.com>
References: <20200204101008.11411-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_02:2020-02-04,2020-02-04 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use resolution define instead of hard coded value.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 2aad2cda6943..07b9dfdf8e76 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1440,7 +1440,7 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
 		ch->scan_type.shift = 8;
 	}
 	ch->scan_type.sign = 's';
-	ch->scan_type.realbits = 24;
+	ch->scan_type.realbits = DFSDM_DATA_RES;
 	ch->scan_type.storagebits = 32;
 
 	return stm32_dfsdm_chan_configure(adc->dfsdm,
-- 
2.17.1

