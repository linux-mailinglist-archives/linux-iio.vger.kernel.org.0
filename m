Return-Path: <linux-iio+bounces-18041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B66A8717B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53528460474
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62517194AC7;
	Sun, 13 Apr 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Qn39pN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317514F9F9
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744538730; cv=none; b=JEl+poQOe+9laWifUYyWHyVCdaH03AYu4SCxatQ2WqvL9JBeCN/Ik/e1V/Kch7dRgWu+k9vlEFi7OM14/3DqZ52O8SjTANmFxTh6UbvJyUFKUputWWxNRSXqDPBu+3cZvjZOIgiU+vwSrY8BPJGPS+6uuhYVSqYYmKtnfUrpEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744538730; c=relaxed/simple;
	bh=nqQmIrEV4NPr/0WiOeiW/2JmyrXwNT/1Gefx8rHeBEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4Je1hjZQHM9ZxaDwmOtuDTtIjbTQ3ZF4rtAVYu8/bj02HA4hoGhUfCCNnbWMdPa89PJQrZsQdTh6H3F5Rwzz+p8nXq4a7aK7liOaSuiJjdV8o5CXDUX2vaUAih+fV/65zgxymKgZN7pAVPq4obMLW/fjgaAoV70go3lDtek/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Qn39pN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F13C4CEDD;
	Sun, 13 Apr 2025 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744538729;
	bh=nqQmIrEV4NPr/0WiOeiW/2JmyrXwNT/1Gefx8rHeBEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1Qn39pNwk0saKPfRbr586oB0PNRqrc3GtFMIHuyPchb7GF0H79SHaP4gsU7HLLFp
	 hBx5NQNLSxLZ4O2waavKPwjcMc0jPaTK3Vn/rq/vi1wu3hPu+8pVC6f02eaWUPilM2
	 ZhHdppoA//XUFIjR7hY6CSpLewfC1UYV80vVATWVaXqOvKSgVNH0jiulZ9n8NXfGxy
	 Q7Q3QCyb28DiCvpOJRdOOscqOl9oGJCmx2d4tWRXD3BVkpzLrZpJbZtT6V239a6VN3
	 NdARp0utK3UbCJfqwqbXkYSsQEzfhRmDk0MURJugdFLEuN4cwUrk8zQveQLOK9JOLQ
	 DpetiiZClpZZw==
Date: Sun, 13 Apr 2025 11:05:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/20] iio: dummy: Use a fixed structure to build up
 scan to push to buffers.
Message-ID: <20250413110525.6a6ee738@jic23-huawei>
In-Reply-To: <b3bf13448a0eda9e83fd501fb4fc7e29070bf0cc.camel@gmail.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
	<20250406172001.2167607-7-jic23@kernel.org>
	<b3bf13448a0eda9e83fd501fb4fc7e29070bf0cc.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 17:34:48 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2025-04-06 at 18:19 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > It has long been discouraged for drivers to make use of iio_dev->scan_b=
ytes
> > directly as that is an implementation detail of the core. As such our
> > example driver should definitely not be doing so.
> >=20
> > A simple anonymous structure definition suffices here as even though
> > we have a mixture of signed and unsigned channels only the signed ones
> > use the full storage so the unsigned channels can used signed types as
> > well.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v2: Add a comment about stack buffers not being DMA safe.
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
I'll not pick this tag up given I've changed the approach based on Andy's
feedback and some more thought.

Thanks,

Jonathan

