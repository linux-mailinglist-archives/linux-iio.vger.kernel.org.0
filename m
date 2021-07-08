Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C796C3C1C43
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 01:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhGHX7S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 19:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGHX7R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 19:59:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40523C061574;
        Thu,  8 Jul 2021 16:56:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i125so7547792qke.12;
        Thu, 08 Jul 2021 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxYklUz44zAQ3MzfouqUmQy/qiMtrAD9UXmtJKCtA/w=;
        b=kEiqnCuR7tMsrDslENNLgLV8ythWAXcMIpmWJ1qplv5s886wXjuWdHYg3ytilBi0VN
         eA3pKnPaPndNSeXEMe3rVAjcE63zXJPxzQ/3emcXVGCimXO1EXLWFY6K1dxc3fS5n5HT
         MzEiGLm8oMbZ/L6LFLefqg22J44//2ovMNnuaoiTrX/JqpwHByOPJdMw3frg6FL5FUke
         1Abi1w1HU5B9GUCe4SFRL+zerr71m9ldADTqHKLx6llGR9qu4E61mWuhy6vHeFU3/8QB
         +vAxM8n+RaIvwq/CjN9UeQE9FRLmuN89UdAL1mFwz5CyqjG2qKLepIjrO/sOOHMvU47W
         fOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxYklUz44zAQ3MzfouqUmQy/qiMtrAD9UXmtJKCtA/w=;
        b=ZC5b9OpX1rfNOAfiLP2PxCnl16pBfs4oli/qfmfp1QNoE20wFkq70OX2wqXmELr8TV
         3a08rJz/8Zb4F1upbP7yIookqyhX6b2n13laIc0/fkJ8cUnR7XHLCJbWfF/AvIqE4Ncr
         fsHuq5H88euw7HqAiJHxxkGOwSaAs0gIk/kpbB9nFz03tZeqPsAurW1ZgIzEg9gDstIX
         WaOgjbpn8c9BfTA4SNrLrVfpXSxyKTJZ8YamY3kYY9qDXPapbRG7cm127zhhFYwjVNfu
         vrvzAaubIdtCS9FY4TgGjOEg8I9t2X7oCiAEIaJ0CDeSI3FAG6VaBwY2wK4mV/KghEci
         8hPg==
X-Gm-Message-State: AOAM530ZGaH6WCz22ots/l2wDEJQIEEyQ052ALTgaAXmCMDkB52Hp6PO
        iVQ04yTL7aFe2RsgtNqr6tA=
X-Google-Smtp-Source: ABdhPJwm5rWvQ/I40uPncgyn0lV5qZM3h3Z7M1wIK4VMncyZjTP4Adn6ZZhAZ1iedD/qPFAwoJHkKg==
X-Received: by 2002:a37:8081:: with SMTP id b123mr34932677qkd.231.1625788593329;
        Thu, 08 Jul 2021 16:56:33 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m68sm1733234qkc.109.2021.07.08.16.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 16:56:32 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 0/4] AD7949 Fixes
Date:   Thu,  8 Jul 2021 19:56:14 -0400
Message-Id: <20210708235618.1541335-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While working on another series[1] I ran into issues where my SPI
controller would fail to handle 14-bit and 16-bit SPI messages. This
addresses that issue and adds support for selecting a different voltage
reference source from the devicetree.

This is base on a series[2] that seems to not have made it all the way,
and was tested on an ad7689.

[1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
[2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both

Thanks for your time,
Liam

Liam Beguin (4):
  iio: adc: ad7949: define and use bitfield names
  iio: adc: ad7949: fix spi messages on non 14-bit controllers
  iio: adc: ad7949: add support for internal vref
  dt-bindings: iio: adc: ad7949: add adi,reference-source

 .../bindings/iio/adc/adi,ad7949.yaml          |  22 ++
 drivers/iio/adc/ad7949.c                      | 191 +++++++++++++++---
 2 files changed, 181 insertions(+), 32 deletions(-)


base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

