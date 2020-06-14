Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381561F8905
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgFNNs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 09:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNNs5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jun 2020 09:48:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FB020714;
        Sun, 14 Jun 2020 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592142537;
        bh=5yoevXJYRCKuuT/+Y41FJCPGaXa/Sd/Ms5zHdVfivDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u9b3/yOXFoCOL4soH+aqaYi21GRCuVWErv8RzkUPZFfP+37iqAN5zxz4I0TR4CRgB
         s+HTRlRJcizoUJsIj03aKt9FfYrnCjv5CNJ33ddQmdJATdYuDT43tWEcEap1kejj61
         K3K3yCxDBJ3COXC+7HbI85DRelr8/FGpVaKArBl8=
Date:   Sun, 14 Jun 2020 14:48:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] counter: 104-quad-8: Add lock guards - filter
 clock prescaler
Message-ID: <20200614144853.0515cddf@archlinux>
In-Reply-To: <CACG_h5qvKvs1VdEYBwrcStfoqM16AvGVDhWp_AOeC3Xc3-dL-w@mail.gmail.com>
References: <20200316125046.GA447@syed.domain.name>
        <20200318021853.GC45571@icarus>
        <CACG_h5qvKvs1VdEYBwrcStfoqM16AvGVDhWp_AOeC3Xc3-dL-w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 7 Jun 2020 10:55:08 +0530
Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> On Wed, Mar 18, 2020 at 7:48 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Mon, Mar 16, 2020 at 06:20:46PM +0530, Syed Nayyar Waris wrote:  
> > > Add lock protection from race conditions to the 104-quad-8 counter
> > > driver for filter clock prescaler code changes. Mutex calls used for
> > > protection.
> > >
> > > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > > ---
> > > Changes in v5:
> > >  - Change spin lock calls to mutex lock calls.
> > >  - Modify the title description.  
> >
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> 
> Adding the 'Fixes' tag:
> 
> Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock Prescaler")
Replace hash with upstream one and applied to the fixes-togreg branch of iio.git
Thanks,

Jonathan

> 
> Regards
> Syed Nayyar Waris

