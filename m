Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B268F322EDF
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 17:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhBWQhT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 11:37:19 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60908 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233312AbhBWQhS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 11:37:18 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NGTeqS004231;
        Tue, 23 Feb 2021 11:36:34 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36tw5bk6t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 11:36:34 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11NGaXZN003439
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Feb 2021 11:36:33 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 23 Feb 2021 08:36:31 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 23 Feb 2021 08:36:31 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Tue, 23 Feb 2021 08:36:31 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11NGaTkp030454;
        Tue, 23 Feb 2021 11:36:30 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v3 0/1] iio: adc: ad7124: allow more than 8 channels
Date:   Tue, 23 Feb 2021 18:44:03 +0200
Message-ID: <20210223164404.93540-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=864 phishscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230138
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Currently AD7124-8 driver cannot use more than 8 IIO channels
because it was assigning the channel configurations bijectively
to channels specified in the device-tree. This is not possible
to do when using more than 8 channels as AD7124-8 has only 8
configuration registers.

All configurations are marked as live if they are
programmed on the device. Any change that happens from
userspace (sampling rate, filters etc.) will invalidate
them.

To allow the user to use all channels at once the driver
will keep in memory configurations for all channels but
will program only 8 of them at a time on the device.

If multiple channels have the same configuration, only
one configuration register will be used.

If there are more configurations needed than available registers
only the last 8 used configurations will be allowed to exist
on the device in a LRU fashion. (in case of raw reads).

If a read is requested on a channel whose configuration
is not programmed:
- check if there are similar configurations already programmed
	if yes: - point channel to that config
	if no:  - check if there are empty config slots
			- if yes: write config, push into queue of LRU configs
			- if no: pop one config, get it's config slot nr,
			write new config on the old slot, push new config
			in queue of LRU configs.

Alexandru Tachici (1):
  iio: adc: ad7124: allow more than 8 channels

 drivers/iio/adc/ad7124.c | 461 ++++++++++++++++++++++++++-------------
 1 file changed, 308 insertions(+), 153 deletions(-)

-- 
2.20.1

