Return-Path: <linux-iio+bounces-19459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A5AB37F8
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 14:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C14C189421F
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A1293B6E;
	Mon, 12 May 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsdY9hbU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63478F43;
	Mon, 12 May 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054784; cv=none; b=hsfTXy1HMSN8bDLHUDG7YbCRFSLcwVAtgzVfAzK/rE798CzacIcrd25q06+HL7eZBSd/uolWlw6lIvMxqgO9g3M1t/qgwPe/Eic6rOuM/AB4g88sy5oZBtZSG/zrJ+abJnm2jaToYLvJZOvD4IDezjl25bZZB+10E+v108SVFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054784; c=relaxed/simple;
	bh=Sl9HhishayHhuvvB5bQuDThhoqmbFaMgmkYIGRlpRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz13aRkb17Oned2NuzkVEf7pWwqEH7l+6M/LybfjeejdWOGGAGG4BX/iGNleurF31IDIa8UNxlQjJmgPWe5103/YqaW6Y8kj8rObHuOin3yyQ4ilA4T6Lw9jGSlsps/oZS13c/wT46rGKdlg95ZgM6nJhkIq6l5Cd/Ae+ZhXg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsdY9hbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7B9C4CEE7;
	Mon, 12 May 2025 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747054783;
	bh=Sl9HhishayHhuvvB5bQuDThhoqmbFaMgmkYIGRlpRog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsdY9hbUj7lzvgCG+qD3jMnd/6+YmALHBCgEFxiAI5SeZV0QsLiluVIisah5mqeQJ
	 caJXV365FgBEgoe/qhzjhhu7c3uteuwTTdTE3bRKWDQ5K3dNAqMTjp94iGN/dcDq5M
	 dPlrnJtUEJTnW0mCls7X2FaBzWgrV2yiQNPfv0cdFuXUnMbhqlTChttFa4QXMIDG+/
	 BB8J4IKc2qJUPnTY6PslvQOhR2xmcm2HEPMRJ3G04adrg2HGyCg3xA/wYv5+4TMwpm
	 889vc2UYfKPbKuRjWHqDQwoOLvnXaMtx57t8OGRjD4w5t36XsqpPMiGGg+BbLyKttv
	 LZAAXBB1X+qRg==
Date: Mon, 12 May 2025 07:59:41 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com,
	dlechner@baylibre.com, David Lechner <dlechner@baylirbe.com>
Subject: Re: [PATCH v7 03/12] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250512125941.GA2952373-robh@kernel.org>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <731196750f27eee0bad5493647edb2f67a05a6e2.1746662899.git.Jonathan.Santos@analog.com>
 <20250509-gala-unfiled-fd273655b89d@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-gala-unfiled-fd273655b89d@spud>

On Fri, May 09, 2025 at 05:18:55PM +0100, Conor Dooley wrote:
> On Thu, May 08, 2025 at 02:03:30PM -0300, Jonathan Santos wrote:
> > +dependencies:
> > +  adi,sync-in-gpios:
> > +    not:
> > +      required:
> > +        - trigger-sources
> > +  trigger-sources:
> > +    not:
> > +      required:
> > +        - adi,sync-in-gpios
> 
> Actually, this is normally not written like this. Usually it is done as
> an allOf entry:
>   - if:
>       required:
>         - maxim,gpio-poc
>     then:
>       properties:
>         poc-supply: false
>         gpio-controller: false

Using 'dependencies' is fine here. It's actually shorter.

Rob

