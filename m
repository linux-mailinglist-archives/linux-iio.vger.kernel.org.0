Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62A4AB184
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbiBFS6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbiBFS6D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:58:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D194C043184
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:58:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4F19B80D88
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEC2C340E9;
        Sun,  6 Feb 2022 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173880;
        bh=mw83zoz93cyp/tvgo5W/vlZmt2sDrShamuN1RXUHl+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGsK7jzpwk6Y32Jqj6ynsA4/Rn7wN2vqV+yKUaH2CxMI7XQlgIO0ejqAV7bgFfAqg
         PIHffUHOPWOD9KMCKdAwygL1d7/QyCMToN/24GLZ64i9nQNFjKC+LZRK4LY7+0m5tS
         bqu17urgKajmRvwANEoFNvD9BZow4qkCVEn7PylfiYkNFmUjiQbcA9+v/0svMlCPrQ
         B6fvTEd7hYwf53PonVZXz5/F2vcFlxVxISe0cbK66C9i5Zve173uzEyeq5ASCM6jiL
         rbZK+/cqGCKiHBxC0sfEDiXKRjvtkZfvGUIa6fJlIXYdRzkbtGIRWlS+2eZSMrupAl
         vhOkQbjLsy5pQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 17/20] iio:adc:ad7280a: Document ABI for cell balance switches
Date:   Sun,  6 Feb 2022 19:03:25 +0000
Message-Id: <20220206190328.333093-18-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very minimal ABI docs. This is unusual enough that I'd expect anyone
who actually wanted to touch them to go look at the datasheet.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
new file mode 100644
index 000000000000..83b7efe6aa07
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
@@ -0,0 +1,13 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_balance_switch_en
+KernelVersion:	5.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Used to enable an output for balancing cells for time
+		controlled via in_voltage_Y-voltageZ_balance_switch_timer.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_balance_switch_timer
+KernelVersion:	5.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Time in seconds for which balance switch will be turned on.
+		Multiple of 71.5 seconds.
-- 
2.35.1

