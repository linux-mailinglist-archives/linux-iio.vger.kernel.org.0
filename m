Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9C12D8D4D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLMNdd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 08:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbgLMNdd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 08:33:33 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FE020728;
        Sun, 13 Dec 2020 13:32:51 +0000 (UTC)
Date:   Sun, 13 Dec 2020 13:32:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: hrtimer: Allow sub Hz granularity
Message-ID: <20201213133248.2e571be3@archlinux>
In-Reply-To: <CAHp75VeYgBN8GJXs5bTJpML9Q=jZHJkh7h877Of5-Jn2E3Z_yg@mail.gmail.com>
References: <20201204194803.751866-1-gwendal@chromium.org>
        <20201205180631.004173e5@archlinux>
        <CAHp75VeYgBN8GJXs5bTJpML9Q=jZHJkh7h877Of5-Jn2E3Z_yg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Dec 2020 17:22:54 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Dec 5, 2020 at 8:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri,  4 Dec 2020 11:48:03 -0800
> > Gwendal Grignou <gwendal@chromium.org> wrote:  
> 
> > Looks good to me. I'd like this one to sit on the list a little longer though
> > + it's missed this cycle anyway so we have plenty of time!  
> 
> The patch has a big issue, i.e. documentation update... where?
Odd corner case. It was never documented tightly enough to rule this out.
So to be honest, I would have expected this to already work, but never
really thought about it before this patch.

Jonathan

> 

