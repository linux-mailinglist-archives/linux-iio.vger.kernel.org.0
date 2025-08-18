Return-Path: <linux-iio+bounces-22958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD59B2B32F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 23:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498F01961B4A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AFC12DDA1;
	Mon, 18 Aug 2025 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjqN5qLR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A013C8EA;
	Mon, 18 Aug 2025 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551085; cv=none; b=fHMdnGxG40fiaX+om6nfoHoCLcrMZUF3hiY+f8slpns1fMIACjE6OxMzNrRv6YSRtS9UzKWEV6V/96vYRmrs9SuhDcMpKRUIZWKJEDztkjRe7dMGjcIbASss24WNacsr+wHcE2XSH1MKEk2MW8nXT42HeUCY36X9/L4ktWTH0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551085; c=relaxed/simple;
	bh=jD/Q8MH/+DVDele+pNqzm76x53yFPBsn2qI6OIESsis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUmfNtDhrwJ+nlxJ7Nx2ZsdoLSO9QuUdQROpXE4fOCjWSR82liFtvBwNUoCz2st9Dhmg9wzzXXgvVpb+kC8gQuVViTlNU8x479mazlipkLA53vkaIYT3VtutwAbM5HLkOqj/x902Ro6XmYE4viuVgKNUpDViKPsAHaYDT2AO4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjqN5qLR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0056cfso6490655e9.0;
        Mon, 18 Aug 2025 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755551082; x=1756155882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0c4f87pIHFq5nF6Cv0v2IC5Lhi5/aICX8TIOVgnmtk=;
        b=DjqN5qLRVevrOxwnjuzqhokR3M1Ilmxig7QyYGLvx3MSS89Id+tMWiUD0ZELGfyv46
         OL/2Wchp2YQRCN8FDGpRmc8Nw/lZEFLuqIvZSw7fWbEpYsCKsixO3/I0amAhsYIsd9kA
         s5Vzq3TtoLtU45CIXBb14HQ3Egi3XwNklxgCEG6csi3PgNRIQsJleLMqOBfnE7u7KkxY
         7/KDL5PK55cVNM0xE3kFDonUCr4cfBv3s3UXFReu7oLCHY4lqkDlZhlQst0e+KETtBY9
         0DBcF3wuqfqIH7AFGozt2SV2S3lWwKThL3+fB1KOIxM71YiyAITut2fkV3J4MzN/qYfN
         OKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755551082; x=1756155882;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0c4f87pIHFq5nF6Cv0v2IC5Lhi5/aICX8TIOVgnmtk=;
        b=aJNAgP5Y7EX58qawWIsH0baylACVCpdEloOUEEHUQ+S17d+k8H9Wc8ZCz8YWbPiWU2
         zG9iWK2NwMvKMDG8/oi+oDP1iu2g4eTZUFD67Nm5tynP498EtMvV+GRRsEEE9Wx/5dUE
         u9MyCABbpl5SoGcYgUd/ZE4KXzpRGW5VSMugjsMi+Xdq+DJkb/E2xAGFk7ke1HCcLHs5
         HAuThbmaSvHBUJjL9JJJjVlr2G5aJyliNJ6Dab6aXPAwiylEvGU+K8ougvsN4icjJVos
         aAiE6h5A/kT1QtcobRZ3QfwxFOwS7XHudjDobrT/F4EMT/zRkmuvEZQ/O97KxmNZ39fl
         cB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEitaHPqNSa3+uhANAt0v4FQtlaZy9t34aNevQRXP12m4Ta9pEadyZZdXW5yHrsB3g+WQbPerlIvrxP00Y@vger.kernel.org, AJvYcCUVzkSYYXbIvlkiGGSLobyhsNPBWRr22NhxcWcxc7gFSpf+8YkWk+5yE5s+Sl6Q/L8ZRY+0Q8cHLQOc@vger.kernel.org, AJvYcCVjq6Jj37MeEDWZgZ7k6n1uMnIXOn5/Zmaij2FgFUckPsgaXmjQ+SZYHqoTKjNVjNK/SGnzl/M6kvk9@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXs9+/pn8w4poVNKl3ifukWEHO0c570gQFvdbL8L5Zsmdt+rb
	NPChYV0U7xyuA2fpMiKC8B+CBxZPe7OvpDXBTlpbkwLi59von2aBeyXn
X-Gm-Gg: ASbGncuU/EYSyNtqf6OyShp4uqS68ZZHy9gN1t9gBC8qRlbsJTpIwCEu3W++8D4SjI6
	MUTcA5EMnuI5ofumNRCEpH68D5LcbNhtKSoGB1BIvkjQK9siMkd3aIeuB4orYlQV9sg2Whs0ps2
	k9MxUSIWaoXQs4Ez3kuyjsSUJFPh8F2q+hglUpT4qrbsy1gYint1ZxkKyQ5e8QXtiDrnzdh2Vps
	qnYi6vxuty9366EYmdYY86aRvPuF5G99gAfviGc3aTYnqEPrR7KGTp17KxRsbjb8qFC0VtMTwo2
	Cu4feDNXLPi3U8R+u4FF8Sf5cdI7ASGYrn4FjA3ntcDoSBmkLn/XF8d+DZi6I/bKi5I6XBb5+Ll
	N3IZ+/Xtnktq5bJ1ibOs3mkfmL3HFIxL3l9HGEPz4
X-Google-Smtp-Source: AGHT+IEvhsbtuIaGsrpE1s24ml2ui6U94GLIFMyT+dKn6bmUDagR1ClEqnsHuYM8QZIS7IGwLZD/TQ==
X-Received: by 2002:a05:600c:4f50:b0:450:d5ed:3c20 with SMTP id 5b1f17b1804b1-45b43e0bf85mr5335e9.6.1755551081832;
        Mon, 18 Aug 2025 14:04:41 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.79.20.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c07487986fsm1013912f8f.1.2025.08.18.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 14:04:41 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:04:35 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
Message-ID: <aKOVY+F8JfOFr0O4@JSANTO12-L01.ad.analog.com>
Reply-To: 20250816141220.0dd8d68f@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <ecb7406f54938658b51b4469034d87a57086bd1e.1754617360.git.Jonathan.Santos@analog.com>
 <c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org>
 <aJ0UEUVmIH94Nuwi@JSANTO12-L01.ad.analog.com>
 <8c27b00c-5b80-400f-8538-b9ad96fd5feb@kernel.org>
 <20250816141220.0dd8d68f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816141220.0dd8d68f@jic23-huawei>

On 08/16, Jonathan Cameron wrote:
> On Thu, 14 Aug 2025 08:03:23 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On 14/08/2025 00:39, Jonathan Santos wrote:
> > >>>  
> > >>> +  adi,aaf-gain:
> > >>> +    description: |
> > >>> +      Specifies the gain of the Analog Anti-Aliasing Filter (AAF) applied to the
> > >>> +      ADC input, measured in milli-units. The AAF provides additional signal  
> > >>
> > >> What is milli unit? Isn't gain in dB, so maybe you want mB? Quite
> > >> unpopular to see mB, but we cannot use 1/100 of dB, so I could
> > >> understand it.
> > >>  
> > > 
> > > Actually, the gain is expressed in V/V, not in dB. I may have phrased it poorly, but since
> > > there are fractional values like 0.364 and 0.143, I chose to represent it
> > > in milli-units.  
> > 
> > Why your reply to is corrupted:
> > "c3cf9b97-3883-4ebb-a2ed-0033adebda87@kernel.org"?
> > 
> > 
> > What sort of unit is milli-unit? Isn't this 1/1000 of some BASE unit,
> > but you do not have here a base?
> >
> > I think you want just basis point if this is V/V (already in common
> > property suffixes)
> Nice. I didn't know about -bp.   That does sound like a good choice for ratio
> stuff and here would be 100x larger actual values which is fine.
> 

Yes, it would be, but the here it is 1000x larger than the
actual value (1/1000 V/V). I don't see another unit in
property-units.yaml for this specifc case. Maybe using -milli suffix
like in 'adi,ad4000.yaml' and 'adi,ad7380.yaml'?

> > 
> > Best regards,
> > Krzysztof
> > 

