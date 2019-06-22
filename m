Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34384F532
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFVKVU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKVU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:21:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF6920665;
        Sat, 22 Jun 2019 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561198879;
        bh=/paa7kvaPmOyIrjhNNZO/7HFK/SfqGzkYzeDRlWqYOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hd/tm98DmDXjjyGHJoHemXX/phFy5c5kjBDmdoQsZjNtdhXJFgv0a/Y39BdJAVrPy
         aAcX1/6CrlVE0sKDgg7ZDyN82IcrKklKvCQjvDUXCX6G/1igjyE2Fc35qEsm0U5gbf
         Pe7S/rsL8WMLE4nY9j6uew6h98D2VCWV0r/NBLRg=
Date:   Sat, 22 Jun 2019 11:21:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] docs: iio: add precision about
 sampling_frequency_available
Message-ID: <20190622112114.78a58440@archlinux>
In-Reply-To: <0c5b7e1f7996e8c1c5f6787cbb9fb58986be1f17.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
        <0c5b7e1f7996e8c1c5f6787cbb9fb58986be1f17.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jun 2019 11:06:39 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> The documentation give some exemple on what format can be expected
> from sampling_frequency_available sysfs attribute
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
It seems I already applied this one, though probably haven't sent
a pull request for it to Greg yet.

Please drop it from your v4 posting as otherwise I'll get confused
(again).

Thanks,

Jonathan


> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6aef7dbbde44..680451695422 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -61,8 +61,11 @@ What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		When the internal sampling clock can only take a small
> -		discrete set of values, this file lists those available.
> +		When the internal sampling clock can only take a specific set of
> +		frequencies, we can specify the available values with:
> +		- a small discrete set of values like "0 2 4 6 8"
> +		- a range with minimum, step and maximum frequencies like
> +		  "[min step max]"
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/oversampling_ratio
>  KernelVersion:	2.6.38

