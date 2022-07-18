Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9326A5789AE
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiGRSnZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGRSnY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 14:43:24 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB62CDFC
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 11:43:23 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10c0d96953fso26143633fac.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjhSUME5p/Vab80ae1ZkpRhOJpW65Uu7Z0E14xK8RwM=;
        b=CL8EItN6J7PIcIU43eKXEDZCHUUKzbSx6sIZ4OEARfr+Zpg3DgZvRllqhEkAAL3P6v
         y8k+Mqdvxzg1fHpFT1P8rwomta3X9nl06I7iJlkHUAnLU36wW3li0fj73ZJhXHDC7xWX
         MqiPeH2TX6u51/DPffnPDw9agCfaDLwUbCzKyD0n0bMSJkBVJs3gKrOayXK7CPDRbNL3
         0KCcRp+BouXgmXPS7KIRLzoYgRpChUcZVVP4A80hm5zk099PkKFO220mW9E0b+6OxY5W
         uOO43CA6sGx73hx2v8xmTP/GlkJl9tmwQc+0euqQm5BzHgGHLbS+C2FkuyyNz8Pd6GCs
         6hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QjhSUME5p/Vab80ae1ZkpRhOJpW65Uu7Z0E14xK8RwM=;
        b=Siwww/hUn7ldeN+MQeRtyWP8h8r97r5O9GaZ7mi9x2QTQCEtrYMuoq8MFt8KisBcQm
         H4eet8qmGVWq1tUmO4DGP6mIKUpPq7Vggg9XpIjpOvOMGEtE6aB42XZCWKOOkWA+eIq2
         jgdn0ORU47bTNSrKST7EUEBBTzTzNZiN3G9nZgWlYRePcxSC37CLsOZX3w/3PCtdP5EI
         xTogV473j/14bc+puYkU8Ta0NeLg46Mwy2BOsZRE+Iq2YbGjrn0uw9jSs5umKU7oW25B
         EmaapYsQ+yuVEAGTS43zoOIQckCjKEs7ygzD8uYEdiU6v+vC0LMPg/1HB9kGp019pf9u
         H4Sw==
X-Gm-Message-State: AJIora9orMD0G7rDE2XZx5W08WXjtV02oOLjpGbkH3BPkFhjTbwl5+Ll
        YzXzdeY/L0dw/nIm7sw02Upt5PvzfmY=
X-Google-Smtp-Source: AGRyM1uM2l1H7UPCtKXX6ijlD3ZZdSVYx4F386z9W+b+cQrG4emRTwR57Rj5dBqcEIALa6e6dwuvgQ==
X-Received: by 2002:a05:6870:309:b0:10c:8b6f:d0f with SMTP id m9-20020a056870030900b0010c8b6f0d0fmr17297952oaf.221.1658169802427;
        Mon, 18 Jul 2022 11:43:22 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id m6-20020aca5806000000b0033a7a2d5e7dsm1045866oib.5.2022.07.18.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:43:21 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, jic23@kernel.org, peda@axentia.se,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC] iio: multiplexer: Copy scan_type details from parent to child
Date:   Mon, 18 Jul 2022 13:43:12 -0500
Message-Id: <20220718184312.11840-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Copy the scan_type details from the parent iio channel to the child.
The scan_type is otherwise empty and things like the storagebits are
zero (which causes a problem for the adc-joystick driver which
validates the storagebits when used through a mux). I'm submitting this
as an RFC because I'm not sure if this is the correct way to handle
this scenario (a driver that checks the storagebits used with the iio
multiplexer).

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/multiplexer/iio-mux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 93558fddfa9b..1de01ec878c4 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -322,6 +322,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
 	if (page)
 		devm_kfree(dev, page);
 
+	/* Copy scan type from parent to mux child. */
+	chan->scan_type = pchan->scan_type;
+
 	return 0;
 }
 
-- 
2.25.1

