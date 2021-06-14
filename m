Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA13A6BEE
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhFNQgp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 12:36:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:12548 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhFNQgn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 12:36:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623688473; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=toC5UdsxFBQqduXXQffVPkrq1lWie0vUE46vkFJV1LjxEEJX6siX9l4UI5HYMgwp3J
    WzKM3tI7w6N5R8NQ+bRJzLRV6z+J2Zt8hlxi9hEhycVaHB86oFBERA6Jq6Af33Pzdrzc
    8K3Tys+T8NVlyfULuca6RFP9fzDdFcZWDTD6AXdJ/pabCI5CkraRZrTB7LAJki27zk5U
    nP4db9mp2qD7RpsI9TF7VibGwdH51vX1a1INcP5blPOcgogWDP5zGbf/BWcbPJeAW0YE
    rOdATLmqAtNagb7wddxjNGVPIaljQmnHB0FKOXhPW7S+vA6okne8KmN5TrD//B8cShBl
    kUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688473;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7ne9iqmWh4ykitKcQi2cUGb5m2K1oU3kgd5/O5RBBDw=;
    b=CR9x1v513pM/xpTOYknizERyrV0R41WHOC1tBnRcZ15FkWHYUjOlzZudEFBf0HS8rq
    /KIVEXgwqFItIMqwmTDV4zIUhSZn6TdnafL9RUWsfQ2wL6p243S3qlcGyvCDHv7qIXHW
    jNNsesGmmuiO6tQcskzmbsZGGoebnJoDaeE/ce7Yv8P6USLDSDb3h4L4p2atoDhqivaN
    W5iUVOrAHp7x/L5/tec+xp82VzSeaMYWFT8Am6ApNQ0PcyygC09m7ZmOjqS5HeE1loWk
    /jLjOTiT9Xnk2c4Bq5Y9RKkA7x2DKaLwovVePrQYzqnr5u2zJKwiU2NenFzjDo/encrc
    9fRQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623688473;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7ne9iqmWh4ykitKcQi2cUGb5m2K1oU3kgd5/O5RBBDw=;
    b=KUjx0Tln/3xcHFTsa5I6pH7TP/Xu7VZAiILN5qZHt9sSBkKKn98NhueHbnAyUFjCUp
    Pe7bI0Eorp0FCO6/1ntEyGYr48abHSRsy9dRx7kcg6UxGJedqacbVuncRt9isxrOJtHE
    GySE4AxTQaIy457W3oRWcCtEdIjiXR+OFJyL/K89d/koOuxAmt5uyvfGmy1k73axY2xF
    7EOAEO/SmRoDJSWvzKIIHZwhDQPtDU7Oac8mMJdHUZ4/kv1u36F4Y9whhV0JAJBnKMq8
    1420RAhO3D/FENAjFBdyxvDpb+/jhB4gisaIuf8ReF7SQBW6tFYzy1UPYnituCh81yGz
    7hTA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6NvdbT"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5EGYXJ6u
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Jun 2021 18:34:33 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/3] dt-bindings: iio: accel: bma255: Sort compatibles
Date:   Mon, 14 Jun 2021 18:31:49 +0200
Message-Id: <20210614163150.7774-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614163150.7774-1-stephan@gerhold.net>
References: <20210614163150.7774-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Similar to recent rework in the bmc150-accel driver, sort the compatible
list in the DT schema so there is a consistent order.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/iio/accel/bosch,bma255.yaml    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index b37ba902e4a2..f35c57b8105f 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -16,15 +16,15 @@ description:
 properties:
   compatible:
     enum:
-      - bosch,bmc150_accel
-      - bosch,bmi055_accel
+      - bosch,bma222
+      - bosch,bma222e
+      - bosch,bma250e
       - bosch,bma253
       - bosch,bma254
       - bosch,bma255
-      - bosch,bma250e
-      - bosch,bma222
-      - bosch,bma222e
       - bosch,bma280
+      - bosch,bmc150_accel
+      - bosch,bmi055_accel
 
   reg:
     maxItems: 1
-- 
2.32.0

