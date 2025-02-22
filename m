Return-Path: <linux-iio+bounces-15943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69218A408ED
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646A57AC809
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1A414AD2D;
	Sat, 22 Feb 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atQYq1rS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27786325
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234213; cv=none; b=gnR5rlKi9qm4i3FOihmYixtURhODsfki6h/IvONV7Q1i/3ISCXMOfzhhRwmDaw+lunBJw/dtzBz6KMrhhFcobC/uNyNYiYa/TTKsFwN4pekSaeJ+jQbrBwpCMnvXMDV5U7gx1vXDHfWnsKYB+oKIQIdOn698OFNvjWmlCxETswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234213; c=relaxed/simple;
	bh=fEtSZvRpTiOAm/jj0LVTunh8ZjRwNhnIJGPdNfvdtUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NefU7WJS2cL8DfD/a/M/RbDpTOUKimgfaMUmPf28FNavv2C1IgSjjVOW5HZ6aKDuaeXtp8L5omNHpZaGwHnzRV7Z1NtIL3fEw0a+58wr4OCWd2MgALtZIv9pYBZoYlMRRB+2dYzxMJ429hbVpjS1+Qr+4aBj8I4/Cnl2mtoCWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atQYq1rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6CBC4CED1;
	Sat, 22 Feb 2025 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740234212;
	bh=fEtSZvRpTiOAm/jj0LVTunh8ZjRwNhnIJGPdNfvdtUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atQYq1rSGffUw+yZdkNswqnwNf7LnTxHAN8XiCtWjEaEq2lsLhcEkKHhocV8DcBBw
	 fY1Z7fqZ1tjCZv+A5e0OWZsKJNhdYGlfapJcMB0deTb2/g6xT4Ca/eof6See9YsYxO
	 0QqoMoIwMVuCrzWog3u3nyCYTxQhf1JwvoqRdAITtKDqooWMGOyCp6TKGonrPbPw9q
	 Rv8rTufsfbkitW/KjLc7qz+coSeFxYsRwDZ4Sx+KIb1//EplKB0avRKs7A0smDIkV6
	 r4Q9b6HNY9nbz17gcmEzKzZdWajQU1MESOW5Tg+8JFdF6m/9sfPp4pZBD59BfIZkou
	 UelkP7zjWukxg==
Date: Sat, 22 Feb 2025 14:23:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Olivier Moysan
 <olivier.moysan@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] iio: small fixes and improvements
Message-ID: <20250222142326.785847e7@jic23-huawei>
In-Reply-To: <4bf45120-d9f5-4c31-811b-655962984ba1@baylibre.com>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
	<4bf45120-d9f5-4c31-811b-655962984ba1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 11:29:08 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/18/25 4:31 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > The first patch is a fix for the backend code dealing with
> > direct_register_access. We need to properly terminate the received
> > string before passing it to sscanf().
> >=20
> > The second patch is about using the simple_write_to_buffer() which makes
> > the direct_register_access write side more symmetric with the read side.
> >=20
> > --- =20
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20

Applied

