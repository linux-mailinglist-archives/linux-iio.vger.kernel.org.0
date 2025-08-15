Return-Path: <linux-iio+bounces-22765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE7B28142
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E54AE43AA
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37034136358;
	Fri, 15 Aug 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FORdYRj+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1031A262D;
	Fri, 15 Aug 2025 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266782; cv=none; b=bGJ7sTZSAiV258uqyHYvP3CJeuA8Y8AZatSD11AekovylMPEa2RgxkCyv2a222JK3piNyVZq//sx4LTnvJ/BhEKkATiz2GyFitCSBR+gJSmXylZpz8hCIDulasf+dSm9oDhuq6ny4p8If1BbaHQ4VfcpaMc14Mo/iTJKHZsHxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266782; c=relaxed/simple;
	bh=CqiTid4pNN3W+ULrEQG68THPXuGhAkKq4wAnz7BZ/Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg1+5jYybr1XQsWrVnBr3Ec2CYUzR8PchwGzx7LzAOxWiA1sxBbmAxeO2mzr4m50ZaiFd90itiGWwfTaLelktXIhEfuSM1PQMZ+I+VLxxQGo02Ag1XTuPp+22gtzpUkPlG9zJ/xau7efyfznHkxYC/SsU0q9fZVXwVMLv1sCsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FORdYRj+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e618a98so1577901b3a.0;
        Fri, 15 Aug 2025 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755266779; x=1755871579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CqiTid4pNN3W+ULrEQG68THPXuGhAkKq4wAnz7BZ/Ao=;
        b=FORdYRj+zeNquOoZVrJfUazKmwVZYFAiTiqVEcCr0lbNwE0d4UvrKGuGvRb0UR4G/C
         g9TVHWDc12BhQgqSg5BYUclt52Iw0/Oatkyze2OEOCgV1Yv+S7rH3nHdCYeWkFjcm+IW
         fdAUDJIz60XX1N1jCepVlvZAD0SgLUacYaNSwtlDlv/l6vk0seB0mS43ojCMyULDKODN
         Rvo3L2GwPoFxZm+tKvpVXOtKktSJ2cFOwnZmJVURUJ79DXdOBFITJMF9LDRwHSLldKB7
         kled8ZjCVS7opzAu2/c3a8ZzHqYKHqfoAgyK6xD6iW7XhMt9woCMkqbemlUQD9nuBw+a
         7qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266779; x=1755871579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqiTid4pNN3W+ULrEQG68THPXuGhAkKq4wAnz7BZ/Ao=;
        b=dHghgBd+iE4csHUzXPLLkTDsEzjz6eCflmLtFaqd0tfvUyNbPmtGz1cUt2G488cZGH
         s3phMkkFpCr9OCuglVGBjKy5f0ZVSCK6ovJOxBd2dZu64dNp/Y8S+uoB8fl8WXvXM+su
         uOZcEkIt4U7M4LXThQ2QjSPCDOxLhCtdynmMOhISOab7uZfHrp75tYdAijNFfcjhJgP2
         Zn6hrsz9BZLZLrg6K9+xPBc5Ce889BqZl59CU7krYTZqdDRR6GLw5tt4PIq/xgYcIiSx
         oSLG70VvoWsob7YjCzcjVZMERrFlwig2IIe9b4idkU8s9ktG5VGnZRPvUhCb86or0u4Z
         G5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXDu6DEFBq5Ik2mTFIyriQzGHDBm8gkNXvsSmsqahmmSB1DWqRX9zWeQS3Epv4f+kb1UDAzs7tTUZX1GdjC@vger.kernel.org, AJvYcCXSmlpE3TrUB0ywrhZomc1zJsZQwv6Yn2tSfTZNOndKaqFYQLk+jS1/c89Zhdww6oot33LiYMZdoHU=@vger.kernel.org, AJvYcCXqLeTQW+earo2+b7c4cZE0QMKuzCda8FMkDjOFBAXd36snNCXxp2+bIxl1K5TcW/0Y3NY0DiVeNzMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTkPVGTzZi9QIg15hMoHwyD5fbzMCUBmlfGzjKPJp0NOLofSJ
	JHYusegDIyOrGmQYwZR8GohSWb6cqJy/A9CqCIPDVQBlj2CTXRWn6XXm
X-Gm-Gg: ASbGncveQqd1+ldPk1we36Rdo740l4nwlUV4q3WaIJfMmcRr+6tVoaC6UaczZaGYlIH
	ptfBbJOYj0OCRe0OsHUv+da8slFOJCVKzDmZ2EevawGjlq+pp0FB6ID3HXnsIO26uJfnCzD7/Qm
	peU0DcXch3szOXhdsJQ8MvA3a7+BZmHE690afGAmj3OGOzrmQt2n500/buUNjMCrFmpjqzdBxQO
	1Xlufz+gPZxr1RABLEtFhYU573CD0j8OWqIFQqcvAJlnxiw9asQkasGIhoTXUlJo3yeDsqX0tlw
	kTPUltwgedKSMHU/McFmYZgW9d0cewsvV0zqw00dMxN8HudhB0UIyUt8a5JdylIVXUpreQxOhMp
	jZaSduh1HCok4HRpoW7TdbA==
X-Google-Smtp-Source: AGHT+IGUBfSwcmRDZE+tanvnB1WTuwEMQwR/R7Q1oiogmNFE8jXio6mf05OIZBi4bGXXGiyvENDiQQ==
X-Received: by 2002:a17:902:d603:b0:240:99f7:6c10 with SMTP id d9443c01a7336-2446d5afb9fmr40542235ad.1.1755266778612;
        Fri, 15 Aug 2025 07:06:18 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5775eesm14870765ad.150.2025.08.15.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:06:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4065241D3396; Fri, 15 Aug 2025 21:06:11 +0700 (WIB)
Date: Fri, 15 Aug 2025 21:06:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Erick Setubal Bacurau <erick.setubal@gmx.de>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: iio: bno055: Correct wording in driver
 documentation
Message-ID: <aJ8-0gzc_XJ_1YoI@archie.me>
References: <20250815070001.55185-1-erick.setubal@gmx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ry8EOtcKYwNErLhj"
Content-Disposition: inline
In-Reply-To: <20250815070001.55185-1-erick.setubal@gmx.de>


--Ry8EOtcKYwNErLhj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 09:00:01AM +0200, Erick Setubal Bacurau wrote:
> Fix typos and improve wording in the bno055 driver documentation.

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Ry8EOtcKYwNErLhj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaJ8+zgAKCRD2uYlJVVFO
o019AP97cIwuMcKDt6izMysmB8ee/SFzqwZFPzLqn6tJrdv3GQEA8v3mycRowGP3
cREnsqSBEGqTzOCBb5OAPCqsX39tFQI=
=NcVQ
-----END PGP SIGNATURE-----

--Ry8EOtcKYwNErLhj--

