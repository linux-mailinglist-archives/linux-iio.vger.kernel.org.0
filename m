Return-Path: <linux-iio+bounces-22014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDEDB11A32
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 10:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A673C5614C3
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E81F2BA4;
	Fri, 25 Jul 2025 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvilkJGh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DC219E0;
	Fri, 25 Jul 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433261; cv=none; b=YavHiaG0TdPGdupAyDaeWbn4uqNw6lz2saM2ImToFJGeoSd4TF2PgyvB7QAdCx/V1Oj/iJQFRCSscgfQDfaTIgQDuU48c79C5zh9aazQYaCR7HzKmLtJSCZNljUaB8crHNWBqFLJOERr7M8HPoSu54VBp/Bn9YJickYlI2qjzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433261; c=relaxed/simple;
	bh=RVJNoS3jyMJS/crUCJ3f96RXEEdmuCA1baA7ilUD9YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSW1GY5BYs2sTQyL0QhXIAWlW7XeK3qnGlFlADgTJJVc86EByGWfH+cT9aLJ01NzijA1DZj8qO5+q+mMVOaQCa1UO/CyLhWZnkuoinM0r0KmcefvBlhXAjlAQhmyRw9emr+RDvvDecO3yg9XmAONJGcMSsPh79V5Jhv4iTV9ynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvilkJGh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso3709985a12.2;
        Fri, 25 Jul 2025 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753433258; x=1754038058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OxSGf1Goj9vGw9/2w7ljaHJCx8os9pgI+QhLw0k/kP8=;
        b=AvilkJGhQRzzA+6p4R0i6Et5fXeKR7+C6bgTf7ps1qbaKBV31HB5LBLoGfLEm+Od0J
         pG3asr+rrhFHxw6ryP+B7DlYZYhdDECxBJY+jcB2vJDvJuCZe4q45zcfrhE9Q9YoudvV
         97XkxfLwTBmVGPJwi8C83xcVczN6VRp+81Y4s06BGqOWhTLJTxSoxHKoprVrFnngb80N
         fye0vxvV/ZBVb1N0dLmWNzxFxFlClbd38mAUUwbybsbCfuHufoIcXPfZ+myu9KG6mAdh
         gqnJ9TJpcNLAa3PNnfEEwS7+gTGBDtiFezjxd4ZRcwDsA2cWVfxn/TM35r3Zsyr80hIq
         Fj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433258; x=1754038058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxSGf1Goj9vGw9/2w7ljaHJCx8os9pgI+QhLw0k/kP8=;
        b=p7xea4t+9FUK7sgx5N0irTlyJSxWS1wFSE7XB70qlRKEPmVPA86neG7N604ZkGH5HX
         +9yoSuz1FTyJc4oRXe2qaPbNkxoSTV91S01xQg49U2BeqPY0uwfhsiv9fZIP9dJzyK3J
         Bi4W0fa2gPC7L5ziRrjj3YpmhpVeTzTs2FvaMHuzhuhItX3o2NGSH4HMBUPlKeyZBXsc
         brVo+FhiojMbGDFTJKOGY/mBW4WEYJajT3KesNnj2gA5PFf9mcQpzZFJvj6Cpb9uT0J+
         lbqxDSSHw1CLNY6iJPSA6wxu1OOT1TVVk89vuqdm0Y6qiQfTtgALgEpKvELq0t32G0VB
         l/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgkEwqoi5tXVXqGMeuk9jQU6MBipGggFtTIK8RW+tEYLlSpmpG6BIlXJ7K5IIKyuZUBTKHsV5xPUI=@vger.kernel.org, AJvYcCX/sHxzPNyVorbJ11PcPCcIthRPhyGkOyGYDLTlbg0P/exxLA4Mc09VZHbiQyZAfqyny1L4m/KDsPqHTSBW@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwFeePPHe//E6FUTej0dQrurFR2tTvy7vx0/Vl4srTf/UExOA
	aQCyh0qA1Ej0L1Aocw9AqYhBFPcaEaRyiobQ5isFlxoLgmykzdMZLxli
X-Gm-Gg: ASbGncvNstVmuq/xNP7wY2P9JbWzV5n8q7xLJGC7Dfq8VuaO4K35p78cEt8eCctle7T
	gPuhrqEhGhtxLpqC+gDjvD/rtOLzucVM2jVYKGXWZEVwvOqZCPGfRlETGpWrh3xqMcjC1326LJf
	1EbP140JB3gHzbFX9pTMjFj88rX1Cs+o7plGR2B5aoY08yiy3p+8V999lpTXgrm967PeF7mkNd8
	oJKFiPuYppvqCuQ/pBJMN2r1HtosTKb4Z8a87sx8kMuKvQwkFrjCZs+ILTn9AJZn/vKB5xOyPgG
	TYjFOjHcPAxacK1BvLmOhqxeneNH6mi8kenzHAxlST6d6P0WGynRn/G/jVHhVzSRR8pTBOSqAOh
	0DpX7nQnhzXpL
X-Google-Smtp-Source: AGHT+IEZ78rgBh+lHnbAs1v1snWgdnx+Hl+1pexireJcJpcmozaTqnmRUgtavqI6Ncne3VvzfJ93Iw==
X-Received: by 2002:a17:907:e84b:b0:ae7:ec3:ef41 with SMTP id a640c23a62f3a-af61950b3f4mr161895966b.45.1753433258008;
        Fri, 25 Jul 2025 01:47:38 -0700 (PDT)
Received: from nsa ([95.214.217.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44dfdasm238002966b.85.2025.07.25.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:47:37 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:47:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: adc: ad7137: add filter support
Message-ID: <itmrmxm5s4y3ytpcfuofwl4luhy6i6girzeaww5aiom6pjxhwe@dhrkgh6pcvzu>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
 <29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29786806-6495-4423-9172-e924c60b93d6@baylibre.com>

On Thu, Jul 10, 2025 at 05:47:14PM -0500, David Lechner wrote:
> On 7/10/25 5:39 PM, David Lechner wrote:
> > Adding yet another feature to the ad7173 driver, this time,
> > filter support.
> > 
> > There are a couple of leading patches to rename some stuff to minimize
> > the diff in the main patch where filter support is actually added. And
> > there is a bonus patch to clean up the ABI docs for filter_type first
> > before adding the new filter types introduced in this series.
> > 
> > This was tested on the EVAL-AD7173-8ARDZ evaluation board.
> > 
> > This series depends on a bunch of fixes, so we'll have to wait for
> > those to make it back into iio/testing before we can merge this
> > series. There is also an outstanding patch to add SPI offload support
> > to this driver, but that doesn't actually have any merge conflicts
> > with this series, so they can be applied in any order.
> > 
> > ---
> > David Lechner (5):
> >       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
> >       iio: adc: ad7173: rename odr field
> >       iio: adc: ad7173: support changing filter type
> >       iio: ABI: alphabetize filter types
> >       iio: ABI: add filter types for ad7173
> > 
> I don't know why, but I really struggle to write this part number
> correctly. The subject of this cover letter is wrong, but at least
> I got it right in all of the patch subject lines.

Series looks good. Just some (apparent) typos and some other thing that
you may or may not change. So, at least with the typos fixed:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>


