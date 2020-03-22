Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8E18EB59
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 19:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgCVSG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 14:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgCVSG6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 14:06:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5496A2072E;
        Sun, 22 Mar 2020 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584900418;
        bh=54j3OVFrBeg4K057FOtUs3HyIoSyizqYq68lF8/KaPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uobLnfwjzIBRlTrRUL6OAd+Wb9ZsstEnFWJehyfoyuIy7yUau5E5Rq6wnA+1wNPj3
         HPi0+3EZyAY3GSAxfVqx3FZadWDaUhOK/xNNOU1llCbFW3tiDDH04DmTz8NkXKMLKx
         L/m+HyNrn0GWnrNgOX+Wy7813ba+cUjZwNJUX638=
Date:   Sun, 22 Mar 2020 18:06:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: core: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200322180653.06ef9b9a@archlinux>
In-Reply-To: <20200316161935.GA1526@onstation.org>
References: <20200316124941.8010-1-tiwai@suse.de>
        <20200316124941.8010-2-tiwai@suse.de>
        <20200316161935.GA1526@onstation.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 12:19:35 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Mon, Mar 16, 2020 at 01:49:40PM +0100, Takashi Iwai wrote:
> > snprintf() is a hard-to-use function, it's especially difficult to use
> > it for concatenating substrings in a buffer with a limited size.
> > Since snprintf() returns the would-be-output size, not the actual
> > size, the subsequent use of snprintf() may go beyond the given limit
> > easily.  Although the current code doesn't actually overflow the
> > buffer, it's an incorrect usage.
> > 
> > This patch replaces such snprintf() calls with a safer version,
> > scnprintf().
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>  
> 
> Reviewed-by: Brian Masney <masneyb@onstation.org>
I picked this one up from v1.

Thanks,

Jonathan


