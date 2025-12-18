Return-Path: <linux-iio+bounces-27184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42681CCC723
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D40C30C5DD2
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C7B34CFD9;
	Thu, 18 Dec 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0lWPtZY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EF34D4C4
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070999; cv=none; b=GxMwzK1o/XLDCdtFZaJbgki8RFIw6WfCFtM4g3k0ggBZezQ5OOeUpmO4BYCoQX5drSmEVpM8CxrWi7gKxKO3R4uobn+yi+v1zW9E8jRzR8z/ranRREG3FPsniaIvtT1jNJPE0qipvLeMU6yU/LQ/h1co2k4biDRow9BgZ39Mhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070999; c=relaxed/simple;
	bh=ffSKSXXWSRpI3xx9H/itO7rvifidsrztH8orFHjfVHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3DGMrlCmTgQE4ONavv8+Aorhksyz0CiPwRLmmUEnyOd01LRLOKzoqeD10PRIriTs1Bs+AuNVc023jHdXSgISBzpkfHyL7Zwou+ObUzn9DshZAbDbMoYNKWSYqEQpQuMBaMYTUp8YTyc79x/rbzir6RqQ4LHGZJrdlgom3CX7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0lWPtZY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0833b5aeeso9990795ad.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 07:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766070995; x=1766675795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4YgC8/woMPQ+Xj9m7PS+PcfWejcCQtxAUQpAaE4ZbE=;
        b=h0lWPtZYVADkGTZc8MIJ6KbOuFbtWr/CEXOluJHEz2yZ1bAjk9sGW779lPFLgXI1ng
         w6g53qq5sVXBeMTAe9FeTcWlLkX4usFrwpYYQVZJHb/OvY4wc0BMaXtKd+lA16mcX/sT
         y+9bs6Qv0uyw0Zkw6/0xrNTBG3NQbndXsBmbDQWVHIxtF/QRrcGix0EQBrGysq3s0EDG
         LRE9j3HkILsaev3RfwXtZf1bWR3yk3PPfML3rKhHwmwiFIIvLq64mFrlxjzXlX74eJFK
         1PQfelxdp0P0h+G0nTn7+lYIQHlQIKG4RK/K8pA6uEiyWSBHfOFEWkA0CUUlOMmNe5uw
         mMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070995; x=1766675795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4YgC8/woMPQ+Xj9m7PS+PcfWejcCQtxAUQpAaE4ZbE=;
        b=mmOZG8P4oPHo8cRNHMXg+jyRTwTbpmpbE2Xizei4UjhrZRTuwzJ3chnkIyRgu7HIHr
         7FdgV8/P/b/3kPCNlCe0kOjqI0R7bHYcHY+bxikm5+ovDwnP4XCWPgMEi5Z4hL7MyV9u
         P3R+R3aQNctSjczc2zoy70h44Gm5e7EaNp7as29sO01y/HjaoscKK8UokUAmQ8Vb5X8t
         L+UcufglkLD9rbEmXE3gJlkweHkJ5BOtbD5IHPWYEFAgPzX1jW9O4Ru7m8zBsxAuq2xg
         QLG834cJ7foBgKCWadKYBnFV69+Gp9QpEkX3rIZueEO305qxN7L8bEMouHETzy4lqM++
         8tUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgXmbY31nxWC5uxmcv8FQr/XJybeQMZYll+l8U1LUwJjeMGiN9BFNYisUPy/Z0Mce1DONFOFaVWig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSnBcsu3vaoQe0UgN9DAWCszRU4DBxqOvllbKNWwqlnh3M+ia
	bhOGwlWbAIFNMdwT8bjMC5OaN8OrkQCusGdyxTOnmsOHITFT7wZZXNNV
X-Gm-Gg: AY/fxX5G4BZfyM0c0VLj2Y0TMx+QeO/6ge2rYdJDczSfncbBZ8usE3H5TX9x01XsQLo
	RQ3Se1Kgb/238bllPRRqTAnV2b4W6SMDTw6QArciFb2xZmzaGV3C1gfpUZJL+1hTY8Xvm4wH+uj
	QELoJDqO6u3xu/iyJ+H8Gi8kQvYfnnEz8MDei1mEXathSD69VeHGyfJtWnWHZg1fRGY3ZYHd6ij
	jzT7zGMnreuv5rxSXpTUeR0Hb3NwxlURk982dXSoHZo/1HkTqcb16tVOmrJQrOaKKgsDXD62kYP
	4gKLbJ1xf7YpNJaTnbuhMPVH0m6+O69QhMoqqKOnE8+bP8bgsxQPd8dB+oIJRMngcPIZEWt630z
	AForUlxt9mWRCqI1o7OmvjICHLy36tKYo16tgSW106BqjfvdLy1IOPZIlITsSGXxdzgXbvIyQki
	sq/yVyC+QDTFJzKN1UbMxjCUi50fN2ysgiLMdezNS9elgzChD3N/7XdHSvvV6IGxTp+MDDTxIqP
	QKd9HS4dQiAsqJvZTkhXLHVdeQHpMrRPGxrrVHzAyDTyDSFCexSzR8M+PEDJZ9LtqI4
X-Google-Smtp-Source: AGHT+IEFIRglE5Bb+2e+0uum5FO1qaZ3iQ7LMvzkffpqPwvsjCl32isCjpg6y5tRTxoVDhkYEOmzfg==
X-Received: by 2002:a05:7022:1b0c:b0:11b:ceee:a49f with SMTP id a92af1059eb24-11f349a17bdmr15451076c88.8.1766070994721;
        Thu, 18 Dec 2025 07:16:34 -0800 (PST)
Received: from localhost ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061f5412esm9195941c88.6.2025.12.18.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:16:34 -0800 (PST)
Date: Thu, 18 Dec 2025 12:16:32 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/5] staging: iio: ad9832: convert to guard(mutex)
Message-ID: <aUQa0IBuE7EITq9G@Lewboski.localdomain>
References: <20251215190806.11003-1-tomasborquez13@gmail.com>
 <20251215190806.11003-3-tomasborquez13@gmail.com>
 <aUQQ3YnaZau2RO2d@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUQQ3YnaZau2RO2d@debian-BULLSEYE-live-builder-AMD64>

On Thu, Dec 18, 2025 at 11:34:05AM -0300, Marcelo Schmitt wrote:
> On 12/15, Tomas Borquez wrote:
...
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);
> >  	switch ((u32)this_attr->address) {
> >  	case AD9832_FREQ0HM:
> >  	case AD9832_FREQ1HM:
> > @@ -203,22 +205,18 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> >  		ret = spi_sync(st->spi, &st->msg);
> >  		break;
> >  	case AD9832_FREQ_SYM:
> > -		if (val == 1 || val == 0) {
> > -			st->ctrl_fp &= ~AD9832_FREQ;
> > -			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
> > -		} else {
> > -			ret = -EINVAL;
> > -			break;
> > -		}
> > +		if (val != 1 && val != 0)
> > +			return -EINVAL;
> > +
> > +		st->ctrl_fp &= ~AD9832_FREQ;
> > +		st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
> >  		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
> >  						  st->ctrl_fp);
> >  		ret = spi_sync(st->spi, &st->msg);
> >  		break;
> Since we now have the mutex unlock handled by guard, why not returning directly
> from each case?
> E.g.
> 	case AD9832_FREQ1HM:
> -		ret = ad9832_write_frequency(st, this_attr->address, val);
> -		break;
> +		return ad9832_write_frequency(st, this_attr->address, val);
> I think the last return (outside the default clause) won't be needed anymore.
Wouldn't work because we need to return len too, so it would be more like:

 case AD9832_FREQ1HM:
		 ret = ad9832_write_frequency(st, this_attr->address, val);
+    return ret ?: len;

Which is a bit more repetitive than just returning at the end ret ?: len,
but lemme know what you think.

>
> And, since you are touching the lock, you may also update to use
> devm_mutex_init() (that would probably be best appreciated as a separate patch).

Yup, sounds good :)

Tomas

