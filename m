Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B58256967
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgH2R2G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgH2R2G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:28:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD57B206B5;
        Sat, 29 Aug 2020 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598722085;
        bh=qY7x57AGtsUkeHbRnNlDUQfIhyRS0g6JReGDi0RPd94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sqillNnVlaj1WTu3OaIzsuJDY0nq3eOaFhPRFbuifV6adDgYasJiObOTqdPYJyAU5
         SyIK04VwkNP/YTKIduPBRw0TfF8Xq4KjxzLkX5EzO/kvN5xyqDUImSf4i3gq4KZCbw
         q2wzuRgYtoj4tHa7ares9vlJHx9IaMMUPV/yMHnM=
Date:   Sat, 29 Aug 2020 18:28:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 0/5] iio: temperature: mlx90632: Add extended
 calibration calculations
Message-ID: <20200829182801.19f028ef@archlinux>
In-Reply-To: <20200818213737.140613-1-cmo@melexis.com>
References: <20200818213737.140613-1-cmo@melexis.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Aug 2020 23:37:32 +0200
Crt Mori <cmo@melexis.com> wrote:

> Add extended calibration calculations for the new subversion of DSP5.
> 
> V6 review comments from Andy Shevchenko <andy.shevchenko@gmail.com:
> 	 - Covert all while loops to regmap_read_poll_timeout or
> 	   read_poll_timeout even though udelay of more than 20ms is used
> 	   in the second. Problem was, that timeout needs to be 800ms,
> 	   while polling frequency could be 20ms, but we konw that that
> 	   will generate more noise on line than needed. Did some tests and
> 	   current number combination seems best. This also caused that
> 	   commit messages were adjusted.
> V5 review comments from Andy Shevchenko <andy.shevchenko@gmail.com:
> 	 -  Swap order of patches to avoid re-doing the calculations
> 	 - Add fixed name defines for Ambient and Object RAM temperature
> 	   channels as per suggestion of the Jonathan Cameron <jic23@kernel.org>
> V5:
> 	 - Add style changes patch along with current series.
> 
> V4 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
> 	 - Move the function creation for Ta4 to first patch
> 	 - Add kernel doc patch for documenting internal struct
> 	 - Add patch to convert while loops to do-while loops for
> 	   polling
> 
> V3 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
> 	 - Change commit message text to more proper English as per suggestions
> 	 - Drop unneeded brackets and parentheses
> 	 - Use defines from limits.h
> 	 - Remove userspace typedefs as leftovers from porting
> 	 - Testing of timeout loops with iopoll.h was no successful,
> 	   because delay between measurements is 10ms, but we need to
> 	   fill at least 3 channels, so final timeout should be 40ms
> 	   which is out of scope of usleep function
> 	 - Fixing some typos in comments
> 
> V2 review comments from Andy Shevchenko <andy.shevchenko@gmail.com>:
> 	 - Convert divison back to shifts to make it more readable
> 
> Crt Mori (5):
>   iio:temperature:mlx90632: Reduce number of equal calulcations
>   iio:temperature:mlx90632: Add kerneldoc to the internal struct
>   iio:temperature:mlx90632: Convert polling while loop to regmap
>   iio:temperature:mlx90632: Adding extended calibration option
>   iio:temperature:mlx90632: Some stylefixing leftovers
> 
>  drivers/iio/temperature/mlx90632.c | 274 ++++++++++++++++++++++++++---
>  1 file changed, 247 insertions(+), 27 deletions(-)
> 

Thanks.  Also thanks to Andy for all his review work on these!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to try and break it.

Thanks,

Jonathan
