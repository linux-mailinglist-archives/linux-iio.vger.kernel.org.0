Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4224E6F0
	for <lists+linux-iio@lfdr.de>; Sat, 22 Aug 2020 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHVKoI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Aug 2020 06:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHVKoH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Aug 2020 06:44:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B285E206BE;
        Sat, 22 Aug 2020 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598093047;
        bh=meJmEjFRlB1QI1uBtV7Y0+W0GJYcPJyhfPeQ0hUUVIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XkCcDK3Bfv/h00ARERSsvgcU/QzqiGe2+JLT0Rax8ImT0VK20LhdYCZcj+N5oVymq
         8gjY+kglB7EYsW/2vua2GLlY6HuE5Ycz+bbh7yZgptdYwcnqhXGfVv1T10rmgP1W27
         Pd0Xaz74vnX2g/6+yZ589YW+Bs/A8vxk00Or02H8=
Date:   Sat, 22 Aug 2020 11:44:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: Use kobj_to_dev() instead of
 container_of()
Message-ID: <20200822114402.5dd84fce@archlinux>
In-Reply-To: <CAHp75Vf1C17eQzbuaxukzqxTgKO9Lv6fKDZ5JqfwMFWcvbMxFA@mail.gmail.com>
References: <1597892486-3236-1-git-send-email-tiantao6@hisilicon.com>
        <CA+U=DsojNXFxT812=i-0ceRGUV3gJXhMMb-ungP=DO166jjZMA@mail.gmail.com>
        <CAHp75VdqrczNjsgR7JZTsK8+=RmgFopGJ1VZdD4+BYxBHMHukg@mail.gmail.com>
        <CAHp75Vf1C17eQzbuaxukzqxTgKO9Lv6fKDZ5JqfwMFWcvbMxFA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Aug 2020 16:07:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 20, 2020 at 4:05 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 20, 2020 at 12:10 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:  
> > > On Thu, Aug 20, 2020 at 6:04 AM Tian Tao <tiantao6@hisilicon.com> wrote:  
> 
> > > > -       struct device *dev = container_of(kobj, struct device, kobj);
> > > > +       struct device *dev = kobj_to_dev(kobj);  
> 
> > And now this can be one line since dev is not used separately.  
> 
> On the other hand perhaps one object per line is better to read.
> 

Indeed, not clear one way or the others, so I'm going with the path of
least resistance.  Applied as is.

Thanks,

Jonathan


