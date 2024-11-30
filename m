Return-Path: <linux-iio+bounces-12891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB59DF2F6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425F2B20FEA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FC1AA1EF;
	Sat, 30 Nov 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uchqTNKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7507132103;
	Sat, 30 Nov 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732998121; cv=none; b=ON5G2KJWTj4XdyBrof9nu90AEybkedFzgUcDAv5eGUTmDm3V+fjw/3R5o72n9oT594mFxggugYOuntoxMoSDtaIYosIC2q6KzS0eBWLdW5CaYdpAZlI9zo6+YahN7o/mAQsMaZBmBaHw6H2lfS6goocxvQ4GeT+qI4JJ8ZLpEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732998121; c=relaxed/simple;
	bh=2nE1h0yILU41OiOECNUhWVit38qRQPHqhrGDzevoGSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdusPznxnurOqt2F8YYHbdm+iiJ3US0JCk0E5qO0wqNIq9DVV7vSqTRvC28DTEJORLKtVnoNHHaG1EhQXI9JPqZplhCplo0BT+IM0tZAz9SiDOa4xPxbKJ/9eqIm/Drz/dIi1r0vLRArD6pDKfFGJ5SM+Mi4MKmrPGYu/maEfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uchqTNKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48620C4CECC;
	Sat, 30 Nov 2024 20:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732998121;
	bh=2nE1h0yILU41OiOECNUhWVit38qRQPHqhrGDzevoGSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uchqTNKXkdKkctS8LhLVbwuMNhtxMKvl7z9lY+sfzluvjlxV8asm/XCGFr3mkyx1C
	 ZQ0jVL45SEpvkWtIcmmtc7BFjMDwQ3gKRNlDg17Ztl+JVHi0o8xUilnaMZZYjO3eDp
	 +48Ei9/TJzslWT906vuqT0lM8NJlCob1rdSEicJFHLo0RTUcYkR2PQyY03TjZmB3KQ
	 4oPnvtYzx6s0UAKZ/Ax7pQFO9mr2cWFknnx57zU5VcOwFmi3ujZKFxGqUJF39LdeGu
	 sl4iTPL1X5ndWtk0NM0Ak/+P19NP0a3WId8DoAgagrkMX15UuY+TNylMV83gOS1vQ0
	 m5ytC8IhAtLFA==
Date: Sat, 30 Nov 2024 20:21:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, haibo.chen@nxp.com, imx@lists.linux.dev,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel
 number to 4
Message-ID: <20241130202153.7909f86a@jic23-huawei>
In-Reply-To: <CAOMZO5AVyubQUpEhm-oRb8bmAH=5w2TxTnuuvoY_+HLhpnBaTw@mail.gmail.com>
References: <20241126195256.2441622-1-Frank.Li@nxp.com>
	<20241126195256.2441622-2-Frank.Li@nxp.com>
	<CAOMZO5AVyubQUpEhm-oRb8bmAH=5w2TxTnuuvoY_+HLhpnBaTw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Nov 2024 16:56:23 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, Nov 26, 2024 at 4:53=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>=20
> > +       chip_info =3D device_get_match_data(dev);
> > +       if (!chip_info) =20
>=20
> This NULL check is not needed.
>=20
> If the code entered probe(), a compatible was matched.

Whilst I don't feel strongly either way on this check, I've dropped it
and applied the patches to the testing branch of iio.git.

Thanks,

Jonathan

