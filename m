Return-Path: <linux-iio+bounces-14148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CAA0A6A9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 00:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B379A1689F7
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 23:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57061BC9EE;
	Sat, 11 Jan 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbSanFuH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AB199924;
	Sat, 11 Jan 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736637764; cv=none; b=KLJvY+n/Ht++dIF6g8Yu5cZfK09QW6x65VRF6UMbIvZYfoi2U0xOwL0AWqysem1iZkg6pjUItc2ipMEbBAC9u2fnCNAhMexNusACvo9VM9KHC0SlnS+nmy8qsZsVIMgBXKvCtx2+q8/5QOVO20smCXuqQ49cRDaAmqzEO7kdH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736637764; c=relaxed/simple;
	bh=kgTx0iPuTYR3nDwT/CHQ41bHPGBEFQn1moXbgDdo8FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgCia8/UIRf2q9ISjFEl+dfl7Plyo5b19k4qGcgTrCk5JQNadMXenEqbIj9VvxvDb/ev2dNU/p/Jxs5O/91D3odAWe5RdNOGfm41AiuMk7kvhDTiEcFagF2SYTxgTJLio2EbihFR+SYWQYZI3246dWnnwFbseNd+8QQxNdoYHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbSanFuH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f2e32b44dfso257045eaf.2;
        Sat, 11 Jan 2025 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736637762; x=1737242562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33Dv9n42OXA67oxG0b3KHx/ASsgttylLmsdpaayyPls=;
        b=NbSanFuHiNKw9fXlqC3sQVzKYf0/3K1lnaAbXsAkhL2rvtjUbVbcxRpo01InNGP5Sh
         7qtSZYkGloyoOQiKN83/n8mM3vc5RrLcf28CUKggk/Nd6+tezDhiO5RUNc1xszhnyDcJ
         pm9jsI3fdgnRGsnKh6UwQPBdASPzw6ozuQaeE5fSj/E90EiS/g+78XsbJOd7YFCPDcT5
         EwLeQuNyM0e83kgdgDr+qEvDZKvwYC7mYjBF8vRipCgTLtNdvNdktuKbQADSAMPNsar/
         wrcs25V+X8bVoW1PyRtbJfeKU4X6zHglK9JvS1fD1gSQ2qa/oPCrgQM7XTwQiMB3kcVd
         Dp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736637762; x=1737242562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33Dv9n42OXA67oxG0b3KHx/ASsgttylLmsdpaayyPls=;
        b=AjeLhWyxO8AVWIE3sSHofOCBPR9Va88tKTLBnFSwKPYCMIAGFkKP288McWgWfSKH2s
         5hcYOTHf1O89eeKvNCsV2d/vYpyaikcwcVkwXe9PJesUeG+E8XRajV8TbIErdcI+0naq
         sAqPYeclcnqP4wUrAUZv78cYvK3qCGMhVuak9RSUjp+ybFJoLNo8ygKiKwf1MBWTScMs
         J22KG4fJkgYIztJ32re+ZcAK9IeT3Ujyx0G5nUAw2FBVlx+1qgt0TREMVuug+ozVH/Y+
         pKX6P5WoO5KlxzU5peA4ozdcD9y4xK+p0jCwv5svhvHUPhAF3+Zfxw6pjq20viMM+29S
         RRBA==
X-Forwarded-Encrypted: i=1; AJvYcCU62Qsz2JTlbl3MD/nPStFmQ13zpigC/tQf0ELjjdzJ7sEeQUM1xdH1M5MGLZiuT99dxhztbbh7E23h@vger.kernel.org, AJvYcCW3DfLXHcVeq3PjhknGGAoBb/AuzpEiMaJf5OmYGgALTq5+up33KWRNqm+RT1Ly3OAYAoL+7RmjpyaN@vger.kernel.org, AJvYcCWdSTiOi58mrqIyalrfykSYospUvzJsYkibMaYIcwWHOrI7+d63F9LJrvigTBRmg6oWNkvQROvnh7pRAVoO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AZmodro0U0k7jKnYfsD3D8Z1cQ0cwnuTuj5aC2ygWFxPn0v5
	Z6UTRpgdQjrGO8t2XSonSPuI6LoJFmuBGEpAcwszFdllqY++Ohfw
X-Gm-Gg: ASbGncuxl8ibm7xI2O80FC2OrZH2GKvtwSDpy2fsvR2f6R0lL/grfp68P415dF6Zdok
	l8V29JpS8+2YfP+IUt77w/wMIk8Glc6wcNcKg9mJKQDHswOsgbcUYuelTE8vbY9iqloVmafJXsb
	eaunUnwfWt4dsXjUbrerfT9vuPExg+yDF4hqJGhowQKTRzfJAw/ktZvN80eXWqRF3fA2n2KQasD
	1NJ9AHlYMmLRaynv3ct25WHvICMJtXHw8JGiwuM3W7NZSujcZlVVEh+zRGRdGOkqKlerGRyX2Hp
	FQ==
X-Google-Smtp-Source: AGHT+IEWzbM18iz+WUFAvgzwU9Y5Xjpzidv1HXQ8icujb5px+DQQ8Fq/vi6rKDmeRpphLT+zlNsnbA==
X-Received: by 2002:a05:6830:660f:b0:71d:4eef:8f03 with SMTP id 46e09a7af769-721e2cd8c1cmr3515485a34.0.1736637762125;
        Sat, 11 Jan 2025 15:22:42 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855290esm2115147a34.29.2025.01.11.15.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 15:22:40 -0800 (PST)
Date: Sat, 11 Jan 2025 20:22:36 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 03/15] Documentation: ABI: testing: ad7768-1: Add
 device specific ABI documentation.
Message-ID: <Z4L9PKKNfonI/4E2@JSANTO12-L01.ad.analog.com>
Reply-To: 58ea1899-05be-4743-911b-77a56f08c347@baylibre.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
 <58ea1899-05be-4743-911b-77a56f08c347@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58ea1899-05be-4743-911b-77a56f08c347@baylibre.com>

On 01/07, David Lechner wrote:
> On 1/7/25 9:24 AM, Jonathan Santos wrote:
> > Add ABI documentation specific to the ad7768-1 device, detailing
> > the decimation_rate attribute for better clarity and usability.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1          | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > new file mode 100644
> > index 000000000000..065247f07cfb
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > @@ -0,0 +1,13 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate_available
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Reading returns a range of possible decimation rate values.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Sets up the decimation rate for the digital filter. This can
> > +		directly impact in the final sampling frequency. Reading returns
> > +		the decimation rate. Writing sets the decimation rate.
> 
> If this only affects the filter, I would suggest to add `filter_` to the
> beginning of the attribute names.
> 
> Also, an explanation of how to interpret the numbers would be helpful. It looks
> like a unitless number that acts a sort of a multiplier or divider, but that
> part isn't so clear to me. 
> 
> Or...
> 
> Since the decimation rate affects the -3dB point of the filters we could use
> the standard IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY instead of introducing
> a new attribute.

Well, here the -3dB cutoff depends on the ODR, which is determined by both the MCLK
divider and decimation rate.

Wideband: -3dB at 0.433 × ODR
Sinc5: -3dB at 0.204 × ODR
Sinc3: -3dB at 0.2617 × ODR

If we use _filter_low_pass_3db_frequency to control the decimation and _sampling_frequency
to control the MCLK divider, wouldn’t it be confusing for one to always affect the other?
A different ODR would result in a different cutoff, and vice versa.

Would something like <type>[_name]_oversampling_ratio make more sense? Let me know what you think


