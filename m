Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD0214799
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDRAR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDRAQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:00:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D04D2064C;
        Sat,  4 Jul 2020 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593882016;
        bh=EPRCEo3CPvecZllK0XrguMxXwf2n1bD9aNgDCMzllf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdGd+0AMhxcrW8fsE8khRXtdcyBX73w5/eBJzBTPKahu6ZFFr++eXfIvqnMy8PYbB
         mh/fWzThKKBZ/2ibWTC568LkfDx0PXllVIrOcPXOMM++xoqkhCWhA2NYY8BqbBTMqv
         2UVIoAsrgDNEdEBlIHhv7SzEIV924j0D5lVfhuSU=
Date:   Sat, 4 Jul 2020 18:00:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 08/23] iio:adc:cpcap-adc: Drop of_match_ptr protection
 and use device_get_match_data
Message-ID: <20200704180012.68a10bb3@archlinux>
In-Reply-To: <20200629152111.GO53169@atomide.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-9-jic23@kernel.org>
        <20200629152111.GO53169@atomide.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jun 2020 08:21:11 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Jonathan Cameron <jic23@kernel.org> [200628 12:40]:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Part of a slow effort to avoid OF specific code in IIO.
> > 
> > Whilst the main advantages of this are not likely to be seen in this
> > particular driver (ACPI support via PRP0001) the change proposed
> > does make things a bit more maintainable and also ensures that
> > this particular (now) anti-patern is less likely to be cut and
> > paste into new drivers.  
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


