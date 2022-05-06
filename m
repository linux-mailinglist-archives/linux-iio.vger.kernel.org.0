Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6278151D500
	for <lists+linux-iio@lfdr.de>; Fri,  6 May 2022 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiEFJyc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 May 2022 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbiEFJyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 May 2022 05:54:31 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F6946642
        for <linux-iio@vger.kernel.org>; Fri,  6 May 2022 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651830647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M/YKkbPnNM7Ksdq23zEc/mzKw+hVS6KYMfYLvsVRcPo=;
        b=LLdVfCPR1vZaJGf+KL399T8VVI0+6WfuPr8RiZijflj5YyQ6rNvZGm/tEJv2pkRC9Fnohg
        yk/YR7oFeERZTzn4JQ15d7nZZPyE+Q35vJwj2EQ+bAb8Ik7LPLSWiCENWd+pVkg93lbHFF
        oovadYTI+FQ4jxRmqHUl4jcmBjUk63Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-ezI47bwTOuW9-uhJP9CdKg-1; Fri, 06 May 2022 05:50:46 -0400
X-MC-Unique: ezI47bwTOuW9-uhJP9CdKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49B2A82A682;
        Fri,  6 May 2022 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE71C27E86;
        Fri,  6 May 2022 09:50:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: axp288: Override TS pin bias current for some models
Date:   Fri,  6 May 2022 11:50:40 +0200
Message-Id: <20220506095040.21008-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since commit 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling") we
preserve the bias current set by the firmware at boot. This fixes issues
we were seeing on various models.

Some models like the Nuvision Solo 10 Draw tablet actually need the
old hardcoded 80ųA bias current for battery temperature monitoring
to work properly.

Add a quirk entry for the Nuvision Solo 10 Draw to the DMI quirk table
to restore setting the bias current to 80ųA on this model.

Fixes: 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215882
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/adc/axp288_adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index a4b8be5b8f88..580361bd9849 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -196,6 +196,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
 		},
 		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
 	},
+	{
+		/* Nuvision Solo 10 Draw */
+		.matches = {
+		  DMI_MATCH(DMI_SYS_VENDOR, "TMAX"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "TM101W610L"),
+		},
+		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
+	},
 	{}
 };
 
-- 
2.36.0

