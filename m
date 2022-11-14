Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D922628991
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 20:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKNTlo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Nov 2022 14:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiKNTlo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2022 14:41:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D91B1E5
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 11:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C0D61405
        for <linux-iio@vger.kernel.org>; Mon, 14 Nov 2022 19:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE1FC433D7;
        Mon, 14 Nov 2022 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454902;
        bh=3mdhgBXn2YRNoeus0YYzhgRPKkal1QzUvzYysA7CiUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SBydUblEcXwppNj3WDnh2Y4xGDj325gIZc+VdCGWluU0Vos/CnvLHyuLaP6UwAuud
         r7KTEmoXUPaLG0urBt1PQFmyQIpx2Tek/Uf7qHxpBzT6X4xRXiqXbFDgmYZ7ym6t3I
         1egMsarF63KSNCy9Mn5tXOArc1waFRp/HpOQDCMgjpRlp1u89tjTegbBBp6iApIMXi
         7bpw4meg2EK6jiBW9TdX6cG+OL0dVtp6K0/BUb0WaHa3q12VdWPCaLuBZKdGmd+Wjs
         nhKuelVOIpDDFyyxFGV/MQ5OOL9R3WE9nORHpVUkM6zbxYNu7trc9Vq/ranozHrY7J
         M9aKxigFFM97Q==
Date:   Mon, 14 Nov 2022 19:53:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix LSM6DSV sensor description
Message-ID: <20221114195359.1b18b956@jic23-huawei>
In-Reply-To: <653e14bf79bb88d8581d2bc42da2f784caaf3776.1668417770.git.lorenzo@kernel.org>
References: <653e14bf79bb88d8581d2bc42da2f784caaf3776.1668417770.git.lorenzo@kernel.org>
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

On Mon, 14 Nov 2022 10:25:34 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix sensor ODR description for LSM6DSV/LSM6DSVX
> 
> Fixes: 111a5f31345d ("iio: imu: st_lsm6dsx: add support to LSM6DSV")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index acb6101aec5d..b680682f9833 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -27,13 +27,20 @@
>   *   - FIFO size: 4KB
>   *
>   * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
> - *   LSM6DSTX/LSM6DSV/LSM6DSV16X:
> + *   LSM6DSTX:
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
>   *     833
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 3KB
>   *
> + * - LSM6DSV/LSM6DSV16X:
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 7.5, 15, 30, 60, 120, 240,
> + *     480, 960
> + *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> + *   - Gyroscope supported full-scale [dps]: +-125/+-250/+-500/+-1000/+-2000
> + *   - FIFO size: 3KB
> + *
>   * - LSM9DS1/LSM6DS0:
>   *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16

