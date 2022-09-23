Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C015E79CE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIWLku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Sep 2022 07:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIWLkq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2022 07:40:46 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE601162CB
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2022 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663933238;
  x=1695469238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YWWRTEYLFNxO870NOCcNsYyfVXhq6fe3HmcfhkY0QeI=;
  b=cMFvmT0HhVxtmx04jLC8hHXYBUb39+ATjcZqsfCI54nmr1FWvPnc7nBC
   Zl8YjyG/kpH2GpWPaepq2urjLWt414e09kqLGXqPgn/h7V5FeNrqjJsJF
   LgwZd9UuxL9V+k9HOIEm7prZRQcKyvGGfNpQ5FUEXPuQpM3JDtOHvmww2
   6+cV8ljSYMl5ORiU8RUcBtNXIheRKycU2lHtQ+NgQHdYcDN6paAZD6VwH
   WbUPqm4ehSUOM6BF7V2nHVPYPLpP5UHSotAiBfwaA4UUhgXTN8hjSkkHj
   4DwcTI1gPtdnV9udiIZ/8i3EhSpeSV9fqvvzC24g9LEL64YQJovrC2J+o
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v2 0/2] Add ps_it attributes for vcnl4040
Date:   Fri, 23 Sep 2022 13:40:29 +0200
Message-ID: <20220923114031.757011-1-marten.lindahl@axis.com>
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

Mårten Lindahl (2):
  iio: light: vcnl4000: Preserve conf bits when toggle power
  iio: light: vcnl4000: Add ps_it attributes for vcnl4040

 drivers/iio/light/vcnl4000.c | 183 +++++++++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 6 deletions(-)

-- 
2.30.2

