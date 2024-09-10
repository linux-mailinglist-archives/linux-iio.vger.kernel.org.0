Return-Path: <linux-iio+bounces-9426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF95972BAE
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 10:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CDB28A61C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977E118D649;
	Tue, 10 Sep 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izI6WbZk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CA174EFC;
	Tue, 10 Sep 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955712; cv=none; b=kAuoGPAntSYjUQDbus6L+OXFkZQ7ws1wf/6d09JO6ARAxtKKBg5BpPlvsd1kv6oeJBK6ZHNdHQeJB3acmTPXhcQUC8SgK8/V927JKwt/L2w7xGG86IxhZTScFjm7CObp4pmcKsB2pPlDIbUM9MsOv1jy7jf6Nn+qe3Fa6fIcnPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955712; c=relaxed/simple;
	bh=ouoonEplLPwSxZkoSj2E1PtZlp2iv3h/AHqc/FfODxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8HcQzae4sd8CJyiUeuz1ebjFrMya/zcPr7iXdVtZnxPQwDhfCH7NgjAeLAqWhSvc/TK9sbxcda8Ci/b6Z3l4AZM1qMbYkq9DklwdOC4vDu4oMNQrWR2ufzL3sEqUszYIu+O2Rw6yHntFOz0uUWvKULhrvTsAUltNAw4ljFDqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izI6WbZk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so28469345e9.1;
        Tue, 10 Sep 2024 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725955708; x=1726560508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ouoonEplLPwSxZkoSj2E1PtZlp2iv3h/AHqc/FfODxk=;
        b=izI6WbZkE5oXc+Xoo9ljSOXgjO8NtkvExAoj1ta2ArIgHdul7Kk5q/i+7mWcW0kvzV
         wce7yBKysIH/YpHlq3I0+jvGtBjDP6sF6iuZ/kxdzXWgqVMt1EMNkRMb1yHzu/0gFd2g
         92QXIjnh9tvz1NMSQF9w2WpzgQxw1JKUcgSy9ma4mwDc78mdHg4DEyWDMmaQm31Z/bQn
         KknM31KMZL9WeN/W6PqqFOl088GxStvd2OZaXmPx8Q/uOfq6IbAFnCCV5bZHruBe28EA
         tbOsg6CZ7J0hldNaRtjk1qXxvt10ArEUaUOm/lcKTE8h4tKVtXbmgfBzJOrXA5cgejiQ
         nKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955708; x=1726560508;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouoonEplLPwSxZkoSj2E1PtZlp2iv3h/AHqc/FfODxk=;
        b=r13B9AKtV3pCIuz9tij9EDKFrITW6x4vvx0lPaXDEj/Kh2SDAVBeb9bx8JJdbcZgNg
         Ko1t2LP/znIk8L0JjeXoOTCskqYXPkG8UNPc3KPFlaceMXMFA6eHdM5bbCcKvxzHhzMB
         Vmb7y6TZW2BK9QtzgnmlCps9Hum724sKm7k7zEJgQNHzWEkkJWO2n/g7pBqqeTbAuMd4
         QABBaHiMed8HH2ic1WokkEoz21hSTZCHP+uBST2imJe5pv909sTrqbmEG1LUdvo4tq80
         GO/ZRxn2tdon8rQxKTuySR9ZQ2pq2xDTwHQHKD8MBo+h959uFPlqUTfP+Rv0EQedLi5M
         QuLg==
X-Forwarded-Encrypted: i=1; AJvYcCVEBHc8dOo4OGSQS4PDzTiUr/vnhFhD598BpO8DsgVFuT+ECuEVUGD2erhbVUMhGLDmtBiXOuo0DVQV@vger.kernel.org, AJvYcCWIVYSIC8+uxlp0s2E5hL9h411VJpXWkg2TH+Xo/jKe6OFt6Dq7bPZyJfRWn7zHcdspqJbzUSSJWmZrdp7q@vger.kernel.org, AJvYcCXANhpZv8qoEJd1b6SH4+tKKL5pvi8oP1jqPQE/Ln4lkBK/wsvEaliKzYs38y5MeWx8eWuAW+JsyCO4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0mz/gAn900g9z28cJhk7A1IO68TtZGrCjGA0Qlh7KabtwPOX
	DRC7OuOpR83RTPe6yzuu4euhryyn2o2KOlPqc5ZJrAKyr4eMuZ3w
X-Google-Smtp-Source: AGHT+IEq7FcjLR1iTKF/2cTQ3RHcIyuxu8ctxoMnjHU+K6yWQHO77ht4wSQcI4OvfrH0BvTy6RUXaA==
X-Received: by 2002:a5d:58f8:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-378895c9c3emr8635840f8f.17.1725955708372;
        Tue, 10 Sep 2024 01:08:28 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caf33e9b2sm102001305e9.14.2024.09.10.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:08:28 -0700 (PDT)
Message-ID: <a8941a316a96be620a058be853b55923ab51fb5b.camel@gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron
 <jic23@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Date: Tue, 10 Sep 2024 10:12:36 +0200
In-Reply-To: <20240909-retrieval-guide-da2a35e571a5@spud>
References: 
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
	 <20240908132925.331c5175@jic23-huawei>
	 <20240909-dwelled-specimen-949f44c8d04d@wendy>
	 <1dca9ce52e7c701c7fb6cbbc723e9dff5d0ace8b.camel@gmail.com>
	 <20240909-retrieval-guide-da2a35e571a5@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 17:06 +0100, Conor Dooley wrote:
> On Mon, Sep 09, 2024 at 04:03:17PM +0200, Nuno S=C3=A1 wrote:
> > On Mon, 2024-09-09 at 13:46 +0100, Conor Dooley wrote:
> > > On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:
>=20
> > > I'd also really like to know how this fits in with spi-offloads. It
> > > /feels/, and I'd like to reiterate the word feels, like a rather simi=
lar
> > > idea just applied to a DAC instead of an ADC.
> >=20
> > The offload main principle is to replay a spi transfer periodically giv=
en an
> > input trigger. I'm not so sure we have that same principle in here. In =
here
> > I
> > guess we stream data over the qspi interface based on SCLK which can lo=
ok
> > similar. The difference is that this IP does not need any trigger for a=
ny
> > spi
> > transfer replay (I think).=20
>=20
> Right, if the trigger part is what decides it for you then I'm wildin
> here.

I mean, not only the trigger. These IPs (axi-dac/adc) are meant to deal wit=
h
data while in theory the spi offload principle is about replaying any spi
transfers. But yeah, the above reasoning does not make sense as a data tran=
sfer
is still a transfer.

FWIW, these IPs are inherently offload HW as their goal is really to stream=
 data
without any SW intervention (so called HW_BUFFERING in IIO world). Just tha=
t
typically you have LVDS/CMOS data interfaces and now we have a qspi interfa=
ce
and a spi-offload concept already introduced.=C2=A0

So, yeah, as we want to have spi-offloads documented in the bindings, we ca=
n
also document this setup with the same bindings.

- Nuno S=C3=A1


