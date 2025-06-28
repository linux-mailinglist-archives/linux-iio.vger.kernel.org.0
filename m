Return-Path: <linux-iio+bounces-21040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47143AEC846
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E36188B236
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C42165F3;
	Sat, 28 Jun 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhVA+6mD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1D71747;
	Sat, 28 Jun 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124302; cv=none; b=ZtkNQs554suVxlnHPLaX2gVBn/roSzGpaF0x7RPeBFqCbA4/pZWyrj2Mihbbk49s6LNamvU6u/S4PwGYq/Ia5nv5gQrX5SeeqdZIY54wb5PAqit6WCap0K1+TMmV2uR9qe51+EXHODgzJU2L+5Emy4POVQspnkQe9tV8hcqgDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124302; c=relaxed/simple;
	bh=x9+sq3TieJcS6izlU7gLoo2hEdPEed1tkqOT6JQDyfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4KAqaik6kCjH70bRqZ801W+Vi9U5GFDt8xx8zRKq6c3CkG1XTohtJO+rkSKJiXvelS7L9zeYWObKAMYzsEHCQGZ0sFw+1JABlaGRGOzHCzOMLcCepEtj/njo5Rw4kOkscRh+UEzVuXjv2hcr1o7dKtiBcnnYiIbb2f0hq/yrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhVA+6mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2DEC4CEEA;
	Sat, 28 Jun 2025 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124302;
	bh=x9+sq3TieJcS6izlU7gLoo2hEdPEed1tkqOT6JQDyfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhVA+6mDH+ze7djdZEjEBZk5LyPuYJP/LvkKBugOT/qdK1wGG8xr8KJ2wXmLFWZoV
	 C8FRWHXYMzbXIo2PFZlgAndRHvxkby1M4nZ3yGBi+HQCI7i1rjgJo8/zVt+uaYUtIR
	 1y6H9UJ6vG5yEPu56vPLjWmDoiIV7ALvXsnhGlSwHVAfYYCtyFB1OOdeULkxW72TPQ
	 lFnyq4PqnshRAXBuOXRkQFQ5tty0x2PH5LolYLfDw4KaXq8UF2drpYMBVwrwxX2uTP
	 Tn2VOxZYb+PQiyB4Lf3JEAwYqT++hDy3GTkVRsJbTKvO6XtYGIXce+V87ygl6TEi+f
	 QlA0ip5T8wJ3A==
Date: Sat, 28 Jun 2025 16:24:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen 
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3530r: Fix incorrect masking for channels
 4-7 in powerdown mode
Message-ID: <20250628162453.0848d93d@jic23-huawei>
In-Reply-To: <c0f4907eb762e618dcf64a6821320f814715be5f.camel@gmail.com>
References: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
	<c0f4907eb762e618dcf64a6821320f814715be5f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025 16:54:33 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-06-26 at 16:38 +0800, Kim Seer Paller wrote:
> > In the current implementation of ad3530r_set_dac_powerdown() function,
> > the macro AD3530R_OP_MODE_CHAN_MSK(chan->channel) is used to generate
> > the bitmask for the operating mode of a specific channel. However, this
> > macro does not account for channels 4-7, which map to the second
> > register AD3530R_OUTPUT_OPERATING_MODE_1 for the 8 channeled device. As
> > a result, the bitmask is incorrectly calculated for these channels,
> > leading to improper configuration of the powerdown mode. Resolve this
> > issue by adjusting the channel index for channels 4-7 by subtracting 4
> > before applying the macro. This ensures that the correct bitmask is
> > generated for the second register.
> >=20
> > Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3=
531R")
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

