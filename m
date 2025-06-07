Return-Path: <linux-iio+bounces-20290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E8AD0D97
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A95F7A8A93
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A78222586;
	Sat,  7 Jun 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTXonBva"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91181C1F05;
	Sat,  7 Jun 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301877; cv=none; b=rAF9goDvNFvThDb1nr1WPeWX3PF+pVbWV8xZf7cOzh/jlpbUx15UN429aZtz8Iz0G4OARR+7GXUfxB5fhJzcFT4U7tCqGpi7Cy2TpFrqTQnDv45oSiEMYL0ZiFDyFewWItLVCtyAXrNPVgJftvDHb42oBPpn2VP1UMdR7j+ystc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301877; c=relaxed/simple;
	bh=6FIk+SotQ2ttPX+ZDy1YxfSy1GjFl9fNYzOZFSVWSjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfLBO8EVN+kt/M11wtdYb2ML4yDlIis/f2nCxnDh9g3Ji+HgZIaNwmLg+G/fWDDTA9nmct96k12zX/jF81GDLnkMlBi6AgdI1cOH9UgqlvqVdOKafS91/DaWAvmvNYelWRYF8VyrNYvfcRf6voALEeRYDPLAgPrug0oIfuqVpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTXonBva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B489EC4CEE4;
	Sat,  7 Jun 2025 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749301876;
	bh=6FIk+SotQ2ttPX+ZDy1YxfSy1GjFl9fNYzOZFSVWSjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DTXonBva6OOUcPiSytcgUF6bzREc25gEf0ymt00q81+EB8XYS9eAv6o1iYcNdSgD+
	 vT3Z9YHagkBw2HTAQR9XAo9xpXoYSCW/fl5/Sb+A5+y6NwOZFC7M1OvXb2qLZzdNgw
	 2PgD7SXyP2VMoEOOs8sf6jNvlWyiqQTEfphnkIeC1HzUZv7WxgFZ5gZGStol0IxbVe
	 4B8LX54T8MmKU5ULgEeM7rtVpumUWIuwJRcdI6pQ+CNfRe0rcVV3b5tsf5WtSc4SKl
	 6qDM3JVhXOGQF5pPNfm99c/FZXrThdQRC+G1aENM7rRr9cXoyBmFho2U9tZbVo0cT6
	 lF760jmb6XXGw==
Date: Sat, 7 Jun 2025 14:11:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 0/7] iio: adc: add ad7606 calibration support
Message-ID: <20250607141106.2e6e50d1@jic23-huawei>
In-Reply-To: <20250607140811.4bff9232@jic23-huawei>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
	<aEM-C0HHPcYTTpBd@smile.fi.intel.com>
	<20250607140811.4bff9232@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Jun 2025 14:08:11 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 6 Jun 2025 22:14:19 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Fri, Jun 06, 2025 at 04:19:15PM +0200, Angelo Dureghello wrote:  
> > > Add gain, offset and phase (as a delay) calibration support, for
> > > ad7606b, ad7606c16 and ad7606c18.
> > > 
> > > Calibration is available for devices with software mode capability. 
> > > 
> > > Offset and phase calibration is configurable by sysfs attributes, while
> > > gain calibration value in ohms must match the external RFilter value,
> > > when an external RFilter is available, so implemented through a specific
> > > devicetree "adi,rfilter-ohms" property.    
> > 
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >   
> 
> Applied to the testing branch of iio.git.  I'll rebase that on rc1
> shortly and push out as togreg.
> 

I just saw that David gave non trivial feedback on v8.
I'll keep this queued up but I'm happy to rebase if we do need to make
any additional tweaks (or to add tags if appropriate!)

Jonathan

> Thanks,
> 
> Jonathan


