Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399D64F0057
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347051AbiDBKL5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352566AbiDBKLz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 06:11:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B25AEED;
        Sat,  2 Apr 2022 03:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0564AB80687;
        Sat,  2 Apr 2022 10:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584A6C36AE3;
        Sat,  2 Apr 2022 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648894200;
        bh=xkZF2Cdqtvpw73MfFlb9tfh/cEitpBymXDCQVEybeP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUphiuEX8rtSJ2fl2MZI5k5Qikm8Nw5/dTdiT+g/u95PNizvKJuUIjSxIm28gMjod
         lS5rKNINTkLgW3tvtFxoDK2vc71oI3+zHNDXo4a2QKorZNinZ3N82HARXr7fn3PBGI
         kGsqC3vmePbJ5LlRcl7Laby7NAJQY6yGI7t8hMQY4oLB2teEJUuoNcwHL1anzG75h9
         O/jh+L8KhY2YEiq5F50KTqh0zoe75vKfx04lp7qlcb3+T4aUz0HzgqBgUFt0giODbG
         H+xZxAPGRYZ0lBTHFFWBPgqZbi/MrUdqK1D0QzskCbB1HzjN30Kyz6FSTBhcdZIfJk
         vYUAZ92QHRzrw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings
Date:   Sat,  2 Apr 2022 12:09:30 +0200
Message-Id: <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648893892.git.lorenzo@kernel.org>
References: <cover.1648893892.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 0750f700a143..23637c420d20 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -31,6 +31,7 @@ properties:
       - st,lsm6dsrx
       - st,lsm6dst
       - st,lsm6dsop
+      - st,asm330lhhx
 
   reg:
     maxItems: 1
-- 
2.35.1

