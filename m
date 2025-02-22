Return-Path: <linux-iio+bounces-15927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E815AA407E2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1910A19C2F4C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606A2066DE;
	Sat, 22 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLklE7wg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA16FC3;
	Sat, 22 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740223880; cv=none; b=k5b4/urrsD2j8wbpbTYKhNnVCu3wAt+XBgGS44+rftBtxvso3xKqD1F04z/ztMTJyemtDZa91wpfvi2zHuaD3L9a8c+TWhS8uK+rJCHAMohqmqgnnuFEhda6d7KM53hn3hg9UWpo5rNAlz7zLDRpK1nUcMIM/UnXuKtzwCQRmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740223880; c=relaxed/simple;
	bh=cSwTYLOvKfcUp265iaxx2WMETmG/vPuRTNnqNn2a1Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAa/csuDH5nwiHN5q5WQ7KnJ3YZrnl2crN0ruNgILbLqHM/SmgWI/k7PeqiI5Sey/3sjkDM/HDwWeHXb0yCC0xCZWqeSF23drmYRmGC9C2iBxnMuz217+mVmnzKu80i8sZSSCrdqLj9sH2NKYLD3r0v6S4kh5z97EFVhOunTHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLklE7wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869EAC4CED1;
	Sat, 22 Feb 2025 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740223880;
	bh=cSwTYLOvKfcUp265iaxx2WMETmG/vPuRTNnqNn2a1Ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLklE7wgVc28ln6v7NmWTimdBKKVmCp8Z+Pdx7my2rjmHseqgRUnTzj+PUR93fP9g
	 WivrgtGpbFsr/+7ioyPY1HbokDCeaFuDDJ/Ar/qua1RbwsOlx/X4bbWoDyyVpoxNM7
	 DeBUCN2grvMXcLv1NMKioWQ0WzH10CC3E8P4/jbf+NixiQ6WvDbobyxHcbfwJHOeJJ
	 Rkyw03yR09FUz7cWeRQrxlojPdm7sRDcslZi1Sq62fkKjb2mfJK5ZxIkFm096Odp37
	 MrXvPe7RKAqpa+K5e6HmsLw9iiYv4gSRQnkXhvDp+hfpXW+4WRyAuUjyhaFH3/gZEs
	 QCPVahq/ySZVQ==
Date: Sat, 22 Feb 2025 11:31:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 corbet@lwn.net
Subject: Re: [PATCH v3 1/1] Documentation: iio: Add ADC documentation
Message-ID: <20250222113111.4886d3e7@jic23-huawei>
In-Reply-To: <Z7ZDzg0KHZhfiLo3@debian-BULLSEYE-live-builder-AMD64>
References: <c21b89367510c3d56d8d17adc24b46c7c63a14b2.1738759798.git.marcelo.schmitt@analog.com>
	<5084aed7-1b39-4cbd-b136-610bceb05c92@baylibre.com>
	<Z7ZDzg0KHZhfiLo3@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:49:18 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> A very slow re-spin time from my side but here we go ...
> I addressed most of the suggestions and am about to send a v4.
> Replying inline to the points I disagree with.
> 
> Thanks,
> Marcelo
> 
> On 02/05, David Lechner wrote:
> > On 2/5/25 6:53 AM, Marcelo Schmitt wrote:  
> > > ADC inputs can be classified into a few different types according to how
> > > they measure the input signal, how restrained the signal is, and number of
> > > input pins. Even though datasheets tend to provide many details about their
> > > inputs and measurement procedures, it may not always be clear how to model
> > > those inputs into IIO channels.
> > > 
> > > For example, some differential ADCs can have their inputs configured into
> > > pseudo-differential channels. In that configuration, only one input
> > > connects to the signal of interest as opposed to using two inputs of a
> > > differential input configuration. Datasheets sometimes also refer to
> > > pseudo-differential inputs as single-ended inputs even though they have
> > > distinct physical configuration and measurement procedure.
> > > 
> > > Document consolidated ADC input types and how they are usually described
> > > and supported in device tree and IIO, respectively.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---  
> ...
> > > +There are three general types of ADC inputs (single-ended, differential,
> > > +pseudo-differential) and two possible polarities (unipolar, bipolar). The input
> > > +type (single-ended, differential, pseudo-differential) is one channel
> > > +characteristic, and is completely independent of the polarity (unipolar,
> > > +bipolar) aspect. A comprehensive article about ADC input types (on which this
> > > +doc is heavily based on) can be found at
> > > +https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.  
> > 
> > It could be worth reiterating here that although there are 3 different input
> > types, in IIO, differential is only a bool, so there is no special distinction
> > between single-ended and pseduo-differential (other than possibly having a
> > common mode voltage input). And unipolar/bipolar is only considered on the
> > difference between the two inputs and not the individual input, so in IIO there
> > is no special distinction between bipolar and true biploar - they are modeled
> > the same.  
> For v4, I'll be mentioning the differential field meaning and the bipolar / true
> bipolar (in)disctinction in other subsections bellow. Hope that will make those
> points more clear.
> 
> ...
> > > +1.2 Differential channels
> > > +-------------------------
> > > +  
> > 
> > Suggest to insert here:
> >   
> > > +A differential voltage measurement,  
> > 
> > sometimes also called "fully differential" or "true differential",  
> 
> I think adding that would make the sentence harder to read and somewhat incorrect.
> The differential measurement has to do with how the ADC takes the input signals
> into account to generate an output code. The "true differential" has to do with
> the expected limits for the input signals. Fully differential input is yet
> another thing that I've been avoiding to describe because I think those can be
> supported as differential bipolar channels.
> 
> >   
> > > digitizes the voltage level at the positive
> > > +input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
> > > +In other words, a differential channel measures the potential difference between
> > > +IN+ and IN-, which is often denoted by the IN+ - IN- formula.
> > > +  
> ...
> > > +1.2.2 Differential Unipolar Channels
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +For **differential unipolar** channels,   
> > 
> > I think it would be nice to have a short first paragraph that just says that
> > this configuration is quite unusual and that the difference would have to always
> > be positive. Then follow with the rest of the info for the curious in a separate
> > paragraph. Then it will be easy for those not interested in the unusual case to
> > skip over that part.  
> 
> I think, reordering would make the explanation harder to follow.
> Even though currently not using those exact words, it can be inferred that the
> difference is expected to be always positive:
> "IN+ is allowed to swing with the measured analog signal and the input setup must
> guarantee IN+ will not go below IN- (nor IN- will raise above IN+)"
> The last phrase also somewhat hints that the differential unipolar setup is not usual.
> "Thus, differential unipolar setups can often be supported as pseudo-differential
> unipolar channels."
> 
> >   
> > > the analog voltage at the positive input
> > > +must also be higher than the voltage at the negative input. Thus, the actual
> > > +input range allowed to a differential unipolar channel is IN- to +VREF. Because
> > > +IN+ is allowed to swing with the measured analog signal and the input setup must
> > > +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
> > > +differential unipolar channel setups have IN- fixed to a known voltage that does
> > > +not fall within the voltage range expected for the measured signal. That leads
> > > +to a setup that is equivalent to a pseudo-differential channel. Thus,
> > > +differential unipolar setups can often be supported as pseudo-differential
> > > +unipolar channels.  
> > 
> > I think we should just leave out the sentence about being supported as pseudo-
> > differential. There is already a different section that describes that and it
> > would be simpler to just stick with describing the fully differential case here.
> > The differential bipolar section also only describes the fully differential case
> > so mentioning pseduo-differential here seems inconsistent.  
> 
> I also disagree with that one. A differential unipolar setup is uncommon
> (at least) so the mention of pseduo-differential is to point to what would be
> the usual way of supporting those input configurations. Differential bipolar
> inputs are common so no need to mention other input types when talking about
> differential bipolar.
> 
> Though, I'm fine with changing the explanations if Jonathan prefers so.

Generally I'm of the view that getting some good docs in place is more important
than necessarily getting the perfect ones.  So where I don't feel strongly
(which I think applies to the remaining discussion) I go with the author choice.

Jonathan



