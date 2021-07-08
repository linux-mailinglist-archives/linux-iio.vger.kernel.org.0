Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3B3BFA44
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jul 2021 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGHMe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 08:34:28 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:45750 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229659AbhGHMe2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Jul 2021 08:34:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 670E949DE8;
        Thu,  8 Jul 2021 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1625747504; x=
        1627561905; bh=6fUv+jaBrxHK3ZizhGPGmxbUkWBHq+ci1uqceWIlcSw=; b=A
        xqjzTTb96UaOkU+UQT9AXAWlE2A+4Jk7flG89DuqotAZ4uZEFZheWL2dkHxFAd+P
        p1Bn0drU3rmRaKsi9pU6X7gewoNL9+FOldsbPQkbSq095S8ABQkf2R6O80QtIFNI
        9pRwsIMIZxFCn1SOVY/JCYRBZ8qgXc/rzxl+al2MLg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XotWQuZy0AMt; Thu,  8 Jul 2021 15:31:44 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D7B77412D6;
        Thu,  8 Jul 2021 15:31:43 +0300 (MSK)
Received: from fedora.mshome.net (10.199.0.196) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 8 Jul
 2021 15:31:43 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v3 0/1] iio: vcnl3020: add periodic mode, threshold options
Date:   Thu, 8 Jul 2021 15:41:14 +0300
Message-ID: <20210708124115.558186-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.196]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add periodic mode enablement, high/low threshold options.

Changes from v1:
 1. Remove changes for hwmon driver and changes affecting
vcnl3020 data structure.
 2. Add enable/disable periodic mode functions.

Changes from v2:
 1. Minor fixes from Jonathan's comments.

Ivan Mikhaylov (1):
  iio: proximity: vcnl3020: add periodic mode

 drivers/iio/proximity/vcnl3020.c | 297 ++++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 2 deletions(-)

-- 
2.31.1

