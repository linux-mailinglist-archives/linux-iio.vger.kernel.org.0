Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D460D7D041
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfGaVtU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:49:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1135 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727865AbfGaVtU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:49:20 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VLlQGA017005;
        Wed, 31 Jul 2019 23:49:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=9e1wDfgu6MVs2Ag65EQKB+XF5Zgr+4tL+Jd7uWYnTkk=;
 b=hHPRgHJu1/J2+OUFxkTMNRxMy8Eet+kQXpqna8Rn54ptuO03f7Ei+09Z3MhiqHAN3oo/
 iPAdmGYAGrngARKhM2E0QXP6sgLaLVbkZKFYdj5wKNJ9C0B/gl4xsmUk/oBajt8ad5wr
 AV68FJtLix5oIFvGqvPrQDZWKDWyQKhPw34gwqAw8rtjbvqr6oVcgEiaoWcYmNBpyggj
 TBGmZPufQiQiKwZxFpf8IIrJucT/ZOpXH37ogQGpZ3XxpYZ+Hq5hOGBzKTUDRQLbAE6G
 ip19GltxdzMXlFhkU4XaR8ymyi2zSpAoP0dmeHs8qHusYFYHZt/KCAAP2SKp6nAPmhHY Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0bra6kn0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 23:49:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C11BF34;
        Wed, 31 Jul 2019 21:49:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B54A1777E3;
        Wed, 31 Jul 2019 23:49:12 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul 2019 23:49:12
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>,
        <jic23@kernel.org>
CC:     Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 0/4] preenable/postenable/predisable fixup for ST drivers
Date:   Wed, 31 Jul 2019 14:48:56 -0700
Message-ID: <20190731214900.15380-1-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_11:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v2 changes:
This second version is necessary in order to fix the possible failure of
set_enable (last function of postenable).

This series is meant to fix for good the functions listed in subject.
In a way, is continuing the task started by Alexandru for accel.

Denis Ciocca (4):
  iio:accel: preenable/postenable/predisable fixup for ST accel buffer
  iio:gyro: preenable/postenable/predisable fixup for ST gyro buffer
  iio:magn: preenable/postenable/predisable fixup for ST magn buffer
  iio:pressure: preenable/postenable/predisable fixup for ST press
    buffer

 drivers/iio/accel/st_accel_buffer.c       | 45 +++++++++------------
 drivers/iio/gyro/st_gyro_buffer.c         | 49 +++++++++++------------
 drivers/iio/magnetometer/st_magn_buffer.c | 30 +++++++-------
 drivers/iio/pressure/st_pressure_buffer.c | 38 ++++++++----------
 4 files changed, 77 insertions(+), 85 deletions(-)

-- 
2.22.0

