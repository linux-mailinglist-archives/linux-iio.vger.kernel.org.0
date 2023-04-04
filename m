Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951086D562E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 03:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjDDBja (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 21:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDDBja (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 21:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36541B4
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 18:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680572321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8FIZEq9E2w7U9M1Y7V5ZDCr+Z6XlIynNUoEqvuqDtMY=;
        b=JIxCb6BPMqrB4szEVWGLgRUsqYhtMRQWe6EUT6NQMOnJkOUJ1x4nZEcUiI0eIZN0x11A4z
        l5OjjhFJRH+R0cPesi3jqo/OpQqviKaHdIHZWMYtrMHhw9EiGnbuN7h6Wg4ktkcU/hbiLj
        +x25+/WNAo56MYqVFyCwgV+f80u8d38=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-I87R7NWRNkaoqchJkhSaPQ-1; Mon, 03 Apr 2023 21:38:40 -0400
X-MC-Unique: I87R7NWRNkaoqchJkhSaPQ-1
Received: by mail-qv1-f70.google.com with SMTP id oo15-20020a056214450f00b005a228adfcefso14077935qvb.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 18:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680572320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FIZEq9E2w7U9M1Y7V5ZDCr+Z6XlIynNUoEqvuqDtMY=;
        b=w5HqXVHXKobgxg/GvKDAVqGk3d7QuPFuPab55xr7//QXPWDYwsfX5btt/qoE/U7mqr
         tNq7P7O32/D2eGZ8ldsM5wJyZPtbY2KCTYY2u57mzYu8hGFodCmPSE3uEQXGK40j0IgN
         iHWdvukgHM9Gxl+5JDzvj8k+qXp18p4+bUB46GvftZsJX0UxRS5EmAIOgZODfcb3zUYx
         uTs3xJEGxti0y1Bdm7ZDRdOQvboDYiKK6nRW9y/toDw4/WAdRqJaYY7CYboFd5SzYz3U
         KRo4pq7Ia1Z7ThhzLs/MTo71oWkh9fuCVtTolgn5pT3+M4oL0PG6rUXa/f3EdJZoxiAP
         UU+Q==
X-Gm-Message-State: AAQBX9fu8ZPHlzeLJJoNBSuTde1Bt2TLTUkj8UGZVj54grNiE3EaFmpa
        dPh4wZHZJy3LyYf6sAtQSIWfx7rNDBbOVHlmS4dzv/PxInfdJ6fsb2WqCw71dsVrxbtC6azIVLX
        q+ZNtm3oZKidzX8Ley9VU
X-Received: by 2002:a05:6214:1cc2:b0:5a3:44a1:788d with SMTP id g2-20020a0562141cc200b005a344a1788dmr1391823qvd.29.1680572319791;
        Mon, 03 Apr 2023 18:38:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YH1YAZKMJbzI7OrgDA5mb6wosGMJ8r7spqB43M2GMR7OluqQRsFKZTRBtZDPJDic0qUhHBFw==
X-Received: by 2002:a05:6214:1cc2:b0:5a3:44a1:788d with SMTP id g2-20020a0562141cc200b005a344a1788dmr1391809qvd.29.1680572319550;
        Mon, 03 Apr 2023 18:38:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k5-20020a0cebc5000000b005dd8b9345d3sm3005993qvq.107.2023.04.03.18.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:38:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, angelo.dureghello@timesys.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: dac: set varaiable max5522_channels storage-class-specifier to static
Date:   Mon,  3 Apr 2023 21:38:28 -0400
Message-Id: <20230404013828.1914523-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

smatch reports
drivers/iio/dac/max5522.c:55:28: warning: symbol
  'max5522_channels' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/dac/max5522.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 00ba4e98fb9c..05034a306597 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -52,7 +52,7 @@ struct max5522_state {
 	} \
 }
 
-const struct iio_chan_spec max5522_channels[] = {
+static const struct iio_chan_spec max5522_channels[] = {
 	MAX5522_CHANNEL(0),
 	MAX5522_CHANNEL(1),
 };
-- 
2.27.0

