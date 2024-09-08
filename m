Return-Path: <linux-iio+bounces-9324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5700B970762
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 14:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3A28231A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EF4161306;
	Sun,  8 Sep 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niQ6mWLG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169361509AB;
	Sun,  8 Sep 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798409; cv=none; b=B2Ns5CigvRN4Qf12lQvUCJg9i3oIsxDAxzAKkqwRx5m5hX+m8jXF+iLR3TfXMEuCRoJau3I4wjnik7O8El6c9SDNdRGIvFvP2hiSxfEU5gGeos42C7NxGNO9YDO29j+ypTnTdaVo6eyIaSaNafIchIsE/RGcweMlJT65qq/5qD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798409; c=relaxed/simple;
	bh=VAcsrFstzUOeCIGcnQ5KBqekKS17CdwXMYlisjyPJQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdhFtIeAB9RDAbqLgPjEgOKT+WRNY7ntjgsNdHLrnOziK0MZ3K+iEzN2HQuDlkTzA0srxAPwMIy+cLfDjXdPfElh62Bh/5eY/B16qjZb+1NysMFZal0igYv59kxsWPKZpz7NkBMAXhl8XNirnkPpShu+S5bNciRpoZQ4oJ9pogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niQ6mWLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9939C4CEC3;
	Sun,  8 Sep 2024 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725798408;
	bh=VAcsrFstzUOeCIGcnQ5KBqekKS17CdwXMYlisjyPJQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=niQ6mWLGzsHB8u7kUzL1M9m5aUfJ4bChFO8ZO3nnPftaa3Ak+oYKbDDalzX8P0qUJ
	 WGgTFycxhZu1+S51n3Wy2spFPyl/CVxSy4WQVn6p8tnGhqWfUDXl47YAUM6DQxMFRe
	 IvavxhXlkCiXOJ36VUnQYPWyDljohSe00MOsPctmbKBfAz3S1qTr8WidrLT4KS9AIq
	 62ORDHh+/YIuDXiPLh4VSo56CtuAwcSP512abmU4fxPceaVx1eYRX2D+8udsrfmuKl
	 fVatOOVhPbzufo6RL8qBz7A9dvpcCeIZ/hkPkbIU30aXyaJWYQ/iE/fpdCIXXZypj1
	 CAkFiSa5J5f9Q==
Date: Sun, 8 Sep 2024 13:26:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] iio: ABI: add DAC sysfs synchronous_mode
 parameter
Message-ID: <20240908132638.6322be29@jic23-huawei>
In-Reply-To: <b70612bd-e61f-4286-9337-bca48768fbdd@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-9-87d669674c00@baylibre.com>
	<b70612bd-e61f-4286-9337-bca48768fbdd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 14:14:37 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Some DACs as ad3552r need a synchronous mode setting, adding
> > this parameter for ad3552r and for future use on other DACs,
> > if needed.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-dac | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
> > index 810eaac5533c..2f4960c79385 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-dac
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> > @@ -59,3 +59,19 @@ Description:
> >  		multiple predefined symbols. Each symbol corresponds to a different
> >  		output, denoted as out_voltageY_rawN, where N is the integer value
> >  		of the symbol. Writing an integer value N will select out_voltageY_rawN.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode
> > +KernelVersion:	6.13
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Arm or disarm a wait-for-synchronization flag. Arming this flag
> > +		means the DAC will wait for a synchronizatiopn signal on a
> > +		specific internal or external wired connection. I.e., there are
> > +		cases where multiple DACs IP are built in the same chip or fpga
> > +		design, and they need to start the data stream synchronized.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode_available
> > +KernelVersion:	6.13
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		List of available values for synchronous_mode.
> >   
> 
> Since this depends on how things are wired, it seems like this should be
> something specified in the devicetree, not through sysfs attributes.
> 
Agreed. Smells like a wiring thing given the description.  Is there a case
where it works either way and it is usecase dependent which choice makes
sense?   Superficially it seems likely if a board has this wired, there
is little disadvantage in using it always.

Jonathan

> 


