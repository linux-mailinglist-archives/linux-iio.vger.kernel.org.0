Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC16D1B4978
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgDVQEl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 12:04:41 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:41060 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbgDVQEk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 513774A0B1;
        Wed, 22 Apr 2020 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1587571476; x=
        1589385877; bh=W4pQ0bQ3n4HftuLMqqgOc5FvTVWIzKSRMrum7lcifPE=; b=f
        wwOD9AgRXi6CTVVB/7wjmU0X2uaKxPO43MnAkChYepOFzBqgcE28kU8PQGigtJjm
        qXyd8Y527ALH/XrSPvzxSv8fVXJ8/0wbxAUzXFiaJ2OkX9nAr0DT5ZMhwaWQKHXd
        xHRNsfQVKDaTgTdR9Y+mK4RtkU3HJMAfsuQV+RlxiE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Hmg7IDDoe9p; Wed, 22 Apr 2020 19:04:36 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id F119749FBE;
        Wed, 22 Apr 2020 19:04:35 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.3.42) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 22 Apr 2020 19:04:36 +0300
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
Subject: [PATCH v11 0/2] iio: proximity: driver for vcnl3020
Date:   Wed, 22 Apr 2020 19:05:07 +0300
Message-ID: <20200422160509.7117-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.3.42]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add proximity sensor driver for Vishay vcnl3020. Only on-demand
measurement is supported for now.

Changes from v10:
   1. add vcnl3020_property struct for optional properties.

Changes from v9:
   1. minor changes.
   2. pass microamps from dts, not register value.

Changes from v8:
   1. add vcnl3020 prefix into get_and_apply_property function.
   2. add bsd license into yaml.
   3. vishay,led-current-milliamp -> vishay,led-current-microamp.
   4. add default value into vishay,led-current-microamp and change
      register values into microamps.

Changes from v7:
   1. forgot to add Reviewed-by tag.

Changes from v6:
   1. minor changes
     1.1 remove VCNL_DRV_NAME
     1.2 add braces in get_and_apply_property

Changes from v5:
   1. add get_and_apply_property function for optional parameters.
   2. minor changes.

Changes from v4:
   1. add vdd-supply,vddio-supply,interrupts properties into yaml.
   2. led-current -> vishay,led-current-milliamp in yaml.
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

 .../bindings/iio/proximity/vcnl3020.yaml      |  64 +++++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vcnl3020.c              | 258 ++++++++++++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
 create mode 100644 drivers/iio/proximity/vcnl3020.c

-- 
2.21.1

