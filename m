Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD62C794E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgK2NJG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:09:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgK2NJG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:09:06 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A7E206DF;
        Sun, 29 Nov 2020 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606655305;
        bh=wH2cPci7f4at7FcXP6hBKILNEXRa0WqtVzobKIxAKpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sseaHLJKgx0YzYaWzdaSJ5Cq341zbm6FDuY2wYsbis7PmNHDTXvB4rg7bOECZZKET
         Mnbm1qF1QMLZCDWK3A14w0QK/ik3nlzzQiNsRFEUu7LYFnnQri6XvX0UNNOGg1PHUz
         C1wMZ1A/L81eb6D87NYCddrNW4yRrV7nerD3LSFw=
Date:   Sun, 29 Nov 2020 13:08:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     andy.shevchenko@gmail.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] iio:core: Introduce unlocked version of
 iio_map_array_unregister()
Message-ID: <20201129130821.2cb07ce4@archlinux>
In-Reply-To: <b933efbe-133e-bece-5516-2ecf3dc120b0@gmx.de>
References: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
        <20201128135435.33e9f6ee@archlinux>
        <b933efbe-133e-bece-5516-2ecf3dc120b0@gmx.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 15:22:16 +0100
Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:

> Hi Jonathan,
> 
> On 28.11.20 at 14:54, Jonathan Cameron wrote:
> 
> > A few notes to make it harder for people to do that in future.
> > 1. Don't send patch series (or new versions of older patches) in reply
> >    to an existing thread.   They get lost and difficult to pull out.
> >    b4 can't automatically figure out which patches to pull from that
> >    original thread for example.
> > 2. Always version number whole series with same number, even if some patches
> >    are new.   So this should be v3.
> >  
> 
> Thanks for these hints, I will keep it in mind for future patch submissions.

Mailing list seems to have recovered so I can use b4 again :)

Applied to the togreg branch of iio.git and pushed out as testing so the
autobuilders can try to find anything we missed.

Thanks,

Jonathan

> 
> Regards,
> Lino
> 

