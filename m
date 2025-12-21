Return-Path: <linux-iio+bounces-27296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D3CD44A8
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC3043006A58
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50822B8B6;
	Sun, 21 Dec 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTyfCxH7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B0017BA2;
	Sun, 21 Dec 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766344985; cv=none; b=fDPTkbPJvbDYVxgB3jAT3X+jSOvpgYGlmYmEDHKf9u7ze1GkgVHSMHRtiTm5ZbEO/uT/fcAg8fBJ7ksb67NNJSguEOdU9FBtIx594akCW2tsnEzMpoejSCVtEr7l0E0HB40aATu6QZ4dYR1iGCvHnIPrI1Nex83jwNaYHfaAV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766344985; c=relaxed/simple;
	bh=j+PQEKAgMwNLRZptY8s9KPaeeBS5rF2koxUOqlmLmyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+SUebtZtFZID2EtSApeQVn87UDyGtaZzzgC5/MvbRIZsg39ivBk9Sd2Yu+DKcOYCxU7+ZVz8WvgjSv9gZg13y4j5fH5XTlFdhNqxtSDzVLZuWjGBdJrORmoOFKI5AXVPFriUqBcu4un731QrO4EdSIT/YHQFjCvUEWe3Vo7Da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTyfCxH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E8C4CEFB;
	Sun, 21 Dec 2025 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766344983;
	bh=j+PQEKAgMwNLRZptY8s9KPaeeBS5rF2koxUOqlmLmyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nTyfCxH7u+T2XQVOlpvRu031mb1FAJEFZ6SvOA3TFRi/VIPhAV8l5p3Lwnh4BJfNJ
	 mYF1bAWImrF6ppDA5+34ray2iioAiDome8YtB8zwQhqCY0tBwE+y5oMXBn4cYD7TLQ
	 ooUUjXnVFHcFKEHPz4CzU6sjw0WOhWI62/S62IfCKi6v8c63iwMj8XWtHSWovyzl8q
	 J7VMbX8sUQUI0XO6hO04P5JJZvG1A2I7iUJRolKt20I6SnFn7VnMA3HY0Wi9SZxAMw
	 Tjr0jANBLYvwVMe5dEUfgqSppErxkJVv81JaI6OTMFjYZHmbeLrPbWAmw2izuSdPnE
	 ivXaZzM5d/JNw==
Date: Sun, 21 Dec 2025 19:22:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/5] staging: iio: ad9832: convert to guard(mutex)
Message-ID: <20251221192253.5e2b29b4@jic23-huawei>
In-Reply-To: <aUQa0IBuE7EITq9G@Lewboski.localdomain>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
	<20251215190806.11003-3-tomasborquez13@gmail.com>
	<aUQQ3YnaZau2RO2d@debian-BULLSEYE-live-builder-AMD64>
	<aUQa0IBuE7EITq9G@Lewboski.localdomain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 12:16:32 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> On Thu, Dec 18, 2025 at 11:34:05AM -0300, Marcelo Schmitt wrote:
> > On 12/15, Tomas Borquez wrote:  
> ...
> > > -	mutex_lock(&st->lock);
> > > +	guard(mutex)(&st->lock);
> > >  	switch ((u32)this_attr->address) {
> > >  	case AD9832_FREQ0HM:
> > >  	case AD9832_FREQ1HM:
> > > @@ -203,22 +205,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> > >  		ret = spi_sync(st->spi, &st->msg);
> > >  		break;
> > >  	case AD9832_FREQ_SYM:
> > > -		if (val == 1 || val == 0) {
> > > -			st->ctrl_fp &= ~AD9832_FREQ;
> > > -			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
> > > -		} else {
> > > -			ret = -EINVAL;
> > > -			break;
> > > -		}
> > > +		if (val != 1 && val != 0)
> > > +			return -EINVAL;
> > > +
> > > +		st->ctrl_fp &= ~AD9832_FREQ;
> > > +		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
> > >  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
> > >  						  st->ctrl_fp);
> > >  		ret = spi_sync(st->spi, &st->msg);
> > >  		break;  
> > Since we now have the mutex unlock handled by guard, why not returning directly
> > from each case?
> > E.g.
> > 	case AD9832_FREQ1HM:
> > -		ret = ad9832_write_frequency(st, this_attr->address, val);
> > -		break;
> > +		return ad9832_write_frequency(st, this_attr->address, val);
> > I think the last return (outside the default clause) won't be needed anymore.  
> Wouldn't work because we need to return len too, so it would be more like:
> 
>  case AD9832_FREQ1HM:
> 		 ret = ad9832_write_frequency(st, this_attr->address, val);
> +    return ret ?: len;

I'd prefer the error dealt with locally as it's more consistent with the other
paths in the code where we return directly.  The fact this is the last one
in each block doesn't to me mean we should bother to handle it in a special
way.

You could stick to
		if (ret)
			return ret;

		break;
	...
	}

	return len;

If you prefer to keep that shared return of len in the good path. Or just
return it as you suggested in each case: block using the ternary.

Jonathan



> 
> Which is a bit more repetitive than just returning at the end ret ?: len,
> but lemme know what you think.
> 
> >
> > And, since you are touching the lock, you may also update to use
> > devm_mutex_init() (that would probably be best appreciated as a separate patch).  
> 
> Yup, sounds good :)
> 
> Tomas


