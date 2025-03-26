Return-Path: <linux-iio+bounces-17272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6BA71E2E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70933A40EA
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D802512C8;
	Wed, 26 Mar 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGWw31t/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E960214230
	for <linux-iio@vger.kernel.org>; Wed, 26 Mar 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013165; cv=none; b=upiaQJuihmijj8zVECcIMjsyb08d+vKI6+1dXJV0bjyClaMDaugI2Qn/0PeXWuyAqnWf8V+o/ZmB0GWei1TeMPRk4azbu2e7MXqYZaasBxIZl4mKRURHZD5oXh6JjMgiVjc+Sj0ff3QqpIx29CBDNFvjAkIVkviucj6wKr29dWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013165; c=relaxed/simple;
	bh=waVsq8OfA/dVAMvBaKhHOE8jvI+2LandRoptsG4CHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI3aYktAJ3GgufyD6KmsgkCAZfwmCt0zSqIeDQh20Q8eeW6H1XnUO2pz5OrBFVNq1svcZ7LAPOh/4sFprkLisdhVCSHWiiocr/psGL0syY/g0gDKn2TintlF9tDxAGB8eAJ81wDb+N6F6XwjRU8Byg7j1YxB4y7QRwrYENvo0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGWw31t/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227aaa82fafso4698335ad.2
        for <linux-iio@vger.kernel.org>; Wed, 26 Mar 2025 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743013163; x=1743617963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zl0dDVHG1AYAWwluJWzpZ4bzBhEFWYnC3QY6T2U20/E=;
        b=OGWw31t/Wa9miwfwgn1x5qnF2JVFLxVGYkgSlJjdwurTEV3v3SZKF1rKrO0sU0w6bO
         AkOzjVxk5sGOm7B0PQWBz6dooAizdS+1gbG4iNCZ41LivOffxF5dchB7rGyj9zTjEpSw
         moOikou7eojkxVDagC+tOkkq+LQ0hsx+cNF1T47af+fEIRoYQSoPIAoiYLUfNQKCvqm8
         wJIvZoYjRFaMAtpyOeywWLYZLUySnLBTmQkZuSMvUX+pq+qVka9MGyIBepze8Bcr5OLH
         X/0/1zJUUOoIDTOs0g/2A1QyO2UqCLBpaUipa+V/jtjjbjdU1h6R61v/z1sFqRPBEIaL
         ODiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013163; x=1743617963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl0dDVHG1AYAWwluJWzpZ4bzBhEFWYnC3QY6T2U20/E=;
        b=K3J9CB61a3ZMngSUCOH0iNmPYgt3Gf91xgFAFNEe3nnnjMUNwKNapmQ7y6COLpkRMA
         R3QB56GSCYmCg/K88Ma26QDbYUpc4c8x16Cpm9HsXqRARLxeSt54JpXUcs3MCj8nMUI1
         i+99cpGKmQ/WAdTt+5kg8Jme18XufZ/eqp2ZNQ/DUMUskouDxhuRK5wG/tnCV+9d9wbT
         IUHlyTISCXdXMQ289vz//n0MviqafP/dz1aaJtSGYcguUJI7cLn/2eFdcoyiNAtRSSrs
         y3RabtUPXNvFSuT/uOAiS/6Pm9aRkX/TZlzffX3k6bXXHRvBYrThzLJagSuvOAOEYtSX
         mKJw==
X-Forwarded-Encrypted: i=1; AJvYcCUDFfOnE2G8PUtgeSJOZ28EUmhmnsuGmJL8z06ya3h3Rtj8TxNDJAQJRJ503F8cDUhYj8O1sZ5kuds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisVlIG3Hs++tHriWFlORoONgtfgP5S3UxzW0Ih9OF/QKy8TTS
	y3rdDaSUyzJvgV+4IU+gzfzTWKfu2hyqVJt7Qh2QgP//mQ3j8gJ5
X-Gm-Gg: ASbGncsjzpELIKpW72YhXlHlWSr2jvVJkcrwlJwL1X8RfaUJqLP9cZPPQ1uL5rzB+LL
	m29LFvEcyn3z2IwDdLTbjZo8PEyPumo47GjHL0GtS2sGhNznF7nF++5JVS6FxzL59u452GtO3On
	nbuk+dnWKKMVuKIWn+xU2hRgqy0BKIVTPQh455kkb1HsSLSJx0ZfDxxgvXJIjd/iXR1I4/6Ipg+
	C4l3wb/P/9VsaQ9kTkkUR6Uvc0nC9D/owxEC9+upqIsY7NHmbEitq+ufSq++em0RJCjHQE7Apkz
	771T6FW4CAzaUOE0fMNuyMPFtLk/ZTD4DUIFW1rPx3uDg5jKPMXbZDA=
X-Google-Smtp-Source: AGHT+IEpPf1dyazPlCxCpuJkkzZkhTWs1nAJEVISEWcVG8mJ34dFOQ6Ds6HXkAou3vN7gtHhNlUW9Q==
X-Received: by 2002:a05:6a21:6da8:b0:1f5:5807:13c7 with SMTP id adf61e73a8af0-1fea2ece24emr1088826637.17.1743013162883;
        Wed, 26 Mar 2025 11:19:22 -0700 (PDT)
Received: from localhost ([2804:30c:1f10:1900:2580:2d5b:b16d:c55b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2843af9sm11308966a12.38.2025.03.26.11.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:19:21 -0700 (PDT)
Date: Wed, 26 Mar 2025 15:20:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ad7124: Fix 3dB filter frequency reading
Message-ID: <Z-RFaLU5jtOScJiu@debian-BULLSEYE-live-builder-AMD64>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
 <20250317115247.3735016-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317115247.3735016-6-u.kleine-koenig@baylibre.com>

Hello,

On 03/17, Uwe Kleine-König wrote:
> The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
> and for sinc3 the factor is 0.272 according to the data sheets for
> ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).

Potentially dumb question but, how do we get to these factors between ODR and
3dB frequency?
Looking at Table 8, Table 18, Table 28, and 
dividing values from Output Data Rate (SPS) column by respective
values from f3dB (Hz) column gives me 4.3478.
If the zero latency mode SPS values are used as numerator, the result is 1.0869
for most pairs of SPS and f3dB.

> 
> Fixes: cef2760954cf ("iio: adc: ad7124: add 3db filter")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/iio/adc/ad7124.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 3ea81a98e455..7d5d84a07cae 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -301,9 +301,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
>  
>  	switch (st->channels[channel].cfg.filter_type) {
>  	case AD7124_SINC3_FILTER:
> -		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> +		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
>  	case AD7124_SINC4_FILTER:
> -		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
> +		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.47.1
> 
> 

