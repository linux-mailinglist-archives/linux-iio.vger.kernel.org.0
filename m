Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366C63CC6D9
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhGQXk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGQXk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jul 2021 19:40:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35640C061762;
        Sat, 17 Jul 2021 16:37:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k4so16490933wrc.8;
        Sat, 17 Jul 2021 16:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8SRcWM58smf+vYhn8K7x+OEcA/vx7MoAU3pV30b6XE=;
        b=iT7eNzuLPQl8K6h6qY+QEObeT5rLsR5X26z1sUiqS15kH8QVZ6b5E895tf3I489vpI
         gmwrX5dDwaAf7UvT2OE0SL/y4Qai9kL3qiCUZPPOCI/SDL2JdKCsaAyjQZWEXwhLFcZF
         y3h5eDBMAs/VulbHzmaZgDSfP3Lm8nrqdNWYY0FVbdA2G7jS6FI6vjBigJYU6k28qKhj
         1+kP071UwEFMA92MX+O5cYfWpBHCDw9HdyTiB4wuZhG4SVEUdQKJAbF6Ae7DvCWrV3ob
         9lWlP7ZUyifIJtdIa5zxF6VQ4xahkSOuQrBgEDxPzrjgLmlNyV6F6EAqS6WwB/0Y8PfN
         2Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8SRcWM58smf+vYhn8K7x+OEcA/vx7MoAU3pV30b6XE=;
        b=PweiNPfbR4w0wYatAOOzHY3yQMJaIze83X0z8ZGOqp3m1GolQ4mANjnncZJiQTMey/
         Hhh2uB/XVlxSi5bCKNSxMM+NTKG9qh4UDYAN71QELVWRjGQN+RRgpnpM/0RYx0bUWQsc
         8+YGh43Rs7YrBKmH5ki5j82+MTbGNAYhGh3HyXeSoK9PB/dynH1ngNIC42GwrtvN+42q
         ZENtP5mo1JYZuV3R5LTc7fCDzI82jnPmIwIHgQ2kMGMDEQoCcG1BPFDpil4W/Xxnzgn4
         OL4TBQd1vejA5uUfjRJOhCSfT9uhKN/uFFqPXyBBllTNB1Bd3NYnLZ5RnOu9eMnbcaLZ
         aNXA==
X-Gm-Message-State: AOAM531WtwpvJcJH0DbqeDBdqYvs3aazs+oeBF6iOyDSV6a75MGcthrV
        frhRldeotCd3ybegrOLFIX8o24t6GaU=
X-Google-Smtp-Source: ABdhPJwD+rzxamNG/ejFbfNCgwhHng6HUyFGRe1HALoyZ1dFXnYHYJ8DMmNuNUEXIFBwTnDWWk3R2A==
X-Received: by 2002:adf:d236:: with SMTP id k22mr21385767wrh.392.1626565049555;
        Sat, 17 Jul 2021 16:37:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q7sm12347527wmq.33.2021.07.17.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:37:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] iio: adc: meson-saradc: Three small improvements
Date:   Sun, 18 Jul 2021 01:37:15 +0200
Message-Id: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

the first patch from this series saves a few CPU cycles on G12A, G12B
and SM1 SoCs. The other two patches are small whitespace cleanups.

In my opinion none of these patches are any real bugfix, which is why
I omitted the "Fixes" tag.


Martin Blumenstingl (3):
  iio: adc: meson-saradc: Disable BL30 integration on G12A and newer
    SoCs
  iio: adc: meson-saradc: Add missing space between if and parenthesis
  iio: adc: meson-saradc: Fix indentation of arguments after a
    line-break

 drivers/iio/adc/meson_saradc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.32.0

