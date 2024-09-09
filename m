Return-Path: <linux-iio+bounces-9410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8A97225F
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927D81C23819
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 19:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96527189BA6;
	Mon,  9 Sep 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St/rbz1d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281C189B8B;
	Mon,  9 Sep 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908986; cv=none; b=EbQdLSxUBOJa4V8mMB65PTInSlxbH6ex4G/ze4qVeeT7i8ebpE/4DX0KJslqd4aNl+BHkdyZeKDu5A222tSM1lG8x4uxtsS7oWStHWCIAXmJce/uzFEDDc+N+XGEoNifnd5euhWX2Ilxy/p21Y01JEXYfwBYOgkW4vm5Vr60gZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908986; c=relaxed/simple;
	bh=TJeb+yY4BdHG3QeXUNQK4acpsl4QjdOwr+xpbgmQfc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igriuCdZ9g6yXGqtUENfpcoI63NQ+/9QEvLgUU+xp0wdBZkJcwn5kqXlh4Q8lClVCjphmszA5SitYWEc+oIPzRlgySVbF8BJYqDUhXmbK8/vDJlY+3B0vXdycGC0HcdtLMxGrrUjsC2TPE3O5c22CoFjjGLv1GUe6a7x4/Y8Xog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St/rbz1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C143C4CEC8;
	Mon,  9 Sep 2024 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725908985;
	bh=TJeb+yY4BdHG3QeXUNQK4acpsl4QjdOwr+xpbgmQfc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=St/rbz1dRVQee8fIhU4CLN01vxCEjoiIVbIiKmU9+wA6YF7XPugn1cLbFBrX1J0kv
	 bOjyuoCPiAQWGohF0rG3tvz0JQh1rlHLbagpPXy+ZqUhfVVBMv5n4411Su5ojUA+f2
	 JJhtC697LxvJj1Jw6kSczAowrlXG8IU68WkIALz8n49GeHiiFa9eKPdZHyic6zH5A8
	 oxMWgDVaLqsGRCndUxJ84B3y/OSVbrR65LijBpYqG2L854zQjZbyrYqE8HyVRpCsla
	 57n87Vu879PpOi2I5qDP0aLNHR62nJg3b+1QzcSWZovZUsUmK71Erf2iuq6Yq3X+Rb
	 KQLFu+nt8fiKQ==
Date: Mon, 9 Sep 2024 20:09:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240909200936.68c23866@jic23-huawei>
In-Reply-To: <b1584871-9a9d-4042-98c3-00581bdb5499@baylibre.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
	<20240904023040.23352-3-Mariel.Tinaco@analog.com>
	<e9cbcd85-062c-47ad-861c-229cb2fd6c2c@baylibre.com>
	<PH0PR03MB6218D70A20E93C46C186441E91992@PH0PR03MB6218.namprd03.prod.outlook.com>
	<b1584871-9a9d-4042-98c3-00581bdb5499@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 09:51:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/9/24 4:47 AM, Tinaco, Mariel wrote:
> > 
> >   
> 
> ...
> 
> >>> +	*val = get_unaligned_le16(state->spi_tx_buf);  
> >>
> >> With spi_tx_buf changed to __le16, this can use le16_to_cpu() instead of
> >> get_unaligned_le16().
> >>  
> > 
> > I suppose we use the cpu_to_le16 for the set_hvdac_word function?
> > 
> > static int ad8460_set_hvdac_word(struct ad8460_state *state, int index, int val)
> > {
> > 	state->spi_tx_buf = cpu_to_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val));
> > 
> > 	return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD(index),
> > 				 &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
> > }
> >   
> 
> Yes, that looks correct.
> 
> 
> >>> +static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t  
> >> private,  
> >>> +				      const struct iio_chan_spec *chan,
> >>> +				      const char *buf, size_t len) {
> >>> +	struct ad8460_state *state = iio_priv(indio_dev);
> >>> +	bool toggle_en;
> >>> +	int ret;
> >>> +
> >>> +	ret = kstrtobool(buf, &toggle_en);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> >>> +		return ad8460_enable_apg_mode(state, toggle_en);
> >>> +	unreachable();
> >>> +}  
> >>
> >> Hmm... do we need to make an unscoped version of
> >> iio_device_claim_direct_scoped()?
> >>  
> > 
> > So iio_device_claim_direct_scoped is used here because the buffer enable/disable
> > accesses this enable_apg_mode function. Is it also a standard practice to put the
> > kstrobool() util inside the scope?
> >   
> 
> Since this is at the end of a function with nothing after it, it
> would be nice if we could avoid the indent and unreachable();
> 
> The idea would be to write the last 3 lines like this instead:
> 
> 	guard_cond(iio_device_claim_direct, return -EBUSY, indio_dev);
> 
> But I didn't see a `guard_cond()` analog of `guard()` in
> linux/cleanup.h. So this is probably fine for now and adding
> `guard_cond()` (if it is actually a good idea in the first
> place) can be a job for another time.

That's a fun topic if you check the archives. Linus really
didn't like the proposal
https://lore.kernel.org/all/170905253339.2268463.9376907713092612237.stgit@dwillia2-xfh.jf.intel.com/

Mind you I don't think he much likes scoped_cond_guard() either!


Jonathan



