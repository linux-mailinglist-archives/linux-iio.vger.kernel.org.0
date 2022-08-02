Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF90587AB3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Aug 2022 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiHBKaL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Aug 2022 06:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiHBKaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Aug 2022 06:30:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36234D4E8
        for <linux-iio@vger.kernel.org>; Tue,  2 Aug 2022 03:30:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so4307042edd.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Aug 2022 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rF+GCEXwdxATecZyeuI/TKQNcD4cz1AO0dOhrmTk/4Y=;
        b=E7prI+9gCMNji/N+q7Sza5k9EuKf3XXqhJbi3DiFP8rYZmOCF+dda3p83tZVV3ShhG
         g8YrmU1brCoQNt17l70tBIFhrKKGnLjYA5j+oQyKQGl8An+BvCqSbZ12oFNmBaUUhZ+d
         Vv6b1l7XT9bEiK0mgXZcIVv8cIjGMVEOAzga+gTFU0H1wMCQxt2Yi5eaTqSh49MbpKtF
         jg6HvWQEBe6b3cy2A+krSmW49pwKFXMSGd32NZ5/sLAuuYcifr7kCy4QhCB56G4XzXPq
         DxDB9NlzZFrs5iUP6VjkLZBA3m2QZeSPfm2D9DsD3HIZ182KxMJoMjGTJKi7+YfFQS7p
         VtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rF+GCEXwdxATecZyeuI/TKQNcD4cz1AO0dOhrmTk/4Y=;
        b=dCefFGiROoui+ao8YtHdakX/4qbVex+9ULO0HVHzFqqNR8/kAZTCbUf8QzMbWyFA5Y
         dFqo2l2+fWIH00ZT0KGnNMF+odWrQo8XM3XaExEWClKYbL5PGO2XvkFMr+CylnEbn1JY
         BDLYivq4okNrPD2UE+M7DvoVFavNJIdxlRVOwQNz61GuAdrVQKQ7ZIZQPS1AMvLgpHZe
         cWb00l+ypAU76HNM/g7YnKGHg3lh4Uiiitlgw/eFgMLKUTW4SbYiq7VIHXN11hTqVb60
         ik+eiHI0+dooHPMqYYAXMjnMWMIwV7DOwVhrFCsTxOy0MkEcfciwEZw9MnkR8dpFJiaw
         RWmQ==
X-Gm-Message-State: AJIora97H4QJqx+5rAx1RglLr4os4FClYOmGORDX0ksz+vLIKeunU7P8
        CdY+8wbfVwxlxG8yTzP7iD13Mw==
X-Google-Smtp-Source: AGRyM1tzeI6JDdJDoDILO95JNRJzwPjRtwLQTcfSkExBFinYtUNJt5eHZD68ZxcZKhHG7yEKd8F7kQ==
X-Received: by 2002:aa7:da92:0:b0:43c:c5af:d5c9 with SMTP id q18-20020aa7da92000000b0043cc5afd5c9mr20094111eds.10.1659436207138;
        Tue, 02 Aug 2022 03:30:07 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xh0y3uhn87zojrdbwi.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:733c:5cdf:8a1a:e482])
        by smtp.gmail.com with ESMTPSA id vs4-20020a170907138400b00730a234b863sm428686ejb.77.2022.08.02.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:30:06 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/2] iio: temperature: mlx90632: Add supply regulator
Date:   Tue,  2 Aug 2022 12:29:23 +0200
Message-Id: <20220802102923.423211-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add supply regulator to the sensor as initial update before proper power
management is presented. This will reduce the diff for the following
patches.

Crt Mori (2):
  iio: temperature: mlx90632 Add supply regulator to sensor
  dt-bindings: iio: mlx90632 Add supply regulator documentation

 .../iio/temperature/melexis,mlx90632.yaml     |  4 ++
 drivers/iio/temperature/mlx90632.c            | 52 +++++++++++++++++++
 2 files changed, 56 insertions(+)

-- 
2.34.1

