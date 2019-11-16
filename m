Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8EFECBC
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 15:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfKPOrX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 09:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfKPOrX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 09:47:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B75A206E1;
        Sat, 16 Nov 2019 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573915642;
        bh=nNPTGWlKf8ootM2ce/5KY/+IAxsqSGuXuSRfQBVTCik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y5xHBovoGPc/b0mTX51FJF2iswT4hg+r6vB1Zw4uUFAj/mYKC6aMnoDX9iEQDS70+
         Bxoxr3zfOu5BhKSS7UzQfMWLMxCEPtcna9R4k4DS/z090JrFnpG6Vn8AThxrM7GfHZ
         85h9PfTrjeFdoipwKVZeEok2I1dZvptV5VcBbzz4=
Date:   Sat, 16 Nov 2019 14:47:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [v2 6/9] Documentation: ABI: document IIO thermocouple_type
 file
Message-ID: <20191116144717.60ad55e8@archlinux>
In-Reply-To: <20191111153517.13862-7-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191111153517.13862-7-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Nov 2019 16:35:14 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> IIO core layer gained a new sysfs standard attribute "thermocouple_type".
> This patch adds it to the list of documented ABI for sysfs-bus-iio
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 94f7eb675108..2cf2c800dba2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1733,3 +1733,9 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Center frequency in Hz for a notch filter. Used i.e. for line
>  		noise suppression.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_thermocouple_type
> +KernelVersion:	5.5
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Thermocouple type i.e. J, K, R, ...
Don't go with ...  No userspace can be written against unknowns.  How do you test it?

List all the types that existing drivers support and we can add to it if new
types show up.

Thanks,

Jonathan


