Return-Path: <linux-iio+bounces-22243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F81B19A45
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 04:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E58F189368F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 02:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CC21A94F;
	Mon,  4 Aug 2025 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GteEx7IA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDF1172A;
	Mon,  4 Aug 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275499; cv=none; b=JOG6oUc2XOgq5W8Vjw9OOw4pfcNxA+kWSON2zgp+xBWlwMR3HAoDHJjyXvSXo5uQqF/BcDwEa7vceMxbDRtSaEJQ7S6Cadi73Uv9nI7O8LxFMxpGHRjCbQd2fEj3cCdmw5j/srE8/SNIFOWl1saX2JSLbivwUdI8Ufq9iDaVm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275499; c=relaxed/simple;
	bh=G62P89FawmCnN47hCa8jldhL0S3OaWSBwXXTJ8PVv7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhKOEyq3q6GN1zUp39j+MVvvqSUeb7AMNxXsZiusudXXmviM2HOIZ5nZfNEM2p2cin5o6jrDapDa0R0zhLijCabTZHg4C5MFi2eq0JIf83G/8RYQI/jmijElmgZpei7hMXbjGMib2YSogWCYuM4Mou5+A9ZmlKDo8B8WWmDaszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GteEx7IA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so2976775a91.3;
        Sun, 03 Aug 2025 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754275498; x=1754880298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts1Kk+6X71kcfI8+jHJzblD/i7r8lLiRswaPzZwm3pA=;
        b=GteEx7IA0SZVOEotzYQsIaGcrKZ7UyxKArZVHSj2yYDMv1Z+Dgx/vWXGQu4HZpF+bV
         HXuqlirS1Fv0Q2rlZuSoq5EuLrT1AkHvDCoJFH7vwYzLgo/lP+sdy1uqFBJY9f3aQPXe
         EAAKz7bAeh234EDZpWOT68PKGqzvfwrMD1x6PwrMxNsyEh4ZMTlfUcCgEKrnIyZEG8AK
         7Mh3JeEUClcQMUEyR2044NiesBgPorzQUW9OxLWNKK/Yew30848JlGtxtdtz3xOesgcF
         AIrA2LjbpxiXG1K6dCrBvdbx561WUL5NRpoaAaJvP40PbFQeX9PHSt3VwAjtcJmNxGLf
         GWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754275498; x=1754880298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts1Kk+6X71kcfI8+jHJzblD/i7r8lLiRswaPzZwm3pA=;
        b=OkxBQTGIjlVqW5oC6jAhWqhjvaJD+G7ylafPzetsI+PqwX15qBqcLS2poHzZM9+sM+
         ciUfDIrfPRnVXigGDxhpPTJXGGedrPUOIgUmPUsNnIuHmXPV1ruPE3E37TVRrTaqR2QG
         Bv2jvqkXW3Y0bqS1H+gcW8dOWQ6wBJnnaEH2fNqwAPwG9XPTI0bpbFBVzdNtrY1WzwP2
         uXdDvt39qHq90uc0b2DRGacp8fbdW43A9MhNUUQoaSlsCfa3xM+nLnYdhpzgrBIls8a2
         J8dLpQ+S8u3kDMj+m5BD0zjpQfAQ2tFnXkhsf0tSeHK4lhzBQ80c+KiYYYbubXNdjFvD
         s13w==
X-Forwarded-Encrypted: i=1; AJvYcCVkKIaSelpK+71H7NOgQqjhFbU87ewk5D4LpYW9D6MMLNt33FAGcDaYEn+myCw01IHESIyVVvZhgqjh@vger.kernel.org, AJvYcCVq6ffme+ATkRP8vm8jIJfaSvEz9+kHMtnJ+8Ndumdf62UFP35dip0qHn3bBQqYm9gXgp7eWsMNAc+O6uAi@vger.kernel.org, AJvYcCXsQXOEHls5/C0LN7pyuuOAtPmiI0Fdqe2Y8uam9W7Z+y9xd2PuIpFPzLOhyPVpd7mM2FSY2cug/b4V@vger.kernel.org
X-Gm-Message-State: AOJu0YycI/1r0j7aSnc3fzKd93CigBxSKdfaGN5XTBpUBAkD9/YL4e67
	vp0zsCc6W46zuA2WQbvwWgco5ZlYQklP9c9jrRZBI4iRWp2hFBnUCdeRPPEBV+zY
X-Gm-Gg: ASbGncvgHAPOogWZlwIaVthoMcBh4mIHwfIagVCLJZkBHiCf6EiTlj5cRpBNrBo7CLU
	n+kUHAaB/4Tyr3V8NlJc5MwqfHpc0ldFJLcbYjWw53vk/EpV7jmCb5QR7UKryo6kTVOC25X+4rr
	lOPNjUlaVRqDZJFJODaPq4kIVW9EZPn4cBv6nE3nHMwlk1DvkEAiG4cJjPV8SCr/IFTcYWCl/IT
	UYdmbt12ZHsZGRpzuGXz41bDnujd/PRN1cnkmGyzZ+VcqV7pe1VBnZ3Y5oKaC6/l30s/ZYCLeUL
	8JCxxo/k5CjePxj362vv4zVWKenxT15fv1ZaEU1x2AlNlj+J6/TU3HlouFQxgDv3PB9MVuvBnI+
	sxk4lKpjrhpmLFJ7Oh3sGZlc=
X-Google-Smtp-Source: AGHT+IEPb/k1lJoJ0bhUk/GP/j1jZ7+km9pMpZn35pHf4rgBRxRP2cUg8VJNDgeEKE6RyQP/03OV4w==
X-Received: by 2002:a17:90b:4c4d:b0:321:43b2:4743 with SMTP id 98e67ed59e1d1-32143b248demr273058a91.23.1754275497712;
        Sun, 03 Aug 2025 19:44:57 -0700 (PDT)
Received: from dixit ([2401:4900:1c43:eb01:acfe:5fdc:edb4:dbec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb1133fsm8063851a12.56.2025.08.03.19.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 19:44:57 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:14:48 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
Message-ID: <aJAeoI4Iz_U06Wmo@dixit>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com>
 <fc15279a-bf3e-4500-8dfc-651e6e2431d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc15279a-bf3e-4500-8dfc-651e6e2431d9@kernel.org>

On Sat, Aug 02, 2025 at 09:45:29AM +0200, Krzysztof Kozlowski wrote:
> On 02/08/2025 08:44, Dixit Parmar wrote:
> > Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> > controlled by I2C interface. Main applications includes joysticks, control
> > elements (white goods, multifunction knops), or electric meters (anti-
> > tampering).
> > Drop duplicated entry for infineon,tlv493d from trivial-devices.yaml as
> > its documented in infineon,tlv493d.yaml now.
> > 
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> > ---
> >  .../iio/magnetometer/infineon,tlv493d.yaml         | 45 ++++++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml       |  2 -
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> > new file mode 100644
> > index 000000000000..ebcf29067a16
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> 
> 
> Filename should match compatible. Otherwise a1b6 is just confusing.
>
Idea behind having a1b6 is that the TLV493D is sensor series and this
a1b6 is one of the models. As this driver is intended, developed and
validated on a1b6 I kept it in compatible, though the file name contains
only the sensor series. In my undertanding, this same file & driver can
be reused for other drivers from same family with new compatible fields.
Does that make sense?
> Best regards,
> Krzysztof

