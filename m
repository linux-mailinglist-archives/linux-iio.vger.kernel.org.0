Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708BD3D26B7
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jul 2021 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhGVOyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Jul 2021 10:54:06 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51578 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232585AbhGVOyG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Jul 2021 10:54:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3317549E32;
        Thu, 22 Jul 2021 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1626968079; x=
        1628782480; bh=s32AEQlzcq96QVBl6KqGeatxYxM+EpyOkVvpXicGTGw=; b=S
        5VFbELLDElKB6oeeXiFkYcTYUym6er+xOiSt4LBIP5Fi+mgiuw7fRnluMFOXQibI
        4gaJarec/Pbg16pzzDXN2Pe10dzoD9VYU3E6G5WEXecYwxUfWiT5ukgRwcbK/Wng
        oUQpiF/Bwo5fm/cBn5Fo1UlZi+e9SZmcvrVulQGYjQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fuq3MT0BAKQT; Thu, 22 Jul 2021 18:34:39 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 769A549E28;
        Thu, 22 Jul 2021 18:34:36 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.0.147) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 22 Jul 2021 18:34:35 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v5 0/3] iio: vcnl3020: add periodic mode, threshold options
Date:   Thu, 22 Jul 2021 18:44:17 +0300
Message-ID: <20210722154420.915082-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.147]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
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

Changes from v3:
 1. add DMA safe buffer in vcnl3020_data and use it on bulk_read/write
    calls
 2. put vcnl3020_is_in_periodic_mode in vcnl3020_measure_proximity and
    vcnl3020_write_proxy_samp_freq
 3. add mutex instead of iio_claim in vcnl3020_write_proxy_samp_freq
 4. out_mutex -> err_unlock

Changes from v4:
 1. split into 3 patches - DMA safe buffer, periodic mode, change
    iio_claim/release on mutex.
 2. add dev_err for regmap_read/write

Ivan Mikhaylov (3):
  iio: proximity: vcnl3020: add DMA safe buffer
  iio: proximity: vcnl3020: add periodic mode
  iio: proximity: vcnl3020: remove iio_claim/release_direct

 drivers/iio/proximity/vcnl3020.c | 354 +++++++++++++++++++++++++++++--
 1 file changed, 338 insertions(+), 16 deletions(-)

-- 
2.31.1

