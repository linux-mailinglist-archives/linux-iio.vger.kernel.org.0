Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AC36ABDB4
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCFLIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 06:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFLId (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 06:08:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14686EF81;
        Mon,  6 Mar 2023 03:08:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9066B80D79;
        Mon,  6 Mar 2023 11:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A68C433EF;
        Mon,  6 Mar 2023 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678100910;
        bh=mJ4aHO3Yyugfnd3hQZUREunikpHtgH4OCA9nSnaG1C8=;
        h=From:To:Cc:Subject:Date:From;
        b=kWupxwTiMKkWjqgY7TVwSVUo2c8fPRUniB51PfOM89lTUyI8DnUryAogmXV7LNT/w
         7PcL65/lzZ+wh6OpDrJJc6wfkeXdIlnM+Bv6H7/sEhKteSTj/jeAljwjjt/l5SU9dT
         SbD3TE4J4YWGv627aXqVfp1dSgqW5IsY3L4i8zHshhqa0N+WNxBoVsHmH2A7n2z9RW
         KDH8OuvCAlEcUAidmjyIcp+6v7qobiaI0Hat4WP2/NQRLkra2cTns/adYZOOqvDOnu
         NtvYfHxDECLwu+3xYfvIWoStXvxJIs6eYAUsI2/OTDRgWRO1K2M+iDtXAnKym5SdK0
         0a04NLYMWCiCQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] add support for ASM330LHB
Date:   Mon,  6 Mar 2023 12:07:59 +0100
Message-Id: <cover.1678100533.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Add support for ASM330LHB IMU automotive mems sensor
https://www.st.com/resource/en/datasheet/asm330lhb.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ASM330LHB
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
 drivers/iio/imu/st_lsm6dsx/Kconfig                        | 4 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 4 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
 7 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.39.2

