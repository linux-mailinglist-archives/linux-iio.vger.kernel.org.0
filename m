Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC80225A4E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTIr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 04:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgGTIr7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 04:47:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E2721775;
        Mon, 20 Jul 2020 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595234879;
        bh=na4KJuLSwKS4s7MQTYSnNs4UNW3KBGX1bzmNlUY31Bo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nf5qoLbb8B1nZe9ODA2A89nnkZSH/c+zQFFslff/2omFHtK3+kOWdFwrC/iL+zHyI
         J6mPKuHDzUz3g7NJ3eX9HRheZudxw7nIaSVYpLT1Wuc4MjoQNOGMVSnIHhO6wkpwya
         V7qUbqsgbxgxzZwOKDyRQ8A4i7RHqSogLHMcNcwE=
Date:   Mon, 20 Jul 2020 09:47:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: chemical: atlas-ezo-sensor: add support for
 O2 sensor
Message-ID: <20200720094755.62e588a5@archlinux>
In-Reply-To: <20200720070330.259954-1-matt.ranostay@konsulko.com>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jul 2020 00:03:27 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add support for Alas EZO O2 sensor, rework driver to allow this to be done, and
> added IIO_MOD_O2 modifier.
> 
> Changes from v1:
> * rebased on modifier changes for IIO_MOD_H2/ETHANOL string identifiers
> 
Series applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> Matt Ranostay (3):
>   iio: add IIO_MOD_O2 modifier
>   dt-bindings: iio: chemical: add O2 EZO module documentation
>   iio: chemical: atlas-ezo-sensor: add support for O2 sensor
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  2 +
>  .../bindings/iio/chemical/atlas,sensor.yaml   |  2 +
>  drivers/iio/chemical/atlas-ezo-sensor.c       | 74 ++++++++++++++-----
>  drivers/iio/industrialio-core.c               |  1 +
>  include/uapi/linux/iio/types.h                |  1 +
>  tools/iio/iio_event_monitor.c                 |  2 +
>  6 files changed, 63 insertions(+), 19 deletions(-)
> 

