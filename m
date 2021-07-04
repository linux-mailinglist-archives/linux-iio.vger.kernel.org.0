Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E247F3BAE14
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGDRej (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhGDRej (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:34:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9367613BD;
        Sun,  4 Jul 2021 17:32:01 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:34:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add "extended_name" to label
Message-ID: <20210704183425.34df79ef@jic23-huawei>
In-Reply-To: <20210618123005.49867-1-paul@crapouillou.net>
References: <20210618123005.49867-1-paul@crapouillou.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Jun 2021 13:30:03 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> This is the v3 of my patchset that sets the label attribute to the
> "extended_name".
> 
> v3 only refactors the code of patch [2/2] to make it look a bit better.

Hi Paul,

Just thought I'd let you know v3 looks great to me.  Timing meant I didn't
manage to get it into last cycle, and am now waiting for rc1 to give a nice
place to rebase my trees on.  Hence I'll pick this up in a week or two.

Thanks,

Jonathan

> 
> Cheers,
> -Paul
> 
> Paul Cercueil (2):
>   iio: core: Forbid use of both labels and extended names
>   iio: core: Support reading extended name as label
> 
>  drivers/iio/industrialio-core.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 

