Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E826C9EE8
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjC0JGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjC0JFx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 05:05:53 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7AE10FE
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=nlRe8f4/ag5dmmxfq8dbVSW6Imwp09NDX9J36bNmqcE=; b=1n9DpUdWR7h3HKncZodKxLLvt/
        PmX3+2bFVlysh3j9qIRbC5G6/HPMQJavh1DU1tvIgnQAAR/p7Zb+/jENNUG/cDYYefi0Exxh+czVd
        y82FrJ/dJ9NiIbNLQAjCXG6eIOpHfNWVK436x4OwNTeJwQEnIDzmrCDFCZ05ZM2A8Z3fNZ7JwVq32
        NQisL69TjgIKd9lmZUqRjc25fqOgQ+SoanQyihH5OZriZB3iZ9KSaGXLe5Cx9mXSXirolDKJKJfsy
        sAlWe+BKSvXmG2Trg8wNEjR0mQ/l1GIk9Vzny9OwL6CStRLw9JqCDcnj5jzrMifS1nlvLDmdE7JkA
        wy9ZnFyw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pgiJo-000PcX-Bq; Mon, 27 Mar 2023 10:35:08 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pgiJo-000H3h-1k; Mon, 27 Mar 2023 10:35:08 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, lars@metafoo.de, alexandre.torgue@foss.st.com,
        nuno.sa@analog.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/3] iio: adc: stm32-adc: warn if dt uses legacy channel config
Date:   Mon, 27 Mar 2023 10:34:47 +0200
Message-Id: <20230327083449.1098174-1-sean@geanix.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26856/Mon Mar 27 09:24:05 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since nearly all stm32 dt's are using the legacy adc channel config,
we should warn users about using it.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/adc/stm32-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 1aadb2ad2cab..d8e755d0cc52 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1993,6 +1993,8 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	int num_channels = 0, ret;
 
+	dev_warn(&indio_dev->dev, "using legacy channel config\n");
+
 	ret = device_property_count_u32(dev, "st,adc-channels");
 	if (ret > adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
-- 
2.39.1

