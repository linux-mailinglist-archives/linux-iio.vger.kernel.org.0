Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CB1AB1D8
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 21:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633928AbgDOTdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 15:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411910AbgDOTdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 15:33:46 -0400
X-Greylist: delayed 1580 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 12:33:46 PDT
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EBC061A10;
        Wed, 15 Apr 2020 12:33:46 -0700 (PDT)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 0AE81E0451; Wed, 15 Apr 2020 21:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1586979225; bh=zt+LqEm5Ju4itUmEBr0gu/NcCUHyrXsZ4W3aO6003Hs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BoNkWHOqhmGC1YIOQKnNi47aPOjh8xq5uaTcY8zyuFe6HNv3KnPhlwfdNDQohnotV
         tzTtt7TnGpoANEtKIabW6z8elmtCW+WjP6T0nqp3i7ovSU7P9KiY1lB3YTDm9OUAlK
         bc945YnMNQwk3F/1UmTOSHGOZxQ6rc74bEA1B2n0=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id F1ED3E01A3;
        Wed, 15 Apr 2020 21:33:44 +0200 (CEST)
Date:   Wed, 15 Apr 2020 21:33:44 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Saravanan Sekar <sravanhome@gmail.com>
cc:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 5/6] power: supply: mp2629: Add impedance compenstation
 config
In-Reply-To: <20200415162030.16414-6-sravanhome@gmail.com>
Message-ID: <alpine.DEB.2.21.2004152132470.18914@vps.pmeerw.net>
References: <20200415162030.16414-1-sravanhome@gmail.com> <20200415162030.16414-6-sravanhome@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020, Saravanan Sekar wrote:

subject: compensation

comments below

> Allows the user to compensate the intrinsic resistance of the battery
> to accelerate the charging cycle.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power-mp2629 | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
> new file mode 100644
> index 000000000000..7b7c0e7a7c45
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
> @@ -0,0 +1,8 @@
> +What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
> +Date:		April 2020
> +KernelVersion:	5.7
> +Description:
> +		Represents a battery impedance compenstation to accelerate charging.

compensation

> +
> +                Access: Read, Write
> +                Valid values: Represented in milli-ohms. Valid range is [0, 140].
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
