Return-Path: <linux-iio+bounces-5989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61890006C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7751F233E3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96415B96F;
	Fri,  7 Jun 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDRK6cQI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3B2B2CF;
	Fri,  7 Jun 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755142; cv=none; b=SEEmOYa3w1jKtJe4Jw80nzupyodx502DpoYPStemBi+l09s+NE8ER/Cnh94EnGMqilooEMPYkk0EGaxhiGpZR4T/uxXzYc9hPvQiLZKvxjSZESPbsuvnRtJCKuj28DLBNK62LpwPaKXit8K8Ek7uUj7HkkLnmmsRdDBDgudxWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755142; c=relaxed/simple;
	bh=uPK2ovi7sKFgN1z7n34wdjJYENnmfmpT8LXspNlACCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JnT8xcRuO/0s/4HiC653uvHVvA95U8OqBxDAFHr3lXtNhBRCIJ/ZV7z320f1bUKNQeulpNk3+153upuQNr4f1FAGlP+9N/fIkX5JCy+USqmS0UZfSKxvI1Bu/JcUp8duGittwOeEAf6+PFDy6qhajUy3CxouhIIsVVReat5KRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDRK6cQI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a691bbb7031so258107366b.1;
        Fri, 07 Jun 2024 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755139; x=1718359939; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uPK2ovi7sKFgN1z7n34wdjJYENnmfmpT8LXspNlACCM=;
        b=nDRK6cQI1p6Zh9NUxwqZKNauCYH64fJx18NevOxea/DE9UQILaj0EWwhYsnlgnGva3
         97vWLMzLlyIrR1UipUQxFj5puEn5OponikQ/YsyUFLx1LocGGgxwmjoRxWBoWo7JgWaJ
         C62kU6PCz9OtQy0QJNnGovVmjdRtx9jFOEAye/J282UW0juVTQ6mTakPRfvs7Jat/ePn
         GzrFsJmsN7J/Yld08/VKb/sqRD2tI3n7IrV6YSFpr+gn19vQmWtY1vh8n6UzbRADGJMc
         jbxlWQuQec1nMD5QidTekZEYkSmYhEzAr58K4eQxS+mDlkA7lmYWUq79S9gwjbhtJ2ws
         PPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755139; x=1718359939;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPK2ovi7sKFgN1z7n34wdjJYENnmfmpT8LXspNlACCM=;
        b=xNyWhHUY3QzNvCnRkxefenfNpsYKI7wMcHkJIWCD9Ggr8iXYSmLn1FXnFwPCkbgduq
         rXQscrCRY0jXuFUqW7WoEekkC9qVGR26y7QLeDYz8doCM4XV+LvAflMAbKK/qk6Dv8gW
         wCwQWYRU1gfJvggbYgz24qtcUAKFhzbfwvuRLEXjulg1pT3D0drItpkfrVxMyBKhSbft
         EL/c91X7K18MzKkqZAcqXAcOXMopdoaEk8YeKgZVfJh4drb3/vszr45PSg1QG9DnhEIY
         cCCS/ZMk7wWb/21EqTBPdGU6M13wjWFV18J4uqAHObAlyT71eCVAj6oLCJUImh3nMwxP
         Uydw==
X-Forwarded-Encrypted: i=1; AJvYcCUZlm54SVOY4viV5L2QjU5Wcodc+xjdwhy308YWURubaYROoKE3DK1s4xevHJZi3aIhKWQRMzGod/yV4+WaDkn89b13Ivq07JL3YaPPtIYMQusO0hh0jTmVnJlfztUViZjKaVhktXtfXIr0X9YY5B+fepsH+CGzrcoXOlwIl6jjd2LKgg==
X-Gm-Message-State: AOJu0YwA6xnETHU9Vc6GGLa3nf1+E+7iY8ys8BrNMW95qJBWLaqOvYPw
	u5rycOcPwS8+NQgEGoDXgPMKUSWqVxwYtpdG8S0WHFn+nodItiAF
X-Google-Smtp-Source: AGHT+IEe4dn8Ah/tcOly+o03eWBP7tz8YlMkhVip1z7BFIIqj51va/zVvh5H41HNlNovMrOLaq5ZyA==
X-Received: by 2002:a17:906:2654:b0:a69:574:91bd with SMTP id a640c23a62f3a-a6cd76a9339mr184559166b.42.1717755139056;
        Fri, 07 Jun 2024 03:12:19 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ec844sm225620266b.120.2024.06.07.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:12:18 -0700 (PDT)
Message-ID: <329d2f78f55f7df1f03d8581cd108b51f01da86a.camel@gmail.com>
Subject: Re: [PATCH v6 3/9] iio: adc: ad_sigma_delta: add disable_one
 callback
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 12:16:06 +0200
In-Reply-To: <c361a87c-f447-4a40-8972-ff2399795ee3@gmail.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-3-573981fb3e2e@analog.com>
	 <be5c166e088e28e8c1e4a09da0ed71163fae727e.camel@gmail.com>
	 <c361a87c-f447-4a40-8972-ff2399795ee3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 12:29 +0300, Ceclan, Dumitru wrote:
> On 07/06/2024 12:02, Nuno S=C3=A1 wrote:
> > On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > >=20
> > > Sigma delta ADCs with a sequencer need to disable the previously enab=
led
> > > channel when reading using ad_sigma_delta_single_conversion(). This w=
as
> > > done manually in drivers for devices with sequencers.
> > >=20
> > > This patch implements handling of single channel disabling after a
> > > single conversion.
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > > ---
> >=20
> > You could have this done in separate patches... Oh well, this is simple
> > enough
> > that I don't care much.
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
>=20
> Separate patches would break driver functionality then fix it.
> The drivers would not probe as disable_one() callback is missing.
>=20
> This would have been alright?
>=20

No, it's not... I mean, you could also only enforce the disable_one() prese=
nce
after updating all users but I agree this is simple enough to go in one pat=
ch.

- Nuno S=C3=A1



