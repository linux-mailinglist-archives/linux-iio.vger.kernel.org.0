Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202B12C190F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbgKWW6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 17:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbgKWW6v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Nov 2020 17:58:51 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B0D206D8;
        Mon, 23 Nov 2020 22:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172331;
        bh=pnYKO68kaCVbgpg0cwV0aYbxE0t2QhMlaGVH3avU1Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fy6a/XnkN5dp3cb2JzMHsKp9dsh55lhjVhIUE57HSkKZ3JWjyURIuDm0Te9j/iPI6
         LyhAtfmadExxg1crFmCRdPBf/j1yQIzKSFwzS5qDdyIQ/QigY9GGUEXiQ1QD8C6PTP
         /oNHaAuCp4cKlnygX/ijvGtcE5xZN2SnG+pE6Y7Y=
Date:   Mon, 23 Nov 2020 16:59:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 090/141] iio: adc: cpcap: Fix fall-through warnings for
 Clang
Message-ID: <20201123225905.GV21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <b3c1c3f9c76f2f0e832f956587f227e44af57d3d.1605896060.git.gustavoars@kernel.org>
 <20201121150504.32385ffd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121150504.32385ffd@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 21, 2020 at 03:05:04PM +0000, Jonathan Cameron wrote:
> On Fri, 20 Nov 2020 12:36:26 -0600
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Hi Gustavo,

Hi Jonathan,

> I'm assuming there is no 'huge' rush for these an intent is that they will
> filter through the various subsystems.  Hence I've queued it up for the
> next merge window.

Yep; no rush for this.

> Applied to the togreg branch of iio.git

Thank you!
--
Gustavo
