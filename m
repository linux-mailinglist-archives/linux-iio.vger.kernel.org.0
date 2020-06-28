Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC920C9D8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgF1TQd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 15:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgF1TQd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 15:16:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F344C206F2;
        Sun, 28 Jun 2020 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593371793;
        bh=TK+rmjWQLyODDh9jTs8Zv7uXG6iVJsIGa7r7WUq1PxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BzVH1MzJGF3X7eMT/lIi3kM2W2KaU3enyknylP7x0X/ULwDvEkeaYbsY3Gj7DRPmZ
         MylHwUviJHImLhpcQpUXkitukRwByqH5UQ8MQlxsxfp5+uYTVFDub7jvzGTCESEICA
         mFBzI3wZ05DNqnrXBXXknRk1CGd42UwF3PM0OnTc=
Date:   Sun, 28 Jun 2020 20:16:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH 02/23] iio:adc:axp20x: Convert from OF to generic fw /
 device properties
Message-ID: <20200628201629.7c6541d6@archlinux>
In-Reply-To: <CAHp75Vdfe=5gwM9wRpVq5+OQeSALQOhcVyENUaNDaXZpYnnRyQ@mail.gmail.com>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-3-jic23@kernel.org>
        <CAHp75Vdfe=5gwM9wRpVq5+OQeSALQOhcVyENUaNDaXZpYnnRyQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 20:43:50 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Whilst fairly unlikely anyone will ever use this driver with anything
> > other than DT, we are trying to move IIO over to the generic interfaces
> > where easy to do so.
> >
> > In this case this involved moving to generic check on presence
> > of fw_node, generic device_get_match_data and dropping the of_match_ptr
> > protection.  Also relevant header changes to have property.h and
> > mod_devicetable.h only.  
> 
> ...
> 
> > -               info->data = (struct axp_data *)of_device_get_match_data(dev);
> > +               info->data = (struct axp_data *)device_get_match_data(dev);  
> 
> Casting is not needed, but if you remove it it reveals a hidden const
> qualifier drop.
> 

Doh.  I should have noticed the odd cast..

Will fix up.  Making info->data a const as well will tidy that up.

Thanks,

Jonathan

