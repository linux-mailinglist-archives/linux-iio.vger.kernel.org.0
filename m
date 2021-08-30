Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D713FB8EA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhH3PUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 11:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237473AbhH3PTt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 11:19:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E0660F45;
        Mon, 30 Aug 2021 15:18:52 +0000 (UTC)
Date:   Mon, 30 Aug 2021 16:22:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v4 4/6] Documentation:ABI:testing:add doc for AD3552R
 ABI
Message-ID: <20210830162203.6f40790c@jic23-huawei>
In-Reply-To: <20210820165927.4524-5-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
        <20210820165927.4524-5-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Aug 2021 16:59:25 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> Add documentation for option for enabling precision mode
> of ad3552r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
> new file mode 100644
> index 000000000000..37573245f3d5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3552r
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/precision_mode_en
> +KernelVersion:	5.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Select between fast mode and precison mode.
> +		0: Fast mode      - For 12 bits precision, the most significant
> +				    bits are used and 16 bits are sent to the
> +				    device per channel, lats bits being 0.

least significant bits being 0

perhaps and definitely not lats bits :)

> +		1: Precision mode - For 16 bits precision, 24 bits are sent to
> +				    the device per channel, last bits being 0.

I don't think the ABI cares about how many bits are sent, but rather it cares
about the precision.

I'm not keen on this ABI if we can possibly avoid it.  It is highly device specific
and therefore unlikely to ever get used by any standard userspace code.

Given I'm fairly sure no linux host is ever going to get anywhere near the maximum
rates this device supports, perhaps we should just always use precision mode and
not worry about this detail?

Jonathan

