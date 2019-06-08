Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D662439C50
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFHKBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 06:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfFHKBt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 06:01:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB561214DA;
        Sat,  8 Jun 2019 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559988108;
        bh=VxUpXuFY/lVkCuNer53WeeVgBD8oF05e070wMrjzqdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ufq5SCUMJvvLQsVUgksCEQDyjg2BydCTu6DURdyv/kfYjdl2c4gVL4B2HyoEwTSM4
         sFitYUKQdnlVl5JIL9evG1ZF9Rn0izqK7uSvqEHGllgqafaujh286lQrSalMTcCtvW
         fSPw3qsGoKeAI2oELQU1JBDowk1qT2RptZEIeEQc=
Date:   Sat, 8 Jun 2019 11:01:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dirk Eibach <eibach@gdsys.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Removing ADS1015 driver from hwmon subsystem
Message-ID: <20190608110143.48a221bb@archlinux>
In-Reply-To: <4aaa9d0c-2ed9-ccd2-2d84-a5bda4ea4a23@roeck-us.net>
References: <4aaa9d0c-2ed9-ccd2-2d84-a5bda4ea4a23@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 7 Jun 2019 18:13:27 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi all,
> 
> there are currently two drivers for ADS1015 in the linux kernel:
> 
> drivers/iio/adc/ti-ads1015.c
> drivers/hwmon/ads1015.c
> 
> The driver in the iio subsystem provides more flexible support for
> the chip's capabilities. Even if the hwmon driver is removed,
> the iio->hwmon bridge can still be used and would provide the same
> information as before to the user. Existing devicetree entries
> for ads1015 both point to the iio driver. The platform include file
> is only included by the drivers, but not from any platform code.
> 
> With that in mind, keeping the hwmon driver around does not really
> add value. I suggest to remove it. Are there any objections or
> concerns ?

It is probably not worth the dance of creating a stub driver
in hwmon to bring up the iio->hwmon bridge but that might be
an option if anyone minds just dropping the ads1015 hwmon driver.

Thanks,

Jonathan

> 
> Thanks,
> Guenter

