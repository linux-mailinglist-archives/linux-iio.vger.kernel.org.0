Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F91ACC1C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfIHKk5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 06:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfIHKk4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 06:40:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC1720640;
        Sun,  8 Sep 2019 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567939256;
        bh=vdK5IubTbK0gamU3v46Fa0mqxrdQnJc4kdPiUbyhZrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oKmnN0bZkVZw2eq3SQK6tsce9fiS+0xTo9e2lsTjn4P+ZyEaoJHkV2CANf5z4e2y6
         hrEq99S5Fc6hupAlSB9iuXKvFVzQuy3mUl3yZ22asR0L/C7/kRz76F5L2U4q4I8VC0
         bb3WwydLTijYAiscA+Uwap2cvSeI6HBieFuAlx1Q=
Date:   Sun, 8 Sep 2019 10:35:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V4 1/4] iio: adc: ad7192: Add sysfs ABI documentation
Message-ID: <20190908103519.201ec40e@archlinux>
In-Reply-To: <20190902130831.23057-1-mircea.caprioru@analog.com>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 16:08:28 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> Add initial ABI documentation for ad7192 adc sysfs interfaces.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to ignore ;)

Thanks,

Jonathan

> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
> Changelog V4:
> - added sysfs ABI documentation
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad7192          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> new file mode 100644
> index 000000000000..74a2873045bf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/ac_excitation_en
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading gives the state of AC excitation.
> +		Writing '1' enables AC excitation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/bridge_switch_en
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This bridge switch is used to disconnect it when there is a
> +		need to minimize the system current consumption.
> +		Reading gives the state of the bridge switch.
> +		Writing '1' enables the bridge switch.

