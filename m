Return-Path: <linux-iio+bounces-17182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C909A6C2FC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8468C480BDE
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 19:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242E22E3E2;
	Fri, 21 Mar 2025 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA5NWrBy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F7F22D4F1;
	Fri, 21 Mar 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583995; cv=none; b=Wb5Q5ZREHiPCvjE2Z0Xx8l3PW43fgZ0haQC3uORjCCFzlZLZSMrpmQYe2YvvELJRycYbbFRct/3r1WVYa5nIGz4vPq8fY86VYaYIl3CpSoP4rFlqLSzxXzeLNGYiABtPA6KSABi3CFHwZ/E2Vt2WN2zVXqLFA6GOaw0BqbOr0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583995; c=relaxed/simple;
	bh=B+aD9dvfpVDv7F9UkKnouTo4wvTO8SyZ4HvL6VdDMqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgrvZp1rOEaDDO+rUnhwER08XD2oVDdUnPFljxBF0fNyd63vkq8OfFi/fZWy96E9shDwdA2Tx9gAHs3q1YRxUf6/hxcqpRtSZgG/PqUu+dTfRYBYywC396lqD1jgr+Kk+upO1uoi2ZvV1P4UNzb+1hPqflLO2ZXYb1JtJv683dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA5NWrBy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso17648715ad.2;
        Fri, 21 Mar 2025 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742583993; x=1743188793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSQFBrcYGnUp+r+VXHpl/J3fI5NrdgINu2gTCJ+GUK8=;
        b=OA5NWrByr8EdZq0LnvIMN7Ow+05Ht2O7juPvAgpDuRiziptqHgp1CMSzyg9xF5GvjO
         8xt0KAyQt+14Ao5XGUTc+YXpjrUkh4WVjEmbqm6X99vQ1MgLnECJX/czujdRK4wBHFSe
         Vpx749XFQicai2HrIuQvmgZ5SeOf6Lk7XEG/kLqdUaP+ErOXHTKhOUw7N1IyRKzLoFnS
         KVJWn2EAygQfqChHJqiSk1kHzlggneAo2xkBXcitIuGcIb+HRIUmZvxBqwKoTLJFkQ8M
         DkEGqWCWS0RUfKTOd7ezQqyCCrT8dzSAZKSbWkIh64WCm4MhB7gZB6/sYcd3PnfK3ZxN
         Wngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583993; x=1743188793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSQFBrcYGnUp+r+VXHpl/J3fI5NrdgINu2gTCJ+GUK8=;
        b=SPWx7/6uDaXqPkJrRXfaavDb//Egf5IBUqorBcfOqUkARGO1O3nr3tgBBwZWLv3jxT
         LeumDuh0djiDqLcuLoC63ePQ0c+LcbAFC1F4fH226T+GWwBcM6Uy4BDRYY/t/5x0xjBr
         dBP+sg1HS/VfBzQYzKAqeSON0wngSVpY4Vp5Z/i4urwW2oV7w8PJPgtN9MauT/n92VYn
         ieHySZmKsufMNP2J+mJGxtRe11Y8KRPOgstE1/6G5lz7j6qWTN508vkUMlbtzMFTmw7n
         SMujQX7xLJF6EqvA1u21isEe5ukCPZUKNilydnycFPYyBaNHv8273P5aVLrz7GXg6njo
         xySg==
X-Forwarded-Encrypted: i=1; AJvYcCUkcLdLNLfZHv5xiUfzJCcTLvZDVcbgxV1moHLyeKyDG/Msv3xd3yBJnOp+Xzy10SCrvAt+uGjhcAo=@vger.kernel.org, AJvYcCVR1JuJVtPRPKckqyZs9JQ90NyaDo2Q7bYJ2HR1o7km1ZyZ/3UeKEgFkzTmpCSbZkYxyuTkRoLIinKG@vger.kernel.org, AJvYcCWlY4AIXOOF5GLD8w4YWGSH8HZGRKqX94HNRBrnc1CPUxQqle0Stbyx4AHMcEN9NKRZ6cqoscLQzDXwsW55@vger.kernel.org
X-Gm-Message-State: AOJu0YxkML7zy11COlRoHuWzRPEweWhDXfyqovo50SYAaVJnUwrFEQNt
	zi/EqHxgMc5YU+vX7DK1DOc2DvQTFb5fHFSz05PkHW6Y1bzHifzh
X-Gm-Gg: ASbGnctD1nRg7AH5/0yHVyA9pgMeWtqSKPMBXVyS/wwC9w2APqlV1LBD70X/sIbVeUg
	KJ2cb0yt/Ra1D7NuazWr+jaTdMhqhBUQKpMyAL3jlTZdcJB2EeBqF9DxqU+lUI2he7rUKkPVUEj
	Ng4bc6w5/RxBGjYQ9Gocs+3baazGo+QWlDEgqcJtMTyTgqSMQmY9BKg6ej0cChA33iYTKOW8Pjb
	3I0Q9S/UpjxShnXEy7x0FY1AxKfBmAQHlveYV6JH7eRw1EvbLz93xifFoSWY2Kpc2EWN2vANntY
	qWOqQWmn/ERxf2uXZz4HWjVnzJatY1W68Km5bJ8+p/gAAKZTDFRmDg==
X-Google-Smtp-Source: AGHT+IHhIKo6xXDfS3u4KCV16vBsyMkhHcyd/L8JMgusFH8Rv4KN00NY/E49L7DMWZ0wMIjy/M1cWw==
X-Received: by 2002:a05:6a21:38c:b0:1f5:8a69:f41b with SMTP id adf61e73a8af0-1fe43435b0bmr8791567637.37.1742583992486;
        Fri, 21 Mar 2025 12:06:32 -0700 (PDT)
Received: from localhost ([2804:30c:b31:2d00:277c:5cbe:7f44:752b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905fd57d6sm2458985b3a.58.2025.03.21.12.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:06:31 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:07:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	corbet@lwn.net
Subject: Re: [PATCH v2 1/5] iio: adc: ad400: Set transfer bits_per_word to
 have data in CPU endianness
Message-ID: <Z92480lC8WdgyuiT@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <930560a0d0ca7af597d4ad901422bc9ba3fc6a79.1742394806.git.marcelo.schmitt@analog.com>
 <4fb5329f-be34-4d98-b34e-2da4e035f44c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb5329f-be34-4d98-b34e-2da4e035f44c@baylibre.com>

On 03/20, David Lechner wrote:
> On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> > When SPI `bits_per_word` is not set, SPI transfers default 8-bit word size
> > and ADC data gets stored in big-endian format in memory. Because of that,
> > the IIO driver requests ADC data to be rearranged from BE to CPU
> > endianness. However, with `bits_per_word` set to the number of ADC
> > precision bits, transfers use larger word sizes that get stored in
> > 'in-memory wordsizes' and can be read in CPU endianness.
> > 
> > Use proper `bits_per_word` size for SPI transfers thus saving the driver
> > from requesting endianness conversions. With that, shifting the buffer
> > data is also no longer needed. This change has no impact on IIO device
> > functionality.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
> This is a breaking change. Some SPI controllers, like RPi can only do 8-bit
> transfers, so this driver would stop working on those platforms. Also, if
> anyone made software already that depended on the big-endian ordering without
> checking the scan_type attribute, it would break that software.

Hmm, if user space software doesn't check
deviceX/scan_elements/in_<channel_type>_type, nor
deviceX/bufferY/in_<channel_type>Y_type, then I'd say that's already
somewhat broken since at least buffer scan_element type attributes are documented
https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio?h=testing#n1470.

Anyway, this patch it indeed broke RPi support so I'll revert buffer endianness
and SPI transfer bits_per_word configurations the way it was in v1.

Adding possible failure due to controller not supporting specific bits_per_word
size to my list of peculiarities related to that field.

> 
> I would leave this as-is (drop this patch) and just make it:
> 
> 	.endianness = _offl ? IIO_CPU : IIO_BE,
> 
> in the next patch.

