Return-Path: <linux-iio+bounces-27568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D537D06B4D
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 02:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4C73031989
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5A224AF0;
	Fri,  9 Jan 2026 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LRIkXzIr"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952921C160;
	Fri,  9 Jan 2026 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921310; cv=none; b=YXbc6rv7rxNiFtpOwwjGrxwLtKH5vV8LCmAVETTPFOS4trlcrCiuhBrcSvC8DTEHp2y+JL2fUbKPUhviAb3v3peDUxY8TlnndjM1mzhDE8Mn0hmYd44WNtZI/0JYETPwNy/P+HJUfNj9iZJ3UXBc8uWyUUic6Szbuckl/b1eVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921310; c=relaxed/simple;
	bh=q3E163uI3K5tcHbZm92cmc4Zh/3hUlsioPVQnfeSCfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lwwn0fFdchpqtaD+WBuY6J0X02/A9HDNBNzuMu2sesbYwVcfoTQNpKuMrZisskmDBaxrTelLRohWkKfr6MKpUAx1ac2/J8psv39itjmF+751iXyFueaI6L7tiOq+iO1oiVvwmiDVcfqJVVbtDqPa6c7kLL3uCtOi+Y8eKAEvwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LRIkXzIr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767921306;
	bh=q3E163uI3K5tcHbZm92cmc4Zh/3hUlsioPVQnfeSCfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LRIkXzIr3s7sm5+72Xzzm8SjVCwh35y5UgkNyHoV+JM3WTIw4jCZ0lDvwCm+aPN0e
	 OQgFLIKM4BqvXo0NDLP3ls7rFqmmBeyhe3rnpJu/pg93332Xw7ohD6Pd9ZJ/hjBMlU
	 PRjuB0y52YZmZ4+MH64SFaK4M4cz7aGbppx05rQHhJZ74p/FIDNPTDWN0K4c0V0JgD
	 wiw55qfCcmMSwZ6OUkuCfyWIamYz6ikXWYRWi0kp9pEh45rf87ky9C+o4xQpR/1WKQ
	 AYxvTEvGFmjwoc8wcX4fj2oaw7HDda+hVz5pALgfHA8ZdaPbXUesk0VOJX+gMBis+I
	 YapIA/GolbjCw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 50B3D7E142;
	Fri,  9 Jan 2026 09:15:06 +0800 (AWST)
Message-ID: <0671df0ea3568056e4d46112c4c9d132c64aed01.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 02/16] pinctrl: aspeed: g5: Constrain LPC binding
 revision workaround to AST2500
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Fri, 09 Jan 2026 11:45:05 +1030
In-Reply-To: <CAD++jLmNGrDt3_w=DFnBnjEuz3LN-=uc1o9KHv1j=4gbGPoPQg@mail.gmail.com>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-2-21b18b9ada77@codeconstruct.com.au>
	 <CAD++jLmNGrDt3_w=DFnBnjEuz3LN-=uc1o9KHv1j=4gbGPoPQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 22:37 +0100, Linus Walleij wrote:
> On Thu, Dec 11, 2025 at 9:46=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
>=20
> > Discovering a phandle to an AST2400 or AST2600 LPC node indicates an
> > error for the purpose of the AST2500 pinctrl driver.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>=20
> Also pretty obviously correct, can't I just apply this one?

Yep, I'm happy for you to apply this one now. I marked the series RFC
because it's a bit of a scatter-gun set of changes and I figured there
might be more feedback than I've received so far :)

Andrew

