Return-Path: <linux-iio+bounces-24883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD099BCAD17
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED667423DD5
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 20:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69436271457;
	Thu,  9 Oct 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezUSbG/4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272432673B0
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042341; cv=none; b=CbrOpZE3NZrDzVQt264lO0DGWLAz89ew7SyF4wNM87yKVS4KsG2plOXpSfasBAYuo672GCc5TM/s2VJoMj5cMjL3H98fbjuOTj44RCQf4EFkYIurJskVI8suih2dcsE6xHnSZaPmYgwDmtJuhhZuwz6eBdptNpSNKeCi6p9QQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042341; c=relaxed/simple;
	bh=mIVtqkoNHttjCPXDk6uG5CeUCLmdpbJkVI7Bh2VlxCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2ds5ie+0VZewo6al2NNqjbpRkPA5TTVyoJKtiQAMwtrO8HQ1yFQkd79znJeFAEwuhLyNeC/HMrhFQ3mO9yQ86IWIOi19/JClplYFAajsUfDLMdwfajrshwNSQrLMMZCkPGN2w8qONIdwqVxMDhAYSZzp4pPbx3guTzr7A2vtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezUSbG/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A112AC19424
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760042340;
	bh=mIVtqkoNHttjCPXDk6uG5CeUCLmdpbJkVI7Bh2VlxCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ezUSbG/4HLzhlOIpwdPbTC/dtWhJviV35ztg3F4zoSz+nS7mOHx8Qf1cphvTqYqQA
	 W0cILIn0j9TqxorBQZW+QznOZ0ZLJGUo6cQ4cVJ/WQdDjouT5fXkdtlWGvGFRKnDl/
	 +h1NKeCvUZ8Bny6Rays9UJz/7i4Id8HD9POHs/NyoXO055441uiZfKph7+XJ3Scgvt
	 wHiasq8899jTpa87VY0yRJpxsvxv4fJj9N0fH/H7LSLSsgE29TokrbMucMVz7NBB7C
	 NUyMN0piwd5giT3xjjt/EdHqVm8mLShlo3AtSQk5Hywe8uykkcYs5VKLiP7O+WbRT1
	 nfZ9lexZS/rAA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-637e74e9104so1872956a12.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 13:39:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu+RYDU1ASjsLPcZbppth7X2VsB+VlueaYprePkIEKDktzd6qhwrEpymiYMAtCPItVVbgf4BjpuSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz68F7m5iNXrATqJwnRspk/MIMr0yJIhzZy783D0grgVmKGQ1q
	Jx/IjP3XcOvM1kWK7ZagiYDWy+64+26k0ipXd2ErUwffaPWcZrEKItnQwayTG0u2BsXtHPP/qw3
	v/p1JN9iKL+ePvK9MHP4Vk9ZuyfPv2w==
X-Google-Smtp-Source: AGHT+IH3D5YG1N5W9DJ6bwWcEifhOaAxT9fv17ap5/spx59HvFJO4h0SkNj6vDTQE9zH0xGyjxXBBrlJg9ToKlaLQG4=
X-Received: by 2002:a17:907:3f0c:b0:b48:44bc:44e1 with SMTP id
 a640c23a62f3a-b50a9c5df92mr994181566b.5.1760042339051; Thu, 09 Oct 2025
 13:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com> <20251009203509.GA3296392-robh@kernel.org>
In-Reply-To: <20251009203509.GA3296392-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 9 Oct 2025 15:38:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKYqw0podCR7rQefg5c1-1-Z5xN9H7zGVrZzCTunmdRUw@mail.gmail.com>
X-Gm-Features: AS18NWDa8_9bIdD0_ZhF3vqk3xljGBSl_cSYfSe1dmXrF6H3s-saKeXGIcN2Leo
Message-ID: <CAL_JsqKYqw0podCR7rQefg5c1-1-Z5xN9H7zGVrZzCTunmdRUw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] another 'interrupts-extended' replacement needed?
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 06, 2025 at 07:21:16PM +0200, Wolfram Sang wrote:
> > Hi Rob,
> >
> > I want to fix the following 'dtbs_check' issue:
> >
> > arch/arm/boot/dts/renesas/sh73a0-kzm9g.dtb: accelerometer@1d (adi,adxl3=
45): interrupts-extended: [[18, 2, 4], [18, 3, 4]] is too long
> >       from schema $id: http://devicetree.org/schemas/iio/accel/adi,adxl=
345.yaml#
> >
> > However, this series uncovers another place where 'interrupts-extended'
> > is not recognized as an alternative to 'interrupts'. Namely, when this
> > is part of a 'dependencies:' like in this binding:
> >
> > arch/arm/boot/dts/renesas/sh73a0-kzm9g.dtb: accelerometer@1d (adi,adxl3=
45): 'interrupts' is a dependency of 'interrupt-names'
> >       from schema $id: http://devicetree.org/schemas/iio/accel/adi,adxl=
345.yaml#
> >
> > Now, I wonder if this also needs to be fixed in dtschema? Or do we need
> > another way to express the dependency?
>
> In this case, the 'interrupt-names: [ interrupts ]' dependency should be
> dropped because that's *always* the dependency and the core handles it
> correctly:
>
> dependencies:
>   interrupt-names:
>     oneOf:
>       - required:
>           - interrupts
>       - required:
>           - interrupts-extended

However, the "interrupts: [ interrupt-names ]" depend is not handled
correctly. It would allow 'interrupts-extended' without
'interrupt-names'.

I'll make a fix.

Rob

