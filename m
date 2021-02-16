Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20A31CC5A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBPOry (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 09:47:54 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:36542 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230206AbhBPOrv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Feb 2021 09:47:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6054E4127E;
        Tue, 16 Feb 2021 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1613486828; x=
        1615301229; bh=nf2b9wfxjyOfai1zkXPhbl+RYtBYM2wtfQ24SUZRBGk=; b=o
        7s6wAi9wjlUxr4fRFWQtHTUW8jK8yvAXsR9HrOcCBJx+JipzFZP2HrdrnX+/6tE5
        AxM1CXHWCUNN+0USZXzV58QV5/1C5v2ZlEEvC/pcLCATMfe5XF8Vzg/xIDGUBvnj
        poagwlErhPjqIteJRbKr032fmpD9RV8+c2st5oAsUc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Om9qyQABM0Ye; Tue, 16 Feb 2021 17:47:08 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4DFD6412D1;
        Tue, 16 Feb 2021 17:47:08 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.0.29) by
 T-EXCH-03.corp.yadro.com (172.17.100.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 16 Feb 2021 17:47:08 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] add proximity rate option for vcnl3020
Date:   Tue, 16 Feb 2021 17:53:44 +0300
Message-ID: <20210216145346.18304-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.29]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the control of proximity rate from runtime and DTS for vcnl3020
proximity sensor.

Ivan Mikhaylov (2):
  iio: proximity: vcnl3020: add proximity rate
  dt-bindings: vcnl3020: add proximity rate in hz

 .../iio/proximity/vishay,vcnl3020.yaml        |   6 +
 drivers/iio/proximity/vcnl3020.c              | 123 +++++++++++++++++-
 2 files changed, 126 insertions(+), 3 deletions(-)

-- 
2.26.2

