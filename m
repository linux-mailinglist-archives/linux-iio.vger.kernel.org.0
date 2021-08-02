Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310BE3DD664
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhHBNE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 09:04:56 -0400
Received: from smtpcmd14162.aruba.it ([62.149.156.162]:48394 "EHLO
        smtpcmd14162.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhHBNE4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 09:04:56 -0400
Received: from polimar.homenet.telecomitalia.it ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id AXcbmfeFVrIRlAXcbmwk1c; Mon, 02 Aug 2021 15:04:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1627909485; bh=rVYeygPWBpTGXWQEM2zCVP/iMpQi/gfSRvb+s6lHMVs=;
        h=From:To:Subject:Date:MIME-Version;
        b=eHu/4bLtlcy1ByCiTKzCq/vCGdD/bDjojM16h67ES2HVPZypyVqBeNAxX6Q+SsQW6
         WjJ9bYd6fGcIKA2MAICJvid70CQMoUucya52GkJ4NdxEf8YJvSt3rsFi35zCtMLBKK
         iq9bjJ8+PikK8JHb3GDaL49+EhOJpYJgIyhOjLu6YXqp9oINacMj8Ftnr4gfMv4AWw
         2BEjAMldz0Ae2W2Q293Oe1+0UeJOkz/6Skcbah6dyvtEqrlCLH/25vC19PeenInFO4
         KTJkwf5+xBGfqBb2IEVYjZjBWf5YhdYsoa7uQF0TAgYwhiLG12GArHlliPGOIe5Sz+
         KGfpA6p0KnuLg==
From:   Rodolfo Giometti <giometti@enneenne.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH 0/1] V2 driver for Texas Instruments TLA2528
Date:   Mon,  2 Aug 2021 15:04:40 +0200
Message-Id: <20210802130441.972978-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI1ZUdockVGYDg5noHNJHZ7m02UhC5DGZyU73oJ08LXvRv+J6YOUWVM04BEFLfXpi4TiSASM3jWVQBAKt/aY9bqHT3i4Xvdch27BqefGD3oH/yy9joHu
 UDiBfqAI5VWM9k7k9fTd9S839DScX3YUpMBYiXagndfiMhn77k9EUjWmBvg28e4Dng8bxyj8cmDFtxIiZN/fC1gtN371plEZvmrE/Omvhfbap6SXaW2AI98m
 WGQYi8Ao6lbEC1jfBJ/5Bg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changelog
=========

Version 1 -> 2
--------------

* `drivers` prefix in the patch title removed

* split return argument in i2c_smbus_read_sample()

* dev.parent assignment removed in tla2528_probe()

* minor code alignment fix up

* of_match_ptr() removed

* comma in null-terminator removed

Rodolfo Giometti (1):
  iio adc: add driver for Texas Instruments TLA2528 adc

 drivers/iio/adc/Kconfig      |  10 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-tla2528.c | 247 +++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/iio/adc/ti-tla2528.c

-- 
2.25.1

