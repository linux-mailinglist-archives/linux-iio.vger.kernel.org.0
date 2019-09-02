Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EAFA54F8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfIBLbh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 07:31:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39646 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbfIBLbh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 07:31:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so13657006wra.6;
        Mon, 02 Sep 2019 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHQshZLqz/FggXxDxmje655X+GnHpK69OGXj5M8uyac=;
        b=J2C2vVuf8Yu42uu6VihvzqIBWOKdX9cRNuezLnLHWH+hz5IshNb6DjdloPUKAyyrnz
         E0qDI5VPXyFybyD7XYDG2zATEqAVnB5PvhMDpbg1HXqCNPt3Bm+qQ53b5EcbkV13DgOZ
         IIJlNmXD7rhooQnbemL4CZ+j1g2UfhDN0Hguvb9XR3fRy7Xok0Kw/xMbPJ4sCav/lxp+
         rDe4+/B82LSSDPUDTb6fZkWEIORMrPsuqdtazMh8itIzW39A5TPogTejx3wQSGYzDCkZ
         TJBakOOyajtRY8YvCWfVHymiMUXtoN//qJ166N2GQKKEWK2YSc8N74kHbP2BaAXjieEM
         0cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QHQshZLqz/FggXxDxmje655X+GnHpK69OGXj5M8uyac=;
        b=NZkB5x1QK1Fp4aK8cMxpWVg3WVmUbrwbs0ouAZo+0y3khUMVBtJmjbwaZjgGQrGFxe
         U69NB5RTjUhUW7hOCNjncm2fhpc7ER/4EFYFkslca7zYZ8KYYygk+kXVzus3GbzwD+LA
         2vqu3wJ6+FAmOisUr9ZAzmhTuPLoNXnsjsh99mr+Y+VLB43waF/MwSCv3g/T2Qh8Mo1c
         6gltxrnqPqoKdXNTP54yOuvthLJDLqbWQOxECAYPgll0Mz81Fv5cP6uaIaFyBBYCdG4s
         vGOjFnNQcOU1fplh+rKoQIaB2465eJSH8PoCkxMuRxHCeKg16Q9+K9/a1e0JBam7dRmI
         bTAA==
X-Gm-Message-State: APjAAAXygo8NWKaT+t+LZ8po19R9qGj1+GEMzHAoRBdk4ldf8LG7AGvz
        aXxy+Yn/8fdb9+sZJZ1+RTs=
X-Google-Smtp-Source: APXvYqy5OtZrAhEwBuIT/RObZWjPgPjdQeCiqTHc8uJ8WK40EM1UB0FD/5qCTKwUNSP6NE/XGd3scg==
X-Received: by 2002:a5d:4b83:: with SMTP id b3mr35670087wrt.104.1567423894690;
        Mon, 02 Sep 2019 04:31:34 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id a18sm18621301wrt.18.2019.09.02.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:31:34 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: bh1750: Move static keyword to the front of declaration
Date:   Mon,  2 Sep 2019 13:31:32 +0200
Message-Id: <20190902113132.26658-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move the static keyword to the front of declaration of
bh1750_chip_info_tbl, and resolve the following compiler
warning that can be seen when building with warnings
enabled (W=1):

drivers/iio/light/bh1750.c:64:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 drivers/iio/light/bh1750.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 28347df78cff..460c0013f1a9 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -42,7 +42,7 @@ struct bh1750_data {
 	u16 mtreg;
 };
 
-struct bh1750_chip_info {
+static const struct bh1750_chip_info {
 	u16 mtreg_min;
 	u16 mtreg_max;
 	u16 mtreg_default;
@@ -59,9 +59,7 @@ struct bh1750_chip_info {
 
 	u16 int_time_low_mask;
 	u16 int_time_high_mask;
-}
-
-static const bh1750_chip_info_tbl[] = {
+} bh1750_chip_info_tbl[] = {
 	[BH1710] = { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
 	[BH1721] = { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
 	[BH1750] = { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
-- 
2.22.1

