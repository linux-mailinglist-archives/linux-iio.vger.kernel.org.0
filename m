Return-Path: <linux-iio+bounces-6939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532C917B5B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C031F23905
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088621662F7;
	Wed, 26 Jun 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSC82Qah"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB91534F8;
	Wed, 26 Jun 2024 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391808; cv=none; b=p/lBcLDz7OjlVK30sX9Jp4sCPpDKoSYKTBfhNgGi9t5n1vN8zQOfeTzXUBlUwqZqgm9e8vkqCZVt1S9VA4fhhut0YCrtc4uWqRNAoaXZsGMDsc/Kvx2HtfrwSMZgkpWJR/7F9NDMaAAzcSHMdiI6KsXUktv3Fh2C5FGhuAqgdK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391808; c=relaxed/simple;
	bh=TH9ocGf0t4tmZuZh3WEwgOQQT8qJPfwDAACN9DZf/FY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqPFDkBPk/hM91BqcqTZVBgEyZNYTE5EvRD5z6tdIgeQQgjo/zBm/EfKklsz+Dn/+h0AEyVrSL3tm7ONJiE5T5T5x5CiWsh7pVhK1VtJmkCqyx2Um32Icn/VPWBkWpNQIUgFF+ctQsFap1DYsCVC7eVp+Z92yEY1Rp8tPnFkaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSC82Qah; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42499b98d4cso14308055e9.2;
        Wed, 26 Jun 2024 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719391805; x=1719996605; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QQz4kMO+LVo3JUvqwvrWDdXDqDW105QydyrvwjnrXVg=;
        b=XSC82QahGe3S1OA7CPrPn3k7xRnroEyKLQVaRnmyN6+MtAmhdpd31rZMIoKa5dletG
         QioCAofH6qFfP/Rh5QTZ+6QzYCJDZzBeUOFGdYVhjyZnlSeifoLh11m6XMWv2gKQzqYO
         RwqSmEJ//vd4Y3XARxZPG8wTfbB52+JsD5Z9EKWhJxQtJx+QYSpVocnLThd5gKLR2JYj
         ZEEnGdlC+3rNyYx4AaTQWd0/pneRSpo4CScVYyq0btYDxks3fICwRWaEacRGtcMjORDy
         H03ULNm+YJ9iKMFEsppfjIGTCxE54lqxu9ipBOnWtBDsog+3VZ41oWWBQHxoGK1D6By5
         ChCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391805; x=1719996605;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQz4kMO+LVo3JUvqwvrWDdXDqDW105QydyrvwjnrXVg=;
        b=iVGLgoGSJSEFHnRB0yNeXKj72031BVcsnJZUmQP/WaDy7gnaEIGTZ1DzkbDsvA6zHS
         aRfFPDWyuuzxXXALGG0L9FhRCU2qYJzFBEYQBYLuefvkwI/KesRuyuJHA3VdOrRT0FDs
         OXqJXPH1Qazra4PkKnbHFcue2L3vo1C2oOHlT8KFIR6840Uy3YsXaSZr82vwqCuKIuD0
         yFWbW39dDRAtmUdZWzDntayTUzxrFIlzhSbFZc78s2S0dc+JGSAHw+6tnaRdviFZ+t2g
         ZLg8em24T1/YhJhejvC7v2pwu3sLbAQk9scpGtNW2TA07PJA6lCwsJs4UMJidGPpDK5g
         OjCw==
X-Forwarded-Encrypted: i=1; AJvYcCWDqmI0BjT2O2dGCY1jD7zcIhxElKXJDM1pBQFyqTJjmRxnY/GumzlE4eHt7mu+U39UquDrBqfk0ZpM6XHczi1tDz4e9ORNrTcnC18N
X-Gm-Message-State: AOJu0Yz3VtsKRu1kEln3gOTTtQcMg+B9ubD3ctFo1FPWc3gOtHlraSqE
	uO3ly1ZEhB/Vsp2Y6KBepyYXFchqMPRERPTuFwlzqns3JyxHdNALJ4qmtJyX9PU=
X-Google-Smtp-Source: AGHT+IESG/WfXg8XZdNYiKy4dyUNqkHu6mZw5n0OHCQsSIv52g5S3mtrz284MfM7DqcRG3W+2dfCww==
X-Received: by 2002:a05:600c:3b20:b0:424:761f:edbb with SMTP id 5b1f17b1804b1-4248e448891mr71365825e9.31.1719391805370;
        Wed, 26 Jun 2024 01:50:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82515a1sm17250325e9.12.2024.06.26.01.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:50:05 -0700 (PDT)
Message-ID: <de6378671c260d0548a299797f3288fe6f95e246.camel@gmail.com>
Subject: Re: [PATCH v2 3/8] iio: add child nodes support in iio backend
 framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 fabrice.gasnier@foss.st.com,  Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 10:53:57 +0200
In-Reply-To: <20240625150717.1038212-4-olivier.moysan@foss.st.com>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
	 <20240625150717.1038212-4-olivier.moysan@foss.st.com>
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
> Add an API to support IIO generic channels binding:
> http://devicetree.org/schemas/iio/adc/adc.yaml#
> This new API is needed, as generic channel DT node isn't populated as a
> device.
> Add devm_iio_backend_fwnode_get() to allow an IIO device backend
> consumer to reference backend phandles in its child nodes.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 62 +++++++++++++++++++++------=
---
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +
> =C2=A02 files changed, 45 insertions(+), 19 deletions(-)

...

> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -153,6 +153,8 @@ int iio_backend_extend_chan_spec(struct iio_dev
> *indio_dev,
> =C2=A0				 struct iio_chan_spec *chan);
> =C2=A0void *iio_backend_get_priv(const struct iio_backend *conv);
> =C2=A0struct iio_backend *devm_iio_backend_get(struct device *dev, const =
char
> *name);
> +struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev, cons=
t
> char *name,
> +						struct fwnode_handle *node);

node -> fwnode

- Nuno S=C3=A1


