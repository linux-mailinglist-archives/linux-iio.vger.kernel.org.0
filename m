Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4725BA06E
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 19:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIORfZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIORfW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 13:35:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057069DB55;
        Thu, 15 Sep 2022 10:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E1EDB821A0;
        Thu, 15 Sep 2022 17:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7490AC433D6;
        Thu, 15 Sep 2022 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663263314;
        bh=D1t3k4ImZ9DyXM8y1sx3W8ThBi+stGoejFBGhghMx/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CoTCEFEXRpKL7KpYxCJu4puBhMOY3BWmeiDh+m3LLiNBicb6sTCkbddn2oUNRiVWr
         Zo+XHoceyWtMEVKgdfisIYXND8Aw368Uy88d9Kdv2W5TQf+olRpCMkGu7pPGyWjpMI
         f7Aj/PSLu3t0idybmJh1Ao/RckhpPXxXNGHivR/UlkfuK5NnEKA7h+qgb58wIHOV1v
         K3kOOKD14iEzkwxUAvaXbQK7ORtoQjTLVC9O8b/AgDHYRF1ZV3kIjPEBdUcntBxCpm
         rlCAaDE9p4DV0TH5NC7FaKiO5eTQCDP2TJZ/bFAyF+KwGt0E020MT2Fb49xblo0EQ5
         nbgTivw20sjCg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dstx device bindings
Date:   Thu, 15 Sep 2022 19:35:00 +0200
Message-Id: <dadc2acf88b0b73feac9a8980ad9af1658297bc1.1663262890.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663262890.git.lorenzo@kernel.org>
References: <cover.1663262890.git.lorenzo@kernel.org>
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

Add device bindings for lsm6dstx IMU sensor.
Use lsm6dst as fallback device for lsm6dstx since it implements all the
features currently supported by lsm6dstx.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index 0ceb29fb01b7..fe1e02e5d7b3 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -35,6 +35,9 @@ properties:
       - items:
           - const: st,asm330lhhx
           - const: st,lsm6dsr
+      - items:
+          - const: st,lsm6dstx
+          - const: st,lsm6dst
 
   reg:
     maxItems: 1
-- 
2.37.3

