Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35627F606
	for <lists+linux-iio@lfdr.de>; Thu,  1 Oct 2020 01:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgI3X3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 19:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3X3s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 19:29:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F7C061755;
        Wed, 30 Sep 2020 16:29:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x69so4253983lff.3;
        Wed, 30 Sep 2020 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSrJVmwIsZm2lv8EiSG21HgOKivmR5gP15fo1x1Whk8=;
        b=e8KW8l6VHc8gITvzq29HhCP2+lxp7DRe7tjnm7U69SsPGV2b0WWo9u7eUrfeTZx0BS
         2/onvk/XipWDiOrXu56cY9gZ4N04HwdvzwjLCz8d9mmpKAxJqT/r3wzZFFxEtQKA2UE1
         joYfgZlUxU7JZ6t/OMVP8Rb7i6JplSohjwIFhONrQ5oIgdNzPV1fmU0vsfWCqQnAM2h6
         xU4aO7fJHHJ7okKmMEY6KypL4Mt3vqy6VGkkz6+2sqPQd/dldLWlWnRSCwQxlvPajGvE
         EEH133xlqNJmt04pNzplXTm1fVq4Rtr+jdy+Qb1MZZVgoZJSItVTPfDMQGfPOp7pUhyG
         KY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSrJVmwIsZm2lv8EiSG21HgOKivmR5gP15fo1x1Whk8=;
        b=kUfJMw4g1/PHj5DQX4hMZLfijTEInjWvc/EOSHUabazIh7VWDzi+er76WpypglpRLj
         vKeboXMJGK+JHXdofxvfogaQkv66RtMuimJ+SMjwlLlmdQCChPhRz6noAOa5/ullCDb1
         EbIiDl+7B5UNcVUELK9xFScmi+H69VMEwV/T71828fPSQiM1KDdsb6mnpoM0vIDRzUEW
         AN0zvh3CXb+3sO/CQIFsLhdGZsnh6xJJ3ibR4HPIAknMoXT84lhOVYXGN4MDXOf46h/J
         NcA9jBNbr6EFT/bVqs10ledbZxNVoiyMojD53fMVTzodo/Z5G8g+OY9Qm7RcTEEP+5qo
         w5UA==
X-Gm-Message-State: AOAM530vyqRjwhLFx8rSdnczgZoMh5Ch+79EMaycdHblu0QDJKH9fnYP
        4JCDJG0VnvRR+UVjloMctwMl9A0qEy+roQ==
X-Google-Smtp-Source: ABdhPJzka8xGlsoG6nXTpFOMV67ZAks+d8d6SKBB+bS9orheOXjEaSO5PF4+2OCBZfkzK9MhR+Ewhw==
X-Received: by 2002:a19:5e4a:: with SMTP id z10mr1487420lfi.380.1601508585876;
        Wed, 30 Sep 2020 16:29:45 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-229-94.NA.cust.bahnhof.se. [98.128.229.94])
        by smtp.gmail.com with ESMTPSA id x14sm345628lfc.93.2020.09.30.16.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:29:45 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] iio: accel: mma8452: Constify static struct attribute_group
Date:   Thu,  1 Oct 2020 01:29:39 +0200
Message-Id: <20200930232939.31131-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The only usage of mma8452_event_attribute_group is to assign its address
to the event_attrs field in the iio_info struct, which is a const
pointer. Make it const to allow the compiler to put it in read-only
memory. This was the only non-const static struct in drivers/iio.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index bf1d2c8afdbd..b0176d936423 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1187,7 +1187,7 @@ static struct attribute *mma8452_event_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group mma8452_event_attribute_group = {
+static const struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
 };
 
-- 
2.28.0

