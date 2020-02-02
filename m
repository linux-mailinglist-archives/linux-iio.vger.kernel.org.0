Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD95714FE47
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBQZI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 11:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgBBQZI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 11:25:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BA320679;
        Sun,  2 Feb 2020 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580660707;
        bh=4fpAHuM+ORaLHkMigKzwC+4vFfeAAgSFS4zhLjmWCy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hRfKgmOYa0/m0I5C83M3OC2SNaJSoXCNK/7kjaOfDR2PaOeWQenvCYxTeXj96kpiQ
         Wz1sA9La22Gsh6eZB2f89Rd8O8/uLSTwuz3YtuJ/m8sI/daFrT2h3YCgnUY7zKJHKR
         DOaiYZFPUpk7pH8D1H2jfNOdtSC7UX266wiaIYfc=
Date:   Sun, 2 Feb 2020 16:25:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: st_sensors: handle memory allocation failure
 to fix null pointer dereference
Message-ID: <20200202162502.0ab50117@archlinux>
In-Reply-To: <CACRpkdYzd13xu9ETj_a4eWrm4FMrVnF1NQ5G+=d_Ch=6SzRoxA@mail.gmail.com>
References: <20200121161757.1498082-1-colin.king@canonical.com>
        <CACRpkdYzd13xu9ETj_a4eWrm4FMrVnF1NQ5G+=d_Ch=6SzRoxA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jan 2020 16:28:28 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, Jan 21, 2020 at 5:18 PM Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > A null pointer deference on pdata can occur if the allocation of
> > pdata fails.  Fix this by adding a null pointer check and handle
> > the -ENOMEM failure in the caller.
> >
> > Addresses-Coverity: ("Dereference null return value")  
> 
> That's a weirdo tag, but I suppose you have aligned with the maintainers
> about this.
> 
> > Fixes: 3ce85cc4fbb7 ("iio: st_sensors: get platform data from device tree")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

