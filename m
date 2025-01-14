Return-Path: <linux-iio+bounces-14350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A4A107FF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A531888EB3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84287236A61;
	Tue, 14 Jan 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0JKWdHH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD432361C7;
	Tue, 14 Jan 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861778; cv=none; b=DnIBy+GkFzXdaNyR7tTkiZLj4MLZcVAvVA08ZdaIn9REJpbdJ4BVRTPbvs4+Wu/OkStjJsSpZHOpPs2h7KBAtn0PuBBppky+Of6UaAAcgd9xKLG3R4I83R6yAD9HM7dklJeRo0YPY1/VyOC+BJ3JX+AsqUx+gbUEAd4aWIigjOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861778; c=relaxed/simple;
	bh=1c2e9HFcCsMuViOIoYsTPgJ00QsEdw7rWxveG6pUH7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUEFl57RwPkpn/blzgHd2AeZqknugotgcX7VLprgXoRZdwiMNbR0J261cUcHhoQP6MEf8NOQbWY254z/Wa7tQ9fImP0kvf8dXprUF/BT0/Vze3q3l2F75qaX2hpPZWzx8LSD1VyYMAOgXCQBgye459sZNroOqpVf0rRaFpOrOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0JKWdHH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21634338cfdso86117375ad.2;
        Tue, 14 Jan 2025 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736861776; x=1737466576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNsRSkhgwMOrmcttajWEwZ4HWjMO7ApWFCKlHWG3OeU=;
        b=V0JKWdHHvPqFk4XeFg/SF6HGkJUuFCIxTHc3KdrvG50WedYxQ3Yi6pGYn1IDjsLA7R
         nnGlhpJJ3Y+aQIiMd8jOF2LYZYoh/yC+u91bxJNVI/RGQrp5xT1bQ9YPCAmpy0gfera8
         sfUWwAzkJWgKhh4uNOgKeZtmUPJGlnCk68axigFy5fWM8LjYnSpcWf3eh3Az0E2cXb4L
         Xt+P53W3qzdhs1W1U9Hx5XLlvlizUrneWV+IkeoS91Ss2mepVs/ZCRB5EwKarxUwWCNx
         p4GeGPoNUM8KXBqS65kDeIVOg2HC2X0uvspbfwWqf6Vrej5I3wTFfT1oKjaD4TZzGHzk
         oWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736861776; x=1737466576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNsRSkhgwMOrmcttajWEwZ4HWjMO7ApWFCKlHWG3OeU=;
        b=DDLJmIhb7jMbtwOd7+pxdcGebJyJQCV0nTg0Tvwea3IEkS9r/EPEOMCr/+F64gQmpZ
         Ci+iI4woAolJLbUu8EyfSr0dd6sVfd5dTpypzEm/SXOAF1TzYUsjTK0R/6xJd5VezUoK
         Em0qJfPXFqJ+tsur8trod61ugsQsNFYtHRE6Ho0Z3wQxXaApdsWhJgbv4oJxp3gRyYni
         AomsM0Xq2go8+RGHiIotAJA+MgTxxheUuCKyKvnZpGZI7jxYQ6RpnrC/HMZv/PAOiUyc
         jx1PeC35ysHPVbDJfFhy4XCPyOeDPEr/9ul0Mf6LNIpgoDJvclnOMFkX70Dh9QrAwgs2
         MFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUrQ5U5M5EhMw7dbasoHjCBFuRCRBcUfZwwRYx5BYWBuk9nKJ+0kvhRgZlwRQ0Kk/SDB1robxWeldzV@vger.kernel.org, AJvYcCVaFBaPPf8O46Zlshs1M2CwwNQVFOgTBmMozitJpWP0mSqE+RtE62c7xUwigPoE1PP3aNaVmR7W7cjn@vger.kernel.org, AJvYcCWiCxkf0K0yi2Pqo+x2r66uZzu6DDY1iaqXcp1MThhEmwZA7kC319mCTENicsAYc2L6UN4S36GW39qyrPmF@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqQcVbFuum0M/G9ART8Jzu2YQjLFoBR2jOgmT4leRC3uK0pq2
	N+qfwypFaprYOePx+IYosIYk7/MEWUM8b3jEcqrlSVro7TE5N+kj
X-Gm-Gg: ASbGncuN7uxqkSLU/gbjC3UI5yQLQIjfiZITa+hTF4Xjz3yyzKVtJS8JKYmkFqfXuqN
	DyRJMinOo/UMkMNo+s2/XQAlTDGqaBrY8MrDwJLOTyIHv7nHEPOvLTQbwSvbynON9HnHZengVNh
	pnJjVyjgT/m6ni7w877gA+q4wAFJxu8P9PVsQbN+HwbWsASHOHQFyAvuLJwBYp+QE4N0N/EQ8xK
	u4AHyMvPikUEhLq4mjRfmaxNawo/DEZ+KFoggWSJK5L2pf+nn5lzatmJ5GSxuDGpjo=
X-Google-Smtp-Source: AGHT+IHUj0smiqPZR2hVR0Bs7Xojitz+U9xqf+KjhyJXe1PEQTkY2psgSe1FQBooBb9BXgunnfMPlQ==
X-Received: by 2002:a05:6a21:7886:b0:1db:ff76:99d7 with SMTP id adf61e73a8af0-1e88d2ec11emr45187159637.35.1736861776028;
        Tue, 14 Jan 2025 05:36:16 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31840e93absm8413516a12.20.2025.01.14.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 05:36:15 -0800 (PST)
Date: Tue, 14 Jan 2025 10:36:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ana-maria.cusco@analog.com
Subject: Re: [RFC PATCH 4/4] Documentation: iio: Add ADC documentation
Message-ID: <Z4ZodgpXRTNP5Rer@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
 <48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com>
 <a2e76ca6-ec21-4ce5-91f7-4d3a0ed792ce@baylibre.com>
 <20241219125503.6c909c24@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219125503.6c909c24@jic23-huawei>

On 12/19, Jonathan Cameron wrote:
> On Wed, 18 Dec 2024 14:46:14 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 12/18/24 8:38 AM, Marcelo Schmitt wrote:
> > > ADCs can have different input configurations such that developers can get
> > > confused when trying to model some of them into IIO channels.
> > > 
...
> > > Add documentation about common ADC characteristics and IIO support for them.
> > > 
> > > [1]: https://lore.kernel.org/linux-iio/0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.com/
> > > [2]: https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---  
> > 
...
> > > +1. ADC Channel Types
> > > +====================
> > > +
> > > +ADCs can have distinct types of inputs, each of them measuring analog voltages
> > > +in a slightly different way. An ADC digitizes the analog input voltage over a
> > > +span given by the provided voltage reference, the input type, and the input
> > > +polarity. The input range allowed to an ADC channel is needed to determine the
> > > +scale factor and offset needed to obtain the measured value in real-world
> > > +units (millivolts for voltage measurement, milliamps for current measurement,
> > > +etc.).
> 
> Add some 'weasel' words in here.  There are more complex non linear ADCs and ones
> only capable of reaching some fraction of the reference voltage.
> Maybe throw in a "generally" somewhere.

V2 will come with a short paragraph with a disclaimer for complex ADCs :)

Thanks,
Marcelo

