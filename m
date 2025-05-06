Return-Path: <linux-iio+bounces-19183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFFAAABC52
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 10:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875465069F3
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 08:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6AD23D2AC;
	Tue,  6 May 2025 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0RxVZnT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702C33FD;
	Tue,  6 May 2025 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517931; cv=none; b=GG0bZRqhLQqQ+2He+mks1v1SJdhm5jj0NyZ4aClEJlK0bm63OujUeIDmGOA4+xL3T0jldIsIGNzTLmTaD6apR3hltsHod76aokupNHxnmfiuEEEVPvgCJ+/BKplRAPt+EdRQSXzYy4SyG1qO/mDYzuWHVqEFq9oUQnP2SnKUf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517931; c=relaxed/simple;
	bh=0+uO/XoYIQCc8Dgm6gCzikikLCGOEjO0kaq/d1A05mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIHIQov5zZUmKhwZwFGcugk7+Ig6FFQF74w1qDM3n9N6cBGRimDfMKm7RaLBpyk1D8a0G8hC7OL4K1ti/x6CZM0LqwKRv4/fYPEzt/Dadq2ReYt7LHDOOOkB8k1/D20y3ww1A7rWlv514PkEVASMMMfsd0EgTsoQRE8NiZykDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0RxVZnT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso7338517a12.1;
        Tue, 06 May 2025 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746517928; x=1747122728; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILaPhC29TjZEHYEs2jF6zz89xMd5BTo40WxWLbWUDSQ=;
        b=g0RxVZnTZS0GMvtGQAMbfIQ/XYaXTs49/GaKXtVPjKR90ZyJt+oAL3jKCR/6FmVhYy
         377Kt6cgnqLCJ/B2Kf2BcR8aw/t40O0+qYuzOa11dTxWB9LdWxZc0QP+YVpJ+5kgr6zD
         Rby4r1FUotXCQAW4+Fp6Dm3BbWGYeNwHCdT4+aSIocYVvsgjeHOvx+rWBii0eYdzWD+9
         Ku0ZQRdBGGg2mYWdhMsYf8P6CfMiYlW46KARRzSFIjHtfVGr4555IMcXWF7toTcTtm/8
         O/g2eNrc4IfA+OcwLrywxMdXYqf5Wj247328Hw8L8zAh1kOEw0XwtjKs6iBzSr8hL/Bh
         ShAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517928; x=1747122728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILaPhC29TjZEHYEs2jF6zz89xMd5BTo40WxWLbWUDSQ=;
        b=IvXXc1egnKmOuldxPoc7MNm6iYqe+K3OeXceKnPrIITkJOuOxrvY/3nRBoTcT6jDBi
         1mxKmzTge0NyBUroqepopRLE27EjerVJ+NfQcMnEVKlJ6lBw+N7VODGP/fhczboPu0V1
         zKZdl6nEwjNqEQSAEJODSHsG7sPW7gm0UvORT8yRlq43ojWgex7VmizMo7EhMzA2Feet
         nKgYVXSilbNJo7oME47f9WafBOFJmDAt+2AJN84H/Amsu6qEBSMvO1/v8uRT/xDjk5Kj
         yzEocdxeVgfwYebKxfprp6fJ+TqCMzE1Js4WDnOWIFA2+cwvaTPn7xyPi3US4moBtBH5
         1E7w==
X-Forwarded-Encrypted: i=1; AJvYcCVJIHMXd7GXqn8P7IsyzZm4JMmhHb2OR9V6+AGFkAz492tX/vdsUJK6z0xCEMZglacSBQS6srjpXary@vger.kernel.org, AJvYcCXv+GA6Mr5ezp6N/DdNqoIEhPrUGkRBGCi/+DtOZMwN+r/wXJ/MlRnHvZ9CjMLFTYysU0bjs/mQcJM2UxkZ@vger.kernel.org, AJvYcCXyKZgHWXOrdoqNHCLCLRgRwghI21hob64zRbDTVWf5+jRv1Vr+2IbXy9zq47lW9Fxk9Tmi7ecFSzG0@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPHBeJxjXRe/vgT1UIzNBOMzCNbLfX6RkbcZ9gsuodpUUbH60
	RCIEVw6nuNmWfsz6IpjZAtkFT+XBO/sbd1iBKw4ySg9KmfAlPkch
X-Gm-Gg: ASbGncu6XOy1uuMNMLnx4mybUR4eNy/yOjH4LSzV96Tf2R72MDULUcFP/RFBkJ72bex
	vqcvCqcIIKHc2/9Vyci0AsGN2Y05FXxLjxwobvjToGmtOZtbA/SgbQNeY+TKbA6r0//9Eytw7h4
	Jh3h3UKGZ/yfgVCtNHvbOULKBbJrBMSDp5F8D6EkFezY8pSCbe0YS+IMk/8eZxGWPumalCg9Dk/
	5DqhmtsaX5b2ZsWSH5MgvxvTBcKyHL9jdN24jHeUWrsmWVJ1SPNwHlV09xgWpgUqWoV6NaGI1D9
	OpZV/JYwVCNPs0+9RWY5TaNNv2+vQNpBpFDCZ3pb6INJWQDqHK0ehBepUuu4M0BEYjwSQ+7lJrs
	=
X-Google-Smtp-Source: AGHT+IEW+wTfs5Sgf1Cb3eF+wezALJj/S29kLlJJHN51zwzNZKOHty3jYcaOzqfnxwvzRxCaXnYlxw==
X-Received: by 2002:a05:6402:5112:b0:5fb:8903:dc82 with SMTP id 4fb4d7f45d1cf-5fb8903e71bmr910254a12.10.1746517927636;
        Tue, 06 May 2025 00:52:07 -0700 (PDT)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fb45a0c675sm1727131a12.14.2025.05.06.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 00:52:06 -0700 (PDT)
Date: Tue, 6 May 2025 09:52:05 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: 
	=?utf-8?B?VMOzdGggSsOhbm9z?= via B4 Relay <devnull+gomba007.gmail.com@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: chemical: Add driver for SEN0322
Message-ID: <4bvmhlzbk3wxnjskfio3i7wyimaclnjt7mlk5bydmn4ycur7fi@pdkvjofbrurw>
References: <20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com>
 <20250505-iio-chemical-sen0322-v2-2-217473983b42@gmail.com>
 <20250505184705.6f00321a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505184705.6f00321a@jic23-huawei>

Hi!

Thank you for the review!

> Checkpatch is lagging behind the times, but it is fine to use this
> as a formal tag in the tag block..
> > 
> Datasheet: https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322
> 
> > Signed-off-by: Tóth János <gomba007@gmail.com>

Sure.

> > +	if (val) {
> > +		*num = val;
> > +		*den = 100000;
> > +	} else {
> > +		*num = 209;
> > +		*den = 120000;
> 
> This is odd enough, that perhaps we could add a comment on why, or at least
> a cross reference to where these numbers come from?
> What is the special meaning of 0?

Okay, I'll add some explanation.

> > +	u8 data[4] = { 0 };
> 
> If you are only read 3 bytes, why is this 4 long?

It is the closest power of 2, to pacify my OCD, but you are right.

> > +	ret = regmap_bulk_read(sen0322->regmap, SEN0322_REG_DATA, data, 3);
> 
> Having shortened above, use sizeof(data) for that 3 to avoid
> any potential future mismatch in sizes.

Agreed.

> > +	dev_dbg(regmap_get_device(sen0322->regmap), "data: %d\n", ret);
> 
> Given you more or less directly provide this to userspace now I'd drop
> the dev_dbg() as not adding any value for debugging.
>

I just like to see if the function actually ran and not reading some buffered 
value stuck somewhere, but okay.

> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->type) {
> > +		case IIO_CONCENTRATION:
> As the sensor only does concentration, you could either drop this
> check on basis we can't get here without it or if you want 
> a strong sanity check do it outside the switch statement as
> 	if (chan->type != IIO_CONCENTRATION)
> 		return -EINVAL;

I did not want to deviate from the pattern, but yes, it will make the code
more readable.

Best regards,
János

