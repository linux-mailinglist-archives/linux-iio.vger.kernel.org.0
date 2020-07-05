Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8A214CB7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGENY5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 09:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgGENY5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 09:24:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A2E2073E;
        Sun,  5 Jul 2020 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593955497;
        bh=baE8WZDGZfZdYGcI1rE+Nsp68GFQ6Go2w1FzG6kWu0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=chL3EswIieXml62axKfiTlPKmflnetNfBzMw2W14YZPqtVSOXoN4DtjBhtTj8USgr
         ovgwjojgrX4G9SFGnir6Q0jc0fwwJmDYpW/+6n7cG2n3RcuXNHBZF5j2najBilDRND
         c9TRvyOh+TN1pZwthvi9HScb1u7B8QmYa1ZaKxjk=
Date:   Sun, 5 Jul 2020 14:24:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 11/32] iio:light:st_uvis25 Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200705142452.2cdd7227@archlinux>
In-Reply-To: <CAHp75Vea7Haj7ZwHOytHXfDB5ywCWSU6UoK3jZBBK+_-mpZ3Ow@mail.gmail.com>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-12-jic23@kernel.org>
        <CAHp75Vea7Haj7ZwHOytHXfDB5ywCWSU6UoK3jZBBK+_-mpZ3Ow@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Jul 2020 15:05:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 7, 2020 at 6:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> ...
> 
> > +       /* Ensure timestamp is naturally aligned */
> > +       struct {
> > +               u8 chan;
> > +               s64 ts __aligned(8);
> > +       } scan;
> >  };  
> 
> ...
> 
> > -       err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
> > +       err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR,
> > +                         (unsigned int *)&hw->scan.chan);  
> 
> Despite knowing that this is okay, from a language perspective this
> casting is not good. Potential mine for all kinds of static analyzers.
> 
> I think it should use a temporary unsigned int (or what regmap API
> wants) variable.
> 
Good point. Dropped for now. Will revisit.

Thanks,

Jonathan

