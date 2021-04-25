Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB936A7A3
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhDYOAi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 10:00:38 -0400
Received: from smtpout1.mo3004.mail-out.ovh.net ([79.137.123.219]:46841 "EHLO
        smtpout1.mo3004.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhDYOAi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 10:00:38 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.156.177])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 51F2F23D517;
        Sun, 25 Apr 2021 13:59:57 +0000 (UTC)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 15:59:56 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 0/3] iio: sps30: add support for serial interface
Date:   Sun, 25 Apr 2021 15:55:43 +0200
Message-ID: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 8492944473393421335
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdduiedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdeggfekuddvkeehgeeggffhhfetkeeltedvkedvtdevuedtteeufeeuheeiteenucfkpheptddrtddrtddrtddpkeelrdejtddrvddvuddrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One can communicate with sensor either over i2c or serial interface.
This series add support for the latter. And in order to do that existing
codebase needs to be separated into core and interface specific
components.

Tomasz Duszynski (3):
  iio: sps30: separate core and interface specific code
  iio: sps30: add support for serial interface
  dt-bindings: iio: chemical: sps30: update binding with serial example

 .../iio/chemical/sensirion,sps30.yaml         |   7 +-
 MAINTAINERS                                   |   2 +
 drivers/iio/chemical/Kconfig                  |  23 +-
 drivers/iio/chemical/Makefile                 |   2 +
 drivers/iio/chemical/sps30.c                  | 270 ++---------
 drivers/iio/chemical/sps30.h                  |  73 +++
 drivers/iio/chemical/sps30_i2c.c              | 256 +++++++++++
 drivers/iio/chemical/sps30_serial.c           | 420 ++++++++++++++++++
 8 files changed, 829 insertions(+), 224 deletions(-)
 create mode 100644 drivers/iio/chemical/sps30.h
 create mode 100644 drivers/iio/chemical/sps30_i2c.c
 create mode 100644 drivers/iio/chemical/sps30_serial.c

--
2.31.1

