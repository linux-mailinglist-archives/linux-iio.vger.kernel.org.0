Return-Path: <linux-iio+bounces-6940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A92917B65
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B81C21505
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4918168499;
	Wed, 26 Jun 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPoyUg6u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B4168489;
	Wed, 26 Jun 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391902; cv=none; b=ZM1/Ri/8FaoR6UDr14YAxvi8DyGczNF5DCaI6OOXcEGB8rZm4Rz2zHxmeGpki6fUt6vAPrZZuxDNu47Mo138CAG83870EjaTgQnM0ExS6uYljOFGWYGsUShf92nhOTP1rRNMExqa5QQwr6DKTmNjVgZdHCAP0+A746wozoik7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391902; c=relaxed/simple;
	bh=NNT87xv4m9uuF7w7Oww7WonP8JR7b+kKW9vqeqsFJL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSFYr05i0bvtPREbcIMbk8YRepAOum4W7WASXH2aCE+z8oSxfXoVZtRS7RX9Cad7Tv1lufVCe9s08nzrMScUrJ5EYdjHFUjV8fazdUKeOq98rhltRXVjY9x3Jc5GAAuctyPoKKdtDZuLdTAE7Rsis8Gp50KTEndi6vuTwaGOmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPoyUg6u; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso96233941fa.1;
        Wed, 26 Jun 2024 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719391899; x=1719996699; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNT87xv4m9uuF7w7Oww7WonP8JR7b+kKW9vqeqsFJL4=;
        b=nPoyUg6uv/FFDqhLFShQ8uj7R2YmNOoNVDAnk5Oixb+V2WSYn5A2Uo3alf9zney+si
         29EjruFTtaR+0WFtgW/hW2w/ZsC4Q3XytwFAVVOyROsfqxtkoKsW5RwWoS2ic3a5YZFw
         KAV7adrAQ8sE9BUC3TaIdcd25p0aMKwdtCCOFkQ6TBG8Oz1sFu4zhZhonll7YvDaZL/1
         uP+V6hsZSZTYyXKcpuu3LMikC9EmMeSfpShE7ARosrOFBc+gUsMMWE0AXGnBQ0nK5BC8
         LXWCsfmOENY68skgB8kdKcNGWmPHr+p5kmo7Lt625xO3b/XMr5OSsrt7M2TGEop+c3Z6
         o3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391899; x=1719996699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNT87xv4m9uuF7w7Oww7WonP8JR7b+kKW9vqeqsFJL4=;
        b=X96ty0sj655SIUO39XV6vI4GqLVZIP+dGogxAfdD5vQjPJJWupvk/pEny+t2ORtGUo
         OiosoamE++5SKNEflF2Nw+u4ScXnXaKXFDBPhOLxupwvkK7ZrDewbAh1KhQF0ABE6QcQ
         IUtpxBKSDcQ4Jrq/StD7/CSDJ6MBG0gppogm0mqhWFktiVPRV8FDdK5mGri0ZnPIjGjV
         ndbWPC03eOA4gETTXpYGOewec9yLm0LogO7Ub07HyVjc+Zz8YBegE6vKhhG9KhRMvhHm
         G/J8J9oOSKca9IDYV1MOg5VwAtFJFMGOyDWOjNoFSx8kEzqTdQoWma3ZHeBaMarvvVBk
         xb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAdQ1XeYFoTxjVsH9+lKDXaNzSPhlTJUsnvWL309auIEppc5Da3lp0vT7ETdIHbuw69vuyHyMZdxaIHFepnhEaRfP52pDM/8sW
X-Gm-Message-State: AOJu0YwgC8A8G+qCblePfRNAyG9xRS3oXAYI4YZR20lSOsXV4uGsAmEo
	pr0wEnhoiWcjbxEikjGuMDHToOnhxsjG1+2emBOvWpNZdEW7QpmP
X-Google-Smtp-Source: AGHT+IEGhJjep9CGD7ppGZuyH7FuYo/+1S1t69B/eAcZHDGbV3o/9eVTLUXAn45jOC3VyFb+6umXdQ==
X-Received: by 2002:a2e:968b:0:b0:2ec:4f6b:de7a with SMTP id 38308e7fff4ca-2ec5b2c4e9cmr66234421fa.3.1719391898828;
        Wed, 26 Jun 2024 01:51:38 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c2c1sm17454145e9.7.2024.06.26.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:51:38 -0700 (PDT)
Message-ID: <be6baa784a3be5a62a68512dd5fdcfe43ffbcd34.camel@gmail.com>
Subject: Re: [PATCH v2 7/8] iio: add sd modulator generic iio backend
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 fabrice.gasnier@foss.st.com,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date: Wed, 26 Jun 2024 10:55:30 +0200
In-Reply-To: <20240625150717.1038212-8-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
	 <20240625150717.1038212-8-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 17:07 +0200, Olivier Moysan wrote:
> Add a generic driver to support sigma delta modulators.
> Typically, this device is a hardware connected to an IIO device
> in charge of the conversion. The device is exposed as an IIO backend
> device. This backend device and the associated conversion device
> can be seen as an aggregate device from IIO framework.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>



