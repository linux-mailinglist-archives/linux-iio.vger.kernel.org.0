Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6966977889
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfG0MC0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 08:02:26 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:42380 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG0MC0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2019 08:02:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id A39B49E774D;
        Sat, 27 Jul 2019 13:02:23 +0100 (BST)
Date:   Sat, 27 Jul 2019 13:02:22 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/7] docs: generic-counter.rst: fix broken references
 for ABI file
Message-ID: <20190727130204.78f5a3f1@archlinux>
In-Reply-To: <f55e1ef71a3a7194dacd3f0cecc0aa67aaffbd15.1564140865.git.mchehab+samsung@kernel.org>
References: <cover.1564140865.git.mchehab+samsung@kernel.org>
        <f55e1ef71a3a7194dacd3f0cecc0aa67aaffbd15.1564140865.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 08:47:22 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> There are two references to the generic counter ABI, with was added
> on a separate patch. Both point to a non-existing file.
> 
> Fix them.
> 
> Fixes: ea2b23b89579 ("counter: Documentation: Add Generic Counter sysfs documentation")
> Fixes: 09e7d4ed8991 ("docs: Add Generic Counter interface documentation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  Documentation/driver-api/generic-counter.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index 0c161b1a3be6..8382f01a53e3 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -233,7 +233,7 @@ Userspace Interface
>  Several sysfs attributes are generated by the Generic Counter interface,
>  and reside under the /sys/bus/counter/devices/counterX directory, where
>  counterX refers to the respective counter device. Please see
> -Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
> +Documentation/ABI/testing/sysfs-bus-counter for detailed
>  information on each Generic Counter interface sysfs attribute.
>  
>  Through these sysfs attributes, programs and scripts may interact with
> @@ -325,7 +325,7 @@ sysfs attributes, where Y is the unique ID of the respective Count:
>  
>  For a more detailed breakdown of the available Generic Counter interface
>  sysfs attributes, please refer to the
> -Documentation/ABI/testing/sys-bus-counter file.
> +Documentation/ABI/testing/sysfs-bus-counter file.
>  
>  The Signals and Counts associated with the Counter device are registered
>  to the system as well by the counter_register function. The

