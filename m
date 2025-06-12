Return-Path: <linux-iio+bounces-20529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958DBAD6A40
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ADD3AC135
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB6020C031;
	Thu, 12 Jun 2025 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="edDjj3Bd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD042A82;
	Thu, 12 Jun 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716222; cv=none; b=QrkG6JesbLH3fjpc3P4sgsD4Q2PLmhUW4H9xUW8RUVcUtgF7Cq1Tnsm88TKfTVa/zS4coBjOWXdeG08D6mRE0+hU+Z5BRB6Y9GfZJU1f9hXJzO6F+OJmNYhfujFSVlQ4BW/G/pFdKhSW2SFTaPIhbvHIFI/PXSAO6u7cLeT8fPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716222; c=relaxed/simple;
	bh=zdD0pGeYxeNtR2mZAMdYcuHzGp8sm1K4vEoldgNKWXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkDtZpWGjEvAHp5g4HC0OOqwj/eHmltDUMHYT3m4cPegiF49pDr1e8bLw5D2xB9xXtspEoPuU7lEZ+lm6ZUEdBxjLZzIyPnnKk+R2/LqL+6QHXbhf9RkxsZVodUBUWr3otMXoYllLEIfEfWbF0Fpxx3ErIwEzzaT4OjzR4LWygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=edDjj3Bd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E7AD31F918;
	Thu, 12 Jun 2025 10:16:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1749716211;
	bh=3VR5y0yctXr4XPaqy1aKaXDWdxCZQO5tubS3+gM8YMY=; h=From:To:Subject;
	b=edDjj3BdUD1gnQTpkEmdkcP/wnYtbxZpJQrdMyg+rC/QFXCa+JIfLShC/OZlNzqXg
	 siW651XVhV8xzKaR41qq0o55LePizdTglIfnsFfkIaei2IWPK3XPjDRCGLc7DtWliH
	 15l0Ln5GvzV7C3u1AzGxO8E7fdhQ89PfiYARKBmK48unDPrYwQfMQ+8335QnqrCBIP
	 oKNsXEW1QdCtN8RwAAmRcx1x6nysHGImfBL5SI6TncUmcQVSS6d9MpCKVqT9mRVOfU
	 ivF4lOQaobzt5BZ2WKmfUn5UbOrNE457dQvNqLFBpOHibGKmiOQM6A4fCPO2K00GKU
	 kwXJvloiVXvFg==
Date: Thu, 12 Jun 2025 10:16:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
	Roan van Dijk <roan@protonic.nl>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 09/28] iio: adc: ti-ads1119: use = { } instead of memset()
Message-ID: <20250612081646.GA316795@francesco-nb>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
 <20250611-iio-zero-init-stack-with-instead-of-memset-v1-9-ebb2d0a24302@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-9-ebb2d0a24302@baylibre.com>

On Wed, Jun 11, 2025 at 05:39:01PM -0500, David Lechner wrote:
> Use { } instead of memset() to zero-initialize stack memory to simplify
> the code.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


