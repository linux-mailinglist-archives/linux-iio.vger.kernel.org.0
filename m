Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87722DEEE
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGZMVA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgGZMVA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:21:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667E7206D8;
        Sun, 26 Jul 2020 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766060;
        bh=TjEimKIfdXKPzHBwwNiIIQGXShL06seWROiBPi2ynEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/zFTwxS9ToI/gTpzplMBzWigB8Ej3wHwyrheyhwAMO5/upn78zsB8eI/nIHXFjkY
         TOG9ci4v6J8hC5s75Iyf03WupH2Lt/WoBZrPwzjHmsgHGB2nC3tFD3hN+adEqghQdt
         VSib7sKf7mDE68sQe+PNYNR1JLq3tVFkjPTm57qw=
Date:   Sun, 26 Jul 2020 13:20:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: chemical: atlas-ezo-sensor: add support for
 O2 sensor
Message-ID: <20200726132056.003cd2c2@archlinux>
In-Reply-To: <20200723062944.11438-1-matt.ranostay@konsulko.com>
References: <20200723062944.11438-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 09:29:42 +0300
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Changes from v1:
> * rebased on modifier changes for IIO_MOD_H2/ETHANOL string identifiers
> 
> Changes from v2:
> * change in atlas_ezo_sanitize() to use memmove()
> 
> Matt Ranostay (2):
>   iio: add IIO_MOD_O2 modifier
>   iio: chemical: atlas-ezo-sensor: add support for O2 sensor
> 
>  Documentation/ABI/testing/sysfs-bus-iio |  2 +
>  drivers/iio/chemical/atlas-ezo-sensor.c | 73 ++++++++++++++++++-------
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 +
>  5 files changed, 60 insertions(+), 19 deletions(-)
> 

Applied to the togreg branch of iio.git and pushed out as testing.
Unfortunately we are probably looking at next cycle now.

Thanks,

Jonathan
