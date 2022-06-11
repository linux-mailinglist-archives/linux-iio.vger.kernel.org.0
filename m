Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C4547718
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiFKSRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFKSRn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 14:17:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D922661
        for <linux-iio@vger.kernel.org>; Sat, 11 Jun 2022 11:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0971B801BF
        for <linux-iio@vger.kernel.org>; Sat, 11 Jun 2022 18:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F680C34116;
        Sat, 11 Jun 2022 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654971459;
        bh=H3oBy9gXWeIkjM+FFDePtiqZBQdIzcS/RN0udyc+gHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bUfntihh8xUehqXkE5/FVDzT9oaEuh1T52UAMBLYXcvVcIIksPBniw49/3Bh5Sywx
         682hldYZgpxxKk92k4PfMtJYUsHg0iGjlzXOhdjipyorKIQoM2OTVlJq+BKnEWxxPI
         UxWgcdyeYY7xDiOE8MXETbSXhbcVrM8QTieoLb1RG60iMJ9XkVxiXKPT7giZ+siBUd
         iLw8GrrQbaE64xEiMKcLEVrKhIgl0vF8maRt0llAcmTJb8hNmZ6z4iByvZdf3dL3Za
         wf17vwoP45v5rh/v/Hr73HDuUyVlaehwXzP+qKU3WViStfm/dud8mLnGrjpIIv+rTA
         rInELHBVs059g==
Date:   Sat, 11 Jun 2022 19:26:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH 0/5] IIO: Where dev_pm_ops rework and namespaces
 meet (4-8)
Message-ID: <20220611192649.2fd0085c@jic23-huawei>
In-Reply-To: <20220604161223.461847-1-jic23@kernel.org>
References: <20220604161223.461847-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Jun 2022 17:12:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Resend as the first part of this series went via Rafael's tree and is
> now available in mainline.
> 
> Hence time to return to the remainder which didn't really get much review
> the first time around as focus was on the more interesting new macros
> in the first few patches.
> 

4 out of 5 ain't bad. (remaining one is my driver so hard to lean on
anyone else to review :)

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan

> Now we have NS specific EXPORT_NS[_GPL]_SIMPLE_DEV_PM_OPS() etc
> we can move these drivers over to their own namespaces reducing polution
> of the global namespace with exports that are only of interest
> within multi module drivers.
> 
> All comments welcome,



> 
> Thanks,
> 
> Jonathan
> 
> 
> Jonathan Cameron (5):
>   iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio: humidity: hts221: Use EXPORT_SIMPLE_DEV_PM_OPS() to allow
>     compiler to remove dead code.
>   iio: humidity: hts221: Move symbol exports into IIO_HTS221 namespace
>   iio: imu: lsm6dsx: Use new pm_sleep_ptr() and
>     EXPORT_SIMPLE_DEV_PM_OPS()
>   iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX namespace
> 
>  drivers/iio/accel/kxsd9-i2c.c                |  2 +-
>  drivers/iio/accel/kxsd9-spi.c                |  2 +-
>  drivers/iio/accel/kxsd9.c                    | 11 ++---------
>  drivers/iio/humidity/hts221_core.c           | 12 +++++-------
>  drivers/iio/humidity/hts221_i2c.c            |  3 ++-
>  drivers/iio/humidity/hts221_spi.c            |  3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++-------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 ++-
>  10 files changed, 24 insertions(+), 30 deletions(-)
> 

