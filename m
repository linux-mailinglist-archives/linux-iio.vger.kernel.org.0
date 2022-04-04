Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81834F1B72
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379641AbiDDVUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380274AbiDDT0y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 15:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5B826AD7;
        Mon,  4 Apr 2022 12:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F1F860DBB;
        Mon,  4 Apr 2022 19:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5A6C340F3;
        Mon,  4 Apr 2022 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649100296;
        bh=xbUUSTK4wSRu3PbpVb8AbFIrqXyQu92fvkR4B6utvhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzTu/LZAIvL4f+SkqO1zimkGwL7fg/GO/gur2/irciIVpMP1wPiCDUk/0RRaCrJRb
         EnN1FtPdWSIRBFAJYUSVJo11mQLG+Aslo/Z4EkxR6pokQWfPxVVVehc8q51lD6nLJD
         Fr5u0V4GrTTLFqzoTQ31qc7DYI/orsp55b3ecxRkDOIJwIUK2mPWUYjz1sWdKSYR2G
         jzXayzJmwX7V5xaA+ZtEUqsuBTRcXLyggdjYEAn6MEzrc/Sfjs6FPGpk+mxyqVitJt
         CrE4jqwONCyez9vwKyK9d9Ojvh9EEkrWKdvw6pphAV/uIL7SNQFyua/DfWERet0jtp
         WdJfL1MDPbO8Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH v2 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings
Date:   Mon,  4 Apr 2022 21:24:44 +0200
Message-Id: <2e5304b7e11085d4e701b4b591fd79cc54f01301.1649100168.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649100168.git.lorenzo@kernel.org>
References: <cover.1649100168.git.lorenzo@kernel.org>
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

Add device bindings for asm330lhhx IMU sensor.
Use lsm6dsr as fallback device for asm330lhhx since it implements all
the features currently supported by asm330lhhx.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/iio/imu/st,lsm6dsx.yaml          | 38 ++++++++++---------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 0750f700a143..5d4839f00898 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -14,23 +14,27 @@ description:
 
 properties:
   compatible:
-    enum:
-      - st,lsm6ds3
-      - st,lsm6ds3h
-      - st,lsm6dsl
-      - st,lsm6dsm
-      - st,ism330dlc
-      - st,lsm6dso
-      - st,asm330lhh
-      - st,lsm6dsox
-      - st,lsm6dsr
-      - st,lsm6ds3tr-c
-      - st,ism330dhcx
-      - st,lsm9ds1-imu
-      - st,lsm6ds0
-      - st,lsm6dsrx
-      - st,lsm6dst
-      - st,lsm6dsop
+    oneOf:
+      - enum:
+          - st,lsm6ds3
+          - st,lsm6ds3h
+          - st,lsm6dsl
+          - st,lsm6dsm
+          - st,ism330dlc
+          - st,lsm6dso
+          - st,asm330lhh
+          - st,lsm6dsox
+          - st,lsm6dsr
+          - st,lsm6ds3tr-c
+          - st,ism330dhcx
+          - st,lsm9ds1-imu
+          - st,lsm6ds0
+          - st,lsm6dsrx
+          - st,lsm6dst
+          - st,lsm6dsop
+      - items:
+          - const: st,asm330lhhx
+          - const: st,lsm6dsr
 
   reg:
     maxItems: 1
-- 
2.35.1

