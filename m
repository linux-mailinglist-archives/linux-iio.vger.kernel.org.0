Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADE5BFF8D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIUOJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIUOJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 10:09:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BA95AFE
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 07:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A625AB82F32
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 14:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E6C433C1;
        Wed, 21 Sep 2022 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663769349;
        bh=9QQ/7KzsmKMhd/P1+l2zohpVkqsHM4fUnso1sNEwspw=;
        h=Subject:To:From:Date:From;
        b=jxJb8mj+FIu99o19Hv94+F38UDPlK6pIK9l+9ls0dypj1iymd4tP5dyXp9Mc4Z4iP
         9XAre8Jeo1BWbQhz6627CnM8mI82zoJvwkHsIvhRBukNWzDeFblpxdr/ldh5MMlNeg
         IfjSdlttT6GpL4h8EN5goH2zQO1Y1/wD2QUGHNsQ=
Subject: patch "MAINTAINERS: Update Microchip MCP3911 to Maintained" added to char-misc-testing
To:     marcus.folkesson@gmail.com, Jonathan.Cameron@huawei.com,
        jic23@kernel.org, kent@minoris.se, linux-iio@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 21 Sep 2022 16:08:52 +0200
Message-ID: <1663769332481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    MAINTAINERS: Update Microchip MCP3911 to Maintained

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 9e8284501c8d9e2bde4dfcddaf0201ee7cc8f2a7 Mon Sep 17 00:00:00 2001
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 23 Jul 2022 11:20:30 +0200
Subject: MAINTAINERS: Update Microchip MCP3911 to Maintained

The actual status of the code is Maintained.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Link: https://lore.kernel.org/r/20220723092030.260812-1-marcus.folkesson@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..b8b6544ba27c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13405,7 +13405,7 @@ MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 M:	Kent Gustavsson <kent@minoris.se>
 L:	linux-iio@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
-- 
2.37.3


