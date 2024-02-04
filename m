Return-Path: <linux-iio+bounces-2140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92896848E30
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB501F2198C
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAE224E0;
	Sun,  4 Feb 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFeWtYuc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8870224E7
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054511; cv=none; b=XhzCekNzQjc7oyMC0M79X5oYrw+Z6PtZN2YmVgrEp5cmBZ3qlzl+73DrupzisCgvOPkLBnlAH9i/Ge9HZAyb4eiYOr/pH4YsmC27XOfkiHp5ZiF6HglAiVQRDi37bUCEFaHMwYS79JAWCDpFrOoUfCGxB9zaO6TmMCH1Ac/WskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054511; c=relaxed/simple;
	bh=C6G3pNqR4bjAhKfNC3LCjs4KDWzy/LZpDOUsH/RHqK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIo832mExAQFFngNrHXjVQM4ojqHM1yaCgC5lfncN/HCkShGHCBuRaBRWWq781veL/7I14nzOH8fHzT9d1aH+d+TNzPj3SG6G6/O23UoStDfSZXqvEtfzlE2kHobKrCEyuuDAKWAl9UtbOwb5//yMdbIhazHTB1ek7iF/AgcZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFeWtYuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45ABC433F1;
	Sun,  4 Feb 2024 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054511;
	bh=C6G3pNqR4bjAhKfNC3LCjs4KDWzy/LZpDOUsH/RHqK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pFeWtYuczqvnafCNMHe/yC/1z/2ZRNoxzUJZIBo45A3OhofIj6EuVqOhRDnvRwHyF
	 rAFpZWbp0ajY3NTeck4fmXBCF3NaDrfr/04Lor0H9PJLCS3CVj84JoA2UItbh5frAH
	 6dGU0KP7xEtug9/w5uLgsej+PcdxgmR3JZ1QbBAHV/nkAQ1TWx+gkuzDMQosO6Vm+S
	 finoRQ2eBDTb4pSwW1dxjGbgT1PxlrEJiG08uswt/zed7+/Nq6CMRpKjYJuNyZKyKr
	 Hw3EEwLOYG/hblq6fzRkOjMvWHBij6JgJ/uXGfXGulprlSbg4aX8+Vq/g9C7YTbs8A
	 2qdV3X1V9w8ag==
Date: Sun, 4 Feb 2024 13:48:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 03/10] iio: accel: adxl367: Use automated cleanup for
 locks and iio direct mode.
Message-ID: <20240204134817.1a2dff4f@jic23-huawei>
In-Reply-To: <270d95aa0190520c443eaaa94c30b5d4d9c64389.camel@gmail.com>
References: <20240128150537.44592-1-jic23@kernel.org>
	<20240128150537.44592-4-jic23@kernel.org>
	<270d95aa0190520c443eaaa94c30b5d4d9c64389.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > -out:
> > -	mutex_unlock(&st->lock);
> > +		ret =3D adxl367_set_measure_en(st, true);
> > +		if (ret)
> > +			return ret;
> > =C2=A0
> > -	iio_device_release_direct_mode(indio_dev);
> > +		st->range =3D range;
> > =C2=A0
> > -	return ret;
> > +		return 0;
> > +	}
> > +	unreachable();
> > =C2=A0} =20
>=20
> I do agree this is irritating. Personally I would prefer to return 0 (or =
the
> last ret value) instead of the unusual unreachable() builtin. But that's =
me :)
Definitely would be an error, not 0 or ret, but I'm still in two minds abou=
t this
in general.  I think I'll go with unreachable for now and see if we get an
push back.
>=20
>=20
> - Nuno S=C3=A1


