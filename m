Return-Path: <linux-iio+bounces-19461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B89AB38AD
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A673B9CCB
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF032951BA;
	Mon, 12 May 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU0EdvTL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7225B666;
	Mon, 12 May 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056155; cv=none; b=AxMFy2kd17slWhfXR4E+YHqNYQTK/U2PY8QPILKGPwrWtE8qtb59YJMQARUvgtD/1tltYeDPz+rr8EgJCSzVOLqcmm4BdqOhSU4tnjdH4gUZMjIY72aF6FrdCZUYtqLJqDbnrfz41n2qjFqWPtPtGE4ce5Q7pifavFkFFW6OD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056155; c=relaxed/simple;
	bh=xEOqVBiS2myNs/lxNmVT+SBDww7wM+cJRrdyFiG0+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th85YwGAKhRoGzj7RkpSjQUpvIo7V5Z6jwtXhpjZbFBL5D8fXiFjQarljzFBU3UG2PEz6pqudoEUVPq+lVg/Yuk2DZdWo+XZQFRAK/s7XdWaHJq9qx5CBWjssoADCl53JWSDEQLUeFuef/IP4NEi2WMpyo8nAlxcupSjs7XLzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU0EdvTL; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-524168b16d3so3435890e0c.0;
        Mon, 12 May 2025 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747056152; x=1747660952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWKRYvmLzREbM66W5hs7RHV/RuFzJd2V/m0RzeDoldQ=;
        b=KU0EdvTL7bw2DHNjadP8LRk/o6+YH7Xbg/FAFOHKRhUBILtST6roVHXD1uCJT4IviU
         pbL2xGLAWRYO7cYOzDlp+stPohjb+QGFymq9j/XOtPM0/8LtqQgCKYRwIjC3cYCZR7c5
         8xdhDzs690GRB/khNM536+7PEFKqKkXWKrPsKAhNtmtLXY8bFTSoCvH8t/GPgUDbhQS8
         sYV3NRjfedp9gtvLKWoqH40ZoZCq/qyLPYD8z/9CfrbJ6d7IV2OFXIMNe0rKFVw41bwL
         pSVqyUfO6UvZWGALvE8zb23raNoI2weEOTvlu3r5I1lg3F2+j2/8inwt19eSy+3Y9sI6
         BVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056152; x=1747660952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWKRYvmLzREbM66W5hs7RHV/RuFzJd2V/m0RzeDoldQ=;
        b=sA1betJIUYSyCVF0/CvMouo3tRiyH0/R4bejKLWBgjXLutLRF7QBOsMommIQ/x9abV
         y4AiY3y/KG//R+rGoqKDoD1qm5NfGjRyXGJqE9lBgbTLqs+1Dj2fpX7RtSSWMHBKfVS7
         JUFJwEOij/qeNl345ocIje5ju/vGXZ+iDl41ELa4fOhDBL0iU0wnkjTIUV2QNMXsSgvk
         hAamvUwj608SwmkdS/E01opYRq+o60ljxdLK3RkBNvAvwxKk16ISVrtd18aCKXlbnja/
         rlxquZiJU4nYQonrrm6jl5TID9OvDRguCC1Wd/4gEgUJDfO6bOl1PF5ZnO8mKbB3BPti
         aGTw==
X-Forwarded-Encrypted: i=1; AJvYcCUoBzCPzdxQZn/GHessxqf7lW2zGH1Ys29iBuIJP8rZqx37cjUdND+IsEk1cz3+B/JrU8v3NFg7zLxM@vger.kernel.org, AJvYcCXi2XGpTMMNNJLEWTgmoaE+QR5ode8hTjiwGJb7iNPH6FIji49o54xAvmCJLB+h5PlKQh3v5AHOBu+9@vger.kernel.org, AJvYcCXypSrSORvhHdF7dyllPbgvvP1juFIXW1gg59NpcMzf0XBDXBHK3i0GmWQ0ajMqfSJ3MvyJ9fXXbpOEnrP1@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/TEjFjYvw17PlHK1z/3HvNBUqqDpeRVJ9O1o/C1NiS9tDiff
	6FC4vAd7/huvigvJ2limbjBvsmBlLABkR/p0RPfb2vSawBjJMExI
X-Gm-Gg: ASbGncs/c/dKMunlkwvDSQYiG++UoE2uGx4Xc6I/YoUuCmMA5FRvypteH8QXCTozEIc
	D3ouSmkdwllI61aYynon5ircUbXgrjPmtYwJ/gzWrwckSVTZ/ZYYGH7D41827RqP6LmmdY/invE
	YaaobmL2olNRpZSxlvtWGHrYnTreBFMCyiNUH53mu/9LFzOXnsImjHGBn771CVk2iyzvANqA7Ux
	3e8aybARFlA0M3Tjgzk1gdRIEtoVIXA2hLSwjCu/GkVPI5Ka8a3nux9sUYcG9RuPMURfg4nStn0
	Ve/0lnUWkoljmXYTxKTct7T4WSBCoC9ApB7QJTpNAsjvameyyusLW8EmZxWq
X-Google-Smtp-Source: AGHT+IHnixNiPLQjUOasfyjvBhuKYV/1baADFmo9aqX6ezYLpea3tEloflKvoMwLzGn2Vz5dPYaKuQ==
X-Received: by 2002:a05:6122:3117:b0:520:5185:1c71 with SMTP id 71dfb90a1353d-52c53ca9ddbmr10836365e0c.7.1747056152432;
        Mon, 12 May 2025 06:22:32 -0700 (PDT)
Received: from localhost ([2804:30c:404b:a800:55e1:4221:1a82:c6cf])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-879f6298361sm5134889241.32.2025.05.12.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:22:31 -0700 (PDT)
Date: Mon, 12 May 2025 10:23:55 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 2/7] iio: adc: Add basic support for AD4170
Message-ID: <aCH2a53ClLnhPDrG@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
 <01ac3a81f9aa7f1fe48478ff60c0033dd02aefb1.1745841276.git.marcelo.schmitt@analog.com>
 <aBSsa-QnloxBbBN8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBSsa-QnloxBbBN8@smile.fi.intel.com>

...
> 
> > +#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * MEGA)
> > +#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * MEGA)
> 
> Ditto. But are you sure that it's 17 and not 16?

The maximum external clock rates shown in the datasheet are 17 MHz.
The minimum clock low/high times are 27.6 ns, resulting in roughly 18 MHz.
So, the specifications indicate that 17 MHz clock would be okay to operate AD4170.

...
> ...
> 
> > +		nv = (u64)chan_info->input_range_uv * NANO;
> > +		lshift = (pga >> 3 & 1);  /* handle cases 8 and 9 */
> 
> 		lshift = !!(pga & BIT(3));
> 
> ?
> 
> > +		rshift = precision_bits - bipolar + (pga & 0x7) - lshift;
> 
> GENMASK() ?

		rshift = precision_bits - bipolar + (pga & GENMASK(2, 0)) - lshift;
?

> ...
> 
> This was really hard to review and I am sure I missed something.
> 
> Please, split this to 3+ patches (basic + feature1 + feature2 + ...).

Sorry about that. This part is so flexible that even basic ADC channel support
becomes quite complex due to the dynamic setup configurations and possible
combinations of input type (differential / pseudo-diff) and PGA. For v3, I split
calib gain, offset, and samp freq into separate patches. The PGA, though, is
harder to disentangle from the rest of the base driver.

Thanks,
Marcelo

