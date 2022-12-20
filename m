Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD7652360
	for <lists+linux-iio@lfdr.de>; Tue, 20 Dec 2022 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiLTPCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Dec 2022 10:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiLTPCi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2022 10:02:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299E1CFE0
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2022 07:02:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7e8P-00017B-Si; Tue, 20 Dec 2022 16:02:25 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7e8P-000arT-0W; Tue, 20 Dec 2022 16:02:25 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1p7e8O-007bqy-2g; Tue, 20 Dec 2022 16:02:24 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/4] Add TI TMP116 Support
Date:   Tue, 20 Dec 2022 16:02:18 +0100
Message-Id: <20221220150222.1813729-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

this small series adds the support for the TI TMP116 temperature sensor
which is predecessor of the TMP117 but still in production.

Regards,
  Marco

Marco Felsch (4):
  dt-bindings: iio: ti,tmp117: fix documentation link
  dt-bindings: iio: ti,tmp117: add binding for the TMP116
  iio: temperature: tmp117: add TI TMP116 support
  iio: temperature: tmp117: cosmetic alignment cleanup

 .../bindings/iio/temperature/ti,tmp117.yaml   | 17 ++++--
 drivers/iio/temperature/tmp117.c              | 57 ++++++++++++-------
 2 files changed, 49 insertions(+), 25 deletions(-)

-- 
2.30.2

