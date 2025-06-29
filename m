Return-Path: <linux-iio+bounces-21134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A7AECF83
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 20:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD3B3B265C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD7233158;
	Sun, 29 Jun 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/jxdmfT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379821D581;
	Sun, 29 Jun 2025 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221114; cv=none; b=bGDVem4AegKxCpZcJzpDSRikg6HPs2KId1jJDwtAzzPVwnKXQ4V7OFinX00McEkMgDP72rMfHJFj+HoFA6KIl7r8hDAOlphvg1jyDdGobwE4RnX4ZA9vcajrYWCnqSSTvunFqfygc+lhEDO+pMys7BAh2R46Vu8HzliI5FdL5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221114; c=relaxed/simple;
	bh=hDNJzFVoCghhGcCobsgEqFF18f/TSt1acJyPgIhd4NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmux9zCJ/x3cd09CZBCS/KDwri2p71gD2ye0wHJ0csvdbsj9ArMzZBmrXgw/fN4agDkS1aHf/4YioSscxJ50uvW44SFRnJI520d7mnSOV46mZovNh9Sazj8XrgYx96jZxL2wS+frsXUtHiRM2EyJ3uy87SrunHdNhDRdOiQTEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/jxdmfT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facba680a1so18169356d6.3;
        Sun, 29 Jun 2025 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751221111; x=1751825911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gigmSkGaUhJ85Fu8r7fwv9o+CpfPEe+hVaAI9Fme9go=;
        b=g/jxdmfTBNscunY3i25Se5I/H83hHkBu8BMjLUDnT3n7bzhZ3TADGdCPm9AFahXcsM
         6LPXG5cvshFG9d6uPwvg/UbQsmrehRVx2G+hvY4ULfZSgVTqCnvaMYXDnZ4lIZ95PIDs
         EIQ0nz5aArKDIxIVoOo+w/+qMq0+0kSI+BAu8ewgEaS1LWKYntlvfnNPI3N+/H9Be94F
         0XRQg+NGCOBmveJ5Hbt2YIKCF+JdBxxdlVFS4BWHonmxwrZWdlK5Z6ZEsqKFhWIF7hgs
         LnG/ujNxK5DFy+nTvkMAIISMQGfGbFqn1hL5VDjroz898WJXob/g/4CPZq14+HONqLdn
         heaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751221111; x=1751825911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gigmSkGaUhJ85Fu8r7fwv9o+CpfPEe+hVaAI9Fme9go=;
        b=tIyMjnM1cmfIGn1ERXPowhLAtr48GEXL1RYx5QfobgL8K3ksTyKoKhNzGnvllalylZ
         ontY9rxJhUSUbTTCojrMFa5am/rtz5n4G6CPt7En7lH+7q4iVQf6bqbJXDkp9vDQhbWV
         4lbtQ52rT8t/A0JAJ2o/WTTOAf4YajjXPSaZgGuOMpS8/v+tpUDayA6gaC+TgvtvouIn
         LNmH9ry5I3EIMo8XSVqnKsQY7yUIsoYmEcOCh6ffW30W/fe1yv/l0od6cn0eVXxgb52I
         cAW5Oo7lLHMUqytVB1FScq2ocHVzFwW+IkPyQi94LWQzz16ln7NvGpra1JJMoRNz0Mgv
         QrOg==
X-Forwarded-Encrypted: i=1; AJvYcCUjnAZx+j3eSO3mqGUdCotU2fkToYgLazscUzVd9dKvSx42Mpvu8iZSBfa3jEpuqWEKRrCJW2aJwgMQl2PU@vger.kernel.org, AJvYcCXNYGBcUMTdWD+GJdYYTnV2qsxiy1TY9Tn9RcF/oJDTZmJIxiMibWCHhYwSqAXBcQTlYKXJnMCZiJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/fwu6NqOLQ/s/gMd4Kx5y2hX2A1ylCHyTcsObGP6oU0eS5Yc
	DZoFVEnnqasZPemt4AKh13LksugZlxiwkCdzc/uiPW3j/6FpaAcnXlpuZXKKKgK3
X-Gm-Gg: ASbGncsFpUs5ps7sKRhyaAqH9kSLyxp6b+fPSiD/u7ViIIg+6PoX9E67AHkfc8lmSGy
	PTVGAAzj535c4iGRqw/SlC2/VLdm7AC71xldihU4yIG2ZIaBGVSdwRq0zPi0FtV8Y/nFPPXNsru
	tZG1RSXeYDdfLj4sBr5YA1xerHZc9ujBC54eLsZ6NvK1MknqfssuLURqZT6JRLcm/x//T5mgr80
	pyVQX5iGzRiYw/h16mQ+g9bBfmGosACuGC6k8Ys5JMmdoDBmxvw0Tk9c+6DLLSzKFUsHzlPYtW4
	gPIXH4pKAxb8lj1H3Gb8qh1BGvnjACc60pHnjGWQJX48UnfAXOOnw96tfL68vq14pUHSiA==
X-Google-Smtp-Source: AGHT+IEYCmP3hmaDpRZdUL30rMm6sXCYzwY9x9v2L6zw1uECE+JMsQisIP4wfqNshmnbLQtsRwqqGg==
X-Received: by 2002:ad4:5d6b:0:b0:6fa:9f9b:8df0 with SMTP id 6a1803df08f44-7001378c6bemr136641516d6.20.1751221111142;
        Sun, 29 Jun 2025 11:18:31 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd772e730csm54529856d6.60.2025.06.29.11.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 11:18:30 -0700 (PDT)
Date: Sun, 29 Jun 2025 15:20:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r5: make ad7091r5_init_info const
Message-ID: <aGGD7a_Jh2Cd_TQq@debian-BULLSEYE-live-builder-AMD64>
References: <20250628-iio-const-data-3-v1-1-13d3f0af5f3f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628-iio-const-data-3-v1-1-13d3f0af5f3f@baylibre.com>

On 06/28, David Lechner wrote:
> Add const qualifier to struct ad7091r_init_info ad7091r5_init_info. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

