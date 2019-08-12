Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1389E9E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 14:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHLMlq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 08:41:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41645 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHLMlq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 08:41:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so2165388wrr.8
        for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2019 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrwfrIKrYFfamy4c5vzLtem+Xc73qRM6JZjJ2gik+Hc=;
        b=FUfvxf0DHtH9KpoJ0X9Ra32kGPWTpFo5rxU1zDYUZD9XzGJiNdMGbwGnUToDx9Bdp7
         LInJGSUSq46S655AB9fh12XDYUsPYcwH5EeRxx84QFfk8JE8KCiJVSireHFlgHai5ohA
         b3q/pqDVxyiQMOaoOXagXwqP/bMC1/CZ+CT3IxAVl/ZURzmgNwnRVeV/SqtnjzQRrx7Y
         Ih+b1xt/VvJWvjqrTfi9RzqT7vFsIWvMCT5xDjbkv4/DuH6+5J3kKqpsciKIVWg/OQS4
         WuxdKXninizlSxRRgzpzKBFLtvVNhfM50UfLmo6if0sjZW7vgKBNG7jOjXXzDBP1em3m
         kwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrwfrIKrYFfamy4c5vzLtem+Xc73qRM6JZjJ2gik+Hc=;
        b=XlVQoNmRhwobl79ET60TpKv02TST5jLP660No/FUhtv2xmXTwVO9TXy7EJfwZO/W2e
         w0slmpgtbvUAsehZcByFFyQdx2ZbPHHFEj+rj1CW1+fGowqx6VeC9YNTMen8ank5cele
         /GA4i+9TMDnYBQHrYtrNA5IL4C9h2UQSCov5pJ3D9Nh3YCuBsIxaF01Wso7sCsHwZiBv
         oWTarR+JPXpkE/vFiBoxBPpfiXZnNf36WS3COraWx7V0k7zF0u2NRJZJUH4klJ9m5NVT
         SdXZ6QILrWyerJJUnCaeuz1A8bUWxZd/6ld8XBq4y83oU57x/bbOU8oK/zHpbwbfztlv
         B8uw==
X-Gm-Message-State: APjAAAU+IHXG+Bq16cYRtIT0W8Oh8IV+BYuYvF72k4aoiS3uJiG5yLs8
        x46DPJCUIphDhWLQs5PvzUi0Kw==
X-Google-Smtp-Source: APXvYqxvdiimPN6REXGqxrbIhOO5sIqtbXFrvpnzU/YAZRZkclAjxlZDYw6lM2NKBwaTeayPp6AhNA==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr11720190wrr.119.1565613704212;
        Mon, 12 Aug 2019 05:41:44 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p13sm37961458wrw.90.2019.08.12.05.41.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:41:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] tools: iio: add .gitignore
Date:   Mon, 12 Aug 2019 14:41:41 +0200
Message-Id: <20190812124141.9108-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The generated files must not be tracked by git. Add a local .gitignore.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/iio/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/iio/.gitignore

diff --git a/tools/iio/.gitignore b/tools/iio/.gitignore
new file mode 100644
index 000000000000..3758202618bd
--- /dev/null
+++ b/tools/iio/.gitignore
@@ -0,0 +1,4 @@
+iio_event_monitor
+iio_generic_buffer
+lsiio
+include/
-- 
2.21.0

