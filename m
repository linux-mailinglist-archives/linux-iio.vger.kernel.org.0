Return-Path: <linux-iio+bounces-26438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5547C827BA
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6F5E4E2E06
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD54E32B991;
	Mon, 24 Nov 2025 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="xKSwrsPT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17269195811;
	Mon, 24 Nov 2025 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018490; cv=none; b=JXJT/0Jx/8Y0Dmt4C8wM1azo1b4bEGtnM1QuTtKHqUbHiSPwux35zYyp8e0JMXLH6o9SNmEQDeP/8bZsxAtWm0sRfxOX+loVTunrBGn/h7TWddOOP5aP3j4CX2POrfXN2I//EmKyxexKz65nbGcopR5lyocNcvVO6pICIs9WuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018490; c=relaxed/simple;
	bh=NW0f5JPi9SEMKFTgzI3Czans/wgatKxBoCU9pPLfF5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpGTJYycmiNSC5x18+hy0YLhoGKkWdFp4+/aD5pmfsGdMTe90S9H4YL4KGm1cF4U/VM8eXaYS7SNxBmcPKy+fdSvMuKuKccbhWTxw0zi7/zlHARzUs9N7Fzj1N2ABGS5/tfbq+Im7Dl3Jelz+gXNzFCCj/GRy5snW+y+jo0qCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=xKSwrsPT; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BF027160209;
	Mon, 24 Nov 2025 23:08:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764018484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IEEhvbpjXvfPRiWmMBKAzn1X/BOJQLsBZlc4aFyD7vc=;
	b=xKSwrsPTSlAw3oV3btc5rgAb8Ul+x7zQM+ocgad7PyIyMdmhWiBvPpvnAwjilp23oaTI3B
	w2hao1EWx1HRNhKJkEFfH0AjR1/8SANvfJGViQVyXP+NBvjcq9wp7yJ8e+UF1KPN9h+iNG
	Z8TE4F8W8r+VaecUcq5XwsrkwtlVONc2+TdFlgiwkl+1v2EQNzO7AYb9uY1OhsZecyAxea
	Glkb0GtDjvb0TPy07gIcunTnADHvwK3rObX2ibZlLI00J9ImOIubJU2RjKwDrmt2MSnZOV
	H0vXduvO1JzH0JOIFSAgQ4C8/u8tHVw9Mxg7rQMMa4Lixr4POac6cCFBNUqywA==
Date: Mon, 24 Nov 2025 23:08:00 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSTJML3fxp0sSeCq@lipo.home.arpa>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
 <aSRF-DL3rKjyFleg@smile.fi.intel.com>
 <aSSV4lxzatAFds5e@lipo.home.arpa>
 <aSSm3JMY3DSg1Nns@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSSm3JMY3DSg1Nns@smile.fi.intel.com>


hello!

On Mon, Nov 24, 2025 at 08:41:32PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 24, 2025 at 07:29:06PM +0200, Petre Rodan wrote:
> 
> > > Why explicit assignments? Is it related to some HW register?
> > 
> > no registers, I just need to ensure the two arrays
> > 
> > static const char * const abp2_triplet_variants[ABP2_VARIANTS_MAX] = {
> > 	[ABP2001BA] = "001BA", [ABP21_6BA] = "1.6BA", [ABP22_5BA] = "2.5BA", ..
> > 
> > static const struct abp2_range_config abp2_range_config[ABP2_VARIANTS_MAX] = {
> > 	[ABP2001BA] = { .pmin =       0, .pmax =  100000 },
> >    	[ABP21_6BA] = { .pmin =       0, .pmax =  160000 }, ..
> > 
> > keep being consistent and are resistant to later editing.
> 
> So, if it's pure software numbering, just drop assignments in the enum.

so you want the consistency check to be dropped? we have data in two different arrays and they must be kept in perfect sync. if I were to remove the assignments someone comes a few years in the future, inserts a new device in the abp2_triplet_variants array at position 84 out of 113, also inserts a new {pmin, pmax} into the abp2_range_config array accidentally at position 83 and the compiler will be none the wiser.
just the day before I had to remove a variant because of a typo in the datasheet. I cheat and use a script to generate the structs [1], but if I had to modify them by hand, the assignments would make sure I delete the proper line.

am I proud of this? no, and I told you my preference. this is just a compromise that uses the non-specific match function and still provides a guardrail for future editing.

[1] https://codeberg.org/subDIMENSION/lkm_sandbox/src/branch/main/honeywell_abp2030pa/scripts/parse_variants_table.sh

[..]

> > > So, why can't regmap SPI be used?
> > 
> > there are no registers, no memory map, just a 'start conversion' and the
> > equivalent of a 'read conversion' command.
> > any reason one would use the regmap API in this case?
> 
> At bare minimum the commit message should have a justification for the choice
> explaining all this.

I had the justification in the cover letter instead, my bad, will include it in
the commit message instead.

> Ideally, try to find a way how to use regmap API. We have several weeks of
> time for this exercise.

you did not mention why use an API designed for devices with registers and a memory map on an IC that has neither.

I also have a bughunt in the spi-omap2-mcspi driver related to improper CS delays in queued transfers, regmap will probably just be an extra layer of abstraction I will have to go thru :/

[..]

oh, and

struct abp2_spi_buf {
	u8 tx[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
};

static int abp2_spi_init(struct device *dev)
{
	struct spi_device *spi = to_spi_device(dev);
	struct abp2_spi_buf *buf;

	buf = devm_kzalloc(dev, sizeof(*buf), GFP_KERNEL);

> Using devm_*() here is most likely a mistake. What is the object lifetime in
> comparison to the used device?

I did think that placing this into the abp2_data struct would be a better idea, but I was not sure how to handle the alignment issue since there is already the read buffer there:


#define ABP2_MEASUREMENT_RD_SIZE 7

struct abp2_data {
	struct device *dev;
	const struct abp2_ops *ops;
	s32 pmin;
	s32 pmax;
[..]
	struct {
		u32 chan[2];
		aligned_s64 timestamp;
	} scan;
+	u8 spi_tx_buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
	u8 buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
};

how do I make sure both 7byte buffers are aligned? can I __align twice in a struct as above? or should I align only the first buffer and make it 8bytes long?
I had a close look and even if the SoC's SPI driver supports both DMA and PIO, I've seen it pick PIO every single time while talking to my pressure sensor.

best regards,
peter

-- 
petre rodan

