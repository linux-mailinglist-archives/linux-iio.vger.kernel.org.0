Return-Path: <linux-iio+bounces-25576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7CC147AA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 12:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0754406DB3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0575313287;
	Tue, 28 Oct 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0YA64Xw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9A3128CD
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652587; cv=none; b=EcLX8y0WDRhdHrCrFP2mcCtPp4khRDljFZ+4Pk01sJ/IS0W/S6p7kF+dvinwNmu78nY2ZTwvTChL8RfTkgICKqFgbuj15QwviZqpiZdQi9K74bn8leKDfg8aJMD1Y5YnNmrMgDE//uW3pEsOVPDCMuXaw4xuviROOvBzFeKBw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652587; c=relaxed/simple;
	bh=Ib4FTXEwOtlDTXM2VpO+nl6c+5tWeUf7p5dmbiVpUfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdCAWB9w2J5Mi73C7bn83tbJ0KmUBSEBVl/bK5y2hhmTF6EGETaPoWEy1Dgopuq2FCXZFlvhEGmVvGj4gI+BZAX8zkIMwpCGrQwZLvSQEWRovcLLVTKBfGHSMtZBavpO3wvVtBMzR4c3kwFfjMaaezhjwQ7MhWt9YZMF/DPmMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0YA64Xw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-421851bcb25so3639729f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761652584; x=1762257384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ib4FTXEwOtlDTXM2VpO+nl6c+5tWeUf7p5dmbiVpUfs=;
        b=N0YA64XwtWzOvj9H4V8peXzUoAq4NeO8IqQeaF57q5emQdaS7jRffhSfbXmbucKA/x
         nrGb5808rJ6w2mIfHDYK0sXymb9M72Eoakp9fu2E03eihVgVme39DiulAFmRFyht7LVS
         f3q4GqEVV1U2F2+ADpRchyc7kAG9JkZ3n2AsZl3fVPY0vC6gzMKW3iTztrUlXBtRXEbR
         4EQ2bQiefTgUKiJ7syb6w2g3sceHd+r5pRhiO3zhhnMHW/U8y31WPvS38DvSXApNLvp7
         Tb8Hqa5IM0xeOKY/Zltx44hu0biLU6chn1Q09JncWgjD3FYMFcxdOt8u5mOlfqPql8fd
         8Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652584; x=1762257384;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib4FTXEwOtlDTXM2VpO+nl6c+5tWeUf7p5dmbiVpUfs=;
        b=TDS9eQVSfLJ9kL4Lroa1CDL9lVJtHTA4zrSwZZwbkMA0tCnQPqCXjJJAD+Dt2Qw3Jq
         Uqv1MIaGj26kH8Vl1d06az51qHZlLB4Btb6L0R/D6MJXHZ22lr3xegAjFp8Mhsqg/V8n
         HUnz0vCOG7zOddKjPRtl8WdC9QF62jmTd/sc9oDvYw5sJVjjSWUYkKfOrYgoAyWH08lr
         Mts/5WcPqnsrT5ZuwjjFdf1fqJo59TyxeOsv8kidiTkvFs7mHd1fLj0vDgKqeOAgrtNZ
         H63s4y6WPcASAe3JuIo6lEzdsOoAiLJoYcPUOt+iQqBmNK0OWmAxvBmJYOeyPS9B5D36
         fwDg==
X-Gm-Message-State: AOJu0Yxdx8sRMgdqPYuWayYHlntJ/gmWKjApVUe20oSs7gLyncFNvuwU
	iImqgUqWNldbtvK8Cz3AfmnvrzH30QrHSzY3kegLQ48+WS/m4oo+lCVA
X-Gm-Gg: ASbGncvtjpdGCx7mzFn/5K+62BpP993coStMNJEynuSiMH7VYNjSfCfSDM9mUu1Eda5
	JI3bAbSMD6QQ01/wKJE2YVVdsLKZyPIE1JouKI0bXGnAl8DkhAAWLjFTSMSyE6hqrQVHcJ7KJOY
	W51IJpxOXQlxjtu1GvpOAZEFnLPIIWNNpbjJ+r4+h5JSxxrtYuImnHKDlylxqiD0Mm9ecuaAS2s
	iv2tpPrfwrN1ytbzaIjwRnfKHQ+/RVI1NTBBm5fiS40+nNfIaJqQAFcqTuWy822NUYSO36MhDob
	th7QTSGn+m8ZMMaY4tefYgS7Uo9yQY+Dz8fkp0iooQ0zPZeo/57zjnFlOVhyXe6GxAEtM+Rv1uA
	X7dhOjmKXOyKM7fCnPXrdf2yVlThNQwVwpNkXqkzRqp4M1AGO+kdWBdlv8Lx/tbbf7BWBm9I0Hd
	6XCq4JZrw5
X-Google-Smtp-Source: AGHT+IHjYJZTMVZ2J00XT5f9CcLsMMeBwXk/4A4OAn+HKaImvZOZ6U1OX1tYqOecRVXVhSFhsX8FLg==
X-Received: by 2002:a05:6000:2005:b0:427:6eb:8499 with SMTP id ffacd0b85a97d-429a7e59e59mr3391922f8f.24.1761652583845;
        Tue, 28 Oct 2025 04:56:23 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de4a1sm20027993f8f.37.2025.10.28.04.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:56:23 -0700 (PDT)
Message-ID: <50f7ef82a98b2d2860466b85f172bcec36fd046b.camel@gmail.com>
Subject: Re: [PATCH v3] iio: backend: fix kernel-doc to avoid warnings and
 ensure consistency
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, nuno.sa@analog.com, 
	olivier.moysan@foss.st.com, jic23@kernel.org, dlechner@baylibre.com, 
	andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot	 <lkp@intel.com>
Date: Tue, 28 Oct 2025 11:56:58 +0000
In-Reply-To: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
References: <20251028093326.1087660-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 09:33 +0000, Kriish Sharma wrote:
> Fix multiple kernel-doc warnings and make the documentation style
> consistent in drivers/iio/industrialio-backend.c.
>=20
> Changes include:
> =C2=A0- Add missing @chan parameter description in
> =C2=A0=C2=A0 iio_backend_oversampling_ratio_set().
> =C2=A0- Add missing RETURNS section in iio_backend_get_priv().
> =C2=A0- Replace Return: with =E2=80=9CRETURNS:=E2=80=9D across the file f=
or consistency.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---

Thanks for this!

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> v3:
> =C2=A0- Changed Return: to RETURNS: for consistency across the file as
> =C2=A0=C2=A0 suggested by David
>=20
> v2:
> https://lore.kernel.org/all/20251027092159.918445-1-kriish.sharma2006@gma=
il.com
>=20
> v1:
> https://lore.kernel.org/all/20251025102008.253566-1-kriish.sharma2006@gma=
il.com
>=20
> =C2=A0drivers/iio/industrialio-backend.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 23760652a046..447b694d6d5f 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -702,7 +702,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get,
> "IIO_BACKEND");
> =C2=A0 * interface/data bus. Hence, the backend device needs to be aware =
of it so
> =C2=A0 * data can be correctly transferred.
> =C2=A0 *
> - * Return:
> + * RETURNS:
> =C2=A0 * 0 on success, negative error number on failure.
> =C2=A0 */
> =C2=A0int iio_backend_data_size_set(struct iio_backend *back, unsigned in=
t size)
> @@ -717,9 +717,10 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set,
> "IIO_BACKEND");
> =C2=A0/**
> =C2=A0 * iio_backend_oversampling_ratio_set - set the oversampling ratio
> =C2=A0 * @back: Backend device
> + * @chan: Channel number
> =C2=A0 * @ratio: The oversampling ratio - value 1 corresponds to no overs=
ampling.
> =C2=A0 *
> - * Return:
> + * RETURNS:
> =C2=A0 * 0 on success, negative error number on failure.
> =C2=A0 */
> =C2=A0int iio_backend_oversampling_ratio_set(struct iio_backend *back,
> @@ -1064,6 +1065,9 @@
> EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup,
> "IIO_BACKEND");
> =C2=A0/**
> =C2=A0 * iio_backend_get_priv - Get driver private data
> =C2=A0 * @back: Backend device
> + *
> + * RETURNS:
> + * Pointer to the driver private data associated with the backend.
> =C2=A0 */
> =C2=A0void *iio_backend_get_priv(const struct iio_backend *back)
> =C2=A0{

