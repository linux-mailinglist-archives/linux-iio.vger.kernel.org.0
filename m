Return-Path: <linux-iio+bounces-16694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EFEA5A44E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF943AEB93
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E51E0DE6;
	Mon, 10 Mar 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIbdkx1r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D91DED68;
	Mon, 10 Mar 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636860; cv=none; b=rNUUQIm8aJSua1CJwvzx1F/24+EfpPevA12Yt6DnR5LKGKv8mXmwlB5C8CjC1pywBMpSUveTrg35cBeb/k5lLE6drVyD5DgEPnHs+BvVW2UmwQXnTpbq7YW2q273qvW0eWnMC4RW5KgUFPNpeLhcmekUAOvFaVPIqZCrrMg9fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636860; c=relaxed/simple;
	bh=PqhJ6nkwaqXg1KtCFXSLvpzSP921WbawLYG/p2fFBgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5ic6Jh1qJOin2i2LRSSe396JmxKwk8PPxdi2/qcmFxvkpJFq7asW8DMhnbO6Ocn9UnIGSE1tNCPaJM16TD1yKLjZeQ+HatJK+PEYcPaC/czj2xhktyb40rmeqQTDhOYYAj/WTTIMmqKvs9iP7mtAvBG5VWX/0V4KwFbTMFoZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIbdkx1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18558C4CEE5;
	Mon, 10 Mar 2025 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636859;
	bh=PqhJ6nkwaqXg1KtCFXSLvpzSP921WbawLYG/p2fFBgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RIbdkx1r7ois3i0X5YbZS3WU4c6/PR1Kuh95eikLY7v7yvsPa3h0dYjB5nWSQ4rJd
	 9HWRY+kzhN+WiG5O7fdDucZjblmLMRmFmqv2hqZx5MmVh5H3qien4FoXQC1Ipji9iH
	 XMjWezslY4klE4Dfw0osCa4L/FjjdbNW0tagHpXdGp6xD3GmvVkPEfIszZO7dgCYr8
	 72wqlJvYzASLqAp2IbDwJ7o1O3bYIHc2SS25fljEgHsL+OViv7zplZd/FAYZBXZtQL
	 EbkaWMewBvZESNHH97FJhcFSqdihWIHAIypPTYmk1i34X6U5tx8CjoU9ayYu/irMqY
	 OxQV1dG/0yE5g==
Date: Mon, 10 Mar 2025 20:00:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: light: al3010: Implement regmap support
Message-ID: <20250310200054.1eea3150@jic23-huawei>
In-Reply-To: <49dfbb2e-5caf-42c0-8917-baf59b6533dd@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
	<20250308-al3010-iio-regmap-v1-3-b672535e8213@ixit.cz>
	<20250309164549.26d4cdfc@jic23-huawei>
	<49dfbb2e-5caf-42c0-8917-baf59b6533dd@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Mar 2025 22:11:57 +0100
David Heidelberg <david@ixit.cz> wrote:

> On 09/03/2025 17:45, Jonathan Cameron wrote:
> > On Sat, 08 Mar 2025 21:01:00 +0100
> > David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:
> >   
> >> From: David Heidelberg <david@ixit.cz>
> >>
> >> Modernize and make driver a bit cleaner.
> >>
> >> Incorporate most of the feedback given on new AL3000A.  
> > Hi David,
> > 
> > Why does regmap bring benefits here?  This seems to be a like for like
> > change (no use of additional helpers / caching etc) so I'm not immediately
> > seeing the advantage.  
> 
> As I mentioned in the summary, the change is smaller binary size and 
> being in sync with al3000a. Since al3xxx series drivers are pretty close 
> to each other, I believe for future maintenance having them in pair, 
> where it's possible is beneficial.

Description should be here (briefly) as this is what ends up in
the git change log.

> > 
> > Various comments inline. Main one is this is doing several not particularly
> > closely related changes that belong in separate patches.  
> 
> I'm aware I should likely address the changes in smaller chunks, but as 
> I get this patch tested, it's fairly small patch, so I would believe 
> it's still bearable size of the change? If not, I'll split changes into 
> separate patches.

Separate patches still preferred even when the overall changeset
is not large.  It allows for crisper description and easy review.

...

> >> @@ -119,21 +118,21 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
> >>   		 * - low byte of output is stored at AL3010_REG_DATA_LOW
> >>   		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
> >>   		 */
> >> -		ret = i2c_smbus_read_word_data(data->client,
> >> -					       AL3010_REG_DATA_LOW);
> >> -		if (ret < 0)
> >> +		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &value);
> >> +		if (ret)
> >>   			return ret;
> >> -		*val = ret;
> >> +
> >> +		*val = value;
> >> +
> >>   		return IIO_VAL_INT;
> >>   	case IIO_CHAN_INFO_SCALE:
> >> -		ret = i2c_smbus_read_byte_data(data->client,
> >> -					       AL3010_REG_CONFIG);
> >> -		if (ret < 0)
> >> +		ret = regmap_read(data->regmap, AL3010_REG_CONFIG, &value);
> >> +		if (ret)
> >>   			return ret;
> >>   
> >> -		ret = FIELD_GET(AL3010_GAIN_MASK, ret);
> >> -		*val = al3010_scales[ret][0];
> >> -		*val2 = al3010_scales[ret][1];
> >> +		value = FIELD_GET(AL3010_GAIN_MASK, value);  
> > I'm never a big fan of conflating use of one variable for the register value
> > (where value is a reasonable name) and the field extract from it where
> > it's not really. scale_idx or something like that would make more sense for
> > this second case.  
> 
> I originally had name gain for this one, but decided to go with generic 
> value to cover all cases. If you want, I can go back to custom name per 
> case.

Please do.

> >   
> >> +		*val = al3010_scales[value][0];
> >> +		*val2 = al3010_scales[value][1];
> >>   
> >>   		return IIO_VAL_INT_PLUS_MICRO;
> >>   	}
> >> @@ -145,7 +144,7 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
> >>   			    int val2, long mask)
> >>   {
> >>   	struct al3010_data *data = iio_priv(indio_dev);
> >> -	int i;
> >> +	unsigned int i;  
> > 
> > Looks like an unrelated change.  Possibly even one that isn't worth making.  
> 
> Well, I was at editing and as i is used within array id, it cannot be 
> signed integer, second it's also compared against u8, so IMHO it make 
> sense here.

I wouldn't bother, but if you do want to, it's an unrelated change
so separate patch.

Jonathan



