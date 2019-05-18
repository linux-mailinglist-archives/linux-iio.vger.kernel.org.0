Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F272256F
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfERWl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:41:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37813 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbfERWl6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:41:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so12198955qtp.4
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKyoBKDfoJbBN8ZdJzWAMlrp7KnkxmJ6vA1sEgIrsvE=;
        b=yV+S7pgOzzbyCqFkDCEFt0jhKExLmBzHHNuFwDdEIcxQn5lVwe5+Ot/pPsbp6E5q8g
         rk06n2713VHScfotxZp0imBhciMduhnW/ffhbngY0mVadoR6Z5AL8R9U8KiPtGRD/iqp
         woGi14VDZQfa6B04dZpDqplOdtMXBP1UtmmS9FaMnNclaMpARA9/pd+hmMZdnpM1H3b6
         9c+AxHTuPJu9v2Q3me5urcxy63wtrCvm4Q3pRRsbd3AGZOYitI76awJuBU8INCVCtCBP
         ukFQnjaGwBUirqT9BakPf/qp1Kse+CKHt2kshrp0ugBPrPfTtSMo/Xg7AN4IVLkLp+Wr
         DG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKyoBKDfoJbBN8ZdJzWAMlrp7KnkxmJ6vA1sEgIrsvE=;
        b=XYGN5rcPHublYkTQSiL55DNewezY0GFcPlButx/alBhzw5KrCvotoI/G8xtmhLkR1P
         BHamC3WuSDDlbvvuUVT9ba1BkjbKrTn48u67WGGt6Px2ZpbHP3KvyagJrURWllG/qrkc
         QJIp77UifxXjy1kElLMnzhKBEkWkZ0dPBzuST8J39dUOPokseSvfI8IIxGTkF+xJAsi2
         SmVHZV4qT8aj+U9pagFkd31A2AYlrUMGyJ7TbrzjLtE1qHNnZmTtAcxuuC8lY7W4VoJ5
         Vv5Sx7dL8o0ZVQ7SxJ9b2j3SclkeZjWPtNVuhJjDImbx3JjAhZd882r9m1dSiBkPcOl8
         lpjA==
X-Gm-Message-State: APjAAAW0HET/u40I6QbhlVWtoSapPAy4LnxspCCrLW6Aj9qG21GH4NsY
        fG2DBSsPGJR41b47BVBA+XA31w==
X-Google-Smtp-Source: APXvYqwe6b/2fIeowTUPXLJW6AzydKeOoAwyOiyvZxsj2W75hS42mLp/UENCdlPbJiN4ffKnlk51Yg==
X-Received: by 2002:ac8:1a62:: with SMTP id q31mr16565529qtk.25.1558219318006;
        Sat, 18 May 2019 15:41:58 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d32sm7348992qtk.0.2019.05.18.15.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:41:57 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH 2/2] staging: iio: cdc: ad7150: create macro for capacitance channels
Date:   Sat, 18 May 2019 19:41:36 -0300
Message-Id: <20190518224136.16942-3-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
In-Reply-To: <20190518224136.16942-1-barbara.fernandes@usp.br>
References: <20190518224136.16942-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create macro for capacitance channels in order to remove the repeated
code and improve its readability.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/cdc/ad7150.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 072094227e1b..d8c43cabce25 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -468,24 +468,19 @@ static const struct iio_event_spec ad7150_events[] = {
 	},
 };
 
+#define AD7150_CAPACITANCE_CHAN(_chan)	{			\
+		.type = IIO_CAPACITANCE,			\
+		.indexed = 1,					\
+		.channel = _chan,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+		.event_spec = ad7150_events,			\
+		.num_event_specs = ARRAY_SIZE(ad7150_events),	\
+	}
+
 static const struct iio_chan_spec ad7150_channels[] = {
-	{
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
-		.event_spec = ad7150_events,
-		.num_event_specs = ARRAY_SIZE(ad7150_events),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
-		.event_spec = ad7150_events,
-		.num_event_specs = ARRAY_SIZE(ad7150_events),
-	},
+	AD7150_CAPACITANCE_CHAN(0),
+	AD7150_CAPACITANCE_CHAN(1)
 };
 
 /*
-- 
2.22.0.rc0.1.g337bb99195.dirty

