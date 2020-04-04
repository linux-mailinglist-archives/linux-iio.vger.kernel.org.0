Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A0119E554
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 16:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDOGi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 10:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgDDOGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 10:06:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD93206D4;
        Sat,  4 Apr 2020 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586009197;
        bh=wjN6og/BdgQiXgjgfs18wtB2fwB8t82/B8/axoPpm0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ktl7UJTQFM1lv/2svEtlYwjB5jadi3E+SxqcjnIoT+DrdEOdxruQp33fAud7E9wGU
         Lmm3JfFFvxTJcvzh9nQC+3rEzUKC7nx+CL8nrFDXlw95rkO3EejbNiA9H1/Myhz6gJ
         w1tqJQFiljIxUtprhkZM92e8O2FDhXs/gmxT95d0=
Date:   Sat, 4 Apr 2020 15:06:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200404150633.2421decd@archlinux>
In-Reply-To: <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
References: <20200316124929.GA389@syed.domain.name>
        <20200318020506.GA45571@icarus>
        <20200322175831.74e10aa7@archlinux>
        <CACG_h5qctM0S2buQHHNnJ_qVY6YY2wYruj9aTKH9RiJ=9_LfoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 23:54:32 +0530
Syed Nayyar Waris <syednwaris@gmail.com> wrote:

> Hi Jonathan
> 
> >Looks good.  I'm not sure right now which tree I'll take this through
> >(depends on whether it looks like we'll get an rc8 and hence I can sneak
> >it in for the coming merge window or not).
> >
> >So poke me if I seem to have forgotten to apply this in a week or so.  
> 
> Gentle Reminder.
> Thanks !
> Syed Nayyar Waris

Thanks.  I've applied it to the fixes-togreg branch of iio.git which will go
upstream after the merge window closes.

Thanks,

Jonathan


