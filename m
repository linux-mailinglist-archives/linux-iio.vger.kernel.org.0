Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ECE65288E
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 22:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiLTVuJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 16:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiLTVuH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 16:50:07 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8751F620
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1671573006;
  x=1703109006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GdCkgA34tU3NNJ+2t88iBC9NN/IUHwTyy6jTCjnQhLc=;
  b=mN4n4QWB3bHY6+EMgBbd4LTDDsB6SyqjlrZu1Ke6UpwqKmDOR/rb1qhT
   fjHIBqtZSLSOQ0sVUXEb/vWDzUspJbjPDXB/4LOOMWDIaO8PS70ygbtpl
   gf2DP/izBgStLc74Few1l7+KgYaF8PPjDfvoO1ZIoWnKOHDlKrgCLzVld
   dQMkXc+KsWrxDYIAdH3RNfJxAyYNq/cuB/40XqsBLHLCpvyaM+DvXu6gz
   OmSr2b78i+rkkRwONVSTghQHWBXdjWukJo/fPV+ECGok82e2S8W+iPI2i
   43dv4O0DeMIW5wbBz6BAuZQHaoaNcImYqLnmStoIWRV9MJnTagd+eo3lU
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 0/2] iio: light: vcnl4000: Add vcnl4040 interrupt support
Date:   Tue, 20 Dec 2022 22:49:57 +0100
Message-ID: <20221220214959.2289330-1-marten.lindahl@axis.com>
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

I'm sending two patches to add support for proximity sensor
interrupts with the vcnl4040 sensor.

The first patch is a minor restructuring of the current setup for
interrupts since the probe function hardcodes it for vcnl4010 only.

The second patch adds support to configure proximity sensor
interrupts and threshold limits for vcnl4040.

Kind regards
Mårten Lindahl

Mårten Lindahl (2):
  iio: light: vcnl4000: Make irq handling more generic
  iio: light: vcnl4000: Add interrupt support for vcnl4040

 drivers/iio/light/vcnl4000.c | 229 ++++++++++++++++++++++++++++++-----
 1 file changed, 201 insertions(+), 28 deletions(-)

-- 
2.30.2

