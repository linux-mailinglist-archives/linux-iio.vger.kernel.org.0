Return-Path: <linux-iio+bounces-17478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7079EA768B7
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8407A2577
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57A21423E;
	Mon, 31 Mar 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2D51RVf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE321B9D1
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431983; cv=none; b=GzUko77ZdHzywILGCSbpXXNQ4iQTKsCWKu/tUX5xioURGq+84bYRkzPBrYmAqCLQFBCV8vo7m/OhAjb1fZdtBxqJdoYhZhwhwQ866HxMwYQXvhDDyFNfqIFaHRJkD8z0e8ywkBIkOaVhSCWI8lfbXjWhD1eR6R8eLQs7TVIiGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431983; c=relaxed/simple;
	bh=F4IoPBPIxKuR2kCihi2djBiuyz8tm2BN9Vmb6can2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqKbFg5H/5AYQzEiGAR5nw3VOofo9uRS9ycuencQShJQUbWFJNQTHeVh5HeFzxajpjwzIn1JWeeVlma+FkVd6b9ToV5mbwcpK1PcbHqBite9qkhXFSn8V8HzxU4AJ2wsef5DQcsvewEJqyR4YXfrjFIEOHLB04vQ5Vga6Y0NHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2D51RVf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fb0f619dso85820435ad.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743431981; x=1744036781; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5J/qQKPDXGIQ/WUglBCRXAyOFbtYR41Crnbh8wUuqw=;
        b=M2D51RVf7VuZtCGpKHWljd0Gs5r9BRRAVsERhwQM8cUNKtyz0VFVBR7hIX25gIjPGT
         vcHChDGxs1cLI/rIqfy+iiWiWqcbvawbLaARqTwMGvbpkJklLHHjC3yYiVVoSK5CMOCu
         Bg3X78lBLbyKE+mdaMb5/DeDcqveq+33uRZdNKAOsT3+a+C+wyHFhbLcI7o9toLTJJkH
         yDduceQPMYLXa6vJU2XTps7QQM1tPE/qfuKefpyVqCttZQjTjbt7X1p5NqWrc+KqWNR6
         532jGbiBL1pYG2RwavyaSHtggZq4Qexfq5n0p/XCrIi/pxR5r64bETmna0RZb3bSBaAA
         GSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431981; x=1744036781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5J/qQKPDXGIQ/WUglBCRXAyOFbtYR41Crnbh8wUuqw=;
        b=U7Kpss/bDn6NEm4SNfapF3nI7MDkr/LNmlfahkjJg8wV3HJVG3VBJ3Xzseasi/sa3s
         KsUq8cfGc0+pQxmHjF7UcLLub//WyuCZqHvyEJLZe6XpqmUMRhA7mZNLibfvjHnVaky5
         IXQASTyOhgsJbNz/3L9GHRoI2R1xOe5B4JCLHdA0TTiJH5mKc2DBmkSwPbWATXNUAo9U
         vubMtdf/v88QltRD4qMDIHfXcUlBPbZCtm6YgevcXpHy2S5m7C9J105E59dyBs+T4D1H
         zF3aZAMupw1s3HJVhf0oUPv3lejYcNKYjGuOK0O32IhnA4pHJtPxp4PdwyH21nUsCA3V
         /KLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCZF487Q7dCmrojfVG9voWMFNMXxkn70rbnosRpAS4B87v29Y9kj/dUvPqCJ4K8mmq+w2xh2BBIGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaT5kZxG9pigTSYJveOSn+HDD9405lKI3xpl6jSKskt5iWuh+
	aX4J5vosgmDzNTv4HCUzGVO+1suQjelUcBhj64qr3bC8qIC2si6y
X-Gm-Gg: ASbGncsHo4bpDopUYcRHAzg3i+bAeZpSqAFU/NeHavEAhmWXKDCN01SNxpiUObpmGKN
	35Xiyg2hYS8Z/IVGtodvFgbrvv/5xtDBTuJt9eODtd1Y2ro7ZMSYfSIb9eSQhWMMVq6IMZyRBT0
	hcHMBSSRPYlCTwsOhBuXIcVuWNDgWJACHuufE3xUPmrOJNFX5DZUyx0QXh7yUYgTVL7BGoeUxsA
	mcwxVxQm7oSnriaYdEhHmSFDDhlsoFhYlBCHBbd8aRe99CfXIfEnUg4ouNqASir39vIsgwmXyUn
	vNlALdETpELHE/hKHFX57Wx5VN1F1fKM5+tGDl5Bq1xqAF2SFQ20rW0=
X-Google-Smtp-Source: AGHT+IHCMWDzdFTdh6ca4DXz/W3LjGWBLlc8gKE9NjGyjjtuLYtdtH3Mg/ni3QrxA/aQHRW9VggqwA==
X-Received: by 2002:a17:902:e550:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2292f9e652dmr146180605ad.32.1743431981521;
        Mon, 31 Mar 2025 07:39:41 -0700 (PDT)
Received: from localhost ([2804:30c:1f4f:6800:9245:316f:6226:cc1e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d3ea84sm7317979a91.8.2025.03.31.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:39:40 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:40:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ad7124: Fix 3dB filter frequency reading
Message-ID: <Z-qpbInHvb3PjMiu@debian-BULLSEYE-live-builder-AMD64>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
 <20250317115247.3735016-6-u.kleine-koenig@baylibre.com>
 <Z-RFaLU5jtOScJiu@debian-BULLSEYE-live-builder-AMD64>
 <p23r6fxfbbgszqaew42dby5yjwio4xipdh3y47rr3wbso6fwcb@ej7ut3sruzoa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p23r6fxfbbgszqaew42dby5yjwio4xipdh3y47rr3wbso6fwcb@ej7ut3sruzoa>

On 03/31, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 26, 2025 at 03:20:24PM -0300, Marcelo Schmitt wrote:
> > Hello,
> > 
> > On 03/17, Uwe Kleine-König wrote:
> > > The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
> > > and for sinc3 the factor is 0.272 according to the data sheets for
> > > ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).
> > 
> > Potentially dumb question but, how do we get to these factors between ODR and
> > 3dB frequency?
> > Looking at Table 8, Table 18, Table 28, and 
> > dividing values from Output Data Rate (SPS) column by respective
> > values from f3dB (Hz) column gives me 4.3478.
> 
> Using the datasheet for AD7124-4 Rev. E in Table 8 we have for example:
> 
> 	ODR = 19200 SPS
> 	f_{3dB} = 4416 Hz
> 
> So it's either multiplying with 0.23 (as does my patch) or dividing by
> 4.3478260869565215 (as you found).

Got it. Thanks for clarifying that out.

> 
> But having said that, a definitive formula would be nice instead of
> guessing that there is a linear correlation between the columns and
> determining the factor yourself. Note that in Table 10 the f_{3dB} value
> corresponding to ODR = 15 SPS should be 4.08 Hz. The 5.44 Hz specified
> there would be the right value for ODR = 20 SPS which is a value that
> occurs in Tables 8 and 9, but not 10. :-\

I see. Yeah, I feel like datasheets are similar to device drivers in the sense
that they tend to get better over time. datasheets for newer parts often have
more information and better explanations compared to old ones. Anyways,

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks,
Marcelo

