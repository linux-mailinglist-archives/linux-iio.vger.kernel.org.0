Return-Path: <linux-iio+bounces-16961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF25A64DBE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594223B22BA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44723A9BB;
	Mon, 17 Mar 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+kyM1j+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465D23A983;
	Mon, 17 Mar 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212865; cv=none; b=jwKGWF0KwVTGM3kK9DwkbvPgJhRJvVWtVF2zkj1LPh9GIhGkX0pOR+Yds4ml0UplQAGABTPXvanu5NQ3WEqrFnpkejdqnPGm5kBO9OXD2efbChU4665jt0mujGrMQqAbUS63HSuftp1c33lM1G6vIjsf8EJJlOZZSiruOUDvdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212865; c=relaxed/simple;
	bh=LlCDNKDvo5kEJa8v9yaiQCRUYA/WFkcBUmy5viW6Syk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRr4MF1F8XXxuKF43BkdCp7b3/ZrkWNG+yubB9cshmwSpgyRoIKr/eEWnzICEcGotHrKoptyZmvdq+jTYf7kVdedPuqt9bJ4lZYgnxxvhXbj0McNpizMAyN795BDZIglqoDtvhxuswRKTYR4PDEwVuHx8VsDa3jZaUqu6Kyi3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+kyM1j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A65C4CEE3;
	Mon, 17 Mar 2025 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742212865;
	bh=LlCDNKDvo5kEJa8v9yaiQCRUYA/WFkcBUmy5viW6Syk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+kyM1j+4UhEWVrdDzz1pQqLcE6MCtFOW5lCdm4SxdCObTbZlSf/vDPAHuoYf4hB7
	 bgFytKAtKGbnY4c9CsJCdY9ln+kmcs46dWZjKW0iCESCq5+1TKoOA869VCPi7IIKdO
	 kyd7FYPZ66EOes28NB97UoaoyX9U42CSy8D918cMFb47ngr4CoADR1Yu268is724z8
	 gloAy0smeHU5R/Wxls5KBHh/581peZCdcFWdFPvSJ28ttn5q+iDOI4svsGOWhQ7PMj
	 Vc45NVlQLo+t/EjenHJ+jr4wtBOHvrfeR/s4waUipuUAjAGwXns9F8DwJ+XRVDmh3F
	 uXmWFq3B9ksRQ==
Date: Mon, 17 Mar 2025 12:00:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 mazziesaccount@gmail.com, subhajit.ghosh@tweaklogic.com,
 muditsharma.info@gmail.com, arthur.becker@sentec.com,
 ivan.orlov0322@gmail.com
Subject: Re: [PATCH v2 0/3] iio:light: add driver for veml6046x00 RGBIR
 color sensor
Message-ID: <20250317120050.425ef6cc@jic23-huawei>
In-Reply-To: <20250316164813.30291-1-ak@it-klinger.de>
References: <20250316164813.30291-1-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 17:48:10 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor
> 
Ah.  As a general rule don't send a v2 out that fast - leave
it at least a few days even if there is an 'obvious fix'.
A rush can make sense if we are trying to sneak it in very late
in a kernel cycle, but right now we are right at the start of the next
one so lots of time.

Anyhow, comments on v1 probably still apply ;)

Jonathan

> Changes in v2:
> - fix missing include for example in vishay,veml6046x00.yaml
> 
> Andreas Klinger (3):
>   dt-bindings: iio: light: veml6046x00: add color sensor
>   iio: light: add support for veml6046x00 RGBIR color sensor
>   MAINTAINER: add maintainer for veml6046x00
> 
>  .../iio/light/vishay,veml6046x00.yaml         |  51 +
>  MAINTAINERS                                   |   6 +
>  drivers/iio/light/Kconfig                     |  13 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/veml6046x00.c               | 890 ++++++++++++++++++
>  5 files changed, 961 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
>  create mode 100644 drivers/iio/light/veml6046x00.c
> 


