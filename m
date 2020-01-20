Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 696BB142E4B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 16:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgATPFZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 10:05:25 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53874 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPFZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jan 2020 10:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6D9CEFB04;
        Mon, 20 Jan 2020 16:05:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cNq075tX6Ipb; Mon, 20 Jan 2020 16:05:22 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 47E3B404AA; Mon, 20 Jan 2020 16:01:24 +0100 (CET)
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
Subject: [PATCH 0/2] iio: vncl4000: Enable runtime pm for vcnl4200/4040
Date:   Mon, 20 Jan 2020 16:01:22 +0100
Message-Id: <cover.1579531608.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is modelled after the vcnl4035 driver. The vcnl4000 does not seem
to have a way to save power so we just leave it running.

Guido Günther (2):
  iio: vcnl4000: Use a single return when getting IIO_CHAN_INFO_RAW
  iio: vncl4000: Enable runtime pm for vcnl4200/4040

 drivers/iio/light/vcnl4000.c | 141 +++++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 13 deletions(-)

-- 
2.23.0

