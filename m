Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5C2C7948
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgK2NFk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbgK2NFk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:05:40 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DA8207FF;
        Sun, 29 Nov 2020 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606655099;
        bh=xx7MzuKcfpl36r9ROYFKhtBpZEpVJ9GhyYcvPpmmFe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=16nGWUcKYdvVA9XJarVXWRScFLLH5yLF/GxoHZ05S4Ia1qEO3DVJP5AyoiR9/5p+B
         E+3ogy0MIGoFtKx0jxewpKDe3ED1qZWjQAEo2drPz34bRdURa0lQMFEve+MCrtglWk
         ZoHpq61gIkiaVs6Nq9IFT98Mc1FJzOvd86A7ko2w=
Date:   Sun, 29 Nov 2020 13:04:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] add support for LSM6DSOP
Message-ID: <20201129130451.77d99f98@archlinux>
In-Reply-To: <cover.1606642528.git.lorenzo@kernel.org>
References: <cover.1606642528.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Nov 2020 10:43:05 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support for LSM6DSOP IMU mems sensor
> https://www.st.com/resource/en/datasheet/lsm6dsop.pdf
> 
> This series is based on "iio: imu: st_lsmdsx: compact
> st_lsm6dsx_sensor_settings table"
> https://patchwork.kernel.org/project/linux-iio/list/?series=392743
> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to LSM6DSOP
>   dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsop device bindings
> 
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
>  drivers/iio/imu/st_lsm6dsx/Kconfig                        | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 6 +++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
>  7 files changed, 20 insertions(+), 3 deletions(-)
> 

Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to do work their magic.

Thanks,

Jonathan
