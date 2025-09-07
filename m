Return-Path: <linux-iio+bounces-23846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC8B47AB3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3971C161711
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72FB2459F1;
	Sun,  7 Sep 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0ORlyRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CC221DAE
	for <linux-iio@vger.kernel.org>; Sun,  7 Sep 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242878; cv=none; b=Fb7wWYceuywCW8Gvk3+PfgoOEVuo5Yn8gKAcibs/499WzFq+kPmkGRquJ5zF4/SbTU3GoKsXQzcsImmdV0d09sQjTLriHU1602LcKqkhkMruFntdLJEINW3UEV1tqc+8lqOP+1kjOoI/NVpX0BDCcBp9I+7ji1e6CfEg6TAvGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242878; c=relaxed/simple;
	bh=ZanWzrscik1NktQ1Kqh/AnXr3XniLDcq2LaAakE21go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYAScOgde97KDuu/H1WYYzuQUUUSyztr5EzdE6StPcXDCCUorXMVbMHQ7jWPDwc4bMNwf/2RIrk8NJWUmxHtlFrg/fp3JDMHW6zIMoEkHky2aTiPqt3h8zGcXAo8O4qi3GHnQpi2ke/38jl52KaTHwjpLySB4+qe7N36aBY9dmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0ORlyRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1BAC4CEF0;
	Sun,  7 Sep 2025 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757242878;
	bh=ZanWzrscik1NktQ1Kqh/AnXr3XniLDcq2LaAakE21go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0ORlyRwrRjgeUuSPBu5juY/z8+AvbpHsJatXUq+R8AX/yQuNx6f8O6lljWBeytDF
	 oGNdlFkRxBQrC3Ws7IUDNiYOO+KrMvonGKwX0RhRiGtY8GERRuNsv70TFMJxEfcNyJ
	 TMHe8kx4AuNOzYUjQGLa0tH5Ik1v4deXuPcdoIM23ZsFF4lUA1YJoGlvNLKL/lo3xc
	 hHAuuOmTR649/SnLMpyF6eiHxfYxt1lUR3ASgfqD9br/KxtXkQ1unnGuaLcPwollNk
	 3wfSdo14NzE6+bo8sTg8mBw6MTNIXHDtospoAh2k7L2MxuYWQvxp9GYPSKHdTaH58c
	 i7BlwVrkBv3yw==
Date: Sun, 7 Sep 2025 12:01:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, tzungbi@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] Documentation: iio: Remove location attribute
Message-ID: <20250907120111.339a970e@jic23-huawei>
In-Reply-To: <e8e2a0b2-dcd2-43b9-9901-52cdfbd82b88@baylibre.com>
References: <20250903190102.1647098-1-gwendal@chromium.org>
	<e8e2a0b2-dcd2-43b9-9901-52cdfbd82b88@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 10:58:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/3/25 2:01 PM, Gwendal Grignou wrote:
> > The cros-ec specific |location| attribute has been superseded by the
> > generic |label| attribute.
> > 
> > Fixes: 7cbb6681d7e5 ("iio: common: cros_ec_sensors: Add label attribute")
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-cros-ec | 10 ----------
> >  1 file changed, 10 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > index adf24c40126f0..9e39262437979 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > @@ -7,16 +7,6 @@ Description:
> >                  corresponding calibration offsets can be read from `*_calibbias`
> >                  entries.
> >  
> > -What:		/sys/bus/iio/devices/iio:deviceX/location
> > -Date:		July 2015
> > -KernelVersion:	4.7
> > -Contact:	linux-iio@vger.kernel.org
> > -Description:
> > -		This attribute returns a string with the physical location where
> > -                the motion sensor is placed. For example, in a laptop a motion
> > -                sensor can be located on the base or on the lid. Current valid
> > -		values are 'base' and 'lid'.
> > -
> >  What:		/sys/bus/iio/devices/iio:deviceX/id
> >  Date:		September 2017
> >  KernelVersion:	4.14  
> 
> Not sure what the policy is on removing ABI, but moving this to
> Documentation/ABI/obsolete/ to let people know that this attribute should
> no longer be used in new code might be more sensible.

Is it still in use somewhere?  I think not in which case we can safely drop
it from mainline.

Jonathan


