Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775BC118C04
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLJPIV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 10:08:21 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42763 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJPIV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 10:08:21 -0500
Received: by mail-ua1-f66.google.com with SMTP id d8so2052484uak.9;
        Tue, 10 Dec 2019 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gsDCJ2TiWJHyVSPNJ89wBdejiv4TtVFMle91MYvYRs8=;
        b=kEthoPw8qmWQSHcfY9LEFaIDJv/Hzzm2ZWB6dDEzILOMgqXALHRZ+w4MR6UoxbrpNT
         xFEWbEMIIW8m5p662Pl/h406yWMMvihVI/q4XkmeJTQB+zXWo0JE07LQ5gWm8xg/miLb
         8p4Bx02Jr+oMlXi5J/jkdsBYQSCvKnzpztUm5BVLoUYxZ24qGyFU6a15++KtiQj5JbGH
         LSz4zDFKuR0Vz0yXHFP1vGJ3sNlSNp0OQ6OrXzj5SrCvtnViTndKue7wvn6Rwvr+1GRz
         phIxcQm/Eumv8D7auo57SWzDyTChVdkQ5bunUfT866REvRWGzCVL90X+Ua693Xd6ssql
         Lynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsDCJ2TiWJHyVSPNJ89wBdejiv4TtVFMle91MYvYRs8=;
        b=uXSJ00r2NN6n6JtLBeKdAzp12YUFuQeu4BMGh70RigLO7hyRUZpSgBwJthNcgpAf2E
         Z2nkWE3xjZt5i2W6QKPv/RRDXSPY/lNm2ZMX40CxE5n/A+XR2J/Q0uHVIX2FZOCgGBpv
         ZKJnNSps3QFH7CLpOWf8HNn9/5Rx/ihmwUrrHtMQMHo8gSsLEZc/pN7UAlmeUMhhg4jt
         h8Y+ArmpxJIB55rzDLE0QrTmYI9/FTtJO36cWikBz1uNcm/jxP8KdJbeA9pwmpASCYYs
         s4sAg/KoigTbYdsyUGIXmNWd+ImjgF6tLN+rODku1VJYww67BGDmhYXwFDAEmkIO4AwH
         Vp5A==
X-Gm-Message-State: APjAAAUULzP08LfJFzv+WSiK8X+vsYTekc/jBkPiDgSy/eWMPdloG2CZ
        c6J648aTWsiveYiPAc8I6Ng=
X-Google-Smtp-Source: APXvYqzdXt3Edu6eVlPKbCCJ57TbabWB07ayvELBFETeRoArqNhxNm3f9eHkS6uy98YYTWE7VyfwZw==
X-Received: by 2002:ab0:6017:: with SMTP id j23mr28736787ual.3.1575990499710;
        Tue, 10 Dec 2019 07:08:19 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id k45sm1986139uae.9.2019.12.10.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:08:19 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2 1/4] iio: adc: ad7923: Remove the unused defines
Date:   Tue, 10 Dec 2019 12:08:08 -0300
Message-Id: <20191210150811.3429-2-djunho@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210150811.3429-1-djunho@gmail.com>
References: <20191210150811.3429-1-djunho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Removes the unused define AD7923_CHANNEL_x from the code.

Signed-off-by: Daniel Junho <djunho@gmail.com>
---
 drivers/iio/adc/ad7923.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 3212eb4c0f25..969c06b7d2b7 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -29,10 +29,6 @@
 #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
 #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
 #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
-#define AD7923_CHANNEL_0	(0)		/* analog input 0 */
-#define AD7923_CHANNEL_1	(1)		/* analog input 1 */
-#define AD7923_CHANNEL_2	(2)		/* analog input 2 */
-#define AD7923_CHANNEL_3	(3)		/* analog input 3 */
 #define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction */
 #define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt write cycle */
 #define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */
-- 
2.24.0

