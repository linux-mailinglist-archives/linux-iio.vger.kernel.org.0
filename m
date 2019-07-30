Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF679D39
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 02:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfG3ALJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 20:11:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22560 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728338AbfG3ALJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 20:11:09 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U06xg6013736;
        Tue, 30 Jul 2019 02:10:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=qwzdvfQWVrVLcFFZUhLpzIf/+n8vROgvrZ/Em9IAqwI=;
 b=VlmOp8JS7hI2nzIekJ8LZj/Ghw8FcHj0jEkr/QKK6fn4itO/3ScSvNeb6ysGhGzQGZzj
 KTf2S8NL/ACwodxfG5gp/EG7eodZ1aWWVkBBtdpFSBFDLjw6atyU1KHV9wv2VUueptFl
 8chmKUyoQFh7ZfDXf73a4HuGp6VwqG+9MnSG6Dfb0rMtF1U4SKlC+1MxxdHrUKQQh4gO
 e15Yl47hkO2BUg7dbwEoiHHJgka+COMJBkIGB+2JbMHrXnWjLorMY3sngCbdlzrhzObp
 Eh4H5chQjxhNA+flga2QX2qBt62Qd8SrJhftXy6pjgJeA3oLnRicTSp+6W0CG/iXspyC Bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0ccwf2mk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 02:10:59 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96F9D31;
        Tue, 30 Jul 2019 00:10:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76A6A260C;
        Tue, 30 Jul 2019 00:10:58 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jul 2019 02:10:57
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <alexandru.ardelean@analog.com>, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 0/4] preenable/postenable/predisable fixup for ST drivers
Date:   Mon, 29 Jul 2019 17:03:01 -0700
Message-ID: <20190730000305.30958-1-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_12:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series is meant to fix for good the functions listed in subject.
In a way, is continuing the task started by Alexandru for accel.


Denis Ciocca (4):
  iio:accel: preenable/postenable/predisable fixup for ST accel buffer
  iio:gyro: preenable/postenable/predisable fixup for ST gyro buffer
  iio:magn: preenable/postenable/predisable fixup for ST magn buffer
  iio:pressure: preenable/postenable/predisable fixup for ST press
    buffer

 drivers/iio/accel/st_accel_buffer.c       | 37 +++++++------------
 drivers/iio/gyro/st_gyro_buffer.c         | 45 ++++++++++-------------
 drivers/iio/magnetometer/st_magn_buffer.c | 22 +++++------
 drivers/iio/pressure/st_pressure_buffer.c | 32 ++++++----------
 4 files changed, 52 insertions(+), 84 deletions(-)

-- 
2.22.0

