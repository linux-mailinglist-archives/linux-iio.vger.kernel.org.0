Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD40637469
	for <lists+linux-iio@lfdr.de>; Thu, 24 Nov 2022 09:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKXItk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 03:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXItj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 03:49:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E21095AE;
        Thu, 24 Nov 2022 00:49:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6000062028;
        Thu, 24 Nov 2022 08:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50663C433C1;
        Thu, 24 Nov 2022 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669279777;
        bh=OI5Hs9iv5mg7XShffN5CHAgfSl/gLhDUtT9EcnhW9MA=;
        h=From:To:Cc:Subject:Date:From;
        b=NND3WVoqoA6FtnrtUyDxVh8MSxLpmVfCJ72qesQy8fBkJ6B+ou1arsokKGade+f/N
         vKulDtg/EdsyOVXxyRp6gHI+lDbKHFMSxRL9adJ+XC4KAB9+pLvimPgeyqUAyNsoyE
         7tTst4kVSCAzpZQaTElXtsjBku4/slWBG6RBjhNFRI+BEuGfTXW4j6owKp9iCW2kyh
         pRLmrbieM/r+vYLZZJGlWbpoaIjEzzEZBm8jPw/DleXH/U8cDLyE/KBYyXSzm/4l/+
         WM/Izmmp4qLFHUqy8TF8xSTauPn0vSmMjzZ5/Yjh9jCEbuXSfDEq//FtjPrl+w3Ed7
         wwtbXCPCKfFMg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] add support for ISM330IS
Date:   Thu, 24 Nov 2022 09:49:26 +0100
Message-Id: <cover.1669279604.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Add support for ISM330IS IMU mems sensor
https://www.st.com/resource/en/datasheet/ism330is.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ISM330IS
  dt-bindings: iio: imu: st_lsm6dsx: add ism330is

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 drivers/iio/imu/st_lsm6dsx/Kconfig                        | 4 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 8 ++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
 6 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.38.1

