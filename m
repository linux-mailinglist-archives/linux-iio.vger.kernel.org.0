Return-Path: <linux-iio+bounces-18103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83114A88B76
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52317A3A76
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311D28BA9E;
	Mon, 14 Apr 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzueOWKl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F819FA8D;
	Mon, 14 Apr 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655746; cv=none; b=WP9ppNAG3+6Jyg2nwC3whFlplscG0iDEZUISPxkJxafD2iuqo0w8M0Y90TZdm1OrzJMrM8+NHF10/cVoDXOzWibQPIpUNqQbCB448oA8ZVpKIelSFAnoanjWK5bVi4wXTVzIbYe5wJX8TPW3fCwsfW55r2IrAv9PKmZ11naZhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655746; c=relaxed/simple;
	bh=k2g0Mk9JKK4aalvTmKqSOU0NxOAcYOyOL4e+bs5uRZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li8r3UXjq3pr6WSplZSWWK5uxRBQjSlIYNZKU+iZPrTjD7PGYlgUQmtY6xR3jS2moRTYF4Z0K+6tXJVDTXmX/6ZPyDnjedhqXc1beS/W6szAkYJScslPMSKxzxT4Wvuc9igdfTyeAaXY/iqNl7OpOfHs52f2J4gPGwKxvsVTt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzueOWKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C94C4CEEB;
	Mon, 14 Apr 2025 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655746;
	bh=k2g0Mk9JKK4aalvTmKqSOU0NxOAcYOyOL4e+bs5uRZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzueOWKl4BW13sJujFq5P68VjB/HMYPEWH0Iyt2DNdulLtZijxhRdc2OnflD2jdLE
	 yeQNi/hPHrtuFXUBALVEUb6Hz8syT4auTaQHaY9DzLRsqngDg8bqwNqPORZkgNQYCI
	 rOZ4nqdqjSXZBFpGyWGMpO4y+xStdLCZ+VVUDfYdy47UigkYnSjg/zHIDYlLpP0I6e
	 6VDOwbJwvipc04OYKH6p3lVdzJ27sm/88TYcxF0IhMw0Gvvhw+uiPP+y1JNpNHejhO
	 5SotQUsupH5yNu2ALc6353Rw7B/kNdhE1zlRjOVtPjQQzSk9t5aeRq+NnpApLEPZqs
	 hbdWLfLxPbfSQ==
Date: Mon, 14 Apr 2025 19:35:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan
 <ldewangan@nvidia.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
Message-ID: <20250414193538.5eb8e4a4@jic23-huawei>
In-Reply-To: <CAPVz0n16TbodhuTcqUufCk6=178ZTcc=2SLUjYHe5YsSJvettQ@mail.gmail.com>
References: <20250310075638.6979-1-clamor95@gmail.com>
	<20250310075638.6979-3-clamor95@gmail.com>
	<CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com>
	<20250412115354.0b266fae@jic23-huawei>
	<CAPVz0n0eqLEjVgMX=4A8jZZ++Ffb_vfCRdqYdizDmuLbXjVb1w@mail.gmail.com>
	<20250413102822.0cca4941@jic23-huawei>
	<CAPVz0n16TbodhuTcqUufCk6=178ZTcc=2SLUjYHe5YsSJvettQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > > > > +
> > > > > > +       indio_dev->name = dev_name(dev);  
> > > >
> > > > What does this end up as?  The convention in IIO is to name after
> > > > a part number.  If you have duplicates this isn't how you tell them
> > > > apart.  So I'd kind of expect thermal-generic-temp or
> > > > something like that.
> > > >  
> > >
> > > it is "generic-adc-thermal" with this name, it is not present anywhere in IIO.
> > >  
> 
> Then this is acceptable?

That string is fine.  I'd still be tempted to hard code it here so the
value is obvious to anyone looking at the driver.

Thanks,

Jonathan


