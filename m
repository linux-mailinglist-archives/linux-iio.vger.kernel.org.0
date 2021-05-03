Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5437116A
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 08:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhECGFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 02:05:31 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:50625 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhECGFb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 02:05:31 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.129])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 0D5A0A3C2AF5;
        Mon,  3 May 2021 08:04:37 +0200 (CEST)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 3 May 2021
 08:04:36 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v3 0/3] iio: sps30: add support for serial interface
Date:   Mon, 3 May 2021 08:00:11 +0200
Message-ID: <20210503060014.7632-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10553341304026717207
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeffedgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdeggfekuddvkeehgeeggffhhfetkeeltedvkedvtdevuedtteeufeeuheeiteenucfkpheptddrtddrtddrtddpkeelrdejtddrvddvuddrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One can communicate with sensor either over i2c or serial interface.
This series add support for the latter. And in order to do that existing
codebase needs to be separated into core and interface specific
components.

v3:
- add i2c device matching based on id table
- constify structure
- rephrase comment regarding reading serial number
- check serial number length

v2:
- simplify Kconfig by hiding core component selection
- export symbols as GPL compatible
- drop excessive ops wrappers
- rework ops to use __be32
- rework polling for measurements, sensor produces measurements within
  1s so instead of polling just wait 1s
- simplify frame ready condition (serial)
- don't mix char with unsigned version
- calculate checksum during frame validation (serial)
- uncomment return status in frame validation (serial)
- pass part name to probe instead of KBUILD_MODNAME

Tomasz Duszynski (3):
  iio: sps30: separate core and interface specific code
  iio: sps30: add support for serial interface
  dt-bindings: iio: chemical: sps30: update binding with serial example

 .../iio/chemical/sensirion,sps30.yaml         |   7 +-
 MAINTAINERS                                   |   2 +
 drivers/iio/chemical/Kconfig                  |  27 +-
 drivers/iio/chemical/Makefile                 |   2 +
 drivers/iio/chemical/sps30.c                  | 269 ++---------
 drivers/iio/chemical/sps30.h                  |  35 ++
 drivers/iio/chemical/sps30_i2c.c              | 258 +++++++++++
 drivers/iio/chemical/sps30_serial.c           | 431 ++++++++++++++++++
 8 files changed, 804 insertions(+), 227 deletions(-)
 create mode 100644 drivers/iio/chemical/sps30.h
 create mode 100644 drivers/iio/chemical/sps30_i2c.c
 create mode 100644 drivers/iio/chemical/sps30_serial.c

--
2.31.1

