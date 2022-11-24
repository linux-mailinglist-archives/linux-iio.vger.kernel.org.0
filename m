Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1063746D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Nov 2022 09:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKXItt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 03:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXItt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 03:49:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92276CFA47;
        Thu, 24 Nov 2022 00:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47B76B82720;
        Thu, 24 Nov 2022 08:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3300C433C1;
        Thu, 24 Nov 2022 08:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669279786;
        bh=74rMi1fnFVj4Wd/xlpYIITFOJt6EYcXTgY4fVmwfo7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQFNOI07kKjjLyg00oMl0ct7frcN8Qn/1hQz6zwwwsTFIP8fl1ffxNqnS6kpaNdcJ
         bBy4WCSPqsNz5O9FkRtAV4RZOIdUk/aMKOl2w2kKk81zQbP5LndUUAfJmVjt5PkbBh
         p2E3ECy1kuyKxwNyMu++I8oYnqaYOiu4JmGIvcQcXOJ1IzqK99AX3NaoLfG9gQPTIg
         uxSa4W3zDSQ6zYT4GToHNvF8WYss9yJT4BWaVj9XO0R9iBqlLv3Ros68B8i82MvFnn
         YCFIXBdAODmCGc+ZepurOJKsr5dF0P2ubo6Mb3tsN0VDWkx6V8n73XE5aJJJniHfls
         guqOp9BkrSPAQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add ism330is
Date:   Thu, 24 Nov 2022 09:49:28 +0100
Message-Id: <a7a8a00037952928364269615ee8b6da4547795b.1669279604.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669279604.git.lorenzo@kernel.org>
References: <cover.1669279604.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device bindings for ism330is IMU sensor.
Use lsm6dso16is as fallback device for ism330is since it implements all the
features currently supported by ism330is.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 07d5aee7e442..68b481c63318 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -43,6 +43,9 @@ properties:
       - items:
           - const: st,lsm6dsv16x
           - const: st,lsm6dsv
+      - items:
+          - const: st,ism330is
+          - const: st,lsm6dso16is
 
   reg:
     maxItems: 1
-- 
2.38.1

