Return-Path: <linux-iio+bounces-25261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBABEDA7D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C01619C1EFA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3EE26D4F8;
	Sat, 18 Oct 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr/8YJoc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAB212556;
	Sat, 18 Oct 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815847; cv=none; b=I5vaDwbYLSoWcI6QVJnHJL9V/mUxemXqph03NwVQENdOHSdQ3/6SODknPXT8UnDN3i9EG5UcBGdBZlVqBvRS2vwgx9Ru8G2OLb1UbFOayrciV+JWG1My61NsmkcKwksXNl8hNKVaAy8RR2IgGQqbonJbl0ktJA5atc/2ZalkF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815847; c=relaxed/simple;
	bh=BWhmOAvJgGNoEDDbN/GPY952TFrD7G5uVkkKREEI2m4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo/n/HM5gnBV8+sHAwAm4lkLrPGjEv9L9hgPVcEJScfXcX4OPtrThUN9LXBf9XUDiABSyBu3S+LUls5oxGO/Kp/NEnim3hNCyRcJbxDR1KeC/LSbW1fb8wq5Hw6/GZTsY4qZkrECpXvvX8BMfe4JV82cluoG7sr4VOn3sut5NUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr/8YJoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D5FC4CEF8;
	Sat, 18 Oct 2025 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815847;
	bh=BWhmOAvJgGNoEDDbN/GPY952TFrD7G5uVkkKREEI2m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tr/8YJocD3nqygXmGcjm9YoaZ+47k0g39GeB5yvR0Aw420M5AtCjXoH2yYNsCZHHw
	 rCURycPv8lxwBCldCv/ysuY8mc6yJnE8i9uslcv/soxF7U5ldXjaDzihUeaHZx2tm9
	 UCKDC5jw4eAq/Qx6K5na5rLb7R4fygZZbSLjIVTo962dLL1T4J125h0P8aL8Ye4AZu
	 j1PqVhshwXXle1uUKhzIp5HCli+vsGp7UiJBGRzecImwht90WNGdp0Q30riI6DZEJM
	 F6x4Gi/22OmCXSgwyaaWKbl2Xm6DdUhZSbTikACNv6rsVRgh5NeDtTcAxgLUuaq+j+
	 n32fMGlGUbitA==
Date: Sat, 18 Oct 2025 20:30:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <Marcelo.Schmitt@analog.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [PATCH v13 2/2] iio: adc: max14001: New driver
Message-ID: <20251018203038.40084197@jic23-huawei>
In-Reply-To: <aPGlWznNdrPma4jZ@debian-BULLSEYE-live-builder-AMD64>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
	<2e0e5fadeb3083a79a31776d9e996b865c1b1f5f.1760502331.git.marilene.agarcia@gmail.com>
	<aPGlWznNdrPma4jZ@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 23:09:31 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 10/15, Marilene Andrade Garcia wrote:
> > The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-range
> > binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
> > more features, like a binary comparator, a filtered reading that can
> > provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> > comparator that triggers the inrush current. There is also a fault feature
> > that can diagnose seven possible fault conditions. And an option to select
> > an external or internal ADC voltage reference.
> > 
> > MAX14001/MAX14002 features implemented so far:
> > - Raw ADC reading.
> > - MV fault disable.
> > - Selection of external or internal ADC voltage reference, depending on
> > whether it is declared in the device tree.
> > 
> > Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> > Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---  
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> Hmm, I don't know why, but I would have given a different order to the tags
> Reviewed-by: M. S. <...> # new tag
> Tested-by: M. S. <...>
> Co-developed-by: K. S. P. <...>
> Signed-off-by: K. S. P. <...>
> Signed-off-by: M. A. G. <...>
> 
> Swapping tag lines will probably not be a reason for a v14, though.

There have been many debates on this but no clear rules wrt to whether
review / testing tags should go earlier (on basis the sign off occurs
after them if they were on a previous version) or just put them all at the end.

Meh. All the right info is here so I'll just leave it be.

Series applied to the togreg branch of iio.git. Initially pushed out as
testing to let the autobuilders play with it.

Thanks,

Jonathan

> 
> Cheers,
> Marcelo


