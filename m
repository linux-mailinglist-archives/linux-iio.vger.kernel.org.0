Return-Path: <linux-iio+bounces-24493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64197BA6133
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AD8189D48C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3492E11AA;
	Sat, 27 Sep 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZrWwscm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946431AA7BF;
	Sat, 27 Sep 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758988270; cv=none; b=fuU7V6QTODGr4qYRbh6674yY+jZ2KzLicagQ+yC40K757I+tQ/aHyYpjmEzYkcl09G+5iLiPtQZ2wW0lB+V3UKQE5hwZOth1MgRXw1jkeyhrsuYsihCV3l8CPQi6S/9ie8blaS1ZbuJ2R3VnpbquJpXU5XNuPUbJQagyLPXmpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758988270; c=relaxed/simple;
	bh=vlv6Xny4puXywF5XCwuhzRxSaXYWcukdI7CtpNpRw2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSaFcWwGcjrUVSsYByLD5iIgJpY904dj13Lw5Py7gpj94Aco5ZqiAObqEG5ccG7JIpNR5FP0ZJNXKe8w/BT/hZot+k5ArriwwDEx8LwclJO3laNx5F4A2tM+1S/xb8qXl3s2qdHDix+sJdXIe5SQP6Db0lwr1pHOeoCT64lpseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZrWwscm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7775DC4CEE7;
	Sat, 27 Sep 2025 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758988270;
	bh=vlv6Xny4puXywF5XCwuhzRxSaXYWcukdI7CtpNpRw2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uZrWwscmNV/flIDnwZ5kf4pxW4cdQfQ38nsohe7iCzNOqllHgjNb8UH8nh/NVXrK+
	 huuI2DUEJA5TvAJMIvblR7JMVatkKmLdniruX9n2i+tzJIA7DwnjPfbJkNusB13BKb
	 APvXSOtoIO8zDoPrvBdgMQB9Yzs+aC6gWlcm/3S3BP6/t2iDOQtxvNKSaLelMkdyBz
	 QYtdbT8CjsSWX9TGFsfbkR1CKisroUHcfnHUxwfnclp22Sf5YPb+Tj+HzRcuhtKqwM
	 ZXyl5mpFqmsxzH0xz5h7YFdFC23RyyMu4f7d+CeU+An0xzAcxGm3xyjN/8gQOp8Fh+
	 Oa8BPgeN+cNJA==
Date: Sat, 27 Sep 2025 16:51:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: ABI: document accelerometer event
 attributes
Message-ID: <20250927165100.5a9d3136@jic23-huawei>
In-Reply-To: <aMp1orvA-SSSZeN2@smile.fi.intel.com>
References: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
	<20250916-bmi270-v6-2-6acd8d26a862@gmail.com>
	<aMp1orvA-SSSZeN2@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 11:47:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Sep 16, 2025 at 08:38:24PM -0300, Gustavo Silva wrote:
> > Add ABI documentation for accelerometer event-related sysfs attributes
> > exposed by the bmi270 driver. These include threshold, period, and
> > enable controls for adaptive magnitude (any-motion) and rate of change
> > (no-motion) event detection.  
> 
> ...
> 
> > What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en  
> 
> >  What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
> >  What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
> > +What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
> >  What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en  
> 
> > What:		/sys/.../events/in_accel_y_raw_thresh_rising_value  
> 
> >  What:		/sys/.../events/in_accel_y_raw_thresh_falling_value
> >  What:		/sys/.../events/in_accel_z_raw_thresh_rising_value
> >  What:		/sys/.../events/in_accel_z_raw_thresh_falling_value
> > +What:		/sys/.../events/in_accel_mag_adaptive_rising_value
> >  What:		/sys/.../events/in_anglvel_x_raw_thresh_rising_value
> >  What:		/sys/.../events/in_anglvel_x_raw_thresh_falling_value
> >  What:		/sys/.../events/in_anglvel_y_raw_thresh_rising_value  
> 
> > +What:		/sys/.../events/in_accel_roc_rising_value
> >  What:		/sys/.../events/in_accel_x_raw_roc_rising_value
> >  What:		/sys/.../events/in_accel_x_raw_roc_falling_value
> >  What:		/sys/.../events/in_accel_y_raw_roc_rising_value  
> 
> >  What:		/sys/.../events/in_accel_x_thresh_rising_period
> >  What:		/sys/.../events/in_accel_x_thresh_falling_period
> > +What:		/sys/.../events/in_accel_roc_rising_period
> >  What:		/sys/.../events/in_accel_x_roc_rising_period
> >  What:		/sys/.../events/in_accel_x_roc_falling_period
> >  What:		/sys/.../events/in_accel_y_thresh_rising_period  
> 
> With the given context (above and below) I'm not sure this is the best place of
> putting an attribute in the list. Perhaps something below will not disrupt the
> xyz structure (like mag cases)?

I took a look at the broader context and it was a bit tricky but I think this
is the best we can do to maintain current ordering (which is fuzzily defined at best).

At some point that whole doc needs a rethink wrt to how we break the different blocks
up and order the elements within them.

With this change, series applied to the testing branch of iio.git.
That will be rebased on rc1 once available and then become the togreg branch.

thanks,

Jonathan



diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 89b4740dcfa1..352ab7b8476c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -926,6 +926,7 @@ What:               /sys/.../iio:deviceX/events/in_accel_y_roc_rising_en
 What:          /sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
 What:          /sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
 What:          /sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
+What:          /sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en
 What:          /sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
 What:          /sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
 What:          /sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en
@@ -1001,6 +1002,7 @@ Description:
                to the raw signal, allowing slow tracking to resume and the
                adaptive threshold event detection to function as expected.
 
+What:          /sys/.../events/in_accel_mag_adaptive_rising_value
 What:          /sys/.../events/in_accel_thresh_rising_value
 What:          /sys/.../events/in_accel_thresh_falling_value
 What:          /sys/.../events/in_accel_x_raw_thresh_rising_value
@@ -1147,6 +1149,7 @@ Description:
                will get activated once in_voltage0_raw goes above 1200 and will become
                deactivated again once the value falls below 1150.
 
+What:          /sys/.../events/in_accel_roc_rising_value
 What:          /sys/.../events/in_accel_x_raw_roc_rising_value
 What:          /sys/.../events/in_accel_x_raw_roc_falling_value
 What:          /sys/.../events/in_accel_y_raw_roc_rising_value
@@ -1193,6 +1196,8 @@ Description:
                value is in raw device units or in processed units (as _raw
                and _input do on sysfs direct channel read attributes).
 
+What:          /sys/.../events/in_accel_mag_adaptive_rising_period
+What:          /sys/.../events/in_accel_roc_rising_period
 What:          /sys/.../events/in_accel_x_thresh_rising_period
 What:          /sys/.../events/in_accel_x_thresh_falling_period
 What:          /sys/.../events/in_accel_x_roc_rising_period
@@ -1362,6 +1367,15 @@ Description:
                number or direction is not specified, applies to all channels of
                this type.
 
+What:          /sys/.../iio:deviceX/events/in_accel_x_mag_adaptive_rising_en

t

> 
> > What:		/sys/.../events/in_accel_z_thresh_rising_period  
> 
> >  What:		/sys/.../events/in_accel_z_thresh_falling_period
> >  What:		/sys/.../events/in_accel_z_roc_rising_period
> >  What:		/sys/.../events/in_accel_z_roc_falling_period
> > +What:		/sys/.../events/in_accel_mag_adaptive_rising_period
> >  What:		/sys/.../events/in_anglvel_x_thresh_rising_period
> >  What:		/sys/.../events/in_anglvel_x_thresh_falling_period
> >  What:		/sys/.../events/in_anglvel_x_roc_rising_period  
> 


