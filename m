Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B56EADFD
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2019 11:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfJaK5U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 06:57:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:62966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfJaK5U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 31 Oct 2019 06:57:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 03:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="283853757"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2019 03:57:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQ88h-000HKd-Ed; Thu, 31 Oct 2019 18:57:15 +0800
Date:   Thu, 31 Oct 2019 18:56:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     kbuild-all@lists.01.org, jic23@kernel.org,
        devel@driverdev.osuosl.org, mark.rutland@arm.com, lars@metafoo.de,
        biabeniamin@outlook.com, Michael.Hennerich@analog.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, Beniamin Bia <beniamin.bia@analog.com>,
        pmeerw@pmeerw.net, knaack.h@gmx.de, mchehab+samsung@kernel.org,
        paulmck@linux.ibm.com, Paul Cercueil <paul.cercueil@analog.com>
Subject: [RFC PATCH] iio: adc: ad7091r5: ad7091r_remove() can be static
Message-ID: <20191031105648.inhvyaovflogzckl@4978f4969bb8>
References: <20191029162928.9720-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029162928.9720-2-beniamin.bia@analog.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Fixes: 608229aeaa1f ("iio: adc: ad7091r5: Add scale and external VREF support")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ad7091r-base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index fda1112e73760..dc42735680c83 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -204,7 +204,7 @@ static irqreturn_t ad7091r_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-void ad7091r_remove(void *data)
+static void ad7091r_remove(void *data)
 {
 	struct ad7091r_state *st;
 
