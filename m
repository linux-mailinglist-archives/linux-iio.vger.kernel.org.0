Return-Path: <linux-iio+bounces-17876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4313A82732
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A328F17DBE4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913C265618;
	Wed,  9 Apr 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZUbyl1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561915530C;
	Wed,  9 Apr 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207707; cv=none; b=q1NsE6j+zjsghs5+7Gmp45zO8A+7MqVAqCtv2f4+6EsUPgV6aK1d4TYAX9hjmHP/Mbqe2sJ/XEhYLshS8Sdo445Umst6PYD+ueE0ORn1sVIURSyAfMfuxfFr7AiX027Vw6l57VQ3/B7VyBIh4PXx/J5m01Nx6mTZADuuMrDSFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207707; c=relaxed/simple;
	bh=rIHKh/mKxsxJnpgNyrdNVBlS2Bla89rn1+FP7nB0RD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFGnaudZ0wO2W+w88DRBixWlGslnosUdXlB4Q05rXCJQxJ2kkuswHBDqm4Tie5vR5XbomqOmkOeqUbki1sgau4Z7+n9L4GQZsmXJdlAc/l06CvJQp6tKj3sn2LK5KuSV1KHo9jQj3TMHC8npbzfXW5FfJDzeggHIGwHCF4tvEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZUbyl1x; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso63522245e9.1;
        Wed, 09 Apr 2025 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207704; x=1744812504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rIHKh/mKxsxJnpgNyrdNVBlS2Bla89rn1+FP7nB0RD4=;
        b=AZUbyl1xxZKNLlUvnxkoFGN8BfW6LLAAVMdqjon6xJM1n+xp5MGX+2gmrvqwBdiagL
         YqcDL1IpMrx6CxNJgxsG1gh4osyMA+LH9RWKMH1uBB5h5qyfaibcgmqBzhDedduOIoMI
         RLxP2F1hlAzDQOHLpfj+P1BusPQArSmai1W4n1GMbWa1SdheokIvZmAjhlOhTomtc4sG
         eIGVN+Ajl4RbNgqUK3bYh6obo0lq7mPPw9bqCSLrBhNUiiCNrdsgCutLThLT/vlxrGnF
         ojh/GFdF7SGnqbHaScZM6f721XCRMRb0uxKoFaNeD6ogX7Ei2QzB5YmDBt/chgINhgcE
         1h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207704; x=1744812504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIHKh/mKxsxJnpgNyrdNVBlS2Bla89rn1+FP7nB0RD4=;
        b=teFx2gtX5pI41AIb8sMnob+KMQmsm8nX2Ca8wHPAmbgCBIY/PfmFCfOOROsIaKloy5
         5ApfXedvBWEQPu53ktjAxDyptICvU28dAgMI2oxcXgdNxXOs/xMXPj83qA5ScUS0qwLm
         kX9B8VG+0Vl5St4smfYN11EOuKNSoVs+Br/6Pn8JbdOTmUC6qU28hLYiL7E6RcxCPzf0
         r+VpWbVqKEoM44pbGT5MPX86KcGRvEkSxXNQ5mQJsBJ0+9kPKz7KIR/n5urOKGqJ8jm1
         MUzVhkPgepoxC51DG+jT2CO6jnr979/Q0pZE/J7NnQ91lJCpmbXo4+RyelEtXVXv8Na5
         jXgw==
X-Forwarded-Encrypted: i=1; AJvYcCUwriqWBQhxh5/eqJMaNPC/RWa6zsdroedc6hiyR1Zi4Z256PBjl/FScRnPP/eRAhJ+4WZkgi5mVU9P@vger.kernel.org, AJvYcCXXAJ/a+v01LCngk4Swf2llCdSmvE0zFyJkML6zJfLG3L8ltJjamwhvUEe1/u50rdD+7l8HKly3jZDCsMq/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sVee9tF9YMP32liexncvAw/zoVbXOzzGg3ILDIC59E0JX012
	mSGSGmMAboCTDCR1T1+wCnmtFJPorOAxuF5ZTeBFSK56g19Mo239
X-Gm-Gg: ASbGncuE1lTuX7wu6G/mfsAjATT6PCbJDMOmxKCcCBWgSiXqt1rvh7mbicCZPwRuIO7
	mymThUo9rmTzhtjHIbOjPiU07jLVx/2kClkHTr+L/UVKscYpdewjJCVDxx0GcjyjP1CKoPlDm+o
	B2egfZ0yz0rYe/YRj8fZVW2e2+8PWW1jPem0/0D3cN4bZiknCylyvuMYLdEgqHeV532kY+MSu4j
	Vkk2+kaWzBs40Wi/Djirn33MyJ/JeRiuPBvs3mU3C7iSSJCWv9uvqZfFmGkZMm6L5clUdUGUjeE
	/juO15YS8fIz/0GyERUcxNbEtwDwMRaEgU33CoiTlWGw2wZwiLAjiPx6PjiR5tdDORHOn4HW1bQ
	uYUYYP/uWq0pM
X-Google-Smtp-Source: AGHT+IHZM3GjBdR+VWRxB6LzvXt749A9KyeZWvexdiGbDsu9DpF/8Q0G/EfwUOqiKkNDA2XYXLcHOw==
X-Received: by 2002:a05:600c:580f:b0:43c:f575:e305 with SMTP id 5b1f17b1804b1-43f203273c9mr17560175e9.8.1744207704289;
        Wed, 09 Apr 2025 07:08:24 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm17231585e9.23.2025.04.09.07.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:08:23 -0700 (PDT)
Message-ID: <a160ad15944f28159a0d1145cdf4584fb2972d6d.camel@gmail.com>
Subject: Re: [PATCH v2 0/7] iio: convert GPIO chips to using new value
 setters
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Linus Walleij	
 <linus.walleij@linaro.org>, Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Wed, 09 Apr 2025 15:08:24 +0100
In-Reply-To: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
References: <20250409-gpiochip-set-rv-iio-v2-0-4b36428f39cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 10:40 +0200, Bartosz Golaszewski wrote:
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. We're in the process of
> converting all GPIO drivers to using the new API. This series converts
> all the IIO GPIO controllers and also contains some additional
> refactoring patches for ad5592r in preparation for the conversion.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v2:
> - move devm_mutex_init() earlier in probe() to avoid using a goto
> - rework returning on error in ad5592r_set_channel_modes(): return
> =C2=A0 immediately instead of saving the return value and going to the bo=
ttom
> =C2=A0 of the function
> - use scoped_guard() in one more place to fix a build warning reported
> =C2=A0 by the build bot
> - Link to v1:
> https://lore.kernel.org/r/20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@=
linaro.org
>=20
> ---
> Bartosz Golaszewski (7):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5592r: destroy mutexes in deta=
ch paths
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5592r: use lock guards
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5592r: use new GPIO line value=
 setter callbacks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-ads7950: use new GPIO line va=
lue setter callbacks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4130: use new GPIO line value =
setter callbacks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: addac: ad74413r: use new GPIO line va=
lue setter callbacks
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: addac: ad74115: use new GPIO line val=
ue setter callbacks
>=20
> =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 10 +--
> =C2=A0drivers/iio/adc/ti-ads7950.c=C2=A0=C2=A0 |=C2=A0 17 +++--
> =C2=A0drivers/iio/addac/ad74115.c=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +++--
> =C2=A0drivers/iio/addac/ad74413r.c=C2=A0=C2=A0 |=C2=A0 28 ++++----
> =C2=A0drivers/iio/dac/ad5592r-base.c | 147 ++++++++++++++++++------------=
----------
> -
> =C2=A05 files changed, 103 insertions(+), 117 deletions(-)
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250401-gpiochip-set-rv-iio-b064ce43791d
>=20
> Best regards,

