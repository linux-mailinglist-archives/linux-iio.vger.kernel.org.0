Return-Path: <linux-iio+bounces-7961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E448D93DF43
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB2D1C20D51
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C906F316;
	Sat, 27 Jul 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4/dmj1G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484511C83;
	Sat, 27 Jul 2024 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722082956; cv=none; b=SBVwsOLqVdBSCShpUXOS4T72LKmKPobTfpo7zASjtJfylX+NLBUld2PK0fmR4Nd2+enKNdzKbtjOgUoUYfZdMwF2Hd9oxJkm48THkzU5wjpz7NTbmheGRaTHA4ObROoAkBoz9FMnddn98MJVG0TPZHt2KsWl9n1JXedXarOV98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722082956; c=relaxed/simple;
	bh=9a0Ha8lQOeilHBupsCVrAgqvfXJ+fKamMODcBHyfa+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vyx+qdPBT4j/7Qjd5GWwXqtgeX8XoSoqDVT/BPrNgIzTV5ImIOsiPWOO1hm6yRaCqu/wQRbNGY1fSRqdVf6mWS/Mj7H6BCuQd5jfLOy66Fs9HXAbYfoiTcRzHEdIxlfg2E8BVFeVeJYH0wIKIb12KppV2LS/C8gfr6iGk0VWTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4/dmj1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F26C32781;
	Sat, 27 Jul 2024 12:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722082955;
	bh=9a0Ha8lQOeilHBupsCVrAgqvfXJ+fKamMODcBHyfa+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T4/dmj1GAkdmw3QNiAzdc2Qj5uZ/7SCICHx55wwy1HCa27bzWQKctlUTp/Nfpq+V5
	 yyCRQK9diS3i3aNC6mFAKErGwaHxAOSvQw0kRRQIN6fr45q+CK1gCTw1tq+5Vu7BwI
	 6YO1kyeiFtDM7HaOgdzScwr5P6u6tj+sVz+F8rm5Hb4rhMoItDxYXbVmEchixs3mGb
	 S72R9Mjf2w4OSbCCtDt/M2zTW6vjWxSzWRaRyHt+Rp+OQvCwBENz0NpOOGtHjQK3AB
	 3ZOM1HcbePT6oypQesSQSx3wXEAbQcv8J1NVRUEOiStD9wta+WqqUe7UDGf7ELBKCa
	 jNylbGCG1QVxg==
Date: Sat, 27 Jul 2024 13:22:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, kangjiajun@awinic.com,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, liweilei@awinic.com, robh@kernel.org,
 waqar.hameed@axis.com
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Message-ID: <20240727132227.4d350534@jic23-huawei>
In-Reply-To: <20240725124732.890375-1-wangshuaijie@awinic.com>
References: <20240713152700.3c395608@jic23-huawei>
	<20240725124732.890375-1-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> diff --git a/drivers/iio/proximity/aw9610x.c b/drivers/iio/proximity/aw9610x.c
> >> new file mode 100644
> >> index 000000000000..15e53d55d2a1
> >> --- /dev/null
> >> +++ b/drivers/iio/proximity/aw9610x.c
> >> @@ -0,0 +1,1150 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * AWINIC sar sensor driver (aw9610x)
> >> + *
> >> + * Author: Shuaijie Wang<wangshuaijie@awinic.com>
> >> + *
> >> + * Copyright (c) 2024 awinic Technology CO., LTD
> >> + */
> >> +#include "aw_sar.h"
> >> +
> >> +#define AW9610X_I2C_NAME "aw9610x_sar"
> >> +#define AW9610X_CHANNEL_MAX	(5)  
> >
> >No brackets around numeric values. They add nothing.
> >  
> 
> The patch for v4 will fix these issues.

If you agree with a comment, usual convention to save everyone time is
don't reply to it and ideally crop that part of the email out entirely.

It is hard to find the active discussions that need replies in an
email unless it is cropped to make them the only remaining parts.

...


> 
> >> +
> >> +#define AFE_BASE_ADDR					(0x0000)  
> >
> The patch for v4 will fix these issues.
> 
> >> +
> >> +	if (reg_val != AW9610X_CHIP_ID) {
> >> +		dev_err(p_sar->dev, "unsupport dev, chipid is (0x%04x)", reg_val);  
> >
> >
> >To allow use of fallback compatibles in DT we normally accept chipid missmatches.
> >So at most dev_info and carry on anyway.
> >  
> 
> Sorry, if the chipid does not match, the driver is likely to encounter issues
> during operation. We will not consider compatibility with more devices for
> the time being.

This discussion has been had many times and the standard approach to this has
changed over time (in IIO anyway). We have not yet updated all drivers to
the current policy.

Current policy is that we do not block probing a chip that firmware has told
us is compatible on the basis of a failure to match a chip id.

Print a message to help with any bug report issues you may get.
+ educate integrators of your device that they must not put false compatibles
in their firmware.

> 
> >> +		return -EINVAL;
> >> +	}
> >> +	memcpy(p_sar->chip_name, "AW9610X", 8);
> >> +
> >> +	return 0;
> >> +}
...

> Kind regards,
> Wang Shuaijie


