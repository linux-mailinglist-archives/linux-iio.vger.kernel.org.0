Return-Path: <linux-iio+bounces-19956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A27AC4505
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 23:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F00318983F8
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB08241666;
	Mon, 26 May 2025 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHZRi3yg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608683C465;
	Mon, 26 May 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748296701; cv=none; b=oYy9KZ6RaYbKJflhYF1apmMgRsxzdT4kq7F7OIDSCtIhncQNfSka6uRjVSNhNSTYKWyonQ1dhypNfv1DO4Ti5rFUhyp/niPgm4OdQ5wA+CpB+niBzarB+NL7BMRtEwbrZ6QBFRnMElzGWDb0lVksDkTjfcNIZ4PpuWVev5opuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748296701; c=relaxed/simple;
	bh=xcUSEYoldTD1RC1lJhH+CpwaZzrcOK6quYSEv6cLkW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oITvJfXsGR3YJKgiJ1oIMSNH2ZL3XCSbVP1CKrCwO5CnLP0bAktieHJgpyGeZoavRb/H5Q0nZMP+7+GYWjoSZjvVRGuVITx0o1/U6QZ+VhD2eUdxSmlXrOv+64lcalvb8LLqinf/yuBJoVgTfxeu5qnSUh6xXfNVbeyOtAbwPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHZRi3yg; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52edc9ad68aso757672e0c.0;
        Mon, 26 May 2025 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748296699; x=1748901499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1I+4BH67s9bB6lJRMyuQUMdvU+PZzM1tv6dmdmBbxHY=;
        b=lHZRi3ygw7PSF5m/iSAA6AgXgJ9Jw3QIvN9SAsWLp6cXMzsber5/vjKohLEQntDgFU
         sTZgAb+56a+qC+CMXsyrL/GpK/lYdn230+ZpC8N3LdSEq7WLisVIaMLlHlJ7qcXHNKtm
         MC58V4cuZ1yK83mWyKEQA9Ub+PkcoCvdJ9EK1MHYn1nsIyCClueWa6zvgvLZ5asxv9+4
         WjtBFu02+lIFOF5E+3/sQ1AFueMec1BZtG2GYicHQymHXqK/oIZWVVh0WoXPEf11+aoL
         tRGMrSWB7JDz7ocV9nwuakNWag9s08t806bLwuPl9s7a+Q4rMUaycMg0zuS4CLKODwDh
         Pu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748296699; x=1748901499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1I+4BH67s9bB6lJRMyuQUMdvU+PZzM1tv6dmdmBbxHY=;
        b=Cqtx15e/skdsO3bcni1ImoNX3mxIUViK84MyoAiUdErnDZ/glRj+qQawTO20xYJh1f
         RNiAl8i4iaUwgLiJuTBvUX3TILPq8zOeXlhOPUPzZMAUBF2TcRB/WUEvaMKFMtXJeg2y
         WrEWaY27e3Ph34qTVbbXYwk8ZtHV1EJtBBXkaHq27FATQOU+leTn34y58vOcSvrhNDvd
         CNJ87usQFy2CqeJurBNHlkyujnSc7vAPIab9cHRLXpnUyWhc6dNEN4nd2AK3pnwfwTY7
         KCorEk9Ch5TLgEfJIdT2hXfhmAolc1PxcljVD/WP7wbnTJu989EAKdBxG0rCOM+b8bVg
         vl1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4SlFvsrVkgHOtEdV6BV5k2w28lNXe3P7Ap3Ico/xXyNtzvshqYoL+zJBiHxW5Wa2xmrW5eKnf7y5VqoLX@vger.kernel.org, AJvYcCU7M6VxWj4f07606/FvcP/xf3gV4hGreKkFvkYUa82cuXbn8W8T/Khmyk3XZb8tqouEaoRy8ENK3edEFg==@vger.kernel.org, AJvYcCUV0KJawe2LLPBK3lqxBlNoj27IjGEAx9aoV16gFMDjvlimYFjryfbDzDPcmQoy/yV49RwfbCxjPP/U@vger.kernel.org, AJvYcCVE8tQigmCUKxDohqayeV5pY9hRCtcts32LdeKrqSa8r6k8LqGHZNSN0uawn8Hn/86IHwZEjmO2Ruwy@vger.kernel.org
X-Gm-Message-State: AOJu0YykiWYbLejn2pnwyGA/4NW/wRYTLjyVVYxUwPR9jZlZXn2eGC3P
	Rt524XB3fRh7qVgru2hnY6LyyVmB3HmH6xgVQjVQZaqGrqJd5EiYlzGNKrbZsgtmHUQ=
X-Gm-Gg: ASbGncvRYkzXslXM3vf/D4zQa7Kt3aUe3UBgZTLhSJRjg/crlx+P7s3xosa58w76xvV
	Qxo4G7fyzFX0QkL2JnpM83MmP4p4wiNa6knUhT1E2TZhNoBIW/qqz5dr5/Gb/sPvbT9nRgQFtYq
	T0kPLX1XxpstW+56ECZeqcLlRvfq4iUCLJ3QP3S5i3mlxCadDQQuSL0N6iJdbKgo+ObH7TmP1Nm
	AEkewPelZ3EHX08DPkxL8eAbyvDYKZl/A66c51OXGuO81IfWPLVyrQ0zos92dqtKMYzMj85t2G9
	X5PbhrtNwa2V9JmaNp/vV+SKd2cej0cTs3pojKEIfiCLNQp7fkExXYxx2+g=
X-Google-Smtp-Source: AGHT+IF8kRpMSFR2eFduvuz/OHFjktMA/BDCeXs95tsxes27B9OG84NRncpHF/uZo1yeIYKTNTAqUw==
X-Received: by 2002:a05:6122:8b04:b0:520:997d:d0b4 with SMTP id 71dfb90a1353d-52f2c4c8022mr8154103e0c.4.1748296699064;
        Mon, 26 May 2025 14:58:19 -0700 (PDT)
Received: from localhost ([2804:30c:922:f300:98b4:5361:e180:4387])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-52dbab6d274sm18502645e0c.47.2025.05.26.14.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 14:58:18 -0700 (PDT)
Date: Mon, 26 May 2025 18:59:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <aDTkVFDNYeyIldBs@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
 <20250525111148.4ca96a55@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525111148.4ca96a55@jic23-huawei>

Hi Jonathan,

I'm still working on the changes suggested for this set.
Just to mention, I've updated the dt-binding to declare only channel nodes under
the ADC node.

... 
> > +      adi,sensor-type:
> > +        description: |
> > +          Type of sensor connected to the device. Depending on the sensor type
> > +          (weigh scale, RTD, or thermocouple) the values of sensor-node
> > +          properties have slightly different constraints. This property
> > +          specifies which particular external sensor is connected to the ADC so
> > +          the sensor-node properties can be properly parsed and verified. The
> > +          possible sensor types are:
> > +          0: weigh scale;
> > +          1: RTD;
> > +          2: thermocouple.
> > +        $ref: /schemas/types.yaml#/definitions/uint8
> 
> I think this should be an enum of strings.  That will give us a clean
> way to extend it for other sensor types in future.
Ack

...
> > +
> > +  interrupts:
> > +    maxItems: 1
> 
> What if they are both wired?  At that point shouldn't software
> make up it's mind which to use?

Not sure I understand the concern here. Is 'interrupt-names' property expected
to precede 'interrupts' in dt-doc? For AD4170 and similar parts, the data
ready signal (/RDY) is by default provided on the SDO line after the completion
of a conversion. Alternatively, it can be provided on the DIG_AUX1 pin in
which case the chip disables the RDY function on SDO. So, there can only be one
data ready interrupt enabled at a time. Guess I'll add some description to make
clear only one interrupt can be enabled.

> > +
> > +  interrupt-names:
> > +    description:
> > +      Specify which pin should be configured as Data Ready interrupt.
> > +    enum:
> > +      - sdo
> > +      - dig_aux1
> > +    default: sdo
> > +

Thanks,
Marcelo

