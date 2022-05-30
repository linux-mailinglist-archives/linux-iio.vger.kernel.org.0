Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EDB5378C5
	for <lists+linux-iio@lfdr.de>; Mon, 30 May 2022 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiE3Iyu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 May 2022 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiE3Iyf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2022 04:54:35 -0400
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FCE13F88
        for <linux-iio@vger.kernel.org>; Mon, 30 May 2022 01:54:22 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 00CA44409AF;
        Mon, 30 May 2022 11:54:15 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1653900856;
        bh=ZNOeS9A1EK0scW+JSEDHC4t8DnEV/2NTDcaqjhwDQME=;
        h=From:To:Cc:Subject:Date:From;
        b=GNoC08vukvAnmj/4H6F+p7Q+1Pa/zLbEkCYw7W6D3mob91obsCE7GYymB4g+MpHQ4
         SNKnzwJp/Qh8tSTiRvODf4mk13rWIgfJR95DgYGQ59ChzXYm6JqCLYrf7NQZBWSbIs
         XDCCelAM5NBIM946vJPBg/qsG5Vmis0Wg0QENYFMYpyqXbwqgpkrfiDvT9cIbhvEEX
         ZnX112UyODV4ViiITgkR7DT95pdiRQt6NPuM/eumTaHSklc0NPsuIFvdW5Yyhr6PNs
         fJo5Kd/3wxt24rGu1WyKTtxFpkCjBlrucaXKzvjcPEKDRbxt8xACJggJ9VKbhPtq7a
         RjQmo9Y7Su1xg==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] iio: adc: vf610: fix conversion mode sysfs node name
Date:   Mon, 30 May 2022 11:50:26 +0300
Message-Id: <560dc93fafe5ef7e9a409885fd20b6beac3973d8.1653900626.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation missed the "in_" prefix for this IIO_SHARED_BY_DIR
entry.

Fixes: bf04c1a367e3 ("iio: adc: vf610: implement configurable conversion modes")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/ABI/testing/sysfs-bus-iio-vf610 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vf610 b/Documentation/ABI/testing/sysfs-bus-iio-vf610
index 308a6756d3bf..491ead804488 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-vf610
+++ b/Documentation/ABI/testing/sysfs-bus-iio-vf610
@@ -1,4 +1,4 @@
-What:		/sys/bus/iio/devices/iio:deviceX/conversion_mode
+What:		/sys/bus/iio/devices/iio:deviceX/in_conversion_mode
 KernelVersion:	4.2
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.35.1

