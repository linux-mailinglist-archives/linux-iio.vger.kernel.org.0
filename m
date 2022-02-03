Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98014A85BC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Feb 2022 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350982AbiBCOGO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Feb 2022 09:06:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349111AbiBCOGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Feb 2022 09:06:13 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcc5-00033q-0z; Thu, 03 Feb 2022 14:57:29 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcc4-009xp3-Fo; Thu, 03 Feb 2022 14:57:28 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 0/2] counter: push event on every pulse 
Date:   Thu,  3 Feb 2022 14:57:25 +0100
Message-Id: <20220203135727.2374052-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes v2
- rebase against latest kernel and fix some regressions
- add COUNTER_EVENT_CHANGE_OF_STATE event

Add support of push even on every pulse.

Oleksij Rempel (2):
  counter: add new COUNTER_EVENT_CHANGE_OF_STATE
  counter: interrupt-cnt: add counter_push_event()

 drivers/counter/interrupt-cnt.c | 7 +++++--
 include/uapi/linux/counter.h    | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.30.2

