Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92C81346FB
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAHQA0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 11:00:26 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:46210 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHQAZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 11:00:25 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id F06C1104487;
        Wed,  8 Jan 2020 17:00:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net F06C1104487
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH 0/2] iio: light: vcnl4000: update sampling rates
Date:   Wed,  8 Jan 2020 16:58:50 +0100
Message-Id: <20200108155852.32702-1-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Vishay has published new information which explain drifts seen in
experiments. So update the sampling rates for affected variants.

Patches are based on iio/fixes-togreg to avoid conflict.

Tested on vcnl4200.

Tomas Novotny (2):
  iio: light: vcnl4000: update sampling rates for vcnl4200
  iio: light: vcnl4000: update sampling rates for vcnl4040

 drivers/iio/light/vcnl4000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.16.4

