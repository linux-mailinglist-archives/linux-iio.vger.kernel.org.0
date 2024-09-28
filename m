Return-Path: <linux-iio+bounces-9858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C901D9890EE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058981C20E96
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213A14F12C;
	Sat, 28 Sep 2024 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ1GmF/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB51474D3;
	Sat, 28 Sep 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727545974; cv=none; b=E5cS/ddF63TwFb+R1eKfipRgcF+RTfCzRT4NTX3O2GXcDx7GtM1CO6Y3mmEkTb6yt6BRJW14Om+l4+lIeI1Jy7PyXsBXfa9s3ltiVw3Wi/0RXBQdXv9ao05R0TDVqArrASezK+Auvq0UCqdAR9Cw+M0Nrzk5js0+Q7T7OYH2CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727545974; c=relaxed/simple;
	bh=LCwr42nAlmM8VreNQQTNzN2P7ftPF2DZHZHTJLAl4vY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOZo7SILbQqY2MmArpc8fqVAI+q1ePzFqcppt8Kn4sfoS8HvGPjbH9XoHJjJSp1Gri9BR436wyf47C1kCodBTnr8c4hTFIsv5qagsIn8Gb9CnhKp4s/6CazKQNocEeMlVheIQcrha1GxGHlZhwFewfdN/YZzWVefbK9psKw+DaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ1GmF/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE27C4CEC3;
	Sat, 28 Sep 2024 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727545973;
	bh=LCwr42nAlmM8VreNQQTNzN2P7ftPF2DZHZHTJLAl4vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQ1GmF/Fq4dyzfz65QlXIv1/gHW/Hrh34IBaQ9dm7Nx1muMjlMLKW3civU2IitaoY
	 vZRjSbd0R1kYaIBI9MmuaPe12fDVSZvL/+J/gzgEZXI3vj79wc/zNNBWQP1a3cn6RP
	 YEIqT+bsMzkN6avHQC4CddV0IWo7Fi3AQtcFuTIfzmbz8YbbGljQWjg8Vd6069Ejrh
	 UQptIjY90WPNYH4fwIIBTEIqtoHToxqoNTmFjtMDv3M1gXbnb826yIx+futPD71SjZ
	 JVYhhdmHDrnRIKQJgAWtoQzhuVbD0qM1qX89OWsBJDlV9FHAqFzFHflOXr430EPmBA
	 mjNpV9xMRbBxA==
Date: Sat, 28 Sep 2024 18:52:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Ramona Alexandra Nechita <ramona.nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20240928185244.678bfa46@jic23-huawei>
In-Reply-To: <ZvVr4nu_UgsmyWnE@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
	<20240926135418.8342-3-ramona.nechita@analog.com>
	<ZvVrsXrm8XBYGeRn@smile.fi.intel.com>
	<ZvVr4nu_UgsmyWnE@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 17:12:50 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Sep 26, 2024 at 05:12:02PM +0300, Andy Shevchenko wrote:
> > On Thu, Sep 26, 2024 at 04:53:56PM +0300, Ramona Alexandra Nechita wrote:  
> 
> ...
> 
> > > +Description:
> > > +		Reading returns a list with the possible filter modes. Options
> > > +		for the attribute:
> > > +			* "sinc3"	- The digital sinc3 filter. Moderate 1st conversion time.
> > > +		    Good noise performance.
> > > +			* "sinc4"       - Sinc 4. Excellent noise performance. Long
> > > +			1st conversion time.
> > > +			* "sinc5"	- The digital sinc5 filter. Excellent noise performance
> > > +			* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> > > +		    time.
> > > +			* "sinc3+rej60" - Sinc3 + 60Hz rejection.
> > > +			* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> > > +		    time.
> > > +			* "sinc3+pf1"   - Sinc3 + device specific Post Filter 1.
> > > +			* "sinc3+pf2"   - Sinc3 + device specific Post Filter 2.
> > > +			* "sinc3+pf3"   - Sinc3 + device specific Post Filter 3.
> > > +			* "sinc3+pf4"   - Sinc3 + device specific Post Filter 4.  
> > 
> > I still think that a compromise to leave the existing values as an example in  
> 
> > the existing bindings is a good to have.
  
It gets hard to do really quickly because we end up with effectively a full set
of docs for each one.  I'd like to capture that information but I'm not sure ABI
docs are the right place because we don't want each entry to followed by pages
of specific examples. 

I'd have loved the option for ABI docs to have extra info in a per device
file that doesn't end up in the main docs build but we don't have that yet.

Jonathan

> 
> s/existing/generic/
> 
> 


