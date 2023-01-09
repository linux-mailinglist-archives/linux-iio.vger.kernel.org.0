Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76032662583
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 13:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjAIM1j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 07:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjAIM1j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 07:27:39 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA01400A
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673267258;
  x=1704803258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JS6tr0jSwDO7z3s0nk1xXJZWGZz+oobnVhxx/p7NHR4=;
  b=KoRmeyfFQfwqdJheT81uZswW9qOqX5FBhBr2QlvyRwf5v7dGw/WLtgmp
   HmHbMNSEraTgatXommvORC6p7ciALjbC/vQn/DAzHm3RQnk7k/FSSuWkR
   bYlyt3lvoGqlOJYpRcyZDh+djeXYJIdHzPnXbaFNFn5vtk71Vhofuo+O+
   u47SoNzeUrbD40jHHE/qVeMvEDqEY7wUmbJyI6IdOC7pmCEiTdw2OGCYa
   OpEc4QC0LngBan0m9QkFr1AKr+vFc3qgd0xr0M95EO/nzskX6Ec7HWG4n
   XOBVBzeboYZgiIc3g0a5pdgT4ATYzLeD397cBXkzdkztGJwPW1WcTFwFJ
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2 0/3] iio: light: vcnl4000: Add vcnl4040 interrupt support
Date:   Mon, 9 Jan 2023 13:27:25 +0100
Message-ID: <20230109122728.118199-1-marten.lindahl@axis.com>
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

 drivers/iio/light/vcnl4000.c | 471 ++++++++++++++++++++++++-----------
 1 file changed, 324 insertions(+), 147 deletions(-)

-- 
2.30.2

