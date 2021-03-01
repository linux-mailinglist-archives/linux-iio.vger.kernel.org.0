Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C23280FA
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 15:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhCAOee (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 09:34:34 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11387 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbhCAOeb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 09:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614609271; x=1646145271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lmX5uso30/IFeq9qj4E8UhF0kNQHgFQ4na7mXouY9G8=;
  b=bCX7pBaZxEPmDO0WDdGW5MtlZC3LzGak5S9tI0Y1FxwzqMs2VRf1kx8E
   27O3H65GLUhTvSnBk+U1riTtH4IBsIrO3MxKdl0i7a6E0WcXAdUxeywGK
   P/YV0/1C9J26aW9WYeTar2jwUL8PuzvlUgunTFuKDNm1u2di0YsG3uTLm
   XeMpOpK2rUBUXKxChIBqTbJgxPnkB6/50O8nU8ShFTJ3I5KGXXmSa9PIO
   gUry5ZiubRM9uBh1MAaSswE6e81pzP56i2nCORxjnfSa/PpUAp9adr+y7
   jLkGd8J59g6TfNkP0Xb3hbHcPmUv3JYzRjXmBciIx20+X7kphrEdTKzR5
   w==;
IronPort-SDR: SUkXuwPyGIqWBVk58mvqCnLqM/plEdZNTsQd2l6esERSnSgBpKdan09r/f3nziXMLmxaLf9BD6
 2xIlSWfzbufa3Or6gd5hRT2ktd0+kUVZPbIB91J8/P34y0/ix5A9b5+Bnb8+iyeTit8MK9FYw2
 3hRBIjdBNlQLs1+9itlNn0C/e1Ytz6jtEwwdfwoupDEzYfqiXilX3U3HrHMPUqsVpKbij6hOCA
 twOVVNaOlj9XPU9lYC3+w7eZfCzVNYE3NLgz+RlSYRdIIY8hAAORICLwQFiNoAGl+VMrT+bV4l
 PwQ=
X-IronPort-AV: E=Sophos;i="5.81,215,1610434800"; 
   d="scan'208";a="45819020"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2021 07:33:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 1 Mar 2021 07:33:14 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 1 Mar 2021 07:33:12 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 0/4] iio: adc: at91-sama5d2: add support for sama7g5
Date:   Mon, 1 Mar 2021 16:32:52 +0200
Message-ID: <20210301143256.16502-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan, all,

This series adds support for sama7g5.
The last patch (4/4) adds the support.

The sama7g5 is slightly different from sama5d2, but has the same basic
operations. The register map is a bit different, so, I added some primitives
to differentiate between the two classes of hardware blocks (sama5d2-sam9x60
and sama7g5).

Sama7g5 has 16 channels ADC, no resistive touch, and extra features
(FIFOs, better oversampling , not implemented yet).

I had to chop through the driver to add support for sama7g5, so, let me
know what you think, if something would need changing.

Thanks,
Eugen

Eugen Hristev (4):
  dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
  iio: adc: at91-sama5d2: initialize hardware after clock is started
  iio: adc: at91-sama5d2: remove unused definition
  iio: adc: at91-sama5d2: add support for sama7g5 device

 .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c            | 293 ++++++++++++++----
 2 files changed, 237 insertions(+), 57 deletions(-)

-- 
2.25.1

