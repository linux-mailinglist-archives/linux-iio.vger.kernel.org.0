Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E187E1C6556
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 03:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgEFBHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 May 2020 21:07:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53790 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728609AbgEFBHV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 May 2020 21:07:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C322D4C83F;
        Wed,  6 May 2020 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1588727237; x=
        1590541638; bh=7zdTSg/YpORI67pNtF1hXovvQa2Yrhy7TR7Vr3f2tMo=; b=N
        57NqQ5fjDkvU5M9t/H3CNmXKZatmtXRI1Vg5TYJKdP/yi2y0WATIvf5+DLeBOogj
        8FEduFzA7dnzohZtJKK0Q/3e5ieBGBoaiA4djhv6Wo5vwXy+YarXTf7NKDdSS/Zq
        p7+fF+3Di6EagBId4uZIeuV0O1jJpEAmv+7GcrQ0VY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a_XwDhOFpGWD; Wed,  6 May 2020 04:07:17 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2498F427B1;
        Wed,  6 May 2020 04:07:17 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.2.222) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 6 May 2020 04:07:18 +0300
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
Subject: [PATCH v12 0/2] iio: proximity: driver for vcnl3020
Date:   Wed, 6 May 2020 04:08:07 +0300
Message-ID: <20200506010809.6348-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.222]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add proximity sensor driver for Vishay vcnl3020. Only on-demand
measurement is supported for now.

Changes from v11:
   1. minor changes to yaml.

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
  dt-bindings: proximity: provide vcnl3020 device tree binding document
  iio: proximity: Add driver support for vcnl3020 proximity sensor

 .../iio/proximity/vishay,vcnl3020.yaml        |  65 +++++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vcnl3020.c              | 258 ++++++++++++++++++
 4 files changed, 335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
 create mode 100644 drivers/iio/proximity/vcnl3020.c

-- 
2.21.1

