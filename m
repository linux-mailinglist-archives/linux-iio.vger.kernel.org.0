Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6170636B52
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiKWUjJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 15:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbiKWUi7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 15:38:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B24B65;
        Wed, 23 Nov 2022 12:38:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6B861F04;
        Wed, 23 Nov 2022 20:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DDCC433D6;
        Wed, 23 Nov 2022 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669235936;
        bh=X5UvGspkqdrcBSBTrwwyleXvIPzCX8ElMS4fqRhZcV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FXO4DXQgI4g+s6EH3quFygzVfeoCoJEJyudVbDStSdl33VE8jyTiTlO7OBOzPFXMZ
         iJErLqRCE9eBhkfeKBN+c0D/4SDsfTFu6raNeTLBqxa/Tu6SGEiJe2TgTQQ3tSctm6
         rad70eEXocKJaWkLvlDPGkAk2fwkAoCzWfOZjExLqqTqsbU1ljwBOxSevfWYmkJF0l
         3cjlxKP0/00mMkbvByVdbxxvodMi/xR8JKkhqtk8kuPyUKYkDX1UkNSx1bGvH5WULF
         dZx6DT+aC4h1ewDEjYeG711jQ6vnHXHnHKJw3GaSV/AEY+GL1vRLvNa/HzHkdiPwli
         DhW1Yshp5uXeg==
Date:   Wed, 23 Nov 2022 20:51:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 0/2] add support for LSM6DSO16IS
Message-ID: <20221123205129.47528fa9@jic23-huawei>
In-Reply-To: <cover.1668605631.git.lorenzo@kernel.org>
References: <cover.1668605631.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Nov 2022 14:40:02 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support for LSM6DSO16IS IMU mems sensor
> https://www.st.com/resource/en/datasheet/lsm6dso16is.pdf
> 
> This series is based on the commit below:
Applied to the togreg branch of iio.git. I might push it briefly
out as testing, but need to get this into linux-next asap given where
we are in cycle so might skip that bit.

Thanks,

Jonathan

> 
> commit 1adcc208048826635bcdabb03d0f40744fea512e
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Mon Nov 14 10:25:34 2022 +0100
> 
>     iio: imu: st_lsm6dsx: fix LSM6DSV sensor description
> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to LSM6DSO16IS
>   dt-bindings: iio: imu: st_lsm6dsx: add lsm6dso16is
> 
>  .../bindings/iio/imu/st,lsm6dsx.yaml          |   1 +
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |   4 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 128 +++++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
>  6 files changed, 142 insertions(+), 3 deletions(-)
> 

