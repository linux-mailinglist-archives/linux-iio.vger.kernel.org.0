Return-Path: <linux-iio+bounces-15246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6398A2E8A6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C943AB7CF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925951C700E;
	Mon, 10 Feb 2025 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvR2Eok/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDC1C5F35;
	Mon, 10 Feb 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181949; cv=none; b=XRwVdn6W2JPjMw96ln8D99b/4OveblOPqIpVwLG3B7KLbsgqFSEh7JoxshfgRO9WkF7S6M+/2ky3AzFzT9rivXBfGK2Yd2svMbM9hT6VJRO/5bw2hGXj6DA2205KXA7e7C1YFamw9/NCSPFq79j7dvcc/Va6QzxC85WCiRXaSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181949; c=relaxed/simple;
	bh=PCoRhO+JWlsKe6qwvAJDqDUYtB2ZTHQCOJGFhwZaBNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F5i2taVg3QolekxuSici6++6gwn5BnYyB+gy3kjur8KndFG/zEGH87cDOIdamO/PWE5xEkgoNduZGl2DqOTkGx7ouWP9+PmVa0v1rr6Vaxjd+e2rq/8L1VZhrmB5TJZkyw1d6RvdyD+HLD1oZ73shWG4HX6VTC69TQtr0ODXX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvR2Eok/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dcae0d6dcso1533002f8f.1;
        Mon, 10 Feb 2025 02:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739181946; x=1739786746; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCoRhO+JWlsKe6qwvAJDqDUYtB2ZTHQCOJGFhwZaBNk=;
        b=IvR2Eok/8Bcky1uoLMvdgjATXRwlab0RO3wl2EQiULXefZ/YeEGzIYDWVYAp201SGQ
         M8JzS0puCbaPBGCmFWhmm+tW1lQHL59DLJ9B1d0fatjSsTFD+K0VergntPpIXkvQXN23
         bB3W1y3BIsefaDDEanB9enfclUInYtYbd75MKdP1JUw2hQpDOREWbJeU6fy9vYTk/5Wd
         vA9pJua8jq5ujbTfjGb4XO6FiGPjAeHtVcVo5wbsjVeaocn2DdcA2ac577P6EUfYA0Vh
         J7MTRmk+V4UrIMRK8UNm1TOlsMlKXVv+ttLnPjFyxbYV0hok4xNLfHrRjs9zSy8+zsba
         YNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739181946; x=1739786746;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCoRhO+JWlsKe6qwvAJDqDUYtB2ZTHQCOJGFhwZaBNk=;
        b=ZFUC5p/MUXIKOaqYwpct/jK5JBBjPz6EE+/EOmcFkEeyPhVDSaUREJWB28LovvnUO+
         BrW7dk9DUArjs17Nf2/FMU2xUhS6cbfY80qh+ExsYuCWoA2p5sGYUn+g/DMp6pdry/aM
         EKKkEaVZ0BEugd9cJLOvRHxsxI3ojBToqdHnT02BIb0CvuIW9/DcvbcVivoUKHelH4uB
         DJYnvtmgz1+JjG0hVdi2U/RbeesbEgzlXUwJz8zRR/r6fHP2TJPYAVH7CQ95aYBbp754
         MLJmvqupKEruEQJs4wWoAknljjWod0/M9Z7VhpELqwpdOZI214vDqrV7MHBPLIarT2HJ
         G24g==
X-Forwarded-Encrypted: i=1; AJvYcCUxemZ5RyGOCH6W5ilhljHGh391gaLMnZqsNutYYuAr/jCBq3zTznLJDrRAtMUo0yVg/v6sBXj9T6U=@vger.kernel.org, AJvYcCVX+XtjZlBYncLX7Sh34YrwVWqSDrP9QBf9RkSgYuhXX2MjlboHyNvNon9lpkwpyPFigpP31s1MCAZfEBLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwOIJsEPENWc2iEQmdJv9rgrJJtSCxZx6/h8a15fpCCQUyFWO
	GKw2kerDQZCz9lJVuq1MC5IzZFi4M1H1tVh4jxHOyTpbFmGdNjQ4
X-Gm-Gg: ASbGncsvUP8lWHQ2gM4MPqLsVLdMbqkIe6iirPmQkZtt03P736rnsvELOEV/eUBv91L
	SJtFxStVtQBys7P0XIZoI1NV0DG9ItKBPo8UZa6eVBcsbz5peMuQfQVhGGHUFSeDSFstIqHf74t
	Dnik9NtU5HnYWZJ79V0Qq2m1UOmr/drp+IH9u9caM31OlVBC3xv3ZjRAfItQLwObrPd/zZPFDpL
	DgZK7RtXHOB9gYmgfgRHAbXx89PnormzJnsLN+PMXRhDCuc5D5gutNVmXh07DCBoYTEClwxFK7+
	0sAyLg21dAiJCrw9M8fhYsVNVMIHYdBlotqqrwgyC6i4KRnT7/c9C3LC4kIdIoM=
X-Google-Smtp-Source: AGHT+IHfOQVgrCgUJvx7tanWvrGOS0jm6pbwsmdfcnOKwS9Vvu9ZeNpiXggYOCegxLt1hGLqRJUUfw==
X-Received: by 2002:a5d:5987:0:b0:38d:d759:3dea with SMTP id ffacd0b85a97d-38dd7593ff6mr5236614f8f.26.1739181945606;
        Mon, 10 Feb 2025 02:05:45 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dca34a8sm139844435e9.16.2025.02.10.02.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:05:45 -0800 (PST)
Message-ID: <2ae962c19bc9d180dabf52e256a1d6bf215f9bf0.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: adi-axi-dac: drop io_mode check
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron	 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 10 Feb 2025 10:05:47 +0000
In-Reply-To: <20250208154521.193da461@jic23-huawei>
References: 
	<20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
	 <20250208154521.193da461@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-08 at 15:45 +0000, Jonathan Cameron wrote:
> On Thu, 06 Feb 2025 09:36:14 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Drop mode check, producing the following robot test warning:
> >=20
> > smatch warnings:
> > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode()
> > =C2=A0 warn: always true condition '(mode >=3D 0) =3D> (0-u32max >=3D 0=
)'
> >=20
> > The range check results not useful since these are the only
> > plausible modes for enum ad3552r_io_mode.
> >=20
> > Fixes: 493122c53af1 ("iio: dac: adi-axi-dac: add bus mode setup")
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Ah. I missed this.=C2=A0 Anyhow made the same change directly so all is w=
ell
> than ends well!
>=20

Hi Angelo, Jonathan,

I wanted to reply to this one when I saw it but I haven't done right away a=
nd
then totally forgot. Sorry about that!

I don't really agree with the "fix" in this patch. AFAIU, smatch is complai=
ning
since the enum is apparently defaulting to an unsigned type which means doi=
ng
the >=3D 0 check is useless. But we should keep the upper bound...

- Nuno S=C3=A1


