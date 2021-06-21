Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316633AEB16
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jun 2021 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFUOXx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Jun 2021 10:23:53 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43648 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229789AbhFUOXw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Jun 2021 10:23:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7DF8E412C3;
        Mon, 21 Jun 2021 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1624285296; x=
        1626099697; bh=h8+eEPaoUxnAdB0gPVSo6u84hnAc7ViMaUL6pINX9nY=; b=u
        9RKXNVqb54ZEf5XQZkLok7uEIxFnfhD79L55wYWfU3+2bYbd6T8ggAtRJ5k2gmmU
        ophJPKql9m9UtGMwRYV9u9DB3HwPcZeGQino3GSEaO0sFVGPnh++X5eRzrAxCIKV
        IODmQtv0nf7huGavXdpm9vK5WlMfZvdkV5YUhWiwHY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X-3pUdky9wGY; Mon, 21 Jun 2021 17:21:36 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id F2F5341203;
        Mon, 21 Jun 2021 17:21:35 +0300 (MSK)
Received: from localhost.yadro.com (10.199.0.93) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 21
 Jun 2021 17:21:35 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 0/2] add periodic mode, threshold options
Date:   Mon, 21 Jun 2021 17:30:49 +0300
Message-ID: <20210621143051.200800-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.93]
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

Ivan Mikhaylov (2):
  iio: proximity: vcnl3020: add periodic mode
  iio: proximity: vcnl3020: add threshold options

 drivers/iio/proximity/vcnl3020.c | 306 ++++++++++++++++++++++++++++++-
 1 file changed, 304 insertions(+), 2 deletions(-)

-- 
2.31.1

