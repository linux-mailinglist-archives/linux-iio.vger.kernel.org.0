Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5604E884E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiC0O7u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiC0O7t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 10:59:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C8B2BF3;
        Sun, 27 Mar 2022 07:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A9B4B80BEC;
        Sun, 27 Mar 2022 14:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D9C340EC;
        Sun, 27 Mar 2022 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648393086;
        bh=8lIko6mJwkpTvm5lEokpGEKrsooA240QrxLFkeg3is8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A5bNTLIsuNOMcsotbLzkLxJKsqP5HLsP1e2oSgNlU5iuF4FKM6mkkGQJVydMX5/7j
         uzVWK3NcXDgnlyizRgCMowvV9XfKZl2xjdb34NXbX6tRHitRLpk/JGtcNx7cXoTRjA
         9PjI7ziOTRoQCGsVVtjkt/my1sUUTL0u0CH2PfXYUbMElB4abZJKmM094NK/Ea8/r0
         ZZfsP5fG8ixKs0QUT/kUA97NOSnVcvYUbMxEKIrXYlM0aMoLRp73nDs57QolzL08Xu
         vC3nxFWar3qUOgZC7TguA0B+hi8CTuMFqCDZMawpr/IvCttt5TvULV8o7z8hfpWOwa
         F2J3YJYOKO7wQ==
Date:   Sun, 27 Mar 2022 16:05:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     michael.srba@seznam.cz
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: imu: inv_mpu6050: Add support for
 ICM-20608-D
Message-ID: <20220327160530.41befccc@jic23-huawei>
In-Reply-To: <20220323121550.16096-1-michael.srba@seznam.cz>
References: <20220323121550.16096-1-michael.srba@seznam.cz>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Mar 2022 13:15:48 +0100
michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> This series copies the invensense icm20608 support in the inv_mpu6050
> driver for icm20608d, which is for all intents and purposes identical,
> except for the inclusion of a DMP (Digital Motion Processor), which
> is deemed significant enough to change the WHOAMI value, thereby making
> the driver fail if the invensense,icm20608 compatible is specified.
> 
> Since the driver doesn't currently acknowledge that there is such thing
> as a DMP core, all that is needed is to copy the icm20608 support and
> change the WHOAMI value.

Series applied to my local togreg branch, but I'll be rebasing that after
rc1 so for now only pushed out as testing to let 0-day see if it can
find anything we missed.

Thanks,

Jonathan

> 
> changelog:
>  -v2: require specifying "invensense,icm20608" as a fallback compatible
>       in the binding, as suggested
>  -v3: fix indentation issue with the binding
> 
> Michael Srba (2):
>   dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
>   iio: imu: inv_mpu6050: Add support for ICM-20608-D
> 
>  .../bindings/iio/imu/invensense,mpu6050.yaml  | 34 +++++++++++--------
>  drivers/iio/imu/inv_mpu6050/Kconfig           |  4 +--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  9 +++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  6 ++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  5 +++
>  6 files changed, 43 insertions(+), 17 deletions(-)
> 

