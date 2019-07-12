Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9089C672D3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGLP6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 11:58:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLP6I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 11:58:08 -0400
Received: from linux.home (2a01cb0c80061e007f541addd69f0d47.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:8006:1e00:7f54:1add:d69f:d47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2D5DA28BBDA;
        Fri, 12 Jul 2019 16:58:06 +0100 (BST)
Date:   Fri, 12 Jul 2019 17:58:03 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com
Subject: Re: [PATCH v4 0/3] Add ST lsm6dso i3c support
Message-ID: <20190712175803.3e1f3ac8@linux.home>
In-Reply-To: <cover.1562931742.git.vitor.soares@synopsys.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Jul 2019 13:53:27 +0200
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> This patch series add i3c support for STM LSM6DSO and LSM6DSR sensors.
> 
> It is also introduced i3c support on regmap api. Due the lack of
> i3c devices HDR capables on the market the support for now is only for
> i3c sdr mode by using i3c_device_do_priv_xfers() method.
> 
> The i3c regmap api is already available in the Git repository at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
>   tags/regmap-i3c
> 
> Change in v4:
>   remover hw_id variable from st_lsm6dsx_i3c_probe()
> 
> Change in v3:
>   Update st_lsm6dsx_probe() call
>   Remove i3c_get_device_id() and use i3c_device_match_id()

Did not receive this v3...

> 
> Changes in v2:
>   Change i3c_get_device_id() to drivers/i3c/device.c
>   Add support for LSM6DSR
> 
> Vitor Soares (3):
>   regmap: add i3c bus support
>   i3c: add i3c_get_device_id helper
>   iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR
> 
>  drivers/base/regmap/Kconfig                 |  6 ++-
>  drivers/base/regmap/Makefile                |  1 +
>  drivers/base/regmap/regmap-i3c.c            | 60 +++++++++++++++++++++++++++++
>  drivers/i3c/device.c                        | 46 ++++++++++++++++++++++
>  drivers/i3c/master.c                        | 45 ----------------------
>  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
>  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 58 ++++++++++++++++++++++++++++
>  include/linux/i3c/device.h                  |  4 ++
>  include/linux/regmap.h                      | 20 ++++++++++
>  10 files changed, 202 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/base/regmap/regmap-i3c.c
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> 

