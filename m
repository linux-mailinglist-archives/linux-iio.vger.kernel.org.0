Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A96D4FC1
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfJLMm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 08:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfJLMk2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 08:40:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE87A2087E;
        Sat, 12 Oct 2019 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570884027;
        bh=CCtm/Y7AomGQk3vQOXgRFA+Wi+O+ZbpH9Ju8lFL5Yy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GCGF4u1K1ewLYtrdjg1t0nDf99TPevgksILmoBjsFRA973XTbhwNmmrstJri/BcME
         FfFQ5faUAIMKDv7ASNNfHUhA9MrsNGSXc3J2/tWLhzgBJWqxsDNC5/MVU78l7sLYi9
         dxOeE3+QQpJjMPQEjKUOi441M2jMhgWh39Ks+VHg=
Date:   Sat, 12 Oct 2019 13:40:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] add support to STM LSM6DS0 6-axis Mems sensor
Message-ID: <20191012134023.1b0238ce@archlinux>
In-Reply-To: <cover.1570441034.git.lorenzo@kernel.org>
References: <cover.1570441034.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Oct 2019 11:43:36 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM LSM6DS0 6-axis sensor. Just compiled, but LSM6DS0 relies on
> the same register map used by LSM9DS1
I'm feeling paranoid. Is this definitely different form the
LSM6DSO which is already supported?

If so ST loose for stupid part naming.

Jonathan

> 
> Lorenzo Bianconi (2):
>   iio: imu: st_lsm6dsx: add support to LSM6DS0
>   dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0 device bindings
> 
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
>  6 files changed, 18 insertions(+), 2 deletions(-)
> 

