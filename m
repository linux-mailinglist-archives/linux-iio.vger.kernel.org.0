Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F022C66E20A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjAQPZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjAQPZT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 10:25:19 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4742BF7
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673969091;
  x=1705505091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qyYYLeCHOabhWScQQHcwzc/sWNDWqt3bRCboJMfXzA4=;
  b=WjuvmV0zlSFMUWnVqxa904TxFxnbMzLSxb6ZFDUPI19TxO6WY3Kn4Ckb
   FYK0XJ0U7VMmufB7TUVpPvtJ1WPvmA2ZtDYW6wEA3Lrw2RjytXLuBjDvd
   XlY9duzMEgVn9X7fwObO3SoT8h+4hLkpLGxX/pn85mAtbr1mD4MiX2CZ/
   p+c/TCVzCqjTVnBP/vBYonC/MnPWrPBorIxRk19OCsux+rRS9fYrFlJ0/
   2AzZoFDoqYZYmIuAz7WtoxW0n4Ml9fPUjU+09kMubMYIZEA1rheMND0K4
   pg0UQurVSdnHJq4XgoO5c3060QemTMt6z+ObZim+wz9Jjd6/W3EMdyiZq
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v4 0/3] iio: light: vcnl4000: Add vcnl4040 interrupt support
Date:   Tue, 17 Jan 2023 16:24:32 +0100
Message-ID: <20230117152435.3510319-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

I have made three patches to add support for proximity sensor
interrupts with the vcnl4040 sensor.

The first two patches are minor restructuring of the current setup for
interrupts since the probe function hardcodes it for vcnl4010 only.

The third patch adds support to configure proximity sensor interrupts
and threshold limits for vcnl4040.

Kind regards
Mårten Lindahl

Changes in v4:
 - Restore unnecessary line changes
 - Remove unnecessary typecast

Changes in v3:
 - Only register iio_trigger when there is an irq_thread function

Changes in v2:
 - Make restructure of functions for interrupts and triggered buffer
   in separate patch
 - Add check for buffer_setup_ops
 - Remove irq dependency for devm_iio_triggered_buffer_setup
 - Change size of register variable and document it
 - Use field definitions for read/write event_config

Mårten Lindahl (3):
  iio: light: vcnl4000: Prepare for more generic setup
  iio: light: vcnl4000: Make irq handling more generic
  iio: light: vcnl4000: Add interrupt support for vcnl4040

 drivers/iio/light/vcnl4000.c | 454 ++++++++++++++++++++++++-----------
 1 file changed, 315 insertions(+), 139 deletions(-)

-- 
2.30.2

