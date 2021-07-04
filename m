Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEF13BADFA
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhGDRQD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhGDRQD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:16:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68C2613CE;
        Sun,  4 Jul 2021 17:13:25 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:15:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] add periodic mode, threshold options
Message-ID: <20210704181549.579f8307@jic23-huawei>
In-Reply-To: <20210621143051.200800-1-i.mikhaylov@yadro.com>
References: <20210621143051.200800-1-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Jun 2021 17:30:49 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add periodic mode enablement, high/low threshold options.
title of cover letter should always include the part number.

A lot of people use threaded email clients and may need to expand
the thread to see what driver this affects.

Jonathan

> 
> Changes from v1:
>  1. Remove changes for hwmon driver and changes affecting
> vcnl3020 data structure.
>  2. Add enable/disable periodic mode functions.
> 
> Ivan Mikhaylov (2):
>   iio: proximity: vcnl3020: add periodic mode
>   iio: proximity: vcnl3020: add threshold options
> 
>  drivers/iio/proximity/vcnl3020.c | 306 ++++++++++++++++++++++++++++++-
>  1 file changed, 304 insertions(+), 2 deletions(-)
> 

