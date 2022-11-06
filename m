Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F861E29A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKFOh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 09:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiKFOh0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 09:37:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9061DEBD;
        Sun,  6 Nov 2022 06:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E437B80B84;
        Sun,  6 Nov 2022 14:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E7EC433D6;
        Sun,  6 Nov 2022 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667745442;
        bh=lEmMXkI65I+vZOHq+Ifn2nzhYeBcOJil+zeWqGxFAjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErSd0asLFcSFs2bUUcXxJd23MpvsQVn0P3CfofoScEKDhzMelf298tZK1fXrPjYYr
         NnkhaIrLIG27/2YJ8M1jn5Di9jFR1V9+pSIPGIfgFJNR/KlYPHuncd+NfBZDswZDAT
         KyHXe8993DO8a2E1BKWm3mr2W0LIchyNm+5DFMQ44U/OYUKc8k5sVPMVV+4C+oVsX1
         i8MgITd4lHibRNtn/34RfiBNRHyzw45LOK0OJBXjEdw1HED+KPtbTSRUi8tlcBnpU9
         JC+5+I9uUYG4wXR/JLebac0DPvm8F5HCridCNddTyLoRkwYZBQy7RRBag0WWQ+XClN
         dVUYiaHcuK02A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv16x device bindings
Date:   Sun,  6 Nov 2022 15:36:54 +0100
Message-Id: <8d10a63ec6abd22863ab25addd8c2f578dbc9cd9.1667745215.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667745215.git.lorenzo@kernel.org>
References: <cover.1667745215.git.lorenzo@kernel.org>
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

Add device bindings for lsm6dsv16x IMU sensor.
Use lsm6dsv as fallback device for lsm6dsv16x since it implements all the
features currently supported by lsm6dsv16x.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index e7349a3275dd..5933270799f5 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -39,6 +39,9 @@ properties:
       - items:
           - const: st,lsm6dstx
           - const: st,lsm6dst
+      - items:
+          - const: st,lsm6dsv16x
+          - const: st,lsm6dsv
 
   reg:
     maxItems: 1
-- 
2.38.1

