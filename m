Return-Path: <linux-iio+bounces-23027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2BB2D327
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 06:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CAA724836
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 04:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8B257846;
	Wed, 20 Aug 2025 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv0mbxsM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E25257820;
	Wed, 20 Aug 2025 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665205; cv=none; b=FxPRLmXOQom697Wdno9d5K5GH/9muNYOANLF8QN95gdJZcFryWMkEpbUetfgAU7F7qQOo8yay4iOsNRyfxh3fvWNrpu9rSheov9WGjpNVY1gg4MIvs8nu5zQ/bZROsiozC4fmJKzNWhz2A/bulu/wPTVo+NSXFDs1lXs5D8CC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665205; c=relaxed/simple;
	bh=1vQ/1al6KZ3n5t/tJ5DyWbLg4g2xkxVaVjbobiDk8EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI/G+vQsqMPpIcPIJCRczPxPKu5X8pM5knmbfl0bIKNmULuFETrG3K1o2lw0e7CB3OLu7UIsirHBAjtXMWN4gATqPRyWkmi8f8OqQv7Rh2s44OmTOZYhxye0zycOp/Dkm5rzJAsLbKjD7GZfPMkUT8gMtr+tpYPqYVymmrls3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv0mbxsM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2449788923eso19747645ad.2;
        Tue, 19 Aug 2025 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755665203; x=1756270003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DarzXDuH+ffptNMW35ITw+JWwVE8qFcBtwND6II5+Pw=;
        b=mv0mbxsMIzDrCPk7ORnB0N0jjQuP6kpIQTd87WWM8SLkkVZcaMBaXh/5Gh2/ayJ+8B
         bGU1rxdpdD8jetWf4pIXR7OVs515UVs9uMU+5Bs7i8m36IkVR9SOmHKBKtOn7aUi0FDl
         ybsrl1gwrNJWYXJ6EMxjyg5PCnGF8EeXj7VBYF5EUDA67xqwa8JzHpTur97F31NzJ2sg
         XqCZFus+gcQtlkpdWEBpv7YqyDqBsH3F+awwM86Cw97S22f9UsY2O9WxbK72BUBoG1uS
         2XcxPxmJPLCa6DzbwEaGm8Wa10ULYmv3jM0swkZ/hdlXKu2dJ6crIsA2KaeDc5V8ndmI
         v9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755665203; x=1756270003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DarzXDuH+ffptNMW35ITw+JWwVE8qFcBtwND6II5+Pw=;
        b=Phd/b6zhCPRn6ZOc6wZ19BurA1j7voCWL+I1ODgMiboaAUdyXKk0rNQLpZUJy7pNIM
         7mcY56GhlCNcy6G1n1Xeg6mWufaAsijrs2QWfygRtVXDMqTelQlO1M+VFeV8XmWkXvLe
         0fiwQCjMKt2T+WSueG0QZ4e8+zGecnYRWkdzdBgXwKxVKDprwv/lhIvVgnAoYmtJmIj2
         AuWweoRzQr0B6WBSUrOK+O3hukmTWp00nAIAX3OM9NlU7z0YRxpCqeS13OhA/pbtk3ee
         hiYAyUBuq/qaGRkockKYbmF9k74+yIkjfVdd8N6BP22fQYr7oth0MGWQXA7LQWJLs6Jy
         EuPw==
X-Forwarded-Encrypted: i=1; AJvYcCU4a1tT3s31RL3NZdU6AFTmM+J/bWcMYk6W7/glJtkQvuSGuMvalqzsUhRlEheKm5F7ki//0Jw/gQFVY0gC@vger.kernel.org, AJvYcCUHJ2kgbpi+FqEH+fvcOjKJnsPuiBQhC1dic6JDrX45TPtg8scbf9D3UT9zkTM13MfEmZNTB2/d7YeL@vger.kernel.org, AJvYcCVqpWY98iVCL1fbGSCzEpqsW7qouTptvlKA0jIRnGp3qdI1PUH7AKwu427nLYmW7MNl2u4F9su3BgEv@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLvB/N2A937pwoiGpSo06AAV9xjb/tgZfLdsnGn6cecSrGzCL
	yDjoL98hSKDwJ3LtyQX91OSfZfy/IiBEjbxXezWdttLSCRgmGK6P7uRa
X-Gm-Gg: ASbGncvDFfmKWFVxRC9En0mawE5Salc8MNhQINYVarSPlPCZWc+BX/fPSQEntjQtoYt
	/BulaCrP9D7foWJ1dl9QZ/pY1S33Nf1OPuybULR+gEX3muVjLc8VYYtRFiTlDb33RIjLY6RJ7d9
	59Mbch9LUkfJG7irkJlKrDTlF/plXGwohRUWRchl0SeEvY72jRdw9U2kBLlLbZ7pNEpTP+Rq8oW
	35Lh60qdsKBtefvWOxl7vpF4DJnyPYowyFHane6M4MgtbkIGeoj3YDMrvfVwrssi+jwo3ndIVTl
	GZ/SK0rMDShpdI/K5asJXPXNqC/teUMWqeaWm5UIQB0VeKB7LUhLe8jkQo6QJsVBP6TjcdaMpxn
	ms9VPAp0jehNR1niE43n30w==
X-Google-Smtp-Source: AGHT+IFP+L16oHaOm3NEbnsDegMl6fP87dVGenQVIRTDtsvxjEewVa+y5/ksq3qQr79odJCBXtGF6w==
X-Received: by 2002:a17:903:15c8:b0:240:2b97:9102 with SMTP id d9443c01a7336-245ef252a2fmr16920955ad.46.1755665202836;
        Tue, 19 Aug 2025 21:46:42 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:5eb1:987b:ce27:5cd5:4ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed375db3sm13659485ad.59.2025.08.19.21.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:46:42 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:16:29 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aKVTJXe50zf07ipR@dixit>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <20250816140448.37f38d0f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816140448.37f38d0f@jic23-huawei>

On Sat, Aug 16, 2025 at 02:04:48PM +0100, Jonathan Cameron wrote:
> Hi Dixit,
> 
> A couple of really minor things inline. Given Andy has been doing most of the review
> work on this one I'll leave it for a few days to give him chance for a final look.
> 
> The stuff below is small so if nothing else comes up I can tweak it whilst applying
> 
> Thanks,
> 
> Jonathan
> 
> > diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
> > new file mode 100644
> > index 000000000000..ee72211576a6
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/tlv493d.c
> > @@ -0,0 +1,530 @@
> 
> > +	TLV493D_AXIS_X,
> > +	TLV493D_AXIS_Y,
> > +	TLV493D_AXIS_Z,
> > +	TLV493D_TEMPERATURE
> As below.
> 
> > +};
> > +
> > +enum tlv493d_op_mode {
> > +	TLV493D_OP_MODE_POWERDOWN,
> > +	TLV493D_OP_MODE_FAST,
> > +	TLV493D_OP_MODE_LOWPOWER,
> > +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > +	TLV493D_OP_MODE_MASTERCONTROLLED
> This is not a terminating entry, so would typically have a trailing comma.
Isn't the last entry in the enum list is termintating entry and it should
not have trailing comma?
> > +};
> 
> > +
> > +static int tlv493d_init(struct tlv493d_data *data)
> 
> I think this is only called from probe, so it would be appropriate
> to use return dev_err_probe() in all the error paths.
There is dev_err_probe() being called based on the return value of this
tlv493d_init(). This function reports the approproiate error(if any) and
the negative return value will result in dev_error_probe().
So I believe having single dev_err_probe() in the _probe() function would
be more appropriate, IMO.
> 
> If nothing else comes up I might tweak that whilst applying.
Much appreciated.

Thank you,
Dixit Parmar

