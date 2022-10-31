Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826DE6134AC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJaLmG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJaLlv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 07:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4589CE0BD;
        Mon, 31 Oct 2022 04:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4711611C8;
        Mon, 31 Oct 2022 11:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5314C433D6;
        Mon, 31 Oct 2022 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216509;
        bh=wZy34/2qvD5KcbCAj+Id9EYXK9BOJSPuJUKfFINyE8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpeHoSWSGyd3GYiXc5IAKS4qIH1INIffk7f3KYqkwuLKcZToIaXJ/N14aHmkAdLsH
         ItSWz2iweC5rTEtPwvJa3IlnP65M9xbZXHA/1fKq3HfQMI0elSEZ3n23bhdO9dhcyx
         Xj315m7DAhbLNqqkH15mTP4xaXl3JiiQ7qhOpF5gkJhUQCih8C9qLGKCmEAp5fvZ6A
         qeA7Royksf3Lr9Z58gCp4aXoi2XQce4CWlpgp/o6LBAqtN3ovFFgsLII0x8GSqLuFm
         yM0o1M5KILsbR0L3GIkPjvtgbQcr+d+5QWe2MwYwO6uGQOay9N01nBtw/tRXXjYtb5
         Z6N8PUxSRhYqw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv device bindings
Date:   Mon, 31 Oct 2022 12:41:26 +0100
Message-Id: <c34cea4468dc26050dff812f47e1a21f8e544758.1667216004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667216004.git.lorenzo@kernel.org>
References: <cover.1667216004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce device bindings for LSM6DSV IMU sensor.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index fe1e02e5d7b3..e7349a3275dd 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -32,6 +32,7 @@ properties:
           - st,lsm6dsrx
           - st,lsm6dst
           - st,lsm6dsop
+          - st,lsm6dsv
       - items:
           - const: st,asm330lhhx
           - const: st,lsm6dsr
-- 
2.38.1

