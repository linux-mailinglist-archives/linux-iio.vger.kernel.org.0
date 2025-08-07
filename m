Return-Path: <linux-iio+bounces-22413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3642FB1DEA0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E520E3ACA78
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBB212B2F;
	Thu,  7 Aug 2025 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj2NoVBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35F145B27;
	Thu,  7 Aug 2025 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600822; cv=none; b=R/PUg5gklFsVMnOBANHQ8bLf9Qzv5balmCBIESjgr3QmqEtqTLeRzs2hJGJZsxyA3VljVdZcBiL2IYxNeS2ntdamqeWvpitTqPbVpPycWGP7gB3mYi2Tazy4wohRRe3/h9IX6y9fXCpj8/x1tm37oxmL7CwOxzlJWweeWPpXFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600822; c=relaxed/simple;
	bh=rMItP4ikaEVzI+LbusSiwqOnI8bnBwq5O+Xv1fRlC9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8JQ4nA9MUx1knYU5n3XOGdEo5U/dSzY8MWVKA7dMesYuPR19q9onxGKl9BxoP0MM4AymeahHkLa5v8yqu930okw3Cy9d530wu2KySM6tYsmWxPVI5CxerVexv8zz8bAoW1LXeJ6Yfp19o2aRjq9FEHC6ac0ADJVM1g/AUTy7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj2NoVBp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso2196596a12.0;
        Thu, 07 Aug 2025 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754600819; x=1755205619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMItP4ikaEVzI+LbusSiwqOnI8bnBwq5O+Xv1fRlC9Y=;
        b=jj2NoVBpwAQygSRRxcUTiw1qWFOJ/WTrBUbQUSLV05yO9AmXCLLMyN5rBn7kVIP1Xq
         k/P8agxLg6CSoosZTFXxPQfb1mp8z+vOu86upHkNV9LAlL8pZJtDOUoQVCxRcOEsYMIX
         N9r6M8kT3U/xxe9W8mv+wEzEDzPF/2dskhg6Z4KeCcY8B59iOHRSTP5VogVQus2MYunM
         tuudqxec75yJben1FtTHr/7Y/AvucaFBQYgNoMm4J2A5ZDc8TJR2ocQGlh/Enw2TLcS8
         3K8macjBvr8fooKDs07FoaqfpbqRLWQZCqRQLOTrjNVtrCkzilXnZgXCLInDc6NPgRDu
         GavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754600819; x=1755205619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMItP4ikaEVzI+LbusSiwqOnI8bnBwq5O+Xv1fRlC9Y=;
        b=L2/JARng4xtJWFB5m49erFQpnyzSZ3uR9lxlIx3V1RprqJvpzmnOXDBPd3IzRvm4Ma
         mtjNCJfImacORWnWCmSNLHzY2YAdnEoRlJ1tuLY77kCma+8ZXqAjgr4FkmXPZX48R5gY
         efJxhvmQ92TlaRjnKwaYWlGuJ8myeWl5TJcf8leDjMda/AXXpPzvoesq8rvhGSyEn5Vz
         bK2tu5+39Rwowb+sMiaa3ExSs9Wf3cpsdEjxq6FYUn0gKfSANzkTH32Uv2VSwIhAk585
         tADiVFgcDEdvR3pwdpNiuSNatNq7dEBfPBULN2SfPSz9JcxyveI7ZYEJd9/eBUUz64Lj
         1AgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUbNmWqvXbF/HlURm+PBLiR2EfXhZ/ZYrWxu5IX8vSk/4+ZGo907ggKlOR9wdBOQ2FqOsSQO3MyG4=@vger.kernel.org, AJvYcCVq7latP8KvY0mPGOcQsWujLWgblsPNftpAAtwoSC30AMCGwvbwTZoVsvvwDQZkqeETDe/cWX2svXBj6IyC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HAWSn07mVo/0iUF6KWcbDcFPZY4LMqbbEJtU8tfxRVeKOdnK
	BOBKGTOOZoDQbzRIQEXw4/7NLSRZQxEq11vSN3MRv2czJCxFDoL04kCtL1FeRhDwIZYy3UgE7g5
	ZxeEFxtoSzAaidDBR23UdvCafAXanei8=
X-Gm-Gg: ASbGncsM3YvUo2G6ZEuDyECEfkJXDCPrNTSeuZ6JuWcqwMXTV9JcMW5/iKyqz5xCAU0
	oyUFkY6UNAbYiiIBubPQISTafQVAkQtkuPMx8zqL4ZZ3D+evrJyUvo/5oaV6tHeH21EeJC0GNLe
	aBYXLvJ0wBNbKcKsMbUmhw+1OSug0TtqY+cClLlzFv/L5xu1Xwe06ACf5p+F6wP+7MsN0xmXaOv
	ShQOGCo0e3f1oHlX/gyzfjsMUDfipLcQILy+GvqOQ==
X-Google-Smtp-Source: AGHT+IExFTVgQgJ2wQwa2dJ9PLbSD564WdrW8sUL4ExWO9YUSD49bYJOM4A5xT5O+e1cik3MsLp1Pi8UgWR1iAfSOnI=
X-Received: by 2002:a17:906:d542:b0:ae3:6657:9e73 with SMTP id
 a640c23a62f3a-af9c637547cmr40852666b.20.1754600819273; Thu, 07 Aug 2025
 14:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807074850.130831-1-stefano.manni@gmail.com> <20250807074850.130831-3-stefano.manni@gmail.com>
In-Reply-To: <20250807074850.130831-3-stefano.manni@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:06:22 +0200
X-Gm-Features: Ac12FXz_Eta3IwJD82m72eL07LDcMnJjrSk9AQZ42AoeKUlv8XLJhW3otuIspUM
Message-ID: <CAHp75VcdZsD8rN8oSgPXUyy7E+aphorVd-o7XVPS9KYo+SP6Fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad799x: add reference voltage to ad7994
To: Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:49=E2=80=AFAM Stefano Manni <stefano.manni@gmail.c=
om> wrote:
>
> AD7994 supports external reference voltage on REFIN
> pin so if a vref-supply has been defined it shall be
> used.

Now LGTM
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

