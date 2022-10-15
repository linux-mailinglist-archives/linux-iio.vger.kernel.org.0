Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C25FFB44
	for <lists+linux-iio@lfdr.de>; Sat, 15 Oct 2022 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJOQrF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Oct 2022 12:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJOQrE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2022 12:47:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46746222
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 09:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF6D4CE0AEE
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2022 16:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A3C433C1;
        Sat, 15 Oct 2022 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665852419;
        bh=iVOQPt2+PxOuRzX6ZWTKgOmgDKIFfA0MlxWpomuKuGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZbw1YU7LJp5Z2tWB8VN2G4kaL9hRD4lQEcKMtlaAkOuy5FcU1vC4a/2sGewMcrbm
         ZOlKaZu1cHVyMUFGcCWYBdbYS1rNwnroAnpGU7YlZom5l+qjr6zBKYJpNYeXgPPoJM
         QruCXMccLKBkRnwqh6cYchfZZxCJnGvjit3FtCCi4pwfDeJ7n2ZrA5Ne6+v9qmpq7w
         8pgLL+iHww8YqFZ+qrQYDP8dYWNXSaLtPuZavbHVynud0SAJI4yej99URFKdOJxG8l
         e07gzAQ5y9JC3nZhYoWsyOBLU+d9n69Veohyy53I+0InohW/ziBMpWmQmeE783w49i
         qo6yHFFS9tnqA==
Date:   Sat, 15 Oct 2022 17:47:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/5] IIO: Use EXPORT_NS_GPL_DEV_PM_OPS()
Message-ID: <20221015174725.00302615@jic23-huawei>
In-Reply-To: <20220925155719.3316280-1-jic23@kernel.org>
References: <20220925155719.3316280-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 25 Sep 2022 16:57:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I've included Paul Cercueil's patch from
> https://lore.kernel.org/all/20220813154902.32f86ee2@jic23-huawei/
> but my assumption is that will go via a different tree.
> It's just included here to provide everything needed to build these
> against current IIO tree / linux-next
> 
> V2: Switch to Paul's more flexible implementation.
> I've dropped all tags given as the form of the patches is somewhat different
> from in v1.
> 
> The aim is the same as v1 - moving the remaining IIO drivers over
> to the new PM macros that remove the need to mess around with
> __maybe_unused or ifdef magic.  They do this by ensuring the compiler can
> see all the code, and then drop it as unused if that is relevant.

Patch 1 is now upstream so 2-5 applied to the togreg branch of iio.git and
pushed out as testing until I can rebase that tree on rc1.

Thanks,

Jonathan

> 
> Jonathan Cameron (4):
>   iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
>   iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
>   iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
>   iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
> 
> Paul Cercueil (1):
>   pm: Improve EXPORT_*_DEV_PM_OPS macros
> 
>  drivers/iio/accel/fxls8962af-core.c           | 16 ++++----
>  drivers/iio/accel/fxls8962af-i2c.c            |  2 +-
>  drivers/iio/accel/fxls8962af-spi.c            |  2 +-
>  drivers/iio/gyro/fxas21002c_core.c            | 21 +++++------
>  drivers/iio/gyro/fxas21002c_i2c.c             |  3 +-
>  drivers/iio/gyro/fxas21002c_spi.c             |  3 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 21 +++++------
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 17 ++++-----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  3 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  3 +-
>  include/linux/pm.h                            | 37 ++++++++++++-------
>  include/linux/pm_runtime.h                    | 20 ++++++----
>  14 files changed, 84 insertions(+), 70 deletions(-)
> 

