Return-Path: <linux-iio+bounces-13957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D479A04061
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 14:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058457A1A4E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE218CBFC;
	Tue,  7 Jan 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmrGGuRZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C2179C2
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255390; cv=none; b=Q/91RW7QQ99ynvZso8wHXp48n55V8lxsVBho3rBP2Fns6aLxtF2lIWK2zBmx5DAoYjDm3aXPPTpCPdKxijGrn68Cs0BZ74KmyVrfjx0VIhG2xquJf00ZIUeVe5/JmbNhklOYPzqyua33m/V221amOX/1Dy7dpSfla48Y9+ojnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255390; c=relaxed/simple;
	bh=UU3/4uHfQb3VtHkNmYtmfM7GwRh8LiiIXM4FJw7TF08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOUfTXK6DyJrSP2uKwgMHlgc2oHYrOPobp5fO4p9tAAy35JSNfi2Xc8EWUEeu56mFSA88b9SzrAzxuMXqekvNH0QgbPyFJpllEdcJbLWwQFk1GjlYr5ZAxZboMRMeubrEb2uCD0pnIdw3JhYPDD/9H1t/wieI4t5941Xw9KwJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmrGGuRZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso70351675e9.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 05:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736255386; x=1736860186; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UU3/4uHfQb3VtHkNmYtmfM7GwRh8LiiIXM4FJw7TF08=;
        b=GmrGGuRZi1+S+7CqjxB1QkV/J89ntiQ2+dSTxH9YlnsWU7i7MzvjgQ/KiVUr2YWyyE
         eYSJgy2GyILk93ipj0CLi5r1MhAWNDyGTnv7++NIBHfOYXFxo7lTwZXiJUSPtQj/XHQl
         XjWG0Oo5TmagQl9QS3nrKkcT7IR2m77pjuCsM/uJgQ0JOTee+xIwkbaPfrLygfHiWZ4e
         Kwn0A7k2q0YDuHLhN6P77SrI15Q+ksadDcIQNBySmcoZ5lTk/8ZPbRDsynbt8FuNJ1K3
         +vWIpU25wnkNkMfzKU/yBQzS+CZH0Y7S4VuOnr0hTZaaPGHRSqTGuGLWd8bt9fsVqA9t
         DoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736255386; x=1736860186;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UU3/4uHfQb3VtHkNmYtmfM7GwRh8LiiIXM4FJw7TF08=;
        b=Naxczftts4tTCxgdCjKPQaAmNfWDTdiY/InSTPDEWYHGqEYyqsJEp5htkUuFMi/stM
         KJ4kRd9kkwDfWABIx8RjVn8b6o2buFDjjrQNlOYOf/TK+2lhvGJ6rLutqCyTNh9EZ3TX
         daKLpfrXOT8qKqB48QsBWHhzCUpBkcN25FCiKrH+bNOdM1UsI3I+JbOVXZ4tgHS3oynA
         anNfQE0OlhWtWiMbNbSbLRR5doaqo8BMt7Xnv2bMjEYEPKJfoMNeAkvAToKE8wei9WND
         WpushX2cNSJZjWZmNM5zCM2GEgJvyz1Xlcet9q8qrMOKTdUWttdMezviEN+K6kVxWkIs
         wRNA==
X-Forwarded-Encrypted: i=1; AJvYcCU8QjVPJ0lj1iwldZWDOoLDqyT5swTx9CCt26dx5Wio9kdnF6UN1rihhRq/pTRIh+Enbq7LlkCeSNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8w4DJITZsAPuyvLsBeN3k7kBLgkLshXbiFIP+3GpuAGJdJPbE
	HyTczj8CJ6TNzgkzHkmZPtC7KUDh+n/nWhjVt9WzPk/6bh1oxgmu
X-Gm-Gg: ASbGncu4XwrqWCvuPb/avbeXGE6mBZLb6jeMvI+2nX0jjNNvDcx7jykohPewrHygA4n
	gUxD5+40d9v8JsW5D55bRwgbgdgoNeQAZe6Ezs9njSGx5Hw/C912CZsS9DbrOlWFzR5znJVM7ES
	8mpMOIFvcfE2883YlqGBFd3PcUthIKn6TaL20AsvtlDf2pgnaKXuv9oNOvM69CgoMU1WLw1rlk9
	Q9D1EjHI+uxWoIn9r4j9DtWvm8FvW/lelA+FRVae4/iBGi8nBq4IX0Lhi3Nybb1zX3yam5yLmPj
	2Tujw9nuYDuqNoINhw4H3pTwf+Ig
X-Google-Smtp-Source: AGHT+IHsBJaS1IN8iGUDtmKgWIzFSzxVvJVRhrnN+cAstjmB6TDxQdswBKNZE17GSKSIuFvFXEzfrg==
X-Received: by 2002:a05:600c:5491:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-43668b78471mr565613755e9.31.1736255385541;
        Tue, 07 Jan 2025 05:09:45 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366120086bsm600271795e9.12.2025.01.07.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:09:45 -0800 (PST)
Message-ID: <052fb7dd2d227527e1ab97159849606ce6666868.camel@gmail.com>
Subject: Re: [RFC PATCH 00/27] iio: improve handling of direct mode claim
 and release
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 =?UTF-8?Q?=E2=80=9CLuc?= Van =?UTF-8?Q?Oostenryck=E2=80=9D?=
	 <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	 <Jonathan.Cameron@huawei.com>
Date: Tue, 07 Jan 2025 13:09:44 +0000
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-01-05 at 17:25 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Note I haven't attempted to CC relevant people for specific drivers.
> I'll do that for a non RFC version if we move forwards.
>=20
> Effectively two linked things in this series:
>=20
> 1) Ripping out iio_device_claim_direct_scoped()
> 2) Enabling use of sparse to check the claim is always released.
>=20
> The iio_device_claim_direct_scoped() was an interesting experiment
> built on conditional scoped guards, but it has been the source of
> a range of esoteric build warnings and is awkward to use.
>=20

Curious about one thing... David, wouldn't your work on 'if_not_cond_guard(=
)'
help with this messy scoped calls? I saw it was not merged yet though... Wa=
s it
dropped for some reason?

Anyways, I do like this approach specially due to 2) which, likely, it woul=
d not
be straightforward with automatic cleanups (if feasible at all).

I plan to go over the whole series in the next few days...

- Nuno S=C3=A1



