Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CC6ABDB8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 12:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCFLIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCFLIn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 06:08:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FEF94E;
        Mon,  6 Mar 2023 03:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E54CEB80D99;
        Mon,  6 Mar 2023 11:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DEFC433EF;
        Mon,  6 Mar 2023 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678100918;
        bh=wrf7lgWdoNrOESaunxwp4Qf5wKYQR5fF6kIZkRfbk9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3ZEZ6dQsFvyB9YSnT51A7RcYl7bh0Xju4p/vj1UVJMPO0OfqgVmCZGfWr8Q5owYT
         DncFkl3ixR2CTpp+dsWP3b2YmHotBI7hvJTkT+r9TvBYUeD5LcNtOF6yzQ8XlxHBFk
         bQUO1Jy9b2yVG6Kl2x3Srz+/6m9E6TnrSYp3PWRSHJfqOJWRIlDf1I9D2SIN3iEDuU
         nTG60DxN8AWqGNK/9yB3GqJtLgAtzeHSezXzbaTi6PQFeV/laj2kp9of84TZPsAWeo
         dAKzWbT6E3S6xgojAMBBoHB14AxMm7+PpUkD1n1/DSuAhX7ze2NEqcc9AHcoAfeQ1g
         4KHxh2xspUnzA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb
Date:   Mon,  6 Mar 2023 12:08:01 +0100
Message-Id: <fecf1f20cc8e99fb8654cc733f14bd449ca7f87a.1678100533.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678100533.git.lorenzo@kernel.org>
References: <cover.1678100533.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device bindings for asm330lhb IMU sensor.
Use asm330lhh as fallback device for asm330lhb since it implements all
the features currently supported by asm330lhb.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index decf022335d8..b39f5217d8ff 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -46,6 +46,9 @@ properties:
       - items:
           - const: st,ism330is
           - const: st,lsm6dso16is
+      - items:
+          - const: st,asm330lhb
+          - const: st,asm330lhh
 
   reg:
     maxItems: 1
-- 
2.39.2

