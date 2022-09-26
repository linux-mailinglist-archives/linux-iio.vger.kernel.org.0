Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA315E9D64
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiIZJWY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiIZJVz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 05:21:55 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20FA46DB4
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664183964;
  x=1695719964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LJnTC2hYAGei0x9TlUnj+fLysOeSDK9sfzvGdPF6NLk=;
  b=APSw3QpEotYeYJb7FwvdNP8e20GZA9S8u1ZOBUfASWyxvRm4nIw9aGvP
   +EY139SnnNQLjIpoZqsIwm5/kCmRwcGxVIrfeer9ahMHR1kjpuBmxsvKo
   PB5OS/OWDvPrvFlJyGbD8sIm+1wvBbR9vncvbnqr8diXHBMGSdHyNHHO1
   M2vIZ0kTNYGyIYezszKFjMpUj0mmVKIu4OFK+Ixxd2rFcOHvOUUP8ja9w
   tgULFQ8M/n2qOfgxTpHvEMgaIe0ZRx63+NEcKx+rJ55vCTgZQZTkJZYMu
   wbBboMWcaarCMq8t2YSEjf3CQVaKxK8/eOAL0gI0VdaI2xlNhdtOok0ZO
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 0/2] Add ps_it attributes for vcnl4040
Date:   Mon, 26 Sep 2022 11:18:58 +0200
Message-ID: <20220926091900.1724105-1-marten.lindahl@axis.com>
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

Currently there is no way for userspace to make any configuration of
the VCNL4040 sensors, but only the sensor readings are exported in
sysfs. To support configuration for proximity integration time value,
sysfs attributes for this needs to be exported.

To begin with the runtime power management turns both sensors (ALS, and
PS) on before reading the sensor register values and then switches
them off again. But when doing so it writes the whole register instead
of just switching the power on/off bit. This needs to be fixed in order
to make other persistent configurations.

Kind regards
Mårten Lindahl

Changes in v3:
 - Rename defines for ALS/PS shutdown bits
 - Add local variable for building register value

Changes in v2:
 - Removed unnecessary switch for chip id
 - Guard read/write sequence against potential race
 - Remove confusing boolean operation
 - Use bitmask macros instead of local field shifting
 - Use .read_avail callback instead of using IIO_CONST_ATTR
 - Skip [PATCH 2/3] iio: light: vcnl4000: Add enable attributes for vcnl4040

Mårten Lindahl (2):
  iio: light: vcnl4000: Preserve conf bits when toggle power
  iio: light: vcnl4000: Add ps_it attributes for vcnl4040

 drivers/iio/light/vcnl4000.c | 185 +++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 6 deletions(-)

-- 
2.30.2

