Return-Path: <linux-iio+bounces-20974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72EAEA546
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B55563F2D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4412EB5C0;
	Thu, 26 Jun 2025 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIS4lPP6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287301F2BB8;
	Thu, 26 Jun 2025 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962165; cv=none; b=tDDwdHqwn6bjLPWABqqhhGGfHVHwRHc5I9MFEvfnMzW3jk22hiyFOfEE5k7k2BEOI5ESU5KCD4qhZHpYMogDGgo81UUb4D0sazMPirWwJuawCTTIG+743xmYP8I6SG+NDrhC3bwYZg6bj8lEZkNM9wI3OG5C/nktj+IcsUhtKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962165; c=relaxed/simple;
	bh=4rrr1+o4pM22LUtrQbujJnbXSgUUBHBo2+S8QH43ENw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPTntOevFcGLVSTOLtUUA5thmDmmCE+hcb2rTkdHkuE6t2tfR6kH3W5kAlq31qJsaNR8cem+6QDvelG9+Q9ZWk7LXsr2NXKM/Nf147dqQK8+qvCVo0+BlzikQlSBvzxJ2Ow2YSvqEWPAY8hv+mrHv7Gs6XlD/X7V3R5EWQJWtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIS4lPP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876DDC4CEEB;
	Thu, 26 Jun 2025 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962164;
	bh=4rrr1+o4pM22LUtrQbujJnbXSgUUBHBo2+S8QH43ENw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VIS4lPP6gP87ChI3L/KHHo1umegsk5xxloa+zmEWWpdHVO3YnZcG5LJMBCGtacxpw
	 MxVCB/TPvvoZmQpDq4jSqhLq6xvE100ikxVhuQuMWoWtxUFU8iwNmFPJHNi2fZ4NJ0
	 TV2Ja6cyN0pqW87gJprS2WuljAwRgAaErAei/r7yWegejC75hGST4ehS0K7KnG4H8c
	 bhcLNR5nzricgCrBVj+Oz0Kp0EFx61plYVYXrtJNetk4K6DdYCZH1fNFrQMy9MYqcu
	 jQyqVa+6Dno/Gs9oDrBOTl2On07b4cKOIRqXyzS62IBhyF1Di5lENNRdjlvkCTeZEa
	 Qk+kCa3u/6pWQ==
Date: Thu, 26 Jun 2025 19:22:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, mazziesaccount@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: ti-adc128s052: replace literal by unit
 expression
Message-ID: <20250626192236.7bd51d18@jic23-huawei>
In-Reply-To: <aFw4kesQt4WMt2uK@smile.fi.intel.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
	<20250625170218.545654-3-l.rubusch@gmail.com>
	<aFw4kesQt4WMt2uK@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jun 2025 20:57:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 25, 2025 at 05:02:18PM +0000, Lothar Rubusch wrote:
> > Replace the literal number 1000 by MILLI from linux/units.h =20
>=20
> Yeah, but with this units (mV, uV, mA, uA) it would probably better to ha=
ve
> dedicated definitions, like we have for Hz, s and maybe something else
> (bytes?).

I'm not that keen on us getting loads unit specific conversion factors.

=46rom a code readability point of view (given my wish to avoid lots
and lots of unit specific defines) I'd favour using
MICRO / MILLI here and let the compiler resolve that to 1000

>=20


