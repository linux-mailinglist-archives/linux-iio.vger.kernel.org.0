Return-Path: <linux-iio+bounces-15809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207CA3CA56
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 21:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AE93A7CC5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 20:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8B24CEF3;
	Wed, 19 Feb 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRZPRzEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BF24CED5;
	Wed, 19 Feb 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998116; cv=none; b=RN7rmDZ4Ycgl+6A2uQKNnah/xVGdzcYIjUNULSOVULkZZl8jicKwUIPqm82QQLVmzAl7DRWmf3zB5sU8E0ymizPWYUqeP9zQeeDdANRUof5jv1T4jy2rjHYwNKeF0/CdiYF48vGZ7k/0+sTxylSu+Hchv4Fkt4TkYkwIqj0Qn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998116; c=relaxed/simple;
	bh=rPURpv5vgBdCwD9dat4BhYNy99e1kMDXzhacqzB6sQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFcOsKO0EznHHR9yiksWc34bMGv2b6QAgDEgtkbyDbi/47LuFUwjIJJkeue4OOi0mqbt6SzVF85lRkYKVV0wfa/0f5+3Ti4vxjq/oxHUbDrpmP2rl4BD07n1uuyr0liLQixdZevgHN+YKYugrN4pgLYNioqz0AZCHPSUnShWNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRZPRzEM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bfdfb3f4so3332155ad.2;
        Wed, 19 Feb 2025 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739998114; x=1740602914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rvvkoHBZqca1tBS0H2AmTF8C7cV1cWNOIDwXraLr7E=;
        b=FRZPRzEMqwdSe3C+1rxXirhtvYM9M0I80q5S4PMCkNczdBFjgylg9AGXsBv17WuVFw
         fm/j72ht9Y6h/x5b83Z57m6wnJ5DIEszCti/Y9Ce7gnd2C9JpO0DCbNaj7x9upcq+/in
         1stJhgjAZs6RUDWBsXekAc/QrcFQPQx01WqaBLFNhjwXKWsMZgbqkEekCZYKzUMFndzD
         hnmaA7BkgphB50jn8gpPPkqBNaayi8VGr42IxQNveVzWwoEbUZ7OYaB5SjYrkvlL19vB
         ccQjQFW5ECoUG1VAMxjS/CWvwCXXucU5I1h5cpA27HhejPLhPiI0hUFsXhELN+HI+AQr
         h1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998114; x=1740602914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rvvkoHBZqca1tBS0H2AmTF8C7cV1cWNOIDwXraLr7E=;
        b=HrnNmbOzVtL/Les0c/9XUTwBVwrHyg/nMCkY7yIURGFoKvCgZ+CvCL42MLCxpBp6AB
         gDjRfb7W33/G5z1t/bWNA12FyiwNqgYaHFQI/GCgalLK6TeG7KlBSo4lcSBQQjTxAaPm
         mj0vPYYORXteZLKBYjaszbTwlT1M51w6ZYFdRRX0phgDMYjb+okvEw20gNgoN1orsfws
         9C9nssrkxEmzKnkuR1mhOxpi6vZs0Ui50lD6zK8nDjR/SjivpCcMErnU4Uv2I0gQe+ma
         autUiLuyu4WhrsDa5VsIEaO2dnbj2IWfu8G5poXdfpjBwEfJbg2Gcf+1Lfd84gd3a28D
         hgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2SCiSnD3sKrnenHUQuo2OzMlwNxfCdOKfri1qlEW76PhHnOwBGTYSnCYM6pFJxF4++onGh7D3fo8H@vger.kernel.org, AJvYcCX224dJ7PON/8OGRKBURD1c2E+GEdbIyDknsPVEH9S1yfY+CzzrK1xAhXv3CSW0HOF5x9kaTfnXrjxZf8QP@vger.kernel.org, AJvYcCXrCp0NHd5/fWkDPQYXxK+9uONfbSFGMoDDrBssSu4zPSicTl4gbulh3aQThm9V+SgTMla4TLW8BKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CFLfRkq0bFhDwDwVszmrK/bgvHwq6FC9capEmSBV0oOqzQf4
	IZHBX8R53DuPN+YecgMXD8QACweWbARKOQHhTr7reDW7KB829TAR
X-Gm-Gg: ASbGnct6v/Qi3BYoWrm2ugF1obTX47ekXHeIg0zaDPHRnaNczeEaJZKEdtYcXUhrfnM
	qXTuD3HzxD26Fd7lGIevPTPUD5Q/OHndn/xgWq+84es/Tt4EBNsukYooRNsu7of4ph5LrdnDIu9
	RRyTaXCYxovFHL2NmKvbQxOq4uQLJ9CBFf0+z0tKVyi5T2rPcg3JKuBKTMD6k2fNBo53fNXknlI
	sp1mVM8g2ZPOIea9z5IjGkzMBiFBvDbH9bLmNXZa1s0KAbo72NGhRR8Vy1XdV7pzYZxJe1bL75j
	Vk3D7IZI9+PLQw4a3yesRocqVQ==
X-Google-Smtp-Source: AGHT+IEuCSjf8eYGI2GnSpolCwQxLMU7Ni89VHflayt+Rt+Bn1K6etIV11qdtPH43Aahy+ZjkDUv+A==
X-Received: by 2002:a17:902:ce81:b0:220:c4f0:4ed9 with SMTP id d9443c01a7336-221711b749cmr63305385ad.45.1739998112543;
        Wed, 19 Feb 2025 12:48:32 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98b3232sm14358927a91.5.2025.02.19.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:48:31 -0800 (PST)
Date: Wed, 19 Feb 2025 17:49:18 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, corbet@lwn.net
Subject: Re: [PATCH v3 1/1] Documentation: iio: Add ADC documentation
Message-ID: <Z7ZDzg0KHZhfiLo3@debian-BULLSEYE-live-builder-AMD64>
References: <c21b89367510c3d56d8d17adc24b46c7c63a14b2.1738759798.git.marcelo.schmitt@analog.com>
 <5084aed7-1b39-4cbd-b136-610bceb05c92@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5084aed7-1b39-4cbd-b136-610bceb05c92@baylibre.com>

A very slow re-spin time from my side but here we go ...
I addressed most of the suggestions and am about to send a v4.
Replying inline to the points I disagree with.

Thanks,
Marcelo

On 02/05, David Lechner wrote:
> On 2/5/25 6:53 AM, Marcelo Schmitt wrote:
> > ADC inputs can be classified into a few different types according to how
> > they measure the input signal, how restrained the signal is, and number of
> > input pins. Even though datasheets tend to provide many details about their
> > inputs and measurement procedures, it may not always be clear how to model
> > those inputs into IIO channels.
> > 
> > For example, some differential ADCs can have their inputs configured into
> > pseudo-differential channels. In that configuration, only one input
> > connects to the signal of interest as opposed to using two inputs of a
> > differential input configuration. Datasheets sometimes also refer to
> > pseudo-differential inputs as single-ended inputs even though they have
> > distinct physical configuration and measurement procedure.
> > 
> > Document consolidated ADC input types and how they are usually described
> > and supported in device tree and IIO, respectively.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
...
> > +There are three general types of ADC inputs (single-ended, differential,
> > +pseudo-differential) and two possible polarities (unipolar, bipolar). The input
> > +type (single-ended, differential, pseudo-differential) is one channel
> > +characteristic, and is completely independent of the polarity (unipolar,
> > +bipolar) aspect. A comprehensive article about ADC input types (on which this
> > +doc is heavily based on) can be found at
> > +https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
> 
> It could be worth reiterating here that although there are 3 different input
> types, in IIO, differential is only a bool, so there is no special distinction
> between single-ended and pseduo-differential (other than possibly having a
> common mode voltage input). And unipolar/bipolar is only considered on the
> difference between the two inputs and not the individual input, so in IIO there
> is no special distinction between bipolar and true biploar - they are modeled
> the same.
For v4, I'll be mentioning the differential field meaning and the bipolar / true
bipolar (in)disctinction in other subsections bellow. Hope that will make those
points more clear.

...
> > +1.2 Differential channels
> > +-------------------------
> > +
> 
> Suggest to insert here:
> 
> > +A differential voltage measurement,
> 
> sometimes also called "fully differential" or "true differential",

I think adding that would make the sentence harder to read and somewhat incorrect.
The differential measurement has to do with how the ADC takes the input signals
into account to generate an output code. The "true differential" has to do with
the expected limits for the input signals. Fully differential input is yet
another thing that I've been avoiding to describe because I think those can be
supported as differential bipolar channels.

> 
> > digitizes the voltage level at the positive
> > +input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
> > +In other words, a differential channel measures the potential difference between
> > +IN+ and IN-, which is often denoted by the IN+ - IN- formula.
> > +
...
> > +1.2.2 Differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +For **differential unipolar** channels, 
> 
> I think it would be nice to have a short first paragraph that just says that
> this configuration is quite unusual and that the difference would have to always
> be positive. Then follow with the rest of the info for the curious in a separate
> paragraph. Then it will be easy for those not interested in the unusual case to
> skip over that part.

I think, reordering would make the explanation harder to follow.
Even though currently not using those exact words, it can be inferred that the
difference is expected to be always positive:
"IN+ is allowed to swing with the measured analog signal and the input setup must
guarantee IN+ will not go below IN- (nor IN- will raise above IN+)"
The last phrase also somewhat hints that the differential unipolar setup is not usual.
"Thus, differential unipolar setups can often be supported as pseudo-differential
unipolar channels."

> 
> > the analog voltage at the positive input
> > +must also be higher than the voltage at the negative input. Thus, the actual
> > +input range allowed to a differential unipolar channel is IN- to +VREF. Because
> > +IN+ is allowed to swing with the measured analog signal and the input setup must
> > +guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
> > +differential unipolar channel setups have IN- fixed to a known voltage that does
> > +not fall within the voltage range expected for the measured signal. That leads
> > +to a setup that is equivalent to a pseudo-differential channel. Thus,
> > +differential unipolar setups can often be supported as pseudo-differential
> > +unipolar channels.
> 
> I think we should just leave out the sentence about being supported as pseudo-
> differential. There is already a different section that describes that and it
> would be simpler to just stick with describing the fully differential case here.
> The differential bipolar section also only describes the fully differential case
> so mentioning pseduo-differential here seems inconsistent.

I also disagree with that one. A differential unipolar setup is uncommon
(at least) so the mention of pseduo-differential is to point to what would be
the usual way of supporting those input configurations. Differential bipolar
inputs are common so no need to mention other input types when talking about
differential bipolar.

Though, I'm fine with changing the explanations if Jonathan prefers so.

