Return-Path: <linux-iio+bounces-6262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB490871D
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 11:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B927528370A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC513CF9E;
	Fri, 14 Jun 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1Cwqw2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0535FBB7;
	Fri, 14 Jun 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356299; cv=none; b=C/qaxBuauEiXdi+nLakEuPJZGt3w6CttV3vt/tXquvi0PCj158S4jxK8AYBOP8ifrkov88Am9bXGC9HTNO0DgmWhka4vG59YElf34r4TKdM3XgILwduYKqjcTJTZDUxCi/RRM/a75UMX+8kPVlXSwpK+qThpKYk/NxXply/6SjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356299; c=relaxed/simple;
	bh=SuqvfsAxCA+jgecy6hs7ZPJ0qUifTMDLbWii6etDTFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gD68q/9htGiobJe4YfSjRd+z0peq50cnpTVoSMkyuwEMOVBDVhh4vW3PYq5LE5br0GGn6IeG2RvTF2fVENV5/fdw2zXf+F91narc6YF6MvIU0MLnQFjDfFyOEd6ihv7T0luNeeTD5/zzjNnpD40hEOVrot/LO8DtMVspFCY/hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1Cwqw2F; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so2207926a12.0;
        Fri, 14 Jun 2024 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718356296; x=1718961096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SuqvfsAxCA+jgecy6hs7ZPJ0qUifTMDLbWii6etDTFM=;
        b=J1Cwqw2FT2zUz7FSWuX7Jc6hkXZ33FDXELnFn1Qbk6D9Opo6e152L5mQjB5ffdlv43
         QcIMlRPgXafcJBpbrCe1UQlbNURtBgCG7XZpYdUABWLuB8y9/zClsTTRVPPQY7Nm3qE8
         5In2utA7IBfrnWovaa8lne6e0KgFaMS/3w6Qe9sSvBRxObeBAlQkSOGRDLhvTMD7Bm4o
         Phdk7K31mWpHHB9YKrakPZnGBDCs4pjSCmmF9mW884bVpLVIdWCy4sJdQsRnNlPRg0wY
         1I9KNwdpvYP+H1B5kbT4XFC1Jwc0aH+EgJBlU/mQUbyRm/jQcg85U5ogOSXZyVTWCx4A
         CI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718356296; x=1718961096;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuqvfsAxCA+jgecy6hs7ZPJ0qUifTMDLbWii6etDTFM=;
        b=KFqCaISs8VmIzOEp12i638HtRnkJ1x11D87jIJOYvhQW3Jh1F6Za604I3Dwf2ry2oa
         30XkIUheSg1djGsM3qXeW+Q6KRifeYKYnOqtVQb+33dFZb1npGfp4E4kLk+/B98MHO6K
         bGqbxirORW35CTs98MuUiVIgdIRK55kUuOCLWQUqgGpCNMXOerEWN4j1/18kbb1QZSNc
         JDcwBky1uyl/NgaFHA6a7RLaqSdANASZVzMHCWCUGgh8ymRepYdlz85WQ3svXFiIr0Q4
         X6Cw8naxGQQ4ubnFFHXz8o+WTtO6d9Nz6+iamuQz3FhgSGci+K5+8A33K5yFPIcbvlK0
         y+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/sfLsalK/iPalc4z6dG8RrgUeJJDGzV2oDJ7SXHufTDgi3OcyGgJFVf3H+2CQCSEUisoXJS8aFSDcmojmaSjXF/IpMmP1oTsNPwGB
X-Gm-Message-State: AOJu0Yx16hnMn7Cpgqa4JJVNo8H4/aFLH8vFK/UbhJmAe60yvht1mmqm
	mSzRFiTFCfsoPYrtBylQiB78fFBMnOGwvnodlxDTG/1MBJrYW/UC
X-Google-Smtp-Source: AGHT+IG0dQ/ng3WdSEMuHGqHcyEyLmiH5xiBYtyTepKaEAALDdWn+bmZCaGWYG56V2lXDtIySyq7SQ==
X-Received: by 2002:a17:906:b28a:b0:a6f:11c9:f349 with SMTP id a640c23a62f3a-a6f60d29731mr153670166b.23.1718356295500;
        Fri, 14 Jun 2024 02:11:35 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdcfbsm162508066b.109.2024.06.14.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:11:35 -0700 (PDT)
Message-ID: <57d4659a5abb63d7c085865059b9d71c40371edd.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: improve probe() error messaging
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 11:11:34 +0200
In-Reply-To: <20240613163407.2147884-1-tgamblin@baylibre.com>
References: <20240613163407.2147884-1-tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 12:34 -0400, Trevor Gamblin wrote:
> The current error handling for calls such as devm_clk_get_enabled() in
> the adi-axi-adc probe() function means that, if a property such as
> 'clocks' (for example) is not present in the devicetree when booting a
> kernel with the driver enabled, the resulting error message will be
> vague, e.g.:
>=20
> > adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with=
 error -2
>=20
> Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
> devm_iio_backend_register() checks to use dev_err_probe() with some
> context for easier debugging.
>=20
> After the fix:
>=20
> > adi_axi_adc 44a00000.backend: error -ENOENT: failed to get clock
> > adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with=
 error -2
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Somehow feel that in these cases the error log should come from the functio=
ns we're
calling but bah... likely not going happen/change:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

(As a suggestion, you may do similar work in the axi-dac driver)

- Nuno S=C3=A1



