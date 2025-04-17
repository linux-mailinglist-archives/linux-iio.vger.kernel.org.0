Return-Path: <linux-iio+bounces-18182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5EA9103C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 02:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA09E7AEAF0
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178397081E;
	Thu, 17 Apr 2025 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enc9rsIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA5322B;
	Thu, 17 Apr 2025 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849385; cv=none; b=MF4MDQWxNBHlwe/2UHsjbijFYeMxF644bmf04RFbubSSKQz+ShxNf7zey846Utcr687sdyFcGJv5ym6CiaTyvE32he7OKRI4D1KrfVtNaT6wIGsctQIhEiDO8Pr5619EvFiix7Cf8GtFoU1uLutLq52r6iheHUvvf5dBqsTH/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849385; c=relaxed/simple;
	bh=P2M08ruexrZHu161VwGKdySd0fawpX9Wi5FalmxYizc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzrF6qMfuxOdumMycmqmvq427DmUsFjExUPYRzZDlnVz0w9dHStiCvQnJN0jDUddqXfyjjCGrMdP3iADEGXXnwHGQOCyXSpfNZ2qZRjEM378MPlRstzsiozDXzVxHeVpp6eOpgiy6O+QFWuzMycWZm/EYxpmswm2GJCBhwStXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enc9rsIM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ff1b051dso477176d6.1;
        Wed, 16 Apr 2025 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744849383; x=1745454183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpTfqX5Cd/jNRBttBS5DQbBPjkK8XAGkNy1DKLn6s0E=;
        b=Enc9rsIM6+EZXe6ekdNaznRd0Vgr6SyHBfMPZCxChWpRm7GQHP9SeJ2ReIf/0zXA2w
         zEute2s3XE8yeqqWpi3/1SYs06V4VAQ37+NmxfBHdYp0EvGKiM9DqC1VlsH3gnFGdd8x
         HmhwE7CHgN94dVO4h63kCqac55XwL7VZDURBDfWpVksbmzi2eHIUp//iZgqsXkSSTPQU
         s6vfyWJg+aD+DJHZ1ke3EmsRgl1gjSgWxjXx9/frerUTb9c/Lg2u70055qKslGCNbQgX
         s5Y1vriv+ZY+OQx64eI/CE1biENX5zApga0EVCvnzz7QdIxZeC/nAvalszWhVa6AUQtE
         4bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849383; x=1745454183;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpTfqX5Cd/jNRBttBS5DQbBPjkK8XAGkNy1DKLn6s0E=;
        b=P65qScCzS6xmpRoO5Bmh9bJIM/N2y88o0HK0LcPB7JZBCB4Sbf3maXPn7bAIwURkkb
         pin3Yuv2ePCjR8AZSvJ6OAoftN4Iqdjo3Vi56D6vglWUDHJYHnCLz4HkcGVpoNJ57p/w
         SQ8NsIq0ZHBNd6GcBTzGHuEEuqer/d41M+qmAOgAikC4IB2C6mlDoa2CmrpF6J4Nt7jG
         dgZJ/Z5jhA7gk7nfTUyRuHvRUlthCcluD8i3lQfqM/31VqulLXzlg/swRE56rbuwSWj6
         8pq7Mw8bbn2a5rjyUKPpEj7GUQWfTNEka9JmC7B7NAXkL71wYofAvldT2PcTTzYTHjDf
         se/g==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ9qhG05sMtxN1sdZQp4OZqs/Ps+GxmIbtbprVs1SXDgg+XKycy3R0JNAFzdj24MHxJkZYRN12mVrZolu@vger.kernel.org, AJvYcCULjKFPrjzGKB9fO/Sui4Egqj8rrrMDFOoiJCbjx5tDASz3p3AJpizqOvM1F4PrJW0O6U5IGLFMUisK@vger.kernel.org, AJvYcCVq6x4bAqQMU0KCOtf73lmpc+UnPi1vRZDlugSv4eOcnNhkdlKQFAWcZfHlqjqnEyT5H4UtQ8Mc+tUIiA==@vger.kernel.org, AJvYcCXzHUUbdmuWDonoN/kTZcpWVFhSxnJQBNsIqozkw2meBaZBNwP/j3WeqqphTvSLy9LyMPj4L12RjxVb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59TJtzR3x9DXa+yRr14vh9RNvMfZcav+aYDlqbnQUjkGmjFXy
	Fktgzi9ifFowvihQbjYpQye+pe4qJWKeBILVxHAiEXr2dqjvGhew
X-Gm-Gg: ASbGncvUZw7a/Bwtdeq9np60okRjGMXDvb1POI8l6wr5oODbFBE4mFayXW3M53mlD/G
	Ol5svCembmkoXbM37XVISEzmm9HYxF3bF8D+vvYAeYs50eIOjPCsSDpF1B2x4ElyG32fq9TSEZh
	T+N6k4AShLN1LJrpGKxrOaiNy5979fmHEqrcmjT4uIOOxjtKp523LS8NX6tC7aCA1Tv32otRpJy
	LBFW8IzNnHA/+ARJSfkL9UE86WJbNkEdbHk8dFlQ/mVEWk9syWBlq/hEtcb5+4J6HAAHB5DKEIN
	G/ElcxYGU0xd1F50Cxf4tDAOk47/M4DMj1AbshNQnpaOtXmjF6EO8CMQJVfrOQ==
X-Google-Smtp-Source: AGHT+IFn2Lu3tiHACq6PjR3vsJPcKKTC+q34qH5F0gMiIblkAdM2ULMkUSEiDVKnxyDyW3dtPaHfLw==
X-Received: by 2002:a05:620a:3184:b0:7c0:a1ca:93cb with SMTP id af79cd13be357-7c91da0bb8dmr88801785a.1.1744849383117;
        Wed, 16 Apr 2025 17:23:03 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a89f99e9sm1114754585a.81.2025.04.16.17.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:23:02 -0700 (PDT)
Date: Wed, 16 Apr 2025 21:22:57 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org
Subject: Re: [PATCH v5 02/14] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <aABJ4UuFWDsJX6vT@JSANTO12-L01.ad.analog.com>
Reply-To: 3027a9b0-cf4a-4e55-80a7-7f0dd2a008e4@baylibre.com
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <35481552e9ce39a24a0257ab001c0bcfea1a23be.1744325346.git.Jonathan.Santos@analog.com>
 <3027a9b0-cf4a-4e55-80a7-7f0dd2a008e4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3027a9b0-cf4a-4e55-80a7-7f0dd2a008e4@baylibre.com>

On 04/11, David Lechner wrote:
> On 4/11/25 10:56 AM, Jonathan Santos wrote:
> > In addition to GPIO synchronization, The AD7768-1 also supports
> > synchronization over SPI, which use is recommended when the GPIO
> > cannot provide a pulse synchronous with the base MCLK signal. It
> > consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> > a command via SPI to trigger the synchronization.
> > 
> > Introduce the 'trigger-sources' property to support SPI-based
> > synchronization, along with additional optional entries for the SPI
> > offload trigger and the START signal via GPIO3.
> > 
> > While at it, add description to the interrupts property.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> 
> ...
> 
> > @@ -57,6 +80,15 @@ properties:
> >    "#io-channel-cells":
> >      const: 1
> >  
> > +  "#trigger-source-cells":
> > +    description: |
> > +      Indicates the trigger source type for each entry:
> > +      0 = Synchronization GPIO-based trigger
> > +      1 = Synchronization device trigger (e.g., another ad7768-1)
> > +      2 = GPIO3 pin acting as START signal
> > +      3 = DRDY pin acting as SPI offload trigger
> > +    const: 1
> > +
> 
> 0 and 1 don't sound like trigger outputs that this ADC is providing, so don't
> seem appropriate here. But the SYNC_OUT pin is missing from this list.
> 
> Also, outputs could be used to trigger anything, not just SPI offload, so don't
> need to mention that.

You mean like this:

...
  "#trigger-source-cells":
    description: |
      Cell indicates the trigger output signal: 0 = SYNC_OUT, 1 = GPIO3,
      2 = DRDY.

    const: 1
...

It would be like interfacing those output pins for a generic trigger
usage?

> 

