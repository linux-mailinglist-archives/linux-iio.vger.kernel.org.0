Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5514FC4A10
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJBI6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 04:58:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51927 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfJBI6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2019 04:58:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so6270629wme.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2019 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGigccZRHcOe6mnr3dySXizOwIoRRgR/GRDjKzSx57Y=;
        b=nMHtAt3zgJxjcaQ6D3dcCo7jyxkk3j51b2aUZHJnFspegFYzV/XJHUA2BEz4Lko2n8
         dqcl8flDFKoNFHFDBjAcIPf+YIHoa8paJHgnaj1iFrtgkXcuiiMaRoRssIQ9cSMMMzDE
         GJ2twjskYndZ0JhiuAgtKGPcitjppwJ9sMljnzL6oRuD37awsadGvXALO5VzYvtXBGH8
         KYH8At9E7Y74tH2Dp0B5o5Ceh3MUYNpQndOxo04eAt3PDKr+0mhnRLP6QfAwnqvOyNrB
         z8vEITM4UFxUtL1bGQ6IEnL854xC2vufXbgAf/uDuJ1s/ExH35l5icK1Gn+ciPtM1zW6
         TMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YGigccZRHcOe6mnr3dySXizOwIoRRgR/GRDjKzSx57Y=;
        b=KbpWYvkncOE+QenGE5NalytIIi3lpYob4dVeHnzLYZcM7gn6RlYLrb/uOYu6FnQn+P
         qD0uch4XGDthbFJC4Prtk6pH6DDO5vN1yU+E3hG9+Qk+yK3RX9DaT2kbUFHyosEa7M7I
         0I/7UCdmWbelKzvqeAXhaRvIzXP1mz5CpqDt2BhzCBxed2qjLtUyPAdm//LOA11FnuHp
         kOccmd1/zWkGHdDrH7ScvxGiGbsK2yaDavKMU/48iZqU4BAQuTz0u/7qRPA2t6BzjpXQ
         FcGV/MMCKCF6mPNKGSWZHuIPVRebrpMZU8DO2BsuamEkhSXAFefnRKlxbKvNzgk18kzD
         AAnQ==
X-Gm-Message-State: APjAAAWtCSeowUePoH9v2AOIl+x5k5ceS0ERGJAyefrLzoUBMAI61OHS
        Ug4RXgLME7BplKPLeAW5H4JkmA==
X-Google-Smtp-Source: APXvYqzyVRb6WScpGMgQlwmQaYkvHsLLv7VL9IVwN03FBI5LC9wI3I9G5Y60sn88O85AiijPGWtoqw==
X-Received: by 2002:a05:600c:2151:: with SMTP id v17mr1859179wml.56.1570006686541;
        Wed, 02 Oct 2019 01:58:06 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b186sm10115616wmd.16.2019.10.02.01.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:58:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/4] iio: pressure: bmp280: code shrink
Date:   Wed,  2 Oct 2019 10:57:55 +0200
Message-Id: <20191002085759.13337-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series contains a couple changes that shrink the driver both in
terms of LOC as well as actual generated code.

Bartosz Golaszewski (4):
  iio: pressure: bmp280: use bulk regulator ops
  iio: pressure: bmp280: use devm_iio_device_register()
  iio: pressure: bmp280: remove stray newline
  iio: pressure: bmp280: use devm action and remove labels from probe

 drivers/iio/pressure/bmp280-core.c | 114 +++++++++++++----------------
 drivers/iio/pressure/bmp280-i2c.c  |   6 --
 drivers/iio/pressure/bmp280-spi.c  |   6 --
 drivers/iio/pressure/bmp280.h      |   1 -
 4 files changed, 51 insertions(+), 76 deletions(-)

-- 
2.23.0

