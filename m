Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F189119F96D
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgDFP60 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:58:26 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35897 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgDFP60 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 11:58:26 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B5283C0009;
        Mon,  6 Apr 2020 15:58:22 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 0/3] Introduce a counter inkernel API
Date:   Mon,  6 Apr 2020 17:58:03 +0200
Message-Id: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello everyone,

This series introduce a basic inkernel API for the counter subsystem and
add a new rotary encoder driver that use a counter interface instead of
the GPIO existing one.

See commit log in 0001-counter-add-an-inkernel-API.patch for further
details.

Kamel Bouhara (3):
  counter: add an inkernel API
  Input: rotary-encoder-counter: add DT bindings
  Input: add a rotary encoders based on counter devices

 .../input/rotary-encoder-counter.yaml         |  67 ++++++
 drivers/counter/counter.c                     | 213 ++++++++++++++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/rotary_encoder_counter.c   | 152 +++++++++++++
 include/linux/counter.h                       |  27 +++
 6 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder-counter.yaml
 create mode 100644 drivers/input/misc/rotary_encoder_counter.c

--
2.25.0

