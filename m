Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748AF36FD7D
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhD3PRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 11:17:00 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55678 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229818AbhD3PQy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Apr 2021 11:16:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C69ED4149F;
        Fri, 30 Apr 2021 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1619795763; x=
        1621610164; bh=/rXJip+F0IvVCEdh2B4yy/908Dqa2MKfXinBs0lFWDg=; b=H
        761oJZhH/NPO+eYlg0LvpUJFwfNDY5xmn6kdEKsRqQStGlPTbe4RvGiYjbPBwA7u
        QURTMMJNVVmZmYlOPiaKeDSAtUhRnbYXwRigG8Zz05SQxZrwaMKk8K/yVOolHgZz
        a3RxvR6DYyYTXVRFkaTb7lLse6EINnCiU86u2oZYY4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PQ2urrZPNQSa; Fri, 30 Apr 2021 18:16:03 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 312294148B;
        Fri, 30 Apr 2021 18:16:03 +0300 (MSK)
Received: from localhost.yadro.com (10.199.0.97) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 30
 Apr 2021 18:16:03 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH 0/4] add periodic mode, threshold options and hwmon
Date:   Fri, 30 Apr 2021 18:24:15 +0300
Message-ID: <20210430152419.261757-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.97]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add periodic mode enablement, high/low threshold options. Remove mutex
from vcnl3020_data structure, change mutex_lock/unlock's appropriately on
iio_device_claim/release_direct_mode.

Add hwmon driver as intrusion sensor which provides information about
any triggers within thresholds, works in periodic mode of proximity
sensor.

Ivan Mikhaylov (4):
  iio: proximity: vcnl3020: add periodic mode
  iio: proximity: vcnl3020: add threshold options
  iio: proximity: vncl3020: remove mutex from vcnl3020_data
  hwmon: vcnl3020: add hwmon driver for intrusion sensor

 drivers/hwmon/Kconfig                  |   7 +
 drivers/hwmon/Makefile                 |   1 +
 drivers/hwmon/vcnl3020-hwmon.c         |  57 +++++
 drivers/iio/proximity/vcnl3020.c       | 335 ++++++++++++++++++++++---
 include/linux/iio/proximity/vcnl3020.h |  26 ++
 5 files changed, 395 insertions(+), 31 deletions(-)
 create mode 100644 drivers/hwmon/vcnl3020-hwmon.c
 create mode 100644 include/linux/iio/proximity/vcnl3020.h

-- 
2.26.3

