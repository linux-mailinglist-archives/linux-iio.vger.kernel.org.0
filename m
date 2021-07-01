Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA9E3B8B7D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbhGABDX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbhGABDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:19 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A4C0617AD;
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g3so2968333qth.11;
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=LfLnuFlRknbp8AER1AHlz2WXSFgMGDBWsNUdwGO5iHyddwn2w77t9UZ0zzNDoosZzb
         yNBgKYpgIIzp53v4Gk4O+1s0EjKgTJUPW12ERtjNX+ATmw7P+pLL3wSYVJPguY516EEK
         2vXwMbFHrrVNtcPMX+V9pqarXNTp0q97M9s0OE36uEoJEOG7ciGX5WV+13yMPz7dSKxa
         uJ116dbZFCqSDdz42HgaMB1n06714E+XpEPkiLf5OqYhbfEQVSPacVEUNvJvoUX4mzZB
         MJajY874ghSHYXqdxGXwbOV6O3uQv8XnIOMRjV2CHAnFtHQ2BMMQd0QjY+8IB2baTAdI
         2axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=CG+763yq2TIVlS4ED/7RvUp4ZDRH3M0e+vXDL3k7BQSkih9gKUEzfXQoWNMNxJTIWk
         zj1jUibrluqRkF5YhW9DZLq/xsKxQCRqi5LXgGeK2ieEFdA4NX3kccxFEz68Sp5h2tTD
         Sxbtk/nORq+ZI52QzkCNeX0WkgZKr45Lsgx/Xb8Z4+P4jV4LjGwEieTB463GWMGVtlV/
         uxGI6Uv/PLnJQBf8efb+gOH6h10PNTa94hKk4MZDdltjt8L5gPEgWRp+Vlu9A8XKmiGa
         qoQtQdIdUCKrD8TjCkdUT3cVYHdx94Ns42px/VdfYFq1eAnSyHoNJmtp+4uBxpEH+yIC
         hHQg==
X-Gm-Message-State: AOAM530WabrzhTSPhUgfFSXCl1VQPpAeQ+f1u39TeYoknT752ZNp6R0c
        SxsGhGVF9KCnQX850Q3zPNQ=
X-Google-Smtp-Source: ABdhPJyiEsuyDAoBTgh8Og8TaRBMtG+qEi+QfEvwQYUza6+sQMgvlbjzxQ5aTMiZF54vDk/6psMn8A==
X-Received: by 2002:ac8:4f50:: with SMTP id i16mr13093682qtw.150.1625101248144;
        Wed, 30 Jun 2021 18:00:48 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:47 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 02/10] iio: inkern: apply consumer scale when no channel scale is available
Date:   Wed, 30 Jun 2021 21:00:26 -0400
Message-Id: <20210701010034.303088-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and no channel scale
is available, it's assumed that the scale is one and the raw value is
returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b752fe5818e7..b69027690ed5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -590,10 +590,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
+		 * If no channel scaling is available apply consumer scale to
+		 * raw value and return.
 		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 
-- 
2.30.1.489.g328c10930387

