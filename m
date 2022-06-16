Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072AE54DF0C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359605AbiFPK0b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jun 2022 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiFPK0b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jun 2022 06:26:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFBB5D66B
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 03:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1B6CCE183F
        for <linux-iio@vger.kernel.org>; Thu, 16 Jun 2022 10:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B3C34114;
        Thu, 16 Jun 2022 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655375187;
        bh=DlICX59c9sC83k5bboEQmQIRUuMZyKR0KmarW+Dr/e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRVJNeoYslOvTmLinuMgCPK4IaWQinMMcyqxRIrSkvobShbmHWFrhDOYepAHIl7mM
         /mLfGxM/Yx6FqHCOfpAEfkbWpHMkhD6kjr5sbKQb5twY3K3ifGItjkKXzYbBrDNGZx
         8sBFrxFaP/kx2gGuJi2Sq7bhLFTaYMk9sapgDofg=
Date:   Thu, 16 Jun 2022 12:26:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 2/2] staging: iio: imu: Add CEVA BNO08x driver
Message-ID: <YqsFSrg+Q+jdsId/@kroah.com>
References: <20220616100006.22045-1-jacopo+renesas@jmondi.org>
 <20220616100006.22045-3-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616100006.22045-3-jacopo+renesas@jmondi.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 16, 2022 at 12:00:06PM +0200, Jacopo Mondi wrote:
> From: Jacopo Mondi <jacopo@jmondi.org>
> 
> Add support for CEVA BNO08x Sensor Hub.
> 
> The BNO08X family (BNO080/85/86) is a System in Package (SiP) that
> integrates a triaxial accelerometer, triaxial gyroscope, magnetometer
> and a 32-bit ARM Cortex-M0+ microcontroller running CEVA's SH-2
> firmware.
> 
> Datasheet:
> https://www.ceva-dsp.com/wp-content/uploads/2019/10/BNO080_085-Datasheet.pdf
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  MAINTAINERS                             |   7 +
>  drivers/staging/iio/Kconfig             |   1 +
>  drivers/staging/iio/Makefile            |   1 +
>  drivers/staging/iio/imu/bno08x/Kconfig  |  11 +
>  drivers/staging/iio/imu/bno08x/Makefile |   3 +
>  drivers/staging/iio/imu/bno08x/bno08x.c | 618 ++++++++++++++++++++++++

Why are you adding a new driver to staging/iio/ and not to the real part
of the kernel?  What needs to be done to it to get it out of here?

I'd prefer that we not add any new iio drivers if at all possible,
please fix them up properly and merge them to the correct location.

thanks,

greg k-h
