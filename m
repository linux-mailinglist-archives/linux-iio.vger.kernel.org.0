Return-Path: <linux-iio+bounces-5976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971B8FFE85
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0248286977
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24515B139;
	Fri,  7 Jun 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP52hWwh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FA18EA1;
	Fri,  7 Jun 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750730; cv=none; b=bEnpnb0eb5NZdVQx+aki9pQTixJi+GlvkroriIXOcrIeAx3loUNfSXcq4LwfXmrTAsW8gkJ78JsSUgcLCbV1v+mv8rdmnrD/M/DYuxNv/+ytGIkGWJuI8qszvQA7MGckC6CWsRMWUVdiMr1MB5/DM16TobrAalLjps0WyRhTkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750730; c=relaxed/simple;
	bh=EStxEKykbbxUE6Xp7RiccdMIZ5upJvK19vz3oYBkq0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EncaenaN81IGzZmA52HP/rmblkVBeF3B4NNf4XVpfTAwGzdBroawfVz+daGSmV4KWJrmFxHlNM8FhW5XB37ZiP0AloJ/1vqwvAc4dRbGJQ9t6u/Pai5983+vw1sVvaDvJ9InQW9k3nt9Ck4hcu93YFC+NR/Z24uyIVkIHa0DaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP52hWwh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68ca4d6545so338934566b.0;
        Fri, 07 Jun 2024 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717750727; x=1718355527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EStxEKykbbxUE6Xp7RiccdMIZ5upJvK19vz3oYBkq0c=;
        b=ZP52hWwhWh++d/nPMZ6j3Mjna8eBzxFVD+eirpupA2EzoJDlAqQTQQO8QzgR3ht1bs
         HzfRETySgUfBfs5VRgrOV25Cflswmqyn0hblriYfSx5rJ8TysisvQmPb7+yU2cQN1yP4
         /OM8kr3jmmhsachDMAmnxhe9/siBFuKqZNAFa9gCZHJRKMddqDiN/J6yVjmX1N0+F95x
         381jZpRsRhLiPPMdP3T1W/Y5Gv4EzGw0wbrNjbml72StFeWnelHsWvGFlJnl30a0gk+M
         4K8oOJCbYzkcSbcvhEHEPVJofnZc9f4vzL0rEaByQKJP01kCuLjKVVE5wVcP4biMPwnK
         kuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750727; x=1718355527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EStxEKykbbxUE6Xp7RiccdMIZ5upJvK19vz3oYBkq0c=;
        b=m0Twv/YDowyHlenN+SfG6fJNlxYXyISMbaXQGYxpXBUyyA6cjbXGwebrH38ZfeU7sB
         G/9y/0GbRNoHhKb+1hI+C2ju6FOG+hUpd7aHwpaDt7gAAmFacEdxc3RJmd22wTrxnG/q
         eKrREOsFZhRfQmsppv/hBlfWEuH9ybbEMwgsVz/5iZ3P48KF5+KUjvBn43SSC66j7+7w
         GxLfjt9Jx7apEJSW2304V1HTFLZIYj0r6iE1LBNf4j9keRhuomy7DvspEFWPIoFPkIfY
         pm4waVvIx09zXxilwNAr/q3Kq3Q5IIgkytVuJrXB+8+DAtC+MxQysvpgjpu1lUfbzBLT
         JpUg==
X-Forwarded-Encrypted: i=1; AJvYcCW3V3Pbi5BhpcNkLmfbKPREzx7TQln2ralF28kFDKNW9ymDqmjBdf0MlWhS+PkI1XJstbI3ZU8c9hmI31tRNUOSDqTbOtZi2O4LgyYifoBnaGoh978xGQQULOeQE0IY5LGCcScOPEL72hRA14gLtzpbfSNZYWJG/toe8+cbgMLbBmltSQ==
X-Gm-Message-State: AOJu0Yx6jny2ZS97cFQiCpDmLns10Ynw5TZQ6yBRC27yRdOalZSC+YwK
	asMEr/+ntffkNXzvGJwpB8yfsplEK7B1JVH2Cu/An8reQcHTFJNq
X-Google-Smtp-Source: AGHT+IG14ugY9dCGRzkJv3mysSlBFDJUUGrxTZrJy1527Qhv0LcCF7CPfrrXwMk04bZAet3PTLwgEQ==
X-Received: by 2002:a17:906:f819:b0:a6a:185a:c12e with SMTP id a640c23a62f3a-a6c75faaf9dmr441230666b.10.1717750727205;
        Fri, 07 Jun 2024 01:58:47 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805fb1efsm217746966b.93.2024.06.07.01.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:58:46 -0700 (PDT)
Message-ID: <be5c166e088e28e8c1e4a09da0ed71163fae727e.camel@gmail.com>
Subject: Re: [PATCH v6 3/9] iio: adc: ad_sigma_delta: add disable_one
 callback
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Fri, 07 Jun 2024 11:02:34 +0200
In-Reply-To: <20240606-ad4111-v6-3-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-3-573981fb3e2e@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Sigma delta ADCs with a sequencer need to disable the previously enabled
> channel when reading using ad_sigma_delta_single_conversion(). This was
> done manually in drivers for devices with sequencers.
>=20
> This patch implements handling of single channel disabling after a
> single conversion.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

You could have this done in separate patches... Oh well, this is simple eno=
ugh
that I don't care much.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



