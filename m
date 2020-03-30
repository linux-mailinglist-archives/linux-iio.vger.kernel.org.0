Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C6197F95
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgC3P1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 11:27:12 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52330 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgC3P1M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Mar 2020 11:27:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DBF704126E;
        Mon, 30 Mar 2020 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1585582028; x=
        1587396429; bh=j4/XjXFKkk1FU9ylD8nIv+Ofp3lPFgY922qjOBiGNiM=; b=l
        1yQglxI49XhmiTFJ+UZPs1qITWjpXQaN5EglrfCZHjBrFubr0+OgvfmmpzwLLQwy
        8rdNKEbcZqc6Ivfj/s+3MZGs3dlu7sh74QinVQhuauONi06ZSikwyZfVZSZ36qZi
        wtU/14uh9IueInNKl2dT2Q8MR/5mA8/bWFg7KQFCCc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F6_OzbTblhik; Mon, 30 Mar 2020 18:27:08 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8F4AC41209;
        Mon, 30 Mar 2020 18:27:08 +0300 (MSK)
Received: from localhost.yadro.com (10.199.0.226) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 30
 Mar 2020 18:27:08 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 0/2] iio: proximity: driver for vcnl3020
Date:   Mon, 30 Mar 2020 18:27:09 +0300
Message-ID: <20200330152711.8769-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add proximity sensor driver for Vishay vcnl3020. Only on-demand
measurement is supported for now.

Changes from v4:
   1. add vdd-supply,vddio-supply,interrupts properties into yaml.
   2. led-current -> vishay,led-current-milliamp.
   3. add possible values enum list.
   4. add bulk_read for result hi/lo registers.
   5. add description of vcnl3020_data structure.
   6. vcnl3020 id table is removed.
   7. make "vishay,led-current-milliamp" optional in yaml and code.

Changes from v3:
   1. minor changes.
   2. add i2c block to fix dts section in yaml.

Changes from v2:
   1. using regmap_read_poll_timeout instead of do-while in measurement
      function.
   2. change struct i2client* in vcnl3020_data to struct dev*
   3. enable REGMAP_I2C in Kconfig

Changes from v1:
   1. using regmap interface instead of i2c_smbus_* calls.
   2. switch from probe to probe_new.
   3. s32/int32_t -> int

Ivan Mikhaylov (2):
  iio: proximity: provide device tree binding document
  iio: proximity: Add driver support for vcnl3020 proximity sensor

 .../bindings/iio/proximity/vcnl3020.yaml      |  65 +++++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vcnl3020.c              | 225 ++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
 create mode 100644 drivers/iio/proximity/vcnl3020.c

-- 
2.21.1

