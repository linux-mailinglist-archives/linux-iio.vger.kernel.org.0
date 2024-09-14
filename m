Return-Path: <linux-iio+bounces-9574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D69791BD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 17:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9818B225C1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C31D0163;
	Sat, 14 Sep 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t45USvuL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8261D014D;
	Sat, 14 Sep 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726326371; cv=none; b=pbiMbU8O07ZuTjnAvtgyRu6sO1WdWxJgTTnrn1OE1iThqJr/9dTPm39aSsinQTJogq2RYk+J1QzZKB03JH/Vv6eHnjzT2Y5bD2OUC+MwXMFQTaOe13DJfks9EZdZptLZYG10Q/exsQ001gt9BQsAOrHoNTVMD6xpH8dfmA3byxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726326371; c=relaxed/simple;
	bh=hBDDooI+VDm7Eo1wgZJPe14xFNUu/LcC/bTZ7Uudp/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLDDTa/jJkXQkmssWobjCvKgN4VdyCT4Y9NHR0TJeMdDDAJiJZiN9ysviZSq5z00gITFLmDOEaorHLpAcZL8lY/BuCAsyPSKDIWMBt7wgLrEseWKFd3eQSDl/tI3E8yqA+5FhUfL9+qrK+J851HNpRlttBWVHEDjjo93EWAK7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t45USvuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7C2C4CEC0;
	Sat, 14 Sep 2024 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726326371;
	bh=hBDDooI+VDm7Eo1wgZJPe14xFNUu/LcC/bTZ7Uudp/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t45USvuLaDS04Eh+rsck2B7DKGFU1WNXrF0oFTRdAMFaXP7GJP/KmyPLP7YuVniqx
	 GKAT8I7K4C5BnmLRI2xLgq9iVwyqtAP/F53i+R4gOT4CdHmlLQTeo2yhg28BM46ifb
	 f0XKZ2zTp69Wvt4W2h1RVlRxX7ngbxhwjnWXyXM1jTBunLZg4PupCvOvCnh1f1lykz
	 V/YEXM91XYI684zqF9j4KAbCb7DRP4JUSQqRxmvrIqbm2KOSYJhA9rVTT6dprEcCZU
	 PJXPxZqRNBeDwMoneccKw3cSLjLDNFTffAedthUqjwFXkrDY+90OYLpSVkgxS021/J
	 inE5pnwJ+sdxw==
Date: Sat, 14 Sep 2024 16:06:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI
 ID
Message-ID: <20240914160603.0eab9716@jic23-huawei>
In-Reply-To: <95134eee-5000-44d7-8a8b-67a93a86c05a@redhat.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
	<c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
	<ZuQGcyrTFek1yExt@smile.fi.intel.com>
	<20240914152541.1c2228f4@jic23-huawei>
	<95134eee-5000-44d7-8a8b-67a93a86c05a@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 16:30:00 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 9/14/24 4:25 PM, Jonathan Cameron wrote:
> > On Fri, 13 Sep 2024 12:31:31 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> On Thu, Sep 12, 2024 at 03:51:09PM +0200, Hans de Goede wrote:  
> >>> Hi,
> >>>
> >>> On 9/11/24 11:22 PM, Andy Shevchenko wrote:    
> >>>> The commit in question does not proove that ACPI ID exists.
> >>>> Quite likely it was a cargo cult addition while doint that
> >>>> for DT-based enumeration.  Drop most likely fake ACPI ID.
> >>>>
> >>>> Googling for LTERxxxx gives no useful results in regard to DSDT.
> >>>> Moreover, there is no "LTER" official vendor ID in the registry.
> >>>>
> >>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>    
> >>>
> >>> Thanks, patch looks good to me:    
> >>
> >> Have you grepped over your collection of real DSDTs?
> >>  
> >>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>    
> >>
> >> Thank you!
> >>  
> > I'll pick these up in the meantime. Applied to the testing
> > branch of iio.git.  
> 
> As mentioned earlier today, at least the LTER0301 ACPI Hardware ID
> is real, so please drop this one. The kmx61 patch is fine to keep.
Done.

Thanks,

J
> 
> Regards,
> 
> Hans
> 
> 
> 


