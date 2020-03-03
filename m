Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3481779C5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 16:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgCCPBh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 10:01:37 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgCCPBh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2020 10:01:37 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023EiDGa009513;
        Tue, 3 Mar 2020 16:01:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=sQZms2KpwGhICX1i5AR/ERDQJKt0Y33jSUSaeXNRL6M=;
 b=v8bvGCY9YKwall0neJq7k1xISp5SkrkCtnHTR2aC/i/w7p8AJ/yndaLObVLs0/4QsV+u
 Oqug72qYjFRwiMfnueoRHCP+7CLb2oOiNFCyB5tUYjRjZ00qukVzem/i1DY8sAlerHBy
 1MQuQ4I+BGvtkxotaZzpnmS9HNCZNBO7m/Jedzh9As7V5GAnnGkFDOD8p9FE9L26Wjde
 mJ6mp5sVxST7L9jBr8N6DN5ofndYNdy5ZU5UBEKW9JubyAFAh6fBXA7nt7YyrSt2DnUJ
 kLEljh259s9dPSjKgIL2Vfy+Nws9IB7K6nUcpxkxejd0mb6ytzsWUYL6AUJPgizbdGLa 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfea6twgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 16:01:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7354100039;
        Tue,  3 Mar 2020 16:01:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B01602B4226;
        Tue,  3 Mar 2020 16:01:10 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar 2020 16:01:10
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/2] iio: trigger: stm32-timer: add support for power management
Date:   Tue, 3 Mar 2020 15:59:43 +0100
Message-ID: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds power management support to stm32-timer-trigger driver,
it adds suspend/resume routines. A small precursor patch is used to rename
"enabled" flag.

Fabrice Gasnier (2):
  iio: trigger: stm32-timer: rename enabled flag
  iio: trigger: stm32-timer: add power management support

 drivers/iio/trigger/stm32-timer-trigger.c | 91 ++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 14 deletions(-)

-- 
2.7.4

