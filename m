Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA294ACC7C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfIHLmr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 07:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfIHLmr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 07:42:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FD5214D9;
        Sun,  8 Sep 2019 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567942967;
        bh=/HDDJYhRSk5/MEvjwhhL2jDKJvSFeoVaEW86c3UQsao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=trNu2x+GkTND6pQualXko8GDyUQkm6id1Vw3REWOJ8dm89t3sInKLttaLjdwxzRzq
         ZILWTz27pd3ep6hxUqdcnheDtsFhwj7clMlFktPfqoUL1uDnYJqUyObY5MP0LshC2F
         +HvHDD3gq83s4o6UiyfKnTpZ4kP6tcHcfnPKam58=
Date:   Sun, 8 Sep 2019 12:42:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/8] add magnetometer support for MPU925x
Message-ID: <20190908124242.21669f1f@archlinux>
In-Reply-To: <20190829151801.13014-1-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Aug 2019 15:18:33 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> This serie of patches adds support of magnetometer inside MPU925x chips.
> It is using the MPU i2c master to drive the integrated magnetometer and
> read data into the MPU FIFO.
> 
> Beware that this is disabling access to the i2c auxiliary bus. Since this
> can break existing setup, it is an optional feature requiring to enable
> the corresponding Kconfig option.

That's not great... People will fail to set that correctly for their
setup even if there is a 'correct' setting.

So we need more information to risk that breakage + discussions of
ways to avoid it.  Can we for example check if the auxiliary bus is
in use? (DT binding for example - check for the i2c-gate node?)

Jonathan

> 
> Jean-Baptiste Maneyrol (8):
>   iio: imu: inv_mpu6050: disable i2c mux for 925x under Kconfig
>   iio: imu: inv_mpu6050: add header include protection macro
>   iio: imu: inv_mpu6050: add defines for supporting 9-axis chips
>   iio: imu: inv_mpu6050: fix objects syntax in Makefile
>   iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bus
>   iio: imu: inv_mpu6050: add magnetometer implementation for MPU925x
>   iio: imu: inv_mpu6050: add magnetometer support inside mpu driver
>   iio: imu: inv_mpu6050: add fifo support for magnetometer data
> 
>  drivers/iio/imu/inv_mpu6050/Kconfig           |   9 +
>  drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
>  .../iio/imu/inv_mpu6050/inv_mpu9250_magn.c    | 239 ++++++++++++++++++
>  .../iio/imu/inv_mpu6050/inv_mpu9250_magn.h    |  27 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c     | 191 ++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h     |  46 ++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 141 ++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |   5 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  79 +++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 120 +++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    | 107 ++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  14 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  90 ++++++-
>  13 files changed, 1055 insertions(+), 21 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> 

