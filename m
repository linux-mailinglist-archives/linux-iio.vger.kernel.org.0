Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878886D55C4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 03:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjDDBPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 21:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDDBPp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 21:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C810D5
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 18:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680570905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TSYL1BZlYm691L/hIPylGQ0hs5V7ipUIWqwof30ZZdE=;
        b=Slp+ZmmxIEDJw0dr0arbVUIE1OnkMz8AO1nnPczt90VgwHCDQVHIeLgT9VaQ+yyt3QDpq4
        i/ehpGXPL1Gi9SMPt3fkWPaMwpA1hHKKxhhWtXH58EX5YfT59+gfZreqDzAsgIz640V1XE
        MRT4l5TWfCzGKrZjnTFePI5eVWRFPdc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Ky6_xyDuOj20dcUsFvXIPQ-1; Mon, 03 Apr 2023 21:15:04 -0400
X-MC-Unique: Ky6_xyDuOj20dcUsFvXIPQ-1
Received: by mail-qt1-f198.google.com with SMTP id y10-20020a05622a164a00b003e38e0a3cc3so20925121qtj.14
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 18:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680570903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSYL1BZlYm691L/hIPylGQ0hs5V7ipUIWqwof30ZZdE=;
        b=SGupeOQCYRmmorD5PpUjho7rqek8T2gYap5R9gFgMN6dFUKVhhbh+Dh5FWiHLEmdQ/
         3xUduYqC+MZFPUFouRVFy5YhkTDQ8tAtV9DjA3R3druJcrGaQL3di6K3drECSEDcS/wX
         vUW00ZX+lWMkhLWyqF4sV91DcLYq/Hwo/1PcfNykaDITMNE8h9i/1fweXCV77USUWyrV
         Kqdj+jRck0yY/JNYH3Kj/IqUeDZUL0V97fFQHyGA8aunnL3vxFr0rN7B+BnrVC540IZF
         rjaRcQLc3gePPhk8LOP9PB6GdlB9pwC2cMD3jiPdCWVQHRqGF4oKaV4Y5VyLryQI9eHn
         gY3Q==
X-Gm-Message-State: AAQBX9fwFSN7RG1DejJ6JhxTn675CXjFcGfLPZUdPl3LnnuV0vRIA1We
        rxrnIuEIEVjROdyFKK6u8UrAVNpeJxDEs2Ul+yvYzLWGJW7JAEo+q6rwZzSnYUgFJbqsi+6r65b
        UrCwJyQ7+5xvFlHF0wvA6
X-Received: by 2002:a05:622a:38a:b0:3e4:ee22:a50e with SMTP id j10-20020a05622a038a00b003e4ee22a50emr964221qtx.7.1680570903643;
        Mon, 03 Apr 2023 18:15:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YsLbWLWr5isuULSaje0HfJTg3w21vMJIabPGBUBuVjvosJ9+6FCPfpIcKBSdDq3UYLsgnu6A==
X-Received: by 2002:a05:622a:38a:b0:3e4:ee22:a50e with SMTP id j10-20020a05622a038a00b003e4ee22a50emr964205qtx.7.1680570903369;
        Mon, 03 Apr 2023 18:15:03 -0700 (PDT)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id o26-20020ac841da000000b003de4e646d63sm2919574qtm.32.2023.04.03.18.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:15:02 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     jic23@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, trix@redhat.com,
        lars@metafoo.de, nathan@kernel.org, ndesaulniers@google.com,
        u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hslester96@gmail.com
Subject: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from device tree
Date:   Mon,  3 Apr 2023 21:14:55 -0400
Message-Id: <20230404011455.339454-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
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

tsl2772_read_prox_diodes() will correctly parse the properties from
device tree to determine which proximity diode(s) to read from, however
it didn't actually set this value on the struct tsl2772_settings. Let's
go ahead and fix that.

Reported-by: Tom Rix <trix@redhat.com>
Link: https://lore.kernel.org/lkml/20230327120823.1369700-1-trix@redhat.com/
Fixes: 94cd1113aaa0 ("iio: tsl2772: add support for reading proximity led settings from device tree")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/iio/light/tsl2772.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index ad50baa0202c..e823c145f679 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -601,6 +601,7 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 			return -EINVAL;
 		}
 	}
+	chip->settings.prox_diode = prox_diode_mask;
 
 	return 0;
 }
-- 
2.39.2

