Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE55BEC93
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 20:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiITSKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiITSKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 14:10:19 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A62AF
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663697418;
  x=1695233418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PpGa4JUsfG70iHiyHmFuSmcm699LUitaSlS44lXU4uY=;
  b=CdUkLBH5PMNJ2dnK7ICIWSfF/3XE4jfTE9jGdR4K+tgpEigt9NLujI6a
   UM0wTAT9ZjJg2PUIW5DsA+8XYtxQQ0IhtmJeNm6sGjUHK3dqAOGSN9ZKN
   oofVQfCHWpASFhQ0VYh2yEgqs+EUpQJwYhTLf2UkxImwSPqCRXWA6VVku
   24ZWEC68uCALeWyxUnRFIj74jH3zRINMfCnFiKPRcraQ4Tr/gJ1BJA0BG
   l+/IOa58GOV5Yu8lvBsvipJGHEw5N5oIzHqesnQUv8v6QCKx64MrBfUKc
   6JNqCSvcgVbtT7OGc5jTlc6Xt/sdJ6A/WQ4yPNLhJnm7MUh5L93hj78pA
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 0/3] Add basic attributes for vcnl4040
Date:   Tue, 20 Sep 2022 20:09:55 +0200
Message-ID: <20220920180958.2308229-1-marten.lindahl@axis.com>
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

Currently there is no way for userspace to make any configuration of
the VCNL4040 sensors, but only the sensor readings are exported in
sysfs. To support basic control of the sensors such as enable/disable
and setting integration time value, sysfs attributes for this needs to
be exported.

To begin with the runtime power management turns both sensors (ALS, and
PS) on before reading the sensor register values and then switching
them off again. But when doing so it writes the whole register instead
of just switching the power on/off bit. This needs to be fixed in order
to make other persistent configurations.

Kind regards
Mårten Lindahl

Mårten Lindahl (3):
  iio: light: vcnl4000: Preserve conf bits when toggle power
  iio: light: vcnl4000: Add enable attributes for vcnl4040
  iio: light: vcnl4000: Add ps_it attributes for vcnl4040

 drivers/iio/light/vcnl4000.c | 205 ++++++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 5 deletions(-)

-- 
2.30.2

