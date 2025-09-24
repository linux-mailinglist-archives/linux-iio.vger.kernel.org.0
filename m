Return-Path: <linux-iio+bounces-24406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136AB99F49
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 15:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B59328556
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9A1B4138;
	Wed, 24 Sep 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq6Ho5u8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C0288D2
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718825; cv=none; b=BvEvJiZRjl158iapbOPVZKcgQ7JGeLgutddWzwo0Q9T+cQG5UBE9Nzu86cptiNlfB/ECq1QQEEgXgmyEDx2lqq+H7vvgMiMha9oe0aW8nMajIzcqMzm5YDe4daNfQGnLAMpCKQAIGef51mcs9afogZINBF3s2ceDkJYWSJ5jZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718825; c=relaxed/simple;
	bh=7eCaqspkeWI4vNVpqbFq/9go1dzDlks7hS30C3QwfMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwyHnRdLqGoTynxzsWLrbs3DJD7abfGWkU2gdpEbZGIkZe1zPwm9OMjLjlqaMGq4QPH5XXMzvIBS5FuOm/fIxfSSqjmfjeGJbhRo0WTfI7gNa3LlvTAdlFdBfuP6XK0oOABkVUBAiD9BQquVba6njbPJdHVpm8Sohrr5MjTzAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq6Ho5u8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-279e2554c8fso34802985ad.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758718822; x=1759323622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOAtSuySMHUL7Eirjuaudouhdhjdq1cQExPV8WIdTNU=;
        b=Eq6Ho5u876bbjMb8q3Xdwoenoe9IkuY3NP+V9ZEMJszrsHT5VS6WQu7JxYkU5B6KCC
         7KXdAKxL5gjoR25g30REhfMv3eYztlZyFt9EuBnsqk+koKK3RrwTSLRJPUUVnkBhz5lI
         cWiYgdfZllE95u3OEfgU6ejNu37OWAiaCmcVml4Rd/WTQcVfNR5yerCA9/DipCKGZ/dG
         +MMboyRKviDABhVoxv39cEhr3JlHgMATcWlhbzukNpRp/sWf+VZUUjaPmbJbetiJW9eS
         kEXHozpX6JdIlsPor9vkJOMnJ/XEIcUcucOPVmc0mcA/qO+ebc2ndU1Ds4OQ6meBI8wA
         5JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718822; x=1759323622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOAtSuySMHUL7Eirjuaudouhdhjdq1cQExPV8WIdTNU=;
        b=t2+9XOwhO7Vo3W7bmS//lvGFSTaWMO7Jyv0T18Ut4riDndnFF22l3pUOGFqsGMvu4X
         /RjSQ0abRJUD90BATaY3UvBuZsVSAYiO0tY5cmOK99eHaIebJR3/W3bKrjtgn/zm0nHn
         2S44INzmfH1g+cnx+gI9J1zsJ5dL+DV8oBqkOPoA+RtCpf9hFMS2eEonAHbkJZvHAiHr
         G8Br0BlvKxdNBUwoXjUQUC7OgsWu2CS2CqwafzndaLMvsWYaZASW8LDRqJ7VKmFS+Fkt
         lg1GIOSXT9ecsBQJ+r+dutHPRitB1Tr3j1QIVuNad65EoOGbI3P+h3AavwpOncsFBFr2
         T1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUo1CCFIrjuDuIofKEtrz0fYGrFC7NWQVlwVyg/h0gcYyftxPrXAQdQgoVr/mk3PBjcXBw0axDTAeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VygKlsa2g60GDcmYoxjeiaE4/HUUy+nchatde9EGg67PpI5f
	K5P2L9crrtd/oX64N1d4yVU0cmN+hUuEPLmOY95a208pGeVSu3FJsxjh
X-Gm-Gg: ASbGncv/XedhbO/OOWZh7M7nqtWy7lyZkDoWMKBEC6pGCJu17TsmUg5Oo4LSoplEXUs
	qCSL4Njc2ulYi7y1Ogl3l0J4qjtc7LHnmVsWms1OVLPDEdzN86w7773mE2l66y33GCujEXvmGEz
	+F5NVWBcUUks6bJ4JE4p/zb+w6UrH4liih2qvQzndD8+fN53o6bFZIt6AY6RKDnZEILtxscSmjO
	1EmC1ZMWZ6ad8VovtH9gHvODxNJ26C4y4bUjDnGMpqahewib8jzOLVW9x6E37p5RmgdB3HpJJAP
	SHi0h23iKr8I0Hr6w3aI7TmaKe+dnFYSiddQQoWaFD18fG9fMJ/j2PwL19gAwGm7ihOPCTl4ibj
	LxNOrcw3Z4Z46pQvYvDnz+ZtkCXQ5pqk=
X-Google-Smtp-Source: AGHT+IEz/eHDv8jJIje+aHMRfCzivvT3GIspIPDR9CA9OdPXfD3ArbyXDsN3eyUmiOe/qYSeJv+Ycg==
X-Received: by 2002:a17:903:1212:b0:269:8d16:42d1 with SMTP id d9443c01a7336-27cc91e1fafmr67773455ad.50.1758718821220;
        Wed, 24 Sep 2025 06:00:21 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3341bdb4cc8sm2383392a91.15.2025.09.24.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:00:20 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:01:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
Message-ID: <aNPrlIYGrB8oSsfL@debian-BULLSEYE-live-builder-AMD64>
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>

Hi,

On 09/23, David Lechner wrote:
> Fix temperature channel not working due to gain and offset not being
> initialized. This was causing the raw temperature readings to be always
> 8388608 (0x800000).

Would
'Fix temperature channel not working due to gain and offset not being
initialized to their default values.'
be a more accurate description?


> 
> To fix it, we just make sure the gain and offset values are set to the
> default values and still return early without doing an internal
> calibration.
> 
> While here, add a comment explaining why we don't bother calibrating
> the temperature channel.
> 
> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
...
>  	for (i = 0; i < st->num_channels; i++) {
> -
> -		if (indio_dev->channels[i].type != IIO_VOLTAGE)
> -			continue;
> -
>  		/*
>  		 * For calibration the OFFSET register should hold its reset default
>  		 * value. For the GAIN register there is no such requirement but
> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>  		st->channels[i].cfg.calibration_offset = 0x800000;
>  		st->channels[i].cfg.calibration_gain = st->gain_default;
>  
> +		/*
> +		 * Only the main voltage input channels are important enough
> +		 * to be automatically calibrated here.
I think it would be more accurate to just say the offset and callibscale
for temperature channel need to be at default values for the data sheet's
equation for the temperature sensor to be accurate.


> +		 */
> +		if (indio_dev->channels[i].type != IIO_VOLTAGE)
> +			continue;
> +
>  		/*
>  		 * Full-scale calibration isn't supported at gain 1, so skip in
>  		 * that case. Note that untypically full-scale calibration has

Maybe, instead of moving the 'if(... IIO_VOLTAGE)' check, this could alternatively
be set when initializing the temperature channel at ad7124_parse_channel_config().

 	if (num_channels < AD7124_MAX_CHANNELS) {
 		st->channels[num_channels] = (struct ad7124_channel) {
 			.nr = num_channels,
 			.ain = FIELD_PREP(AD7124_CHANNEL_AINP, AD7124_CHANNEL_AINx_TEMPSENSOR) |
 				FIELD_PREP(AD7124_CHANNEL_AINM, AD7124_CHANNEL_AINx_AVSS),
 			.cfg = {
 				.bipolar = true,
+				.calibration_offset = 0x800000,
+				.calibration_gain = st->gain_default,
 			},
 		};
 
 		chan[num_channels] = (struct iio_chan_spec) {
 			.type = IIO_TEMP,


Nevertheless, the current fix looks good to me as it is, so
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> 
> ---
> base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
> change-id: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 
> 

