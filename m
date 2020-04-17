Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706191AE22A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDQQXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 12:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDQQXA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 12:23:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730CC061A0C;
        Fri, 17 Apr 2020 09:22:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so2610826ljk.12;
        Fri, 17 Apr 2020 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSPf0aY0yppzj5gx9Joi4SbBbhqOVEPDH+QYs8U5ZbU=;
        b=i5SP6oSPqjEcxQYe1/OaztHbbHTIepY9zMXcv4d7taT/zo/sqdmsBo+MvHpjVBt0Oc
         A5kGipir+gRukYvCtpevQ9WWiWU5GkLHzpusNp7939Hv66RJx2V4mY73wztJjFDN22q3
         zhYtfmQ1TOK5Fh+36EXqc9snT1JQgi4D0T3YRJt/gMEaDBpWXsuZ4JIGV7rPCmwhNuz+
         2rjTKPJ7QtdygFcgpv452IjOkL2u7bdAjsmHmz09HDdBYjMFSEjFzhYFwXBkzNv+qcTn
         WCyvdXyMTyHcmoLXDfHkCT8Fjhh92MX1ygD+FhBWQ58db0SDio85I2C4SIcxBds21/L/
         wz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSPf0aY0yppzj5gx9Joi4SbBbhqOVEPDH+QYs8U5ZbU=;
        b=k7f2AayuBvDGP1Uv6V5opUXBxWmJ8hghlFrqnwZhY/6MM7QTzQwjBbLL+56aEk7rzK
         rcfILwteSi35px6iG3+6aCQqruoSgWuBI6Atf3Avm5ef8M7+VSehINbv6W6JhyGxWKOW
         HTbF47F+OxPJaPFTJlid1t0i7jejKQnQePi0G/JFF6KqEdCxDS1zTOfPlW/AiPYrORNC
         ecM6QLDIMCQkTRw56oCxVb5o6MF6Y3AHhyGFhWcW2joM8o3Efeg11IE+IxcN458UrAFo
         guqEtGowfn7nrsehEtTAo5JOAiiUA4ouV7HkLrvxCuK4D2Wvk/Jy53mIT81wkff8tzjq
         8/uA==
X-Gm-Message-State: AGi0Pubzc6kFv4npJJC1jpZrAdCTvmw5JUZ1gy4ou7j/kMttg9XSaubh
        KByQnHmSFJfLBLl+wFEWw0I=
X-Google-Smtp-Source: APiQypLSV/rMKlJbQzBn1kDvs9KkGdPzIR+jUYKlZffArq5ulwJYH/zFg1jj3ihpOGnmYYGqAW4WlA==
X-Received: by 2002:a2e:968d:: with SMTP id q13mr2708587lji.62.1587140578175;
        Fri, 17 Apr 2020 09:22:58 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id q6sm18014950lfp.28.2020.04.17.09.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:22:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: magnetometer: ak8974: Silence deferred-probe error
Date:   Fri, 17 Apr 2020 19:22:04 +0300
Message-Id: <20200417162204.14463-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's not uncommon that voltage regulator becomes available later during
kernel's boot process. This patch adds info message about unavailable
regulators in a case of the deferred-probe error and also amends the
error message with a error code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Replaced dev_printk() with dev_info() for the deferred-probe error,
      as was requested by Linus Walleij in a review comment to v1.

 drivers/iio/magnetometer/ak8974.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index d32996702110..ae1dc478fc02 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -746,7 +746,12 @@ static int ak8974_probe(struct i2c_client *i2c,
 				      ARRAY_SIZE(ak8974->regs),
 				      ak8974->regs);
 	if (ret < 0) {
-		dev_err(&i2c->dev, "cannot get regulators\n");
+		if (ret == -EPROBE_DEFER)
+			dev_info(&i2c->dev,
+				 "regulators unavailable, deferring probe\n");
+		else
+			dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
+
 		return ret;
 	}
 
-- 
2.26.0

