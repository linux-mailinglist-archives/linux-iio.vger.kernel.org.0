Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765C517472C
	for <lists+linux-iio@lfdr.de>; Sat, 29 Feb 2020 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgB2OFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Feb 2020 09:05:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgB2OFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Feb 2020 09:05:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id u3so2382111plr.9
        for <linux-iio@vger.kernel.org>; Sat, 29 Feb 2020 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=0Wg9/zfrqeQTxFTAVntMjcBHDKBu0oSKIa1cm5v5zzU=;
        b=tXYzdkrLKmFbwucPiRDys6E5pK65wETyOHAKjJn/1sLwMO7jpYU0vc5b9jPW2+ZUfX
         mVdvg58pjgf+OnR4c2xGez52FLCWPNgrAFyhz1NLLv2G3VKGlUHSpHbE6cElr+RAcmgd
         wkSbn/Ipj4p4/AC3QQYI+BO9u4MXIQwJoXBO8WNWpVtCL5kvZ4/6B2nl1Qv34lJOwqZk
         MmXAapf8MB2+yWpBNYWm3FX+P++oczppoXKYMBe9ULBsxW59P8/n+H8U7OZ0ip93Z46M
         xHi61nJ3fop6n7Ol01ULNrccFEnSp/yPTgw6FcFbkG8Cn+ui3szZ0kqB5/uqaMlJJTTe
         PArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=0Wg9/zfrqeQTxFTAVntMjcBHDKBu0oSKIa1cm5v5zzU=;
        b=dFcPJEFfOmVcX5W/rXPQZwIcRjXru17mT3EuFgVt9b7bxg0+Jwd8LVuvLwbrRfq6A9
         giXjR9VlmPuNSKfH5Z7NhuKhGdlPi5vUoIhJ4W64QqxFt+ZC+PpyJgaR9XIIeHq+lQpZ
         wOg1bXjJy0yXu7YBTrurMV0LPQ18gqV9zwAtdT83QA8Jhu6juQc7CmD2TKY7gsW4Yafk
         DY5h5Ie4rOIGIIGSuZ55Kt2en2urwWT2wvJD7Yl3OlpEW3UItSAx52ynmCOg5HN3V2fP
         opYLXwQnErvhGlt8+46+r8GgXTlF6pSAEaOd3z5DTOtcKfGXoZYdTtzTv82uhXy4gpJ+
         uTbA==
X-Gm-Message-State: APjAAAUtk9qdsAjpaMhXeHxF8249ZR5DQW3VF6/sMdGLoz7uRUNhHsjR
        E+fi93qMbKb56HwLzos3cR8=
X-Google-Smtp-Source: APXvYqy8wfTx7MgfbrBdcWr+vKL7O3VfSPsdQm6MlZjEhO5Obp2zPKydy7tv5+gB1cKU+6wjwFZ+cw==
X-Received: by 2002:a17:90a:f17:: with SMTP id 23mr9814574pjy.84.1582985150059;
        Sat, 29 Feb 2020 06:05:50 -0800 (PST)
Received: from SARKAR ([49.207.56.215])
        by smtp.gmail.com with ESMTPSA id x66sm2635781pgb.9.2020.02.29.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 06:05:49 -0800 (PST)
Message-ID: <5e5a6fbd.1c69fb81.f08c3.4cf0@mx.google.com>
X-Google-Original-Message-ID: <20200229140545.GA1507@rohitsarkar5398@gmail.com>
Date:   Sat, 29 Feb 2020 19:35:45 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, grekh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3] staging: iio: update TODO
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since there are no uses of the old GPIO API, remove the item from
the TODO.

Changelog
v3: Remove new items added.
v2: Add work item mentioned by Alexandru in
https://marc.info/?l=linux-iio&m=158261515624212&w=2

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/iio/TODO | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 1b8ebf2c1b69..4d469016a13a 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -1,10 +1,4 @@
-2018-04-15
-
-All affected drivers:
-Convert all uses of the old GPIO API from <linux/gpio.h> to the
-GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-lines from device tree, ACPI or board files, board files should
-use <linux/gpio/machine.h>.
+2020-02-25
 
 
 ADI Drivers:
-- 
2.23.0.385.gbc12974a89

