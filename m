Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4545BFFB6
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIUOQe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUOQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 10:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38187642E3
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 07:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B4762BEE
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 14:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7E9C433D6;
        Wed, 21 Sep 2022 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663769792;
        bh=TKXpX1K8bLo3a98p81KukESDdLEdzDsFxaMcOdlja3U=;
        h=Subject:To:From:Date:From;
        b=0vaaIXFUY7LBNlw9qkdrcGozmX6/gfZeHCBibrbz4qpbDRb+kuKDc588c6LUx8sVs
         wSITG7Ovra5ymTmkXM8aWs93ItjPkS6Ggl2bYLlvFD0yJayJZKbPcgtac4qJ7F4Uuh
         22/OkzEfNRSpx1BlZGVR5a1fdwjooOcX7PedST84=
Subject: patch "MAINTAINERS: Update Microchip MCP3911 to Maintained" added to char-misc-next
To:     marcus.folkesson@gmail.com, Jonathan.Cameron@huawei.com,
        jic23@kernel.org, kent@minoris.se, linux-iio@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 21 Sep 2022 16:11:51 +0200
Message-ID: <1663769511205149@kroah.com>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


