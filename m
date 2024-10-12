Return-Path: <linux-iio+bounces-10505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4AB99B4E2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE731C20EB7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED4183CAA;
	Sat, 12 Oct 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3yQUHpV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C516F826;
	Sat, 12 Oct 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736819; cv=none; b=iy3NLXV1jA5Uau3FwBowWD6j2G+12JU6ThgFwqS86XuDu3bOqm0oTGB5Zmy21K4kW5EL8Wws7DpytpgzzhJvrAAeYc+rBxGX2aowaQ2NmXt2fE/G/6BSwsZplDfnA7Y7JNvI1AF6ie3Y46q5OcxQo3qMclDNnmSKxMiVH/K79JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736819; c=relaxed/simple;
	bh=jIHKuXxG7RdcY/yByMCx54EVmk/+xKzgtcQYyeOtGEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr5aBRDlZwgCQnK2oXd1zHNFgTeCQWLR1aZbpsCcazEy5/JeEgk2culilb4YZVwpOULMpJcLHyiJd2nyWxnzcluHrQZMbtlhe/cw2QRKtrD3pz+3LLCZieMl76m+aPmYbGcDj4AD1T6GNwFg5v3iHY/3XOMa++ctNojcoSjwR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3yQUHpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF8C4CEC6;
	Sat, 12 Oct 2024 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728736819;
	bh=jIHKuXxG7RdcY/yByMCx54EVmk/+xKzgtcQYyeOtGEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3yQUHpVU7WBvOwl6GPY6lL6NgTpIzcJXM1wuwdBHsOe0sV8V1jQfnrm3XF4pDhLj
	 rDOQ2WtRuMeDB5+dlApnOCweDjXpNoqLm2ZyCkj/eImkoWdBd/yTovtMcUBsJe9XtJ
	 ose6ikFPeRTTSxovbEOPdSPTW+P+UQS+NTBEjiRciChnxNibjusdc3CWM83HdZWoPJ
	 dk+fPMauhF48gC7VCs3msd28nRWGJl2W9PXYpbJl6LPRP80BkX7jP9RL42Z8JfCIR7
	 Ub+5JsiPnHUNk1F48SEV2FJEG8Y7KcC1c/qsIG9wqoHQzEDKRuqyZMtHRS2ZFFau2j
	 gERpqWtfoJvEw==
Date: Sat, 12 Oct 2024 13:40:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/3] iio: adc: add new ad7625 driver
Message-ID: <20241012134011.55870567@jic23-huawei>
In-Reply-To: <6f5sqahnu6nxmzzxfj56432eogjcgell7c5sth5c2arvekl4sx@ndf2tdl73glx>
References: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
	<20240914182848.34edc5e3@jic23-huawei>
	<6f5sqahnu6nxmzzxfj56432eogjcgell7c5sth5c2arvekl4sx@ndf2tdl73glx>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Sep 2024 13:52:40 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Sat, Sep 14, 2024 at 06:28:48PM +0100, Jonathan Cameron wrote:
> > Uwe: From a quick look at [1], looks like you plan to queue that lot up
> > after the merge window.  Would you mind doing an immutable branch for
> > me to pull into IIO? =20
>=20
> Yeah, I intend to put the changes that are necessary for Trevor's series
> into next after the merge window closes. I'll let them cook a bit there
> in case some issue pops up, but then I can create an immutable branch
> for you of course.
>=20
> Best regards
> Uwe

pwm tag merged and this series applied.

Pushed out for now as testing to let 0-day take a look.

Thanks,

Jonathan

