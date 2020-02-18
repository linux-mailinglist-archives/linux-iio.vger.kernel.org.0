Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA801629B5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 16:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRPpI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 10:45:08 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:38148 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBRPpH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 10:45:07 -0500
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 43C30102FA1;
        Tue, 18 Feb 2020 16:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 43C30102FA1
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Angus Ainslie <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v2 0/2] iio: light: vcnl4000: update sampling periods
Date:   Tue, 18 Feb 2020 16:44:49 +0100
Message-Id: <20200218154451.13066-1-tomas@novotny.cz>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Vishay has published new information which explain drifts seen in
experiments. So update the sampling periods for affected variants.

As pointed out in another series, the variable has a misleading name
(rate instead of period). This will be fixed in the other series to make
backporting of these patches straightforward.

Tested on vcnl4200. Tests on vcnl4040 done by Guido.

Changes in v2:
- fix rate -> period in commit messages and subjects
- collect tags

Tomas Novotny (2):
  iio: light: vcnl4000: update sampling periods for vcnl4200
  iio: light: vcnl4000: update sampling periods for vcnl4040

 drivers/iio/light/vcnl4000.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.16.4

