Return-Path: <linux-iio+bounces-7294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957ED92718E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5011F23F58
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8611A3BA1;
	Thu,  4 Jul 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2z1qyOr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435240BF2;
	Thu,  4 Jul 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081128; cv=none; b=E4iOHG3pnJABQC+bj0RUwdWQ2KgqwFcQCpnGl8jfY7U/ark+ZUz8gs+Yq5LCFkDbHEfW6PJ6YivfDUqI+4ou0xSBC0wonZkZJpPaTH+MFfWripItwZ/STwo2mOzMDfj6U244KNjucHfXCWxvNIfFxmH26/lgcyKRThip2DCc54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081128; c=relaxed/simple;
	bh=6/zPblrqcHg0wS138MP652lBp+ZaoHvh+/0sq4DtdMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjlkExfWw/EsPYQ7/7ATIQdGSPWarQPjyPsGhUJlpxonhKLTLHdzwJWATvB881tp8SEfQZzmJQ3+BI7olgLRkhe2w+chbqNy/GAeI597UtAKHZxHSAb70BgxNFNRC2h/vQUJc9T3hBQPpOdB3eFarZXP8wil1bdS4n/uUPaXOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2z1qyOr; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-367940c57ddso236468f8f.3;
        Thu, 04 Jul 2024 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720081125; x=1720685925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/zPblrqcHg0wS138MP652lBp+ZaoHvh+/0sq4DtdMw=;
        b=M2z1qyOreGt/fyIwpnOh7KE2qHDRM3i81IqQ4/Lnt6j7XkaD2QqVLhvte0M1mz/vPs
         PUUmhpjg+nyG7ZFSG0cEHQGY9Dpk5guoAhbv7HdldDUWiagfv5X9dG+DOON0f/hPxCGj
         kPEjaX/RMuLnC59tpSGszAQVCSsZfVwd2UYN/VQCyQsTDMJVPMG30aqczKwAlqeIK+N9
         VPkxCzEMdppVot4762K+dSwFlR0nECP9DgOEXuhRYn5gRaDBoo2SODag9TTy+HjnMxgB
         NJfxwq3ILOVUkXJo967IKu7M1lIjH/eCWtLOf8h9gI/aExHPaWNTAz2ZzTXA5gOP1K8D
         boeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720081125; x=1720685925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/zPblrqcHg0wS138MP652lBp+ZaoHvh+/0sq4DtdMw=;
        b=iBdPb9RUeJyFp7q0xgTO6W68a2mKvxJQQyqc8ywCsytC/KF30mOzaU0d1H0g2UHXLO
         W/QLBm0qoBXMfc15LQqT/AZPlNFBR5g/Ee2sH8pFPUV1mvIGt5v4VB2vQkxOZ1gw5Dr+
         RN9ZViAjWkDWW30W8TNZhLMt+bBuyIjFqUq9fpaoejwEUeOU22aYS3Y/GwhbWK+LXTKC
         7yi/gUeLQPbVg2woZNIX76YWUImthsUqbRJNWUP0+qPBnJrHAEgQXReev+zQj9nnEtk8
         OX4Cn69ese9H4W82iewdjMiC3/ec8IQNJR0l+w36eIKJc9e4C9gCdmHoVIDUrnu3Jjhn
         yMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCWL5PONLCp6U6DJa2dRaMkvp7IeweXNzrwg+A5Mwt0HnS8YIP6cYKria8gqP1hwyX5e3BWiKAUgfmoNqE2S+RLemJmeWXgFT9Xbv4UJDgPFIYE1V1DDqLQSq5T3pLdY0741dPK8N8+w==
X-Gm-Message-State: AOJu0Yw3dmJr8LR0pwwExYdWyLZw6F8C74mT+NxeV39z8ZO2WrnV6y3m
	pumq1uaC1GFKEjPpoydHxelfVWAyrLq8gEk/E/NTwKozLzDw3DKFiXbRHA042fBRI+vMbWP4OiU
	60nUT7oCYxiBa88UNPpgvQ9v74Y0=
X-Google-Smtp-Source: AGHT+IE4xiUQw4dA1SxZD9H8hd0AhnHzluII0lZ3PaApoihwyyt3Sqaxa2JgTFbDWdLCz+VUsHZ+XDj1tTAoqJEElVM=
X-Received: by 2002:adf:f744:0:b0:366:e9f9:99c1 with SMTP id
 ffacd0b85a97d-3679dd63cc6mr847228f8f.53.1720081125395; Thu, 04 Jul 2024
 01:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com> <51563155-c53f-47ce-bf68-5a6da72f8655@linaro.org>
In-Reply-To: <51563155-c53f-47ce-bf68-5a6da72f8655@linaro.org>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Thu, 4 Jul 2024 10:18:34 +0200
Message-ID: <CADFWO8GWZzwuV_CSue9_GcBre2OdY4uBs8CiCtUePy4PW9BCuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:15=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> >
> > Sensirion SDP500 is a digital differential pressure sensor. It provides
> > a digital I2C output. Add devicetree bindings requiring the compatible
> > string and I2C slave address (reg).
> >
>
> You did not test your code before sending.

I tested the driver for sdp500 on our system and it worked well.
I must admit that I forgot to change the dts to sdp510 and retest.

>
> Please respond to existing feedback from v1 and v2, thus confirm that
> you understood it and you are or are not going to implement it.
>

I tried to reply to all previous comments. Sorry if I missed something.

> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

I didn't know about that dt_binding_check. Then I spent a few hours
yesterday fighting with dependencies to get it running.
Thanks!

>
> Best regards,
> Krzysztof
>

