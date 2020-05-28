Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3D1E57AC
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 08:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE1Gkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 02:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgE1Gkj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 02:40:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB8C05BD1E;
        Wed, 27 May 2020 23:40:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so277216pfd.6;
        Wed, 27 May 2020 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f153Oiv6V0dDvFVZ6jioj2CuCS8APNuYD3It8Lwcg+4=;
        b=UhZlk94F98Aj/hZGx61pLSICB2FDY7I6hJdQWOtN9kJ4NJLvVTCYnWR0LU7v9B7N2B
         FE8DgnAHdXmCi/QeMS0zRp4d61ujJy6bubDqAS6TQT3wwX9nomojpLmXPjnlHH/e+t9S
         MRbcwT9ByYEIcOrpWHXMFVOolCLJzLBYSUTMoszVTQz2ke7BMHARE4dKh8PSmftbdRmm
         ouGHfcTvKstVClY14Q8m4e2IzrhW5qD+O7fqp9bvzIV9DuTJDmgnoJvehByfGUBwtNm+
         +KjcSrSet0Ak5Zms30vcHBGuchPi9FR2OcJ3u+xl3IoxIidWPvv6+WNH3ztOygESKQhf
         oxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f153Oiv6V0dDvFVZ6jioj2CuCS8APNuYD3It8Lwcg+4=;
        b=BKkRyIUfdOt3IqhMXc993y63jks8n7bG1Y9Mpc3kd3rOMMjNqWw96WsYMWKOMhYxwh
         r7z990BW38n5KdguoYnfXk7ZDVb4p+9Y3U4wF+PsK/Vp+TZj+kXGcKOEGOERH6nzaIMm
         5CCAeXr4LwapGQpliGTNYOpjlY6KCZRxKApqSWLfrmLQPNaQOxJ7tWwAKyl44KNnxviB
         yA5Sm56E8Fj757f6RsvL0+C1nbtfYTBp8RLThx2TCtKqiE4p7GqLTXPvRNohraoY0Xhj
         rQt/9cmtityGt/mVDOdt5vt1v31Xqah7/8jZiWzekEeC6EmD+w5BejUSiPdqFlBnaOzu
         o8mQ==
X-Gm-Message-State: AOAM530iNtexcJc221lSRLsj/E9c+Wd1hXojP8aAK23LhVqgydsOs9qH
        mUPiHqIbXFWIajYF8YFuDuo=
X-Google-Smtp-Source: ABdhPJx9md1AR61lHBvpJgMZk46aFkX7hlTdIy0H6XrIhkCvZNH9cFhp1yfYraE3awUeUEtqBAaWnA==
X-Received: by 2002:a63:3101:: with SMTP id x1mr1423569pgx.392.1590648038543;
        Wed, 27 May 2020 23:40:38 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id n8sm4338580pjq.49.2020.05.27.23.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:40:37 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] iio: amplifiers: ad8366: Add the missed check for devm_gpiod_get()
Date:   Thu, 28 May 2020 14:40:27 +0800
Message-Id: <20200528064027.546944-1-hslester96@gmail.com>
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

Fixes: cee211f4e5a0 ("iio: amplifiers: ad8366: Add support for the ADA4961 DGA")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Add fixes tag.

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

