Return-Path: <linux-iio+bounces-20731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64566ADBE7B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 03:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB061188CB09
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462F018DB1F;
	Tue, 17 Jun 2025 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcMkGw34"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAD2AD22;
	Tue, 17 Jun 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750122849; cv=none; b=Qo/q/hVSHEJgeO64ouMfluOslsa5sL4BB9DLEaeWwNa8fBqxXnHbcic7KoHMo1JD+H7CHm1k9Bsnka1LnEH+yLSa4SKGLFFHNfpKO/S7In8qRquoDHyfY59Q7Vo5AjhRc4it+51ThXqYarfh3okzZYfRFKpx+fYYWNxGm9qXmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750122849; c=relaxed/simple;
	bh=kpYk43BX78abeboUzPolvtVkkwIHChrlSj8NENX9mt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T12QxZ8tz6toHybXjsSHDdT+KM8UnUZT8LK4J/96ERy6Hwet9m1/bGwBz4uIsJ9ejWT9KBRhjLsESkOlmunRfYZtuc/QkhHFSRgW+1iZoHtDWreUEbrPCs/karxtdwwINEzXXvfvTTfAnBjzics+3ho+RZLY5xouU2mLvu2QaIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcMkGw34; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so4050595b3a.1;
        Mon, 16 Jun 2025 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750122847; x=1750727647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpYk43BX78abeboUzPolvtVkkwIHChrlSj8NENX9mt4=;
        b=YcMkGw34O5kxtfncTQj2QH8BRFMehCO9IRAfNuN6G986kwiDhF9C3h8Zh1IplX1RM0
         0s+VT+MDaf7ewV4O+nZRljJiZqGeYWA8bTdTCI/aR5faQKPesfUEUEtu0phZ1bI+Gzdu
         +43XEB4DNGcalV78cXtKX2EUnPf3aFW+avPBuarmunoTsc2OxAJGxQ1njwDIRWs7nYkx
         XVgGbud1qq0Usxcd6cpvbytZw7XQsi8LeJ4CiV/FfSH3+IfMBm1BlNc4Ga/mqisw3tom
         wOhiCG8/7Y1VNxACHxVhVvarW7Wzoi8f/9Y+fj+lVcSNRnAtXaT785bsCma2AizflZHy
         URLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750122847; x=1750727647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpYk43BX78abeboUzPolvtVkkwIHChrlSj8NENX9mt4=;
        b=QjuVsB5xTxxpLW9XOcSb/WTeiA5bJaoADPtVgljaZhCHO7CPbO+EGr/qrpU51wjLJm
         GWGvfIUGzTctq2Hqu6OhBb8VYZuXnIPw0lqqxVAbgUsczRMv5OIhVzyurfexEz4OWfDa
         tcUSQKlJmeS7bsMVaxX1LpK2o9iJrcE/jercpTRL9cMec9U+SKNimFIJfToOTFTf2vje
         vubcXxLXTa+rt9ljWbf5FlFOvpt4QQVwBNZcxFjZCNK1yBbwooIB7rQkJ1wyd669NDnX
         dbTSwoL2UmX3wwrn2sVKrdXxeQo1cCQEsDYCu2mkITbSCrrShJMbOdSZrqAp/hRIbDF1
         sXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUMdL/jLBneFzQByZ3F5bygsBwIAbAY7eNaTtEz2fvsYqjZOfpqei7T0BGUEgkyFC/9wknSNkbn/9c=@vger.kernel.org, AJvYcCXI1RgfWJkvV8GS4P81C48Vio/2lbO9KE7IKN2sedbwu6dg7Bwp/1OTxvpYrhnCQQ1UG20RpkuBniV5jRL7@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtLX89U6v5v226otm35CV8VjuoLO/FROe4TMFZ3Vk3c9XSsgK
	g99DHyFVXFYmvX+6Lod5rs2HmWreOW4PZq9DYWdpvIyHit0AoEWVHLOc
X-Gm-Gg: ASbGncsoZsimBz1g9298jelemAhhGZoviVX7OsZHD/dBe7k9RJTbCnnzZeRGEmMrWXB
	wqwYokJrQ+5sOAlHMbVtO8v6PlT6fJDPi9WDLpX5jod9+dklNKI19VyCHJJJ7zYapjQpqEYH2Ag
	nsroURJ5UJxpKp7njzDyf0oJn2Ul4FaQlkn7TSqgGIyWs70085NspxZvCwywIpxxx4fkIbPSpXF
	MSzCzfIA3UVjs0sLMCZJia0dh6TJ+PlUqXJzmle1VtQJ8JoL1ZSBIaI5+alCkN8QtPUs95ZfWyV
	4kO+J/gRGpFw+hDbGdFQI/1QLBYL+ecwzEdieUDdmNlBi6eytTBwpU54EWBuAQ==
X-Google-Smtp-Source: AGHT+IGHNJI5rDVV8B5l1SOl98BZN93rEklnkzEYfIxtQDE11ofXODrRvc4euJb8tlPe67MPYCVNZw==
X-Received: by 2002:aa7:8219:0:b0:746:1d29:5892 with SMTP id d2e1a72fcca58-748d14987b6mr749030b3a.4.1750122846672;
        Mon, 16 Jun 2025 18:14:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890084013sm7842198b3a.96.2025.06.16.18.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 18:14:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7996E4241812; Tue, 17 Jun 2025 08:14:03 +0700 (WIB)
Date: Tue, 17 Jun 2025 08:14:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <aFDBWztZT67hUF6I@archie.me>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J6rThkAjSk/uBmxO"
Content-Disposition: inline
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>


--J6rThkAjSk/uBmxO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:22:50PM +0000, Lothar Rubusch wrote:
> base-commit: 7461179e080df770240850a126cc7dbffad195c8
> prerequisite-patch-id: 263cdbf28524f1edc96717db1461d7a4be2319c2

What prerequisite patch?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--J6rThkAjSk/uBmxO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaFDBVgAKCRD2uYlJVVFO
oxsJAQC6kO6Qlq0kPZ853TcbuWHF5EKhdrT+ACRSC58geoFPLwD9HHhjAfa9SkLx
9bNVpoqGB9uGSiNHgq9NFqVmfHj8Bwc=
=Y7Jk
-----END PGP SIGNATURE-----

--J6rThkAjSk/uBmxO--

