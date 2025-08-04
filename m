Return-Path: <linux-iio+bounces-22287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA7B1A372
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A87189F201
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF026A1B6;
	Mon,  4 Aug 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm/SV6h4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74745029;
	Mon,  4 Aug 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314625; cv=none; b=QkyZGRoMtD6fMTHsQvy6spnl9UB8kY60zyK+4bboujR8T1mzPyBSOnQJ7Mz/UCyOaxByw7zxif9CAvR+fgAuZSWDUeEJsUsoO3wMUQ5Q68dSAVDGFgsKwk67px4ULTbm+pt8W6OoqayxXYkBs3UMb0wFPV1Ur25Z9UG/8H8WqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314625; c=relaxed/simple;
	bh=tbl8+m1PkOtcEPoJu2cquxgKxVdziZfQHZehmNjpZ8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaPxWmlQ1Z2R5FciBBEwVYaPYJuMszbAcAXRiJlUcd4SKmBEm1TgvccAqwDy5w4yBWrfzOAwATJhosaQq5zQ9il4aXGUlIOAgKKkSDYTn44JcwmKz/pP48nNiSOkur3fyhRhbiZ2NoVdv5x4L2byKXVOLX4sLWoA+Vup4YYKNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm/SV6h4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so2981258a91.1;
        Mon, 04 Aug 2025 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754314623; x=1754919423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIfHWSrWPLCehQt7PwF3t5y1ZJSBfz1BmkgqpCZlKko=;
        b=Cm/SV6h460mko4TuIPGRPZ8B5m+LIQsM3zr3cj6nntdO3zZijm0FaRZSP5roLxlZZL
         eZOc3mbW2zJZC/h/Qx6wnofw+e0kkkdJp9GvVFjwCy5HXijzT0szkaQvuFXBdz75fE+0
         ZQoWu0TmGOKksg9GN5JGReNPv493ZrjzVOvLHagabpno3G+d2JZRer3fQe7AsZ687v5S
         Q8PM1VxvH061j2XC7L4cj33eIAN/T3dDx454eXtvZ6QLPYN9npg93Mp0Oqlh73pYB5PE
         mc/Etl8oYJCMqvpi6ovcI6zQ5DRHlU5hACItUdReJ4Z7/+Xlo0dZwV9C2fjWjPs2Rtie
         Sx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314623; x=1754919423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIfHWSrWPLCehQt7PwF3t5y1ZJSBfz1BmkgqpCZlKko=;
        b=CkoBXtGo8r4jrxaVs+cd46pEDIdPe9Jvy2wUHK1qsJTRvP/Wu/e65lvb7Jml+GlW07
         lQrqCi6SUnAeAIGYVal8whPBdvS8xNrKxqXZ4KoGkaQuuIKydwA6t2d2TXgN0ZyTAkWw
         685CeVSMRZp4FAlnoVJamc6DwwmBZ1SBt13Mncw5oMkibxp+MNFvolRk7l2ucTYnwH1K
         Sw2Sdw8R+Ja+S2vht3Ffbb0/ltg65fMOAtBErdhFoXjFvzEQq4sraG/4HuHeWOlv72D6
         L2jewfzcLpuVPMMI+5xS9+FXZox/QvdJXrruN9arASv8J3t+ARc64/+hQgylasa/fudK
         q8ng==
X-Forwarded-Encrypted: i=1; AJvYcCUgZ+vwhwoVCU5vOC0x+P0ktQt00hpO4czFR0N88oUfD8R+qGGrIpmOuyN3ja75CqONKZF4AAP0aEMOxo2S@vger.kernel.org, AJvYcCUpOs8QfT6o+gviDUId39a2jql6A2tkCM+LgJ10A1AiK6eyGjgW6XgE7WsxpwaPY1k6tQ/fIr8p0jEk@vger.kernel.org, AJvYcCXVv8eqIPDJpVSmwKZnw5/jnMNiQjxrOGgrC2DT16S5LkNRJvi2B3sZ70Nrz4jM2bBT70+th29h1jUT@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdgNO036dgaUM5r/lAdiKUvyuFjDu9f6zUVQKek1DFKc2+2bR
	KrHJJwEzgeCTNeDIHo0WxHB3BvWH6yH5yvJQFODW6BXRn7UNxMjv9/ct
X-Gm-Gg: ASbGncsrEGnCAcLGvHZgFGQQ0iZ8b2u1bZrxZrV4A/yxEplGNrSzxzWkf2x2uYlhNDt
	WJC5Gpzwc3lSIpNnvGsM6ujn6vxELsjl49x3LYBKsecuH/wt57wR7oylWwOy1u/ISr3hfkRlJQ8
	lw2+5yBUBeJtIDTvyfJJSeQeoHp4WgC8voxJzxyeHF1DYIQdQ4arxZ+7OTZRf+Kr29qu5mCzQDb
	azApiwJ+tmN7bkur+Go9xuQPau5HOBFSsxqpw9ckg/m6usd16qOMLl8fwFjYc6f153dswv7r7Xe
	MXNBhun2G8yPwseOFwSAWRonVO35DEH2nFwSIUboVk/lp29Y60CnENwoz/4472iCsDTWHfErmqh
	2i1UqWun8+HG8na8OaGTI2UE=
X-Google-Smtp-Source: AGHT+IHKuRCYCMIVxRA5yUjOHCC2AI+ZcE5kw/HZYseqng2YDWh5q0w+caV0r7Dn7qeWEi8QeUvPkA==
X-Received: by 2002:a17:90b:1d0b:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-321161ea341mr12756787a91.3.1754314623258;
        Mon, 04 Aug 2025 06:37:03 -0700 (PDT)
Received: from dixit ([2401:4900:1c44:1e70:ca26:1d52:f1e9:6f6d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7ceb3fsm9038942a12.22.2025.08.04.06.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:37:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:06:53 +0530
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
Message-ID: <aJC3dVbffwjh09mt@dixit>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com>
 <fc15279a-bf3e-4500-8dfc-651e6e2431d9@kernel.org>
 <aJAeoI4Iz_U06Wmo@dixit>
 <6b691092-f931-4140-8097-0ad67d02bde9@kernel.org>
 <5999ba4a-79ec-45b1-9d91-0252669917fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5999ba4a-79ec-45b1-9d91-0252669917fe@kernel.org>

On Mon, Aug 04, 2025 at 08:16:36AM +0200, Krzysztof Kozlowski wrote:
> On 04/08/2025 08:03, Krzysztof Kozlowski wrote:
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..ebcf29067a16
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml
> >>>
> >>>
> >>> Filename should match compatible. Otherwise a1b6 is just confusing.
> >>>
> >> Idea behind having a1b6 is that the TLV493D is sensor series and this
> >> a1b6 is one of the models. As this driver is intended, developed and
> >> validated on a1b6 I kept it in compatible, though the file name contains
> >> only the sensor series. In my undertanding, this same file & driver can
> >> be reused for other drivers from same family with new compatible fields.
> >> Does that make sense?
> > 
> > No, because I did not speak about drivers at all. Please follow
> > kernel/DT conventions.
> > 
> 
> And now I see this wasn't ever tested. :/
>
You're right. I just learned about the devicetree binding validation process post
your comment, make dt_binding_check. This is my first time contributing to DT bindings,
so I wasn't aware of the requirement to validate the schema before submission.
There was mention of this in the bot error reported, now I see.
Apologies for the oversight. I'll make sure this does not get repeated.
> Best regards,
> Krzysztof

