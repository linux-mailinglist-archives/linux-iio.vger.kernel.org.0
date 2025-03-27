Return-Path: <linux-iio+bounces-17293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377CA73734
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0933BFB76
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5481FC7F4;
	Thu, 27 Mar 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQrmitgn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BFB1CAA67;
	Thu, 27 Mar 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093825; cv=none; b=GwuU8RPH9TyDto3RTX+yGAto4Pp+NoL2EZIq5r/FU3nloNChRCYXOy0Znu2sPriboAFg9MJzgWz14wTo2dFZU44ydisvIdODuG0/CDy1ocaoycG8i9SQLBUWxxZ8Y4nz/FbRmSAEa/BFwzrp305eOePJdZVa+jdTcc7whV2TwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093825; c=relaxed/simple;
	bh=TnJVCFD64o69mN5Hh/YDo52i9+KO2ogrvXQQhM53668=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1RWYJpi4QwztXpYEF3Rzni2pJrkNBsVEEf+59FPgGsfe2MMr0byDNEyta26tWHLq6/S7brq1pj07QsTRMOWwzQE8/xI/Z3+9/xcfUSwIvRUzk9RNaiktA6mLU6K0v7B0HX2fzaIfvUYc4fj11Pve3tYipP4DAnOKnS0ga0uTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQrmitgn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-226185948ffso27773185ad.0;
        Thu, 27 Mar 2025 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743093823; x=1743698623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lb1+R66+rUYGnBLRmPtMSXkNrgkfnJRiAlwP5fnx9QU=;
        b=PQrmitgnryitbBrE41o4Jw4BNAWfwmNIbw2mUGgLVyCgjWinbr9zI35MCG8yHgTy5V
         FJeqzRFGNKGggMWl60PBLIN2Gd7bRsUcSHAC6mxAa2UVbvvXFo/48PPJIMNsNxlPYDgU
         Jwlj3trHsPa3Hb8bkn+89elH7JeW4Vl1QAExR/tyvZMeqBhcA/6FPwx12AwqPG8aVV0G
         1FlvB01ggSEG79VpocRAAbqrtcAHN63/t71gp49K0Gst/sRxU8Bzae8D5AZW+BF1FmyQ
         ZQflXLsgiUZW3Bj3yIoFwebt6pBQjp6dRLobtbXYmvi4EuqBDnwSinERq22uLXSk4GHo
         l4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093823; x=1743698623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb1+R66+rUYGnBLRmPtMSXkNrgkfnJRiAlwP5fnx9QU=;
        b=s/UdkaTBT80xqtX2NXN/X2A3QqHC0euIPBB4VE+05hkI+KOkPgwazH+Yq00CF7mFGf
         HmS+HRhKsGQtrHnkdDe5/Nqtt54obMnTs6j9t1X/B+sQ0wRCKlImJLVa/4nJ2xOZJb+b
         5PeuhHCjQMUOQqU5wk+gGF8qmk4KiYPZ2RKWDgAdtX/0/lsNee6gavHIUuG/0cHl4yJb
         AN29SbuxdToqFNRVxInIFaUFU4Ox0AESay9VAHXQILd9hZTTEIb/sAa12aiARt0FSQiD
         ESdavRtY/QZIwGIo4GeDHeMrge5NdujFyR3GuYfngvUeeW+g7exBIEi7jYj1vGdNBdMQ
         JplA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+YkB4UZbBKgIuB/P+4lb5kaukPFr29anSCOShwfxcnTcE6BqNIOKzTeoiwqL/JOpazp2TozVU6iOyVio@vger.kernel.org, AJvYcCUuN1hXhpSP3fnDj1sIqOq3zvPiKuJBSGmAfjilpbQZAwzvIiLlv3brFNs0vQiFpWaf0YYYzpq7hHE=@vger.kernel.org, AJvYcCWl3uNLg6D9FTzA10f+LojatytekmfekaCB57vnDxyhBZi8WpiNBI5GkSXhLTsz5aulj6sTlLC/4a55@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKt+yDvwR/8zMVaNWD5RQCEetKfyHdwhjIE1Hr+13CadC3Wo/
	jgsCv6pOSHA10ai1QvfRFW3kadjLY8rOZvhU/53EGu26nG8C0TG7
X-Gm-Gg: ASbGnctBFYxUcMvtjppTqzVx2Jo6OgF2f2wRekiRkcdf6Os0IRYVmJLYCwhvXl1o1iv
	7EBolyJVqDAiaQ/HxRcd3MGzQbDOrgfG9HqB5crtGjkVxYvPdO0Udj0QxCyfx+Wb4EyWirKAkuh
	xrT6wA8PGgZHq77D64ieYXiXjBZM/OEdKazPGKEtimYJruLnmYM/I4b5vkrmXNKb1z13PBEjgEw
	5BlK/3jewRMhmH4bDDYdwMJ/ldtQL20C3jzbDfm7I0B9fieW8JLwGz77fVqHUOQnpdBBPzokCoa
	emQAg6pOwASnVgPqTcm+gNseDQzsHofkA9vOLnRl8KFS6mDCOD5FVA==
X-Google-Smtp-Source: AGHT+IG9qnhCTor+SGyDKWAUyClWNk4AWFZpE4cZ+MxMyD0oepgvr5ve7N3BBCEMLaVTfMHbgN6Pew==
X-Received: by 2002:a05:6a00:194d:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-739610d1e18mr7478554b3a.24.1743093822611;
        Thu, 27 Mar 2025 09:43:42 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93ba10863sm87262a12.74.2025.03.27.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:43:41 -0700 (PDT)
Date: Thu, 27 Mar 2025 13:44:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	corbet@lwn.net
Subject: Re: [PATCH v3 2/4] Documentation: iio: ad4000: Add new supported
 parts
Message-ID: <Z-WAfEIvsWTr5Q_v@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
 <bb57e4452cb6bf9f644c0ea2c248d4b72ecc65b8.1742992305.git.marcelo.schmitt@analog.com>
 <ab73f7d5-77fb-4264-ab4a-03ee78aeee06@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab73f7d5-77fb-4264-ab4a-03ee78aeee06@baylibre.com>

On 03/27, David Lechner wrote:
> On 3/26/25 8:25 AM, Marcelo Schmitt wrote:
> > Commit <c3948d090080> ("iio: adc: ad4000: Add support for PulSAR devices"),
> > extended the ad4000 driver supports many single-channel PulSAR devices.
> > 
> > Update IIO ad4000 documentation with the extra list of supported devices.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> Don't forget to pick up tags. I already gave my:

Oops, sorry. My bad.
I've picked them now.

> 
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 
Thanks,
Marcelo

