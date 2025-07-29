Return-Path: <linux-iio+bounces-22123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96BB146DE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 05:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A41541732
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073321E08B;
	Tue, 29 Jul 2025 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGUqyt9M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AC286A9;
	Tue, 29 Jul 2025 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753759729; cv=none; b=KBA3XAiJGpvOMS1D3Iq/ZRAVKZidy8pomBTTnrlIwZQpJvt6KkJYAAEGcu+CZsHlbOpl4zCEqSd8zlLWa5aiTVVWI0+EXs3nURXfQPKKSn2XGE4rAQq83uQnMDmUVLfMWG8LfORDcLm6KIYerFBh+M/0k/3lQIm+BjBlIu417ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753759729; c=relaxed/simple;
	bh=Vc3F7fDUjuWyPhA8XgrLeIZNqq3fcTYNnOGGK8lz3ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0ljsMjOSIGP4lBzgaY1LJN0PKr15WhGyHDRMIvW6gIZ59VOfEE7DquvdlKAtlINBzeVxOsSVguxiZqpzqmxTUOG5f6lJxpzBzjpWA6fX5PICosmSGg02W79zJq0Y9YhODUe0XSn6yd9MOdEBJDVr8knw0C/Gr9DTVdEAtE1F10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGUqyt9M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2400f746440so17881145ad.2;
        Mon, 28 Jul 2025 20:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753759727; x=1754364527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWkHODXRSaBpp1kJFSHZeySC9LLfUVXK4KXQxUtXKco=;
        b=MGUqyt9M78PsMfc717a7IpFMMWat++IXzlEu4C3fZZEZwryC/Jkllb0eJwCMA1wcB2
         QaNdq1ifgAw5fiNOYIrX+hs3dAuR/S0YLh7AH+GXfnEmS9V2BN6R4Zl1Nq8pPfiVWera
         rm4fyUpB5ueNUQN5/+LyPC6W8tXJdHbJsXUvSPevhPPNZHfJgfXR9zmPz2FDIC0RIbbC
         I9K/mqpGiDbTITQQqLYvMNkDn93XZAQVWMmSDaddQURIO1lYOpj2oNWhXECo5G/+wzkY
         ZQ17wFfXartMzo5FO5VEkGRTGHQSU1pZcNjBUVtdFKerrEVkapoqrfR1cmFMGpFNJmtX
         KZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753759727; x=1754364527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWkHODXRSaBpp1kJFSHZeySC9LLfUVXK4KXQxUtXKco=;
        b=eA2fprInun2DOY2Jd0N+riVOdBsuCEorpDiZkGWn79f2/PvKyLMNa19E9+I3TxXV0R
         FnkYKcJQG9MarTHIIzCuXQjkBPBbSRbAr7243UA05Yo8SsOhS2Xn/x1806caAidpOqkw
         mGwaWTPSgz8T5dv2t8KR7VIRa4RjzSy8c56gd5Jdx1BsLJa+MMGanGkww9l/Xo7ake1c
         Dbpc1zixAoD6AnXqvLijeP+sjW2RjWI3ArDl7WwdAZ8wsFIOI6yI0QW5I4uQ87UT8C9m
         gn/hS0XQVBL3bjRnqfXWVOb1Evg11l0KeFaMBDooXbQRsYDF8OIsIGRXgGG6Ux+V2SIK
         ffyg==
X-Forwarded-Encrypted: i=1; AJvYcCVP98ez1m3SkeQHnqXNXHpKxeEOTPvElAb15P3eAvVBqpcUrF3B1EBFuVlxP8Pzi3PEr/A/2BlFr/Qa@vger.kernel.org, AJvYcCVaSBv72SjLJt2QZcJQO1TVH9ZsMDMbGu7R5KjIUNTdXrl1zY7XTVzvrzVCY5XtD8LkHnPdhGdleiV/@vger.kernel.org, AJvYcCVwxV6K4Lrb8TckQn7ZpyTN/eBFzVF4gWBYpqC4/npvibmEOe9vHjux0JfzlYvS5KIU+rMPdjJ2hen3Eb6f@vger.kernel.org
X-Gm-Message-State: AOJu0YzIF4pktZGaLtTNTItG6PYK+SoJY9Gszx7jvAs8srsasdfx251J
	O0OPKDzGsbN/oMAo3lwBjQs98rNCT7dvY9ZIhKcHrmAhbFRnVKGdJTDu
X-Gm-Gg: ASbGncvTBn3nKJOvdxHFs8UHtccq/zetI6/oe6yGsqmv52pSi80N9kgD9n9ekmxVJ2u
	j4WTXOyna2rK+qfBSCqm/QwEWmskym6FVFza4LkK1yKa6UgmFsaQTb3/oI+K+Yi1hQKKeetHhES
	eqbVfVT7X2eqEQrNyr/SZtoivtLgeP9iMtZ1jpkQC5mqGEMw8+99hwdtx+brT7JPE1FHzEUy19l
	UI+AHC1D7bRPHseU5XCVeouQUBUwshKJhvGOSwhetpnLKQqhqPgT3++sh9c4yOu3LEYpUDXvjdS
	rYgDXHPRoRwXBTawpB5UQjMUdPiPq5N4/cqheUE0HmyiWUh6dvpsol2E+Rm6ydepRZMZ+eOqp/L
	Cvq1efIFwTI2m+k7ypIoBL2CSFBC2kqWM
X-Google-Smtp-Source: AGHT+IEhpVDiU2dSTjW3VtpkX52jrLcBwf8jQCpX7NcFEJMWBMCgOxfH8/cTIT8xJwSE9sKYI5CoqA==
X-Received: by 2002:a17:903:2ac3:b0:235:15f3:ef16 with SMTP id d9443c01a7336-23fb2ffc4a3mr189077795ad.13.1753759727338;
        Mon, 28 Jul 2025 20:28:47 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:9464:4ee2:7e58:1508:18c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6b3a62sm5721966a12.55.2025.07.28.20.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:28:46 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:58:37 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <aIg_5S_Wq6jmhUKV@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <cc69ced8-7a20-49a5-a550-64050cf04e7f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc69ced8-7a20-49a5-a550-64050cf04e7f@wanadoo.fr>

On Sun, Jul 27, 2025 at 12:03:59AM +0200, Christophe JAILLET wrote:
> Le 26/07/2025 à 11:37, Dixit Parmar a écrit :
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> 
> Hi,
> 
> > +	ret = read_poll_timeout(regmap_bulk_read, err, err ||
> > +			FIELD_GET(TLV493D_VAL_CHANNEL, buff[TLV493D_RD_REG_TEMP]) == 0,
> > +			mode->sleep_us, (3 * mode->sleep_us), false, data->map, TLV493D_RD_REG_BX,
> > +			buff, ARRAY_SIZE(buff));
> > +	if (ret) {
> > +		dev_err(data->dev, "read poll timeout, error:%d", ret);
> 
> Nitpick: missing trailing \n
>
Ack.
> > +		goto out;
> > +	}
> > +	if (err) {
> > +		dev_err(data->dev, "read data failed, error:%d\n", ret);
> > +		ret = err;
> > +		goto out;
> > +	}
> 
> ...
> 
> > +	ret = tlv493d_init(data);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to initialized\n");
> 
> Nitpick: to initialize (without a d)
> 
Ack.
> > +
> > +	indio_dev->info = &tlv493d_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> 
> ...
> 
> CJ

