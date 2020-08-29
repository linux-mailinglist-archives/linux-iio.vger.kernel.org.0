Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187FC256393
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 02:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH2AB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgH2ABY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 20:01:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977FC061232
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 17:01:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j11so379780plk.9
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2020 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WP5DuUAAG+qcaTHe2FLLmzgJobs8Ub99cEAnEEBXuUY=;
        b=MPHYleUx8NXhjcAnguiZgLc8Hc6XDR5fa10bzuEXqMIdBJH8bS89r+x1MKa7c1wUpU
         ZnY2HhQkn5h2hHTqrzPsavaBqNe6hyLnIppKHgqzjbUlfw9oKloXIEnC1DK9+uaK9dyZ
         +c1Ns+MjuYF05yj8hWwZpfYLz0fMbpkX2emLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WP5DuUAAG+qcaTHe2FLLmzgJobs8Ub99cEAnEEBXuUY=;
        b=jN1dfoeKx3RXRnbiOvjU9ncs+9xE7ba/GtCsBE8ZdO+kmHQHqrfv2wFS+/xFB/hP1e
         ADXZ/X/1pvaxMxKDNBeZSVQaG74l4kRdTKBT+MdUX51buKiC7G9WC2h+WmdyUZ9JdxvV
         gNMe14xYZM6gbYHcd1YqACU01k/C7HQCrpte1Dzl/AG6EDotSkQUPmJEOrEGhSpcHS7m
         EAtnleJhQcD2VKNKsn74YNYMCFkUQSsndcvhe9+3VedhE2NAPRJsqnHJ4Vcqc/hhrFeG
         voeDSymBLPA0fbCT9JoNTlXNuNn8ienG9VosMZ5CjYwZcSnvTPZJBCqlCrHG8fZD8WEe
         CnRA==
X-Gm-Message-State: AOAM533G7qMLgS4cNNYvclaHqcRZPoDUCMO32rS739GyxwvDd3VTgr2Z
        9ABtYjvl+JeUXsUdQgEv8E2edg==
X-Google-Smtp-Source: ABdhPJw3m732pYyvoiDOQensvtwKdLaavSAtqO5S1Z1mo48Jk4EyhYZsvMNb5Ibun68EKUGZX/Hsyw==
X-Received: by 2002:a17:90b:40cb:: with SMTP id hj11mr1196294pjb.67.1598659283950;
        Fri, 28 Aug 2020 17:01:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id h5sm611367pfk.0.2020.08.28.17.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 17:01:23 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Daniel Campello <campello@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: sx9310: Prefer async probe
Date:   Fri, 28 Aug 2020 17:01:18 -0700
Message-Id: <20200828170052.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On one board I found that:
  probe of 5-0028 returned 1 after 259547 usecs

There's no reason to block probe of all other devices on our probe.
Turn on async probe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: I haven't done any analysis of the driver to see _why_ it's so
slow, only that I have measured it to be slow.  Someone could
certainly take the time to profile / optimize it, but in any case it
still won't hurt to be async.

This is a very safe flag to turn on since:

1. It's not like our probe order was defined by anything anyway.  When
we probe is at the whim of when our i2c controller probes and that can
be any time.

2. If some other driver needs us then they have to handle the fact
that we might not have probed yet anyway.

3. There may be other drivers probing at the same time as us anyway
because _they_ used async probe.

While I won't say that it's impossible to tickle a bug by turning on
async probe, I would assert that in almost all cases the bug was
already there and needed to be fixed anyway.

ALSO NOTE: measurement / testing was done on the downstream Chrome OS
5.4 tree.  I confirmed compiling on mainline.

 drivers/iio/proximity/sx9310.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index dc2e11b43431..444cafc53408 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1054,6 +1054,7 @@ static struct i2c_driver sx9310_driver = {
 		.acpi_match_table = ACPI_PTR(sx9310_acpi_match),
 		.of_match_table = of_match_ptr(sx9310_of_match),
 		.pm = &sx9310_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= sx9310_probe,
 	.id_table	= sx9310_id,
-- 
2.28.0.402.g5ffc5be6b7-goog

