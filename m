Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62CF391D62
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhEZQ7Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 12:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233550AbhEZQ7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 May 2021 12:59:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2794F613D7;
        Wed, 26 May 2021 16:57:40 +0000 (UTC)
Date:   Wed, 26 May 2021 17:59:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] doc: add a couple fixups for IIO ABI files
Message-ID: <20210526175908.42db03a0@jic23-huawei>
In-Reply-To: <cover.1621944866.git.mchehab+huawei@kernel.org>
References: <cover.1621944866.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 May 2021 14:23:51 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Patch 1 was already submitted as patch 10/10 on this series:
> 	https://lore.kernel.org/linux-doc/87wnrtnpko.fsf@meer.lwn.net/
> 
> However, it generated a new warning, due to a separate issue.
> 
> So, resend it together with a warning fix patch.
> 
> As these patches are independent from the other ones, I guess it
> can either be applied via IIO or via docs tree, whatever works
> best for the doc and IIO maintainers.
> So, I should leave such decision to Jonathan & Jonathan ;-)

Either works for me, but on basis I got here first.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jon, if you'd prefer I picked these up, then let me know.

Thanks!

> 
> Mauro Carvalho Chehab (2):
>   iio: ABI: sysfs-bus-iio: fix a typo
>   iio: ABI: sysfs-bus-iio: avoid a warning when doc is built
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

