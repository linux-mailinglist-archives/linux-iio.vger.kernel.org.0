Return-Path: <linux-iio+bounces-14487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D9A16380
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 19:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285C616454B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2025 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC401DF745;
	Sun, 19 Jan 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blw7QPM0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F136D
	for <linux-iio@vger.kernel.org>; Sun, 19 Jan 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737310688; cv=none; b=Kt8Lpr8BvtAvyQjeWYTuFyBVO9JHgJbqoy5FUi3edo4ykPGSuWj9I6g8MZQtchEsRwlLF8aUh0Y+hGICMTViG/k7tNpfZPCOVskzd8hUnt6AtMfbxH3zVtieQkFvQl7sD3mrY+Er3OncKCiCnFAUmPc805EH0ndnJ3zNVcroldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737310688; c=relaxed/simple;
	bh=yFohMB8A8rrG+w013NcsUb7hy3XFUzadfZLW585P4XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5sSMkgK3vFkjzPcwwC/OtsSnK/wfarPNs0GKC5ZIn5XIDIz2QSh8RFK1WoFaxFTga2gvx+lqAsp68lZbLzQFkBIk0zwQvbRu7NJfPM+TjdGEfPZdZOM4cD+nEJPBWNPq1PmfvzyYKouwADGFYtJb2rLJy8LxJ8aSbD4tp6IZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blw7QPM0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163b0c09afso68708545ad.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jan 2025 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737310685; x=1737915485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6blR4ZQLNkI+g+lGnqf5N7+uOI4S+53mB5G42ZHSa/o=;
        b=Blw7QPM0KUXF6hc1+z6Si7o2GJXyGcrV/1xfkJRMeqM0D9iNSnJXDvM15DO7iYIesk
         iUvp1c7NM0EVOyGpYh7eltPe/qXZNH59/+PKPJD1q1P6jz277L//pH19Whzp47OAHS9M
         pZBU21kcyC2x5YtHqPtQ6k228FKjQuygxV/gKONvlcCA9pvhaTK+pouOO8YO7Zi945nT
         O+GXWjwtnQNHMAxuUcDcwWvVAereGtlSFYWt6I+YUFgPOVQ6bOwmtqQPCVTFoj+n8Nku
         vIKh5BtslhuPRW6ZQiDLGIxf70qRv4RfEpxgBKAQThwx6Zk/qx4nd+ieKGg2O8RIw9f4
         a+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737310685; x=1737915485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6blR4ZQLNkI+g+lGnqf5N7+uOI4S+53mB5G42ZHSa/o=;
        b=aYE1aw1pmMYX3bG/Rpi+qVsxjfcps6YwtqGtljq6EMcUqeDdBpkzSGC8LX+4bk74UY
         fQBfU+hmNOfESaWPqdAyePnSXq28nHuE5uuobXmniRMmBNCYcvHgwkOACO4PfJuzvANS
         g6+hTqBJcPgZG0U2eqnJXRCPQukOLHGk2gwCUaClcBUFxGRk3gQYuo3CtZQQkvsxEkg+
         L/+a/Pt/mYDNSA6krUaf8C1gVv0K+IIq4sYq/iIkTS2L0Tj9dfaQrNCTlL+JlpkooDUk
         UoXALD6PS6w58rOPejPU2j5uLRkk7duo5KA7/sytMG2nGNXMblyvriwFUE0tv8nPAT3w
         iPmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlYtgsJm9TawKLY5l5E+cfpC9v1+znMvvMPKUYXJOEGM5IzqgKgHYRWzxJMyRc/OpVgTetgW/Kp6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZj6Lu7edlNU7OV+CzsjPcw+wiJoS1d4vP7NTuL58x9Yw3RYJ
	v89M3peuM1gzbo8VAsxp6Y60wbJQTJwAQ9JIFKwFmpFly0/MoVlM
X-Gm-Gg: ASbGncsefjsIG0dCROnrsoHsvnM5IgiVoSqJPJNrgN1+vL1v+LDFLRPeFxSuMAq41vP
	azAqlXsnRQn0NBU5EHD6F8y11dlNyvdJjAfPpcPjP5RC4jXXFlpv0RURLoItMwHUvetyP5Ni2QZ
	u+ijitRasgMpvL3ToupWH2B+m2oI9534vJA2M+AycCeAeaivwxO7mKR+QxbD2QVxIa6z/SHz2KG
	wdQxZEIc7QXHydFDldSfOMd2+9HiXklmfE+vLZthx+zj9qwxc0DGMpEesT+m+EuzDcObkxYm9l+
	Xvo=
X-Google-Smtp-Source: AGHT+IH7qKj463mx+Qdr+mcxOwkzXhBg/VUpi5sBbODKkrpy0ifjQwAiRudUMYJFKew9YJ9VaAlTng==
X-Received: by 2002:a05:6a00:2444:b0:727:d55e:4bee with SMTP id d2e1a72fcca58-72daf92b010mr13994825b3a.1.1737310685426;
        Sun, 19 Jan 2025 10:18:05 -0800 (PST)
Received: from localhost ([2804:30c:b6f:6000:977f:d193:3cfb:25c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e4esm5399580b3a.115.2025.01.19.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 10:18:04 -0800 (PST)
Date: Sun, 19 Jan 2025 15:18:39 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	=?utf-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [RFC PATCH 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <Z41B_8X0o7-vBBns@debian-BULLSEYE-live-builder-AMD64>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-10-jic23@kernel.org>
 <Z30QIFr12sw7Wajd@debian-BULLSEYE-live-builder-AMD64>
 <20250107142854.0000656a@huawei.com>
 <20250111133731.18f6a6e4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111133731.18f6a6e4@jic23-huawei>

Hi Jonathan,

Thanks for clarifying the intent of the series and for the hints on how to test
the patches. I think we will need a v2. Didn't look through all drivers being
updated but most of the ones I looked at had a bugy check of
iio_device_claim_direct() return. Please see my comments to the cover letter.

Thanks,
Marcelo

On 01/11, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 14:28:54 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Tue, 7 Jan 2025 08:29:36 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> > 
> > > On 01/05, Jonathan Cameron wrote:  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > This complex cleanup.h use case of conditional guards has proved
> > > > to be more trouble that it is worth in terms of false positive compiler
> > > > warnings and hard to read code.
> > > > 
> > > > Move directly to the new claim/release_direct() that allow sparse
> > > > to check for unbalanced context.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  drivers/iio/adc/ad4000.c | 61 +++++++++++++++++++++++++---------------
> > > >  1 file changed, 38 insertions(+), 23 deletions(-)
> > > >     
> > > Hi Jonathan, aside from the spurious blank line noted by David, the changes for
> > > ad4000 look good to me.
> > > 
> > > Acked-by: <marcelo.schmitt1@gmail.com>
> > > 
> > > I also tried running Sparse on IIO subsystem but didn't see any warns for the
> > > drivers being changed (nor prior nor after applying the patches).
> > > 
> > > make CHECK="path_to_local_sparse_v0.6.4-66-g0196afe1" C=2 drivers/iio/
> > > 
> > > Did see warns after adding incorrect type in assignments in the driver.
> > > 
> > > Mind sharing how you are running Sparse?  
> > 
> > I just used C=1 but that doesn't really matter for this.
> > With this series there should be no false positive warnings (or before
> > it where we didn't have any markings so sparse didn't know to do anything).
> > 
> > Testing wise, I sprinkled in some early returns, breaks etc to add
> > some broken paths and those triggered context imbalance warnings.
> > 
> > This isn't fixing warnings, it is just about moving to code where we
> > will get them if we do something silly in the future.
> 
> Seems David is also not seeing warnings when he deliberately breaks
> the code.  See discussion on patch 1. Hopefully we'll soon get to the
> bottom of why!
> 
> Jonathan
> 
> > 
> > Jonathan
> > 
> > > 
> > > Thanks,
> > > Marcelo  
> > 
> 

