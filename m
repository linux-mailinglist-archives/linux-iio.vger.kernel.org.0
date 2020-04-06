Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2620B19F8AB
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgDFPS1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:18:27 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:44520 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728667AbgDFPS1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 11:18:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 22A19412DD;
        Mon,  6 Apr 2020 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1586186304; x=
        1588000705; bh=b78VX+KfoZ1OBoOyTTeff1xSZodd76U9hcyDMh3BFsI=; b=T
        INLtQtcDmIRWLdUkU2ffIWS8RdYPPWlLC+fdP3yrR6/pmJG04OaZzL+sRNPZfyHo
        CsLD8miVI3b2u8Vjfj6OgUAA9m/AiU23NU4Rb8CmfHfbY/BSGRJgyaa6JUlSnQo4
        YCKYYJFsPejtOre4UfOTA3bAREBjMXY3Np4FBsCT2s=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Huy4NrZx28lO; Mon,  6 Apr 2020 18:18:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AA3E84125E;
        Mon,  6 Apr 2020 18:18:23 +0300 (MSK)
Received: from localhost.yadro.com (10.199.2.226) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 6 Apr
 2020 18:18:24 +0300
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
Subject: [PATCH v7 0/2] iio: proximity: driver for vcnl3020
Date:   Mon, 6 Apr 2020 18:18:37 +0300
Message-ID: <20200406151839.13572-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add proximity sensor driver for Vishay vcnl3020. Only on-demand
measurement is supported for now.

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

 .../bindings/iio/proximity/vcnl3020.yaml      |  65 +++++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/vcnl3020.c              | 234 ++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
 create mode 100644 drivers/iio/proximity/vcnl3020.c

-- 
2.21.1

