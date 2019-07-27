Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5C77834
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfG0KmS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 06:42:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39550 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG0KmS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2019 06:42:18 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0EACC283CED;
        Sat, 27 Jul 2019 11:42:16 +0100 (BST)
Date:   Sat, 27 Jul 2019 12:42:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com
Subject: Re: [PATCH v6 2/2] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Message-ID: <20190727124212.3da89d41@collabora.com>
In-Reply-To: <20190721181656.236faa63@archlinux>
References: <cover.1563542515.git.vitor.soares@synopsys.com>
        <77c709aca8607f31f141ee7c4dc28bf89266bd23.1563542515.git.vitor.soares@synopsys.com>
        <20190721181656.236faa63@archlinux>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jul 2019 18:16:56 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 19 Jul 2019 15:30:55 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> 
> > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only in
> > spi and i2c mode.
> > 
> > The LSM6DSO and LSM6DSR are also i3c capable so let's give i3c support to
> > them.
> > 
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>  
> Great. I'll pick this up once Boris has that immutable branch
> available. Give me a poke if I seem to have lost it!

Here it is:

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/export-i3c_device_match_id

for you to fetch changes up to 934d24a5e1508e73c0001afb54a3916e4270428f:

  i3c: move i3c_device_match_id to device.c and export it (2019-07-27 11:22:19 +0200)

----------------------------------------------------------------
Needed for the st_lsm6dsx_i3c.c driver

----------------------------------------------------------------
Vitor Soares (1):
      i3c: move i3c_device_match_id to device.c and export it

 drivers/i3c/device.c       | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i3c/master.c       | 45 ---------------------------------------------
 include/linux/i3c/device.h |  4 ++++
 3 files changed, 57 insertions(+), 45 deletions(-)


