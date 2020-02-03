Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9D150325
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgBCJRK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 04:17:10 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:46366 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgBCJRJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 Feb 2020 04:17:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 93447FB03;
        Mon,  3 Feb 2020 10:17:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mVpf3Sr-6tqT; Mon,  3 Feb 2020 10:17:05 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CD9F0400E5; Mon,  3 Feb 2020 10:17:02 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: vncl4000: Enable runtime pm for vcnl4200/4040
Date:   Mon,  3 Feb 2020 10:17:00 +0100
Message-Id: <cover.1580721204.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is modelled after the vcnl4035 driver. For the vcnl40{0,1,2}0
we don't do anything since they use on demand measurement.

Changes from v2
---------------
- Based on review feedback from Jonathan Cameron
  https://lore.kernel.org/linux-iio/cover.1580391472.git.agx@sigxcpu.org/T/#m80668f77cb45cea3973b3609ebdce5bba351ed50
  - Fix missing return statement
  - Only update timestamp on power on
  - simplify returns from vcnl4200_runtime_suspend
- simplify return from vcnl4000_init

Changes from v1
---------------
- Based on review feedback from Tomas Novotny
  https://lore.kernel.org/linux-iio/20200120182853.37a724fa@tomas.local.tbs-biometrics.cz/
  Drop long wait in vcnl4000_runtime_resume but rather
  use vcnl4200_{al,ps}.last_measurement to make sure
  we wait long enough.

Guido Günther (2):
  iio: vcnl4000: Use a single return when getting IIO_CHAN_INFO_RAW
  iio: vncl4000: Enable runtime pm for vcnl4200/4040

 drivers/iio/light/vcnl4000.c | 144 ++++++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 19 deletions(-)

-- 
2.23.0

