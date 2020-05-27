Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503D51E46F2
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbgE0PGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgE0PGC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 11:06:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575AC05BD1E;
        Wed, 27 May 2020 08:06:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g5so434210pfm.10;
        Wed, 27 May 2020 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r8qW1GbzwPbZg/HkuQqnA356Pshlg9uzOTT3+JhmRM=;
        b=QsvhzIsNmgfUdK4CS9ZD1rrd26M+p3WwCI2iy5dW0YTISBuOcmd9J7yhgaCoNyrbPE
         5v5bBYaiB2PM5xgznY2bF7s4/p8WhzDtDGCwxBOQnOLwQCGFlqI92KHSM98erLb9CTBT
         vwe2uElL+9hmmdeqO/g9lWag7XpTevoybESaQuWPPchkL9CxaG0LZKh64qRi3PLXOE+o
         YzcErXzwz1Pp6Fi3DxRYoBx4Lu9j3suZ6D6cOw3OfVPat4PsYDo3ks2nqOYOR1+kzkEM
         g5PTI22fBZX2r8tJ8Xwop6ifXOzW7VyfG9glSqs+hmbR6mR8Jwnpi/8noV/pEaUYCu4y
         /cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r8qW1GbzwPbZg/HkuQqnA356Pshlg9uzOTT3+JhmRM=;
        b=UuudTWh5a5cyHLnNe2z5sk2yYugJDMSXKnZF2emkZM/jv43uwurxunsr3nEp6Lw3+t
         obJjD6UqRPfkJh+Dw2Vihaa2KxIzS1G7WwHyK9AcwTaxWXcUwK7JvGv8x79xgnkuhApg
         qCVCHs/YfyRPFcJSBAaNCq5tvACFj+CTzhBb5y21uy/AnL4VEMUsz5Th7l68o+Vx87Gv
         KmrW8fa3C7SsQglr18V9mZaInSob/USkpdfP991nTW5WI9Voe//8SRJt2PgNtzUzmg9w
         GReTPUgjmZS/+1ETV0YXjd+BHSj7WLMDce4VLxZm+CYD0z+TogmJd2geYLSubWKzopED
         f28A==
X-Gm-Message-State: AOAM530W5NNTRys7ICBrJPJ2Dlut/vTVdlN2C85krrBMRj1VhwbI7unE
        UNgZbAmZhmLXWYfJ+n48oTs=
X-Google-Smtp-Source: ABdhPJxJqNylx2TSCxCjRB/cji+ywky1bhvI30hSRJ3tF5o44Jb8SIM6ZokhFtUddHZ0KzH494D8ag==
X-Received: by 2002:a62:5ac2:: with SMTP id o185mr4348006pfb.148.1590591962363;
        Wed, 27 May 2020 08:06:02 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id a10sm2247999pgv.72.2020.05.27.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 08:06:01 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: amplifiers: ad8366: add the missed check for devm_gpiod_get
Date:   Wed, 27 May 2020 23:05:48 +0800
Message-Id: <20200527150548.539000-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ad8366_probe() forgets to check the return value of devm_gpiod_get().
Add the missed check to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/amplifiers/ad8366.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 62167b87caea..b996823c8d51 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -264,6 +264,10 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_HMC1119:
 		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
 			GPIOD_OUT_HIGH);
+		if (IS_ERR(st->reset_gpio)) {
+			ret = PTR_ERR(st->reset_gpio);
+			goto error_disable_reg;
+		}
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
-- 
2.26.2

