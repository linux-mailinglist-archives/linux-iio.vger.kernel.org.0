Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B249625382F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 21:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHZTTa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 15:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHZTT3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Aug 2020 15:19:29 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D312078A;
        Wed, 26 Aug 2020 19:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469569;
        bh=F6Y1Xklmrbbf3bsS48BdgWI0k9w+fz3aEY1yMgt01O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIL3cgtkt1CcbsrdZdmz0umqHMv1hzSTBKLpLxK/HDPFuGEhlIjqhtartZ81nfZeL
         1y8QnUmpx3OUBJ8tWaDLheTw2Pep19qpjDAOkBi0UbaTO08B6fLs4BYCI8VxS34COE
         FDFNlU+SnV4ACynvPbIKjcPOggry/Z6+Yb/q2qiE=
Date:   Wed, 26 Aug 2020 14:25:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dpot-dac: fix code comment in dpot_dac_read_raw()
Message-ID: <20200826192529.GC2671@embeddedor>
References: <20200826000844.GA16807@embeddedor>
 <3fb79fa8-e86b-111b-a4a7-5da767d40b52@axentia.se>
 <3528f053-70d8-bd12-8683-3c1ed0b4d6e7@embeddedor.com>
 <13e9b0cf-9fae-5dcf-d0ac-4beaf18295d0@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e9b0cf-9fae-5dcf-d0ac-4beaf18295d0@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 04:16:23PM +0200, Peter Rosin wrote:
> On 2020-08-26 16:17, Gustavo A. R. Silva wrote:
> >> And just to be explicit, this fix is for 5.9.
> >>
> >> Acked-by: Peter Rosin <peda@axentia.se>
> >>
> > 
> > If you don't mind I can add this to my tree for 5.9-rc4
> > and send it directly to Linus.
> 
> Fine by me, Jonathan might think differently but I can't find a reason why.
> Just about nothing is happening in that file and the risk for conflicts is
> negligible.
> 

OK. In the meantime, I have added this to my -next tree and queued it up
for 5.9-rc3.

Thanks
--
Gustavo
