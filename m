Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6079C15D858
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgBNNYF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 08:24:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNNYF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 08:24:05 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D83222C2;
        Fri, 14 Feb 2020 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581686644;
        bh=MXrjXhaFgOalarsip2NkBf3rjAB+4YzFemtmCeMTXkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uqe5X2AqWpMzpF/SfU3/gRTH3uqvzYOe78hgNi/flaqzVgh6vD0dDyWuOrTcANT+q
         MrCsJJn59DRizP0Kzd+4Qku55TcEnuveoIQxYYooBzFFNGGsQYuP10MByx56leyjHq
         5Am0Mdj3F8TfXzr+oZnhoGP7z42djUYxDlgTpG+Y=
Date:   Fri, 14 Feb 2020 13:24:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dylan Howey <Dylan.Howey@tennantco.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200214132400.7133bcf5@archlinux>
In-Reply-To: <20200213220407.GA11762@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
        <20200208163154.4d4f6752@archlinux>
        <20200213220407.GA11762@tennantco.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Feb 2020 16:04:08 -0600
Dylan Howey <Dylan.Howey@tennantco.com> wrote:

> I tried disabling the temperature channel after every raw read, but I'm
> running into some issues. When the channel is disabled the data ready
> bits in ctrl_reg1 won't go high anymore, and I'm doing the dummy read of
> 33h as the datasheet says. Data ready interrupts also stop working. So
> something is not right with this particular hardware. If you leave the
> channel enabled everything works good.
> 
> What are my options? I could implicitly enable the channel the first
> time it is used and leave it on, but it seems bad to leave the channel
> enabled. In that case there would be no other way to disable the channel
> other than to reload the module.
> 
> Maybe an argument passed to the module to enable temperature output or a
> compile time flag to do this?

So ideally we'd get someone at Freescale to confirm there is a hardware
rather than a documentation issue (i.e. maybe we need some other magic).

Assuming we can't confirm that, then compile time is not a good idea.
Could do a module parameter.   The reason we might not want to always
have it on is that it limits the maximum sampling frequency. 
The question is whether anyone actually cares about 800Hz?

If they do we probably need to avoid breaking them so would need a module
parameter to be 'enable temp' rather than the more natural option
of 'disable temp' to be set only by people who need the highest
frequency.

Jonathan
> 

