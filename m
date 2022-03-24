Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697B4E6218
	for <lists+linux-iio@lfdr.de>; Thu, 24 Mar 2022 12:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbiCXLHl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Mar 2022 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiCXLHk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2022 07:07:40 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 04:06:06 PDT
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55AF79A9BA
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2022 04:06:05 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.85])
        by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7623c4fe2745-65e38;
        Thu, 24 Mar 2022 19:03:00 +0800 (CST)
X-RM-TRANSID: 2ee7623c4fe2745-65e38
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvrnew03-12028 (RichMail) with SMTP id 2efc623c4fdda26-ac1c3;
        Thu, 24 Mar 2022 19:02:59 +0800 (CST)
X-RM-TRANSID: 2efc623c4fdda26-ac1c3
From:   jianchunfu <jianchunfu@cmss.chinamobile.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [PATCH] tools:iio: Fix the potential stack overflow risk
Date:   Thu, 24 Mar 2022 19:01:57 +0800
Message-Id: <20220324110157.13143-1-jianchunfu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.4
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add judgment to fix the potential stack overflow risk.

Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
---
 tools/iio/iio_generic_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 2491c54a5..733fc21c2 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -487,6 +487,10 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 		}
 		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!trigger_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
 		free(trig_dev_name);
 		if (ret < 0) {
-- 
2.18.4



