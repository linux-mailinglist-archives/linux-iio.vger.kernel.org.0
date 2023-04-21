Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA66EA601
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDUIj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjDUIj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 04:39:27 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A78A6F
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=Guq9tjQRAPQ7aI3TlsQDkj7tfxjVkiUdlit3uczhIeU=; b=I7RZuy9uzKlRjoRHKP3cC47UV+
        7EytV4deMhrFG5fUOkPGo7aHqhxF4pDVb7PpKW65nnFWou5EO2M0VE5x3LCeNFnOuygDhKc/6qdOT
        7W7eayhyMVuwL3CeOVLS/eB7tdJgtmk17M1sw27W9kskRb7DxveCvnJrE3zBCF0cy4xKqt8W3y5KC
        btkWYRhZMwiNAyy3uSLIpWaFSSAlsRGUFV70Rf4pmkter6HgS+0mfbLnqEBSb/1Oy9FDPEB1BwMbl
        5qz8+nJLFi6MgRhBN0k/xwk46oppE3HRz4h6PruStSqGPwSYk8/9d0kmQ8zu4nu/Zuox/2qowHZcf
        +QD20ODQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1ppmIa-0000rU-4J; Fri, 21 Apr 2023 10:39:20 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1ppmIZ-000NoW-Oh; Fri, 21 Apr 2023 10:39:19 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, lars@metafoo.de, alexandre.torgue@foss.st.com,
        nuno.sa@analog.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] iio: adc: stm32-adc: add debug info if dt uses legacy channel config
Date:   Fri, 21 Apr 2023 10:38:58 +0200
Message-Id: <20230421083858.2613289-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26883/Fri Apr 21 09:25:39 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since nearly all stm32 dt's are using the legacy adc channel config,
we should warn users about using it.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
 - Changed dev_warn -> dev_dbg

 drivers/iio/adc/stm32-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 1aadb2ad2cab..e179b6611e4d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1993,6 +1993,8 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
 	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	int num_channels = 0, ret;
 
+	dev_dbg(&indio_dev->dev, "using legacy channel config\n");
+
 	ret = device_property_count_u32(dev, "st,adc-channels");
 	if (ret > adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
-- 
2.40.0

