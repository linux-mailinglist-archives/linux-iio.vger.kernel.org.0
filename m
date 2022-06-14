Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E9054BABE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 21:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiFNTmf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiFNTme (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 15:42:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02F11C3D;
        Tue, 14 Jun 2022 12:42:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg6so19277863ejb.0;
        Tue, 14 Jun 2022 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Bb9QNZS4KUSJsXgLquKvLX7xOgHLYAfEYnI8Rwogk=;
        b=mG/eHEL8IHiiXX3lwQqj1ByYG2yfyG2p/ABwKfFepjbu51p8bk72vj3vwigthhvUZd
         OmNkAzGH8WChgCCGbskRfmp8fwYA7Yo07SDKpKTTYQfIXkbX9BD+VnQ/LueokRpxC3xF
         m+6ezwYpOdOekV2qf82AZR4FwDlPsvn8+R+Hndet0eCEzwchA9XtatzIIxObArp8HNvW
         b1tueDp0Gzq52gv0NFv2+rSL7HPYE5Lu4GEjhwynfW4JlKp9OxVm0IoLxUGzyCEQI+yk
         opWsH0HZsJCwcU0SO/KucZSVFDfQp9wVezyINtUiUh/hoA1h+3MUXDgCojU+F/K3yJEW
         QDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K/Bb9QNZS4KUSJsXgLquKvLX7xOgHLYAfEYnI8Rwogk=;
        b=dVBMlxfETJWZWksptHylSgEBVLC0/tK2L4d8p5MRIgMRgQOGHh+KvUgrsyH9Hp1ZVn
         VO0DwjIQ6TFZkOINsQ39UUU/g+J2GoN6W+sx0ZjhhfLxhLEtKVFmnN2Y7TUgCwKjQHZV
         rzTrezlSekwyQ6RQ0EIVBZdqmk8aWsq4hWK69sZjWScSM1Z5fKXw/+cxeiJ2unpO8tgx
         bOc5RugNbr3eAIFhH8kPh4bojkn4+JvCY06vSHmbThX4lwLGnzoAmybZaEiAhU4YlKwn
         QMwgFKsxcJiJduyO0llC/zUYWIS1g2DG/C/aLvm9lqbsn+degrHIvs/OQIPHmCemA3yx
         0tNg==
X-Gm-Message-State: AOAM532xffy2gIpStvQmOcphIRL+S2ywo0uMmoeMP7Pl9+qX7n4FRMU8
        JNQFIKDSqvs6M4aYfI4gu0I=
X-Google-Smtp-Source: AGRyM1sholsx+b9UD9l3BsHE6Sq67aqZchS39iu04cYO0cmXVVcj+06mgjn4CLJP/bgGew8Xtt2NPw==
X-Received: by 2002:a17:906:2086:b0:717:4e91:f1db with SMTP id 6-20020a170906208600b007174e91f1dbmr5633590ejq.345.1655235751260;
        Tue, 14 Jun 2022 12:42:31 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907058500b00712057b037fsm5306699ejb.167.2022.06.14.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:29 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 1/6] iio: adc: mp2629: fix wrong comparison of channel
Date:   Tue, 14 Jun 2022 21:42:20 +0200
Message-Id: <20220614194225.2226447-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Input voltage channel enum is compared against iio address instead
of channel.

Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/iio/adc/mp2629_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index aca084f1e78a..e7fbfe92e884 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -73,7 +73,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (chan->address == MP2629_INPUT_VOLT)
+		if (chan->channel == MP2629_INPUT_VOLT)
 			rval &= GENMASK(6, 0);
 		*val = rval;
 		return IIO_VAL_INT;
-- 
2.25.1

