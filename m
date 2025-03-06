Return-Path: <linux-iio+bounces-16483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D5A55417
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B93C17A536
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8926A1BA;
	Thu,  6 Mar 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAxbqBnt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6912144BC;
	Thu,  6 Mar 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284194; cv=none; b=dvQIJa1RFZfIFud9I5CkpE2ibppoGystysx0OvMm2KZaRmwTGOfws3v5D5lrK2KvRYRVihj3wTDQcRhoFXaqGy7y5uuRvg1d2BPd2I5eIp9GAKbIgDJaJeSb75jQNsFwgqnyAem6WT6vCl8qx4Xqkutq4SQ5JjBwcGvV17zuj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284194; c=relaxed/simple;
	bh=ZtVrZjQFqTDnAqIoaX5Ypb2xkJpO7DSyb5N7uTvyQpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehzna3dD5nM0gP8on9VaRrNVZ0uM/TJv8vYio8F/CNHqsCHBeXZI/hoqv6dn+TTO8Ipy1fH3bpFHfAnfqNo0x+pKYuq1iVzN8LSwG7GXz8VQGd0sKhas/B14XhdPy2DhTL8kiSimfZdt/+ICB9t9SALGkxZRk7VXAvuNe7Hi2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAxbqBnt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf538f7be0so184903466b.3;
        Thu, 06 Mar 2025 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741284191; x=1741888991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3kuHkXanaOTo+0aIppeGuMX06kTIJWcAX7i2rEjPIs=;
        b=hAxbqBnthFA7LsJdpJYAv7rZEafkdmPruyA9V/w5iS6xbdin5A0xMye3caSBlsvt1U
         485BHSRCbzBVzgoIZl2UGBtS58edUA75nnw97hyhG1cqliC0a6inG5OMHs6fDm5w2WEI
         xsq3N2Lwlj3oJ99s+NLnaHmWhTmyct6Qh6ICXNGdgQOS9yvx2FuOVmaiDx1Evp4uh9ku
         +Gg2euvNDv1aqOcSlukucZBveBfqpS2U/2JXpF+MhgkQJC1sUnyfAFSHfiIIq2W+6BB6
         vmCO6JtvaJojyde5WUkPHpkvwThQmc1lNVj7CBjCNy3ndob+6i889qZRoRlvOSNv65Yf
         5Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284191; x=1741888991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3kuHkXanaOTo+0aIppeGuMX06kTIJWcAX7i2rEjPIs=;
        b=fLv0ngcDcAuG+tF1RTklHubfljlNNHkvMW9kdFs9tytEOUC2ElcGBLGktzrSWU6aW1
         VLpaMtHsqCqzW1/s5rXXKxOR0eXmeEsjjjr8qYZUwZ1gddL0b1QBPxeix+VXFEQG4d6T
         /FTgKRcT7zOYVIAVTAUEylRrCvr9xe2e1mJMjBSE2nMh7lFcG13d1rEhEmvEKSSECZiS
         xMjJarlee8taSPxwUTd66N17H27RsQbip7tA5gc5wMDEg2qNIa3vUYRKsmDKTxDK/RWk
         TVRIsdPABTeqcNtiAYVwJWBul5P50LFPeHVtOeeq0jQVW0cqFMxGBKIrcPkFMOUwYyQr
         oI6w==
X-Forwarded-Encrypted: i=1; AJvYcCU++0rVHRSNFFqWW+S+K9ja1eyiv8Dublip9pJz8Ul4LKQyhXbXkrE+3RIsSFt60ZiWo0mdhwrB3t3WUez7@vger.kernel.org, AJvYcCVkxv0idEgL41uQGvhB75JDcgs93VWRsPKYdDs8APUYmpjWPABm162+PTKkgqRiKfqAgg3t0YFHF0Z0@vger.kernel.org, AJvYcCVldR2t/yXa2/HoaJOrSku7dOccgaUnaGgOCROq13loXc1bCV3xA4tkUkIiPbPF727GAZ1qCTWf9w4H@vger.kernel.org, AJvYcCXJg2HIZ/O8N870h7zc1k5Wj7OzEVLvnA6vpWYmBLoc3iPRIv35mB6rsO3ezpw7gdBBHNcQ60aXasUHz1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmT7UMHCXmNSMXtXjwZCmW9sqZ3IWqzLSwli9HJo/pOcExji8
	KxkRzKKyd7uMsnVeoVF4vLAG5NlSc+sltvkqX2sKBUV73Nf43F3q
X-Gm-Gg: ASbGncuNE0SXFKgDsXUf2ZnC6DhQ6XOJVf8jDfN3QYFexNlZOy2q2clCDiCLdnIgqBk
	/wyXF1QR6o8Z7kFfCAHij/xT9C2SojWOE4iYs+GL0aiz+F63yz4hWQdwaU7vQ6jFDxdDQtKoPSp
	MV9yjDiqOXabC+mABHYnIwOjKTocpqvpBqZlWBYhqeCHBTBNbQh5np43zuNsdmzOlIcHSfVfA1q
	1OEHC4inwq+/UCSYzE3UzTb6EWDFcaRFJ/EbzoRUN9Ko07wcZ33g5zq1rp51pXtdKIogBHGQUZn
	8P9Pb8fxPaktLQj1y03uMOS40zNMMU5W9LjCvXjPGFiv1BQsNd5B5RR9Q9Ri8r00c1eblqQGi+g
	Z79t3qukInc3BZqVK1bCeKMt0HSBREG4=
X-Google-Smtp-Source: AGHT+IG3hvV8BJ0NN7/H7q0tmxlUSiDeUmEyFjUTk3K+eSHRE27ImnKQ0l4Y3mXrvvA631ymWrCKOw==
X-Received: by 2002:a17:906:3498:b0:ac2:29c7:8622 with SMTP id a640c23a62f3a-ac229c786fdmr403972766b.54.1741284190858;
        Thu, 06 Mar 2025 10:03:10 -0800 (PST)
Received: from orome (p200300e41f3a9f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3a:9f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943945asm129576166b.22.2025.03.06.10.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:03:09 -0800 (PST)
Date: Thu, 6 Mar 2025 19:03:07 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Emil Gedenryd <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, 
	Mudit Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ARM: tegra: tf101: Add al3000a illuminance sensor
 node
Message-ID: <lhaelviu7bcayqlsvtiji46fm76zriccvnsfxxbqzmsihezpjn@muwpnrr2soyy>
References: <20250217140336.107476-1-clamor95@gmail.com>
 <20250217140336.107476-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gxz45puszxhuafcu"
Content-Disposition: inline
In-Reply-To: <20250217140336.107476-4-clamor95@gmail.com>


--gxz45puszxhuafcu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] ARM: tegra: tf101: Add al3000a illuminance sensor
 node
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 04:03:36PM +0200, Svyatoslav Ryhel wrote:
> Bind al3000a illuminance sensor found in ASUS TF101
>=20
> Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

Thierry

--gxz45puszxhuafcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfJ41sACgkQ3SOs138+
s6FwsA/7BanKRD2ABf4tG95mNRSMO3PzHDgibeqXTlfPdpugaoAZOR3QomWAduW4
V4IRibLkgAbU08cC79OoUu/xACamkgH04J9lH7Vv+WSGcdHJH9jPNRDNE0ua+F3R
J27LffRXb7zix3IrohS48g/QeO8chcfS4UycAOXhr5N80pSe1RwZ4v8QIX8vUTAe
ZvvWYZAbS+lJV/U3I/DGZQm192xn9sZ8QEqOmxHD7AVXigAA8m3Whdehl84i14tY
UeTd1b/QgkF1h6YXt/TiwzxDjwPzTm4Al3sjF72o5199LnCRbzE71Xn8r7RzN9CJ
8OwNjr+q6Vx2Ithg4ylzoko5dsyoKx9RNDlUVEWpd8KnLXpge/SdkKtOJcEgmXq8
Dt8NAT2ngnHsDhS8jksHrCQK3spgOoXiDDzA4hhTF8QW4nstgyf4vYj8pk0rhfjl
D1QZW7pRr1K3mKw1VuMNmQMOheGD7j19SuuJ8qPt1jOfQtbmEUCiBVW9UgrXxzQV
2vOoDC0ZLs3zOw7Y36yJ6hbOUz9Mshop9pVYsqdkfquCxzJ3ojek3MgTyWhYsW3K
0sMMBwVOwzotl7Ajv+F2IOnztIHu73+aFfuEQxZhjbLn+1kC5Pv4imgYNnPnTjaD
Z8B8cX3I6JosrTW8eLrDGZEC+P4KHKhAwVFuPyFk9bf7YvFxBt8=
=hUln
-----END PGP SIGNATURE-----

--gxz45puszxhuafcu--

