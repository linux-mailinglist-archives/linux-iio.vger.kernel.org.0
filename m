Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F01664223
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jan 2023 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjAJNoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Jan 2023 08:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjAJNnt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2023 08:43:49 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4248BF0A
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2023 05:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358214;
  x=1704894214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jzvwhyuCLO9TRTk+5hfSpoFGHFJcj3L4i4+BB1up7tU=;
  b=F+iUvhVk2TGvgmwTjDBpWeuhmkq79jxN6VTLtB11sqrlBmiwt3G+7g6T
   SK92MgLLoNV/8ERnXoI8rFzjZKQJQ8OQ0lEliwZvLebWh8z/d7tR1iqvi
   AuuESTtToKKHUvFHXBSEqGY4jqTaVw2xrPdUrPgUu8jgTeKrweMGmr75V
   aibw7W9EdBYaXQZ+OaqanOqICiGIFi7vKyuZzY1nHRKCp2Jt7xFmtb/x4
   oYc2WbpdEQG0xwHwwlE2e67rZHZdruoiWpVWhGrKjsdE7HWKFzdpJl7Fb
   fdD9QbhsdkWd1YvxPH669UMX5g4NHtZ87X2IhnSvbpJsxZP/1eaDKJ2VJ
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 0/3] iio: light: vcnl4000: Add vcnl4040 interrupt support
Date:   Tue, 10 Jan 2023 14:43:20 +0100
Message-ID: <20230110134323.543123-1-marten.lindahl@axis.com>
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

 drivers/iio/light/vcnl4000.c | 479 ++++++++++++++++++++++++-----------
 1 file changed, 328 insertions(+), 151 deletions(-)

-- 
2.30.2

