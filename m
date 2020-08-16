Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140D2456B5
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgHPIiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 04:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgHPIiW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 04:38:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF56B2067C;
        Sun, 16 Aug 2020 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597567101;
        bh=HZ0nY3DKL4orBHBU7MEJ+GStWLgX85+oJU6g/uPMgUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cXQZT5+BO2vXQ5dNguRsQOasYjTJi7+l/gU4tHTYagD84wjHyBvA/ENvxBP4+kpfD
         /Z8bJNd4hUYV8eoytQJ/NR2qm9Y3wFQBkJ6KL6eaNqt50LZbhUPSRq6gcgzK4SIL2D
         as7zRj3vge5874Yr8zrHs1kjyKIXtCGEFcZiL+IE=
Date:   Sun, 16 Aug 2020 09:38:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] iio:temperature:mlx90632: Some stylefixing
 leftovers
Message-ID: <20200816093817.713a29b3@archlinux>
In-Reply-To: <CAHp75VecZuvF3fyQV=uGK8NBpTStbASqdR_1kxb0g6_nHdfvQQ@mail.gmail.com>
References: <20200813075125.4949-1-cmo@melexis.com>
        <20200813075125.4949-6-cmo@melexis.com>
        <CAHp75Vd0D_jq7S=ANLJ-JSTb6iD1vHVRs2cN25Y3sNWCC9L2Xw@mail.gmail.com>
        <CAKv63uvrrc6Qfr2FjzgnNsHC0maZWT1Zpo=WQZvMmGgtYL6-tw@mail.gmail.com>
        <CAHp75VecZuvF3fyQV=uGK8NBpTStbASqdR_1kxb0g6_nHdfvQQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Aug 2020 22:41:51 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 13, 2020 at 4:12 PM Crt Mori <cmo@melexis.com> wrote:
> > On Thu, 13 Aug 2020 at 13:01, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:  
> 
> ...
> 
> > > > -#define MLX90632_REF_12                12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> > > > -#define MLX90632_REF_3         12LL /**< ResCtrlRef value of Channel 3 */
> > > > -#define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
> > > > -#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */  
> 
> > > > +#define MLX90632_REF_12        12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
> > > > +#define MLX90632_REF_3         12LL /* ResCtrlRef value of Channel 3 */
> > > > +#define MLX90632_MAX_MEAS_NUM  31 /* Maximum measurements in list */
> > > > +#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
> > > >  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */  
> > >
> > > This was actually in doxy (perhaps kernel doc also understands this)
> > > format of description.
> > > Can you double check that the kernel doc is okay / not okay with it?
> > >
> > > If it is okay, perhaps it's better to convert others to that format
> > > rather than dropping it.
> > >  
> > It is indeed from doxygen and looking at other drivers it should not
> > be OK. I checked the docs and it does not say in fact. Maybe Jonathan
> > knows, but he was already OK with these changes in v1.  
> 
> I'm fine with either choice.
> 
I'd prefer to get rid of them as you have done.  

Jonathan


