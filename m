Return-Path: <linux-iio+bounces-22619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC845B229B1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D015A046F
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36A2857CA;
	Tue, 12 Aug 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuFhLCK0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4A2853ED;
	Tue, 12 Aug 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006737; cv=none; b=DbPcZiHSYUAHZIs2WJrNYAxgGVyirTA3YVV5Vcf4ZGwiPqBCAIQ15CucEX3t/vWbRhkx5K6WgH7n+24l8e0a11b/m+iuUQc/wdFF/AjQ2tVV1hBzAT51hYFP3NlbvJmAI17A7he7GPW0kLTkIAWbQGOcNRfn7JdGrTi9Qn5xNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006737; c=relaxed/simple;
	bh=pbMUSHq/YNNaCArGDvDjk8wRb18KIRpXix8AV/Waf1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLsqGYi+RAmNsEcopxZ9ojEiDi3X7C9hHJDAupeS1BZMq9h6wkKja6o3S+qm6Qrl1dlmlD0n+xgZJE7fk96RoCNd1ux0iPbP0bvbsNO0iWhu5owC4dwpchw+qRmQQhz2aSxqvg1RWY10mBVQm4PQL/lz34wXc+x+qsab/HHQTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuFhLCK0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24307977420so4745515ad.2;
        Tue, 12 Aug 2025 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006735; x=1755611535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0llAY0VwEwkWRZxSWHsUTjSAYVzQD+4E2bIspQfrX0=;
        b=EuFhLCK0j/wdW1DBaH6Yf2VKpGV5w7RAvgmDym4Bu++AAMACre4dyBdFZzvlbLBYTa
         080VFePRBqowObU4gKvs9w3CRqqMtQI5uq1UeRAPwpb+5A6ncBcAibTRHN/YZdKScUl5
         anVtxGWfWGJIlm525vI/6/0j39/5SWgMjsMI2VQPx/oHTz6rMGtaNq8pBeqknRqIThkx
         qFLJQ26nXawTui90rXs61L5kwQpHFH7eyev+wCPJYh/BGk3MCfsF1d65641dB2FsCbp0
         JmOEiiUdTGeAiRDpJloygyiaWTZeHfiV4P4dgG+MYOCOj4axhk8E4fPyib2uw6NdjH8W
         Hzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006735; x=1755611535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0llAY0VwEwkWRZxSWHsUTjSAYVzQD+4E2bIspQfrX0=;
        b=V5b/jkOqg3E7buRPVsfc76EBgYYV3Sl/vOrO2z7H/nGjvFCqTbhjBkUBeGemTaAD/k
         NHNxPrPv9uc4wytMMNOOYuTK1tZVOka1MFG2zHcUGwt76uOMQMNi9oW2tsshWFewU9KP
         rRxLn04KIUVr3YVYFW5JuUst5r9K/2lXH6Fp3+Agc+KJxaPeZiEc1NjAuV5K9svb1wKC
         BmoLGA17bcsIKpHK4oSLQaqUCZOdPPAFuDLGstECexFLwH04csvU4wH9ELYw2GPtVe0B
         +i/I+9GA9E7/uN20cuaWydsJciiJfxBpvwxcw50Gqa46G0WRHmPL5eHuGWVUJWYE4ZC4
         vGtg==
X-Forwarded-Encrypted: i=1; AJvYcCU3d0V8C20WgD1nBjNImXLW6Yap/mDR3lSg5iDE1vjzSnLnfndDfvd+nbY8QLd5OG2S2m+K70YmUGSj@vger.kernel.org, AJvYcCU6C0fEA9fdr4m/lf1uM+EGGHxCCEXuCNn+BkOfZ9Ynj7qdYtmJT83r8ez/EApzSGs/FDUz43QCSk26TP+p@vger.kernel.org, AJvYcCVGFQFfmEwAIBT8glI9hkH/Brbcokbr+XAuGE0ZHl505hnl5+lHZphOV05/VOJ5rCDkKQJvEcjHfQNV@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqXYYyGTlLcqV5hTHRGFk/z/CYHI6GRHV4HwiYpLZGoOOx8vp
	FDDrfjYQjKySsedjHLPeZBEOppiH1yh6bXAZ3Hy8Z38PoXnbYnIG1oPe
X-Gm-Gg: ASbGncsKsEirL1kwMVe+sTVStV1BTR2u0R5QOXDpokptJO8cL8zl5UvtotbvMx5RKib
	PcCACJq7KlBsN0xypoo15MieC8/iQN4a53c5sEnuqLBufX+eV/OMV9mktSGHmV8Z/UngRSY1C4f
	AO1t6xsAOOTaqis//ZKxGzuC/Am40puOyW0xZQkf1fSJ/JHmFFpSvBApmNtMKHHYlwnDt/ZI9K+
	3wqJvWFonpDv8hpWc7YmqYvy0ifRdi0+LHQuICoeC093X7q1sHIpTy57mV0SToNd2HAhEcO2z02
	zcnVThVQ2TXuNK+5Cryoe2gRpD+n1IFyp4P+Hnq3EGEZg21Q2cYK9owgbdu0bIU1aQ0xJQtu5Gs
	fsaGBdl5dCDe6+c+2EXRDnrDgVWO5TAI=
X-Google-Smtp-Source: AGHT+IFCVeX4DZSLmnS1ZpbzghtTiDT7mUKw+SGxc7HopabHAMlQntL9W6YNEQh+avv/ZDVdDdhETw==
X-Received: by 2002:a17:903:1106:b0:240:3f4d:b9b1 with SMTP id d9443c01a7336-242c21fe5e9mr248206715ad.29.1755006735266;
        Tue, 12 Aug 2025 06:52:15 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31f63f0b04dsm35156975a91.25.2025.08.12.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:52:14 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:52:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <aJtHHdbWSYg9DjBd@debian-BULLSEYE-live-builder-AMD64>
References: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>

On 08/12, Krzysztof Kozlowski wrote:
> Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace them with Marcelo Schmitt and Nuno Sá (listed alphabetically
> by first name) from Analog where appropriate.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Thanks,
Marcelo

