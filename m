Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9056134A7
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 12:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJaLlp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaLlp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 07:41:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243DE0A7;
        Mon, 31 Oct 2022 04:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15323B815E8;
        Mon, 31 Oct 2022 11:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E3C433C1;
        Mon, 31 Oct 2022 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216501;
        bh=C5BPpifklVBtFn4MGICfN4C4DOuCCD/+hZL7Cry+Nag=;
        h=From:To:Cc:Subject:Date:From;
        b=sVGcZw1yY86icyl00GA0iCa1mGowFABq14+J7ccqusNU0jjzMCCz2wqFM70kyYBG1
         9tVhyQq9RxkxuNay0dAC9t6/1ggbUsyBeD+ly4LMcvN2wm3nmTAQcduQB6XnAcQ/h+
         fLhwwgRM3rppL265ZpkzG8JApBHvxU2UzVHc+wMXgCpPAn/OY3cJuZ735XiSx57SGY
         IItgABSkiTsfCZDQsebixiiJWUxQrbchHM5ZMoO12HzgoGyCo5WsYbwCmumJxFd+7d
         jyQTJvKzosXC51kK6fpDKbOWAcEKGx0QkYwkeiX6Me8vnKgaO3iQU/kWngpRGL8+Dg
         JoAuF7b6XhOdg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] add support for LSM6DSV
Date:   Mon, 31 Oct 2022 12:41:24 +0100
Message-Id: <cover.1667216004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Add support for LSM6DSV IMU MEMS sensor
https://www.st.com/resource/en/datasheet/lsm6dsv.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSV
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv device bindings

 .../bindings/iio/imu/st,lsm6dsx.yaml          |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 202 ++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 7 files changed, 217 insertions(+), 2 deletions(-)

-- 
2.38.1

