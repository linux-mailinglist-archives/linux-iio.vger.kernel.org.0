Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4B4F1B64
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 23:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379616AbiDDVUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380272AbiDDT0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 15:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136826AD7;
        Mon,  4 Apr 2022 12:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2F660DBB;
        Mon,  4 Apr 2022 19:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AD5C2BBE4;
        Mon,  4 Apr 2022 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649100291;
        bh=Udh0YThCObvpATKVHs+ovlwAEy4V2McaWjSLWOakQlU=;
        h=From:To:Cc:Subject:Date:From;
        b=NI5H9f00xsOksDyexOsO9ycqHIKjE+93cbiJlxCcHrWzW5rxwt1Gz34BkejP9+f8K
         Ac5JeGgvkO1wkb4DLzqZZpH1/18jFaR/kVd2lLuIvjoXQcrRQJPCXO8a9XjEo4scah
         kBTx/flBKZQZfbbCwEyvdE5WWsyBklYe7Vj89F8zjy5cNUctCyacp4yxJ5WefbtbWo
         ltUKz3+0qyRuc76ci6vGpP0rNoLTRzeWPqnyiE9XqvyWevjQ1FXC6o9YRdsvPPwYt9
         CN3IvcxwTLPWoAhVPiFrFuLe6+S/NjfJZkLzuI/czbhRg5pu7PGzW/KFKrFPhkFsvK
         OObnWxSrNSgUA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH v2 0/2] add support for ASM330LHHX
Date:   Mon,  4 Apr 2022 21:24:42 +0200
Message-Id: <cover.1649100168.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Add support for ASM330LHHX IMU automotive mems sensor
https://www.st.com/resource/en/datasheet/asm330lhhx.pdf

Changes since v1:
- use lsm6dsr as fallback device for asm330lhhx

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ASM330LHHX
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings

 .../bindings/iio/imu/st,lsm6dsx.yaml          | 38 ++++++++++---------
 drivers/iio/imu/st_lsm6dsx/Kconfig            |  6 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 +++
 7 files changed, 43 insertions(+), 22 deletions(-)

-- 
2.35.1

