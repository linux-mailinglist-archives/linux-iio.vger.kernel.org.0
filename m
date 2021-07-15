Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846AF3C9EC9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhGOMkr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 08:40:47 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58718 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhGOMkq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 08:40:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 519DD467A9;
        Thu, 15 Jul 2021 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1626352671; x=
        1628167072; bh=W1Hm4aHneE27psg+Tpvs/oT0B3tKmnEcpqmN8R+kTVM=; b=G
        iItvrTwH1fk2yjAMwnifHZz0EEHk2UbrjyTepqSpiSZTOsLDuEzzuh8AQjFrqZqy
        YENY7DQt0qk7VUjDicbpTysJQNJ0YElIleYhlP+yUcunCUrEftEcRnaTKi4eG7xe
        m3uXE9XqjMoNuwAcLbXP3sViX7Br4qmQDONo9klFNQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aGjoDyGZpCjj; Thu, 15 Jul 2021 15:37:51 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8A4F941268;
        Thu, 15 Jul 2021 15:37:50 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.1.7) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 15
 Jul 2021 15:37:50 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v4 0/1] iio: vcnl3020: add periodic mode, threshold options
Date:   Thu, 15 Jul 2021 15:47:27 +0300
Message-ID: <20210715124728.838455-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.1.7]
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

Changes from v3:
 1. add DMA safe buffer in vcnl3020_data and use it on bulk_read/write
    calls
 2. put vcnl3020_is_in_periodic_mode in vcnl3020_measure_proximity and
    vcnl3020_write_proxy_samp_freq
 3. add mutex instead of iio_claim in vcnl3020_write_proxy_samp_freq
 4. out_mutex -> err_unlock

Ivan Mikhaylov (1):
  iio: proximity: vcnl3020: add periodic mode

 drivers/iio/proximity/vcnl3020.c | 328 +++++++++++++++++++++++++++++--
 1 file changed, 313 insertions(+), 15 deletions(-)

-- 
2.31.1

