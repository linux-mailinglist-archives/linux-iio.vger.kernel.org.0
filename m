Return-Path: <linux-iio+bounces-14848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C451CA24B49
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 18:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4254A1657CA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3B1CD1E1;
	Sat,  1 Feb 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSA3CSeb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BF1CAA90;
	Sat,  1 Feb 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738432105; cv=none; b=Md0G2Wz6+j2vEXR8iCFLfPPCJ34EjLHvF1sFnBrVQXktPI3A8CgKdNfolEO3bbdGOcV6VyBVDpAYyRVzLevc5Dfkhxh9pBsjt+m9A+M1C3dz98HgnT0EGBpJDPuY2qYFVKqZiUrjrRtF7bdbEd+QXmpmbnSVdPMhJ7QVnlIxvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738432105; c=relaxed/simple;
	bh=n1RAwqaYRrnkFmDK9cSfZdSN66zxHHIu0i2aujOBA0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9J/s3qfE+EQabufR2GGq3ZgxQoTdwclJ/cJEj6iCdqskSDxi6VRpZiO1bjNLOCFrE2Lj/0s5PR9KNNvhGCzqXdi0v0UM7iDWrRAxqY8jn+9CHdWC5cW205zXDg7BI+UuxD+pMK5Vn+cCDvvBOoGfTOtHsAPRjxZJfJlcyfShhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSA3CSeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95A4C4CEE0;
	Sat,  1 Feb 2025 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738432104;
	bh=n1RAwqaYRrnkFmDK9cSfZdSN66zxHHIu0i2aujOBA0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kSA3CSebN3fhoYcuLZ2+Qy1r4swiS5GaLI6VWZwWrCxmfJCW463IeNdZVHA0ycTZe
	 9IUSBt1k6+/a/4KihG5i1mmHxdkiKJh59VOnZpKTk3vugU+pBT9H1utMW3+EVxyt73
	 kPpbMUMy/MTQfQZeY65iiQZHN4SgSejxNP/sagOLxl6Yo7dVYd3LkLKw6nExx7N0z1
	 xyKbkUgyYfF34vuyltpEzlu8I84HpyfxqhHUMi6MxMwzvnvxnLTH+ybZIyKkL4S25K
	 g+swRCn06DNEB4ULTj/mFQcOAq0NC5I2GZ6vUMu4RFXPjwleQPLgCK8z8lA0efIE1L
	 XfjdfH0cdbLKQ==
Date: Sat, 1 Feb 2025 17:48:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v1 00/12] iio: accel: adxl345: add interrupt based
 sensor events
Message-ID: <20250201174818.26dcc646@jic23-huawei>
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:00:48 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add several interrupt based sensor detection events:
> - single tap
> - double tap
> - free fall
> - activity
> - inactivity
> 
> All the needed parameters for each and methods of adjusting them, and
> forward a resulting IIO event for each to the IIO channel.

So my main feedback here is to be much more reluctant to add new ABI.
Anything you add is unused by all existing code and if it is unique
to a driver probably never going to be used by anyone other than you.

We have a bunch of accelerometers in tree and as they go wrt to events
this one isn't even particularly complex.  The existing ABI covers
their events reasonably well so take a look at how they do it.  Often
it's a case of mapping names for the application of an event (free fall
detection, activity detection etc) to what what they are actually detecting.
Those generalize a lot better across different sensor types.  It's almost
always a threshold of some type. The tap / double tap are more complex
but we put quite a lot of effort into coming up with a general
description a year or so back.  There may new things but most of the
ABI is already there.

> 
> The sensor has further features still not covered:
> - g-ranges scaled by different ODRs, especially for activity / inactivity
>   threshold is not covered so far. There seems to be a particularity with
>   the ADXL345 as annotated on some analog FAQ.
> 
> - Various thinks like low power, sleep mode, etc. are (still) not covered
>   here, others (ACDC bit, selftest, etc.) currently are hard coded or not
>   covered.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> Questions:
> - Do I need a mutex/lock protection as this is the case e.g. in the ADXL367
>   or the ADXL380?
>   Actually, I understand those cases as protecting access to the state
>   object by different channels, temperature and accelerometer. I'm unsure
>   if this is a correct understanding, where for the ADXL345 there should
>   not be any issue. At most, a currently displayed value on sysfs is
>   (still) not updated. So, IMHO I can rely on the internal protections in
>   regmap no further mutex is needed. Please, can you give me a feedback
>   here?

If you have an read modify write actions triggered by sysfs writes they
can race (not serialization between different file writes).
That's why you tend to need the mutex.

> 
> - FIELD_PREP/FIELD_GET: I'd like to use arrays of enum indexed elements
>   to allow for more generic function implementation passing just a "type"
>   field, e.g. at single tap/double tap or activity/inactivity handling.
>   When it comes to filtering out bits using FIELD_GET/FIELD_PREP, it says
>   that this enum array element is not "const enough". Is there a
>   work-around?
I don't have it to hand but there is a patch set trying to add non
const versions of these that went to my other email.

For now just carry a local version as we don't want to end up waiting
for that patch to merge.

> 
> Lothar Rubusch (12):
>   iio: accel: adxl345: migrate constants to core
>   iio: accel: adxl345: reorganize measurement enable
>   iio: accel: adxl345: add debug register access
>   iio: accel: adxl345: reorganize irq handler
>   iio: accel: adxl345: improve access to the interrupt enable register
>   iio: accel: adxl345: add single tap feature
>   iio: accel: adxl345: show tap status and direction
>   iio: accel: adxl345: add double tap feature
>   iio: accel: adxl345: add double tap suppress bit
>   iio: accel: adxl345: add freefall feature
>   iio: accel: adxl345: add activity feature
>   iio: accel: adxl345: add inactivity feature
> 
>  drivers/iio/accel/adxl345.h      |   86 ---
>  drivers/iio/accel/adxl345_core.c | 1150 ++++++++++++++++++++++++++++--
>  2 files changed, 1099 insertions(+), 137 deletions(-)
> 


