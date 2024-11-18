Return-Path: <linux-iio+bounces-12376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7730F9D0FD6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD87EB23719
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D76E198E99;
	Mon, 18 Nov 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXeaD6aC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8861194A68;
	Mon, 18 Nov 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929831; cv=none; b=phZ/sOrJL13KBuIKJKHtpMjTpLc4Bxwt2xGOcBc4yOk0Ncjc+7EKUEgcxK/AIJWLZP7bkUnNAmUJl99XypNgZJ6jzirh5LR4hu+INExFROpivx3LJv74/By0Ir/RcHzBCKo5vUVpliZTOrrYPtOhfJXJ6CU4TT0ez6rrKhxItLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929831; c=relaxed/simple;
	bh=31f63cT9cGr3gLKOMXPNf8G8Rq9837/wowS823QzWgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5/DNE9IKSqWw94YqLoxYGRuYPSdpY2eo0dr4Ee7UKanXBl0SG5wIMh0fBPln0J/rdGlAzSe/0equs/ui5Zo0g0bs6jGvKP6hcocat+fGMUuri61bVncg1xsTbBeHVn16wwsiXlScSOw02Pj4Br6NXoKjn2IEqeqwdx1k0npKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXeaD6aC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72483f6e2f3so1379727b3a.1;
        Mon, 18 Nov 2024 03:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731929829; x=1732534629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzasLoJr8T9pHfFmEYMw00zyjyFfURXh+CYiFyGOzCM=;
        b=hXeaD6aC+cbkNx5EmXP7/Z/cO7XSdqFMCa52lrqNUPsyfe8XcHwNmppBKyFHZN9Qls
         YjY40MytnHjsYNmLiJD7PCo3LHJH6HqZoGndEzilnmp8mcDhCMitvlXjtAwW0SrgRNfX
         3mOdVdPK4UDqM4cKowUnfZkyq4nyLaQl56++aFPx1ycl25bEf6UM2FCIDAjAg3DQB1nD
         ZJJiNBsCuA7lVbWSEt3snp5S1vL9L/1/eGj2zOBs48SY1m+tLvFVk/F2yyTNu5D054q1
         u+KkM/dEAZaIDkbWzkSTK2ZKlfWIPciS/DtydhkA3IHSCmCas/QFR5AYYJv41oJ+t1Aq
         +gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929829; x=1732534629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzasLoJr8T9pHfFmEYMw00zyjyFfURXh+CYiFyGOzCM=;
        b=RIq6hTwwizohVerhv3AgnmQw22Pz961+6/aLb1zNbTTYgVXss9wjgE/gPfpr0oS98W
         OqewKGqlLt32uj/elIJKCUfXkKBMmhvRWczGaueS5mcsJ7tP6UXE8W65BkXUxVgZAdbN
         gk+BBaWQk5Z09kq8+bASNvvfY1z3H1HoTRuQSbIyodG6c/Ds4/nVX4fOLmZFwIDDPx5n
         NheKq5NYTKR3zubRv0h6vnBaP66VnwdesWlWQz21hwUAW2VKAsjZbTlpUP9qnDIgX9vv
         r1BbI68kZ/ij/GzEGjmLClrEfw8X0R7uKuTi/PexZHf2WXFCnO1Wj4Ij81Bily33PTd5
         nuAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQg/dkhtGvfGGGjpQ3AgpTXgkHMv4u9j2eEd5xTBm2jMmJ00rjzjvpE+X1MwQyZ1CvnobVyLNpwcnq@vger.kernel.org, AJvYcCURGRybPjVPryTcaFprQ1KmSSUYHi21xdwdJgTEfwqFP3L40wvjFC1kpPTQdkm5sfFbnc17ePSDSjq9e31b@vger.kernel.org, AJvYcCWb/p2GYBlMB2Pmbq0hRDCn0sX2pThS1krgk4wPtilTjmIwUCfsv8mvEe/pFeRm3tnYOrE4kAa/uCj1@vger.kernel.org
X-Gm-Message-State: AOJu0YwNH5zRwWm578KXR/vJQAnKNMlP2ONCUHSABE+ZasQLo0xJ+JNP
	Z60DBTA7ICClfql6TLvB7Wo8YGgskeIS7B9OsMIz8bnJvD1wnJpn
X-Google-Smtp-Source: AGHT+IGM84PYTgxIk9mLFAtLdt1riKMxe4764ItcsKBTDYN/u31EiHZ7+puhc98etps3Gfdinbn34Q==
X-Received: by 2002:a05:6a00:a0c:b0:71e:5709:2330 with SMTP id d2e1a72fcca58-7246674f4bdmr26728480b3a.7.1731929828855;
        Mon, 18 Nov 2024 03:37:08 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711e005sm5982735b3a.72.2024.11.18.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:37:08 -0800 (PST)
Date: Mon, 18 Nov 2024 08:37:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ad4000: Add support for PulSAR devices
Message-ID: <Zzsm-vwm-gFbiI7w@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <a2a1bb929a83f5906a9c1fd9ba76889a3682cf95.1731626099.git.marcelo.schmitt@analog.com>
 <a1852540-eeb4-4d92-a381-185014c828ac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1852540-eeb4-4d92-a381-185014c828ac@baylibre.com>

On 11/15, David Lechner wrote:
> On 11/14/24 5:51 PM, Marcelo Schmitt wrote:
> > The AD4000 series and the single-channel PulSAR series of devices have
> > similar SPI transfer specifications and wiring configurations.
> > Single-channel PulSAR devices are slower than AD4000, and don't have a
> > configuration register. That taken into account, single-channel PulSARs can
> > be supported by the ad4000 driver without any increase in code complexity.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  drivers/iio/adc/ad4000.c | 163 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 163 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> > index 68ac77494263..8e31b42534f5 100644
> > --- a/drivers/iio/adc/ad4000.c
> > +++ b/drivers/iio/adc/ad4000.c
> > @@ -137,6 +137,41 @@ static const struct ad4000_time_spec ad4020_t_spec = {
> >  	.t_quiet2_ns = 60,
> >  };
> >  
> > +/* AD7983, AD7984 */
> > +static const struct ad4000_time_spec ad7983_t_spec = {
> > +	.t_conv_ns = 500,
> 
> I'm sure there are diffing opinions on this but I would prefer
> an explicit .t_quiet2_ns = 0, so we know that it wasn't omitted
> on accident. Or a group comment to say that these chips don't need
> any quite time.
Ack, will set it with a macro.

> 
> In any case...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 

