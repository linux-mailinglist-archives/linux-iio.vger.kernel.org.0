Return-Path: <linux-iio+bounces-7832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E493AD5C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 09:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E47F1F22C31
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 07:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C7361FF0;
	Wed, 24 Jul 2024 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIK8fupl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E845016;
	Wed, 24 Jul 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807130; cv=none; b=CfXbpXje2spE7x3srrRbYmb/cHQRTvLYeLnJ4WIHUk/2CFCFaTfCeQ9jTLH74U67jNdUSxmeTcrbG1gb/R/oF/pDvsjzUtMr3Fw8fL1OgwFIuDy0z24ipgVktGve5fu9dOhQxSd3Wt6mQNP+hv5LZPUd/JlcKth/JRBOpPH24/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807130; c=relaxed/simple;
	bh=OI34kF7X8iVTXee6Y5kBgaZd1jpEtspvl3Yyd3FdS9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ijc7VFb6qHtsT2tKnHpeF9n1/k+aL/djl0G+yzZzWqGSw1diRD+36Jq2q8FKDX4Y6WDaZaaS8wHNA3O59NLHug7gA89u8R62M29YG/Gt657C8ivv3wa9EMMluYwC5oEIJV1RQc/iktv34c0YYyibBD8mqar0SKDQ2EUQMqmd4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIK8fupl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36858357bb7so3528984f8f.2;
        Wed, 24 Jul 2024 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721807127; x=1722411927; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OI34kF7X8iVTXee6Y5kBgaZd1jpEtspvl3Yyd3FdS9I=;
        b=WIK8fuplmeZFkdAYNka9Q6GuVsZKcMkpIprHU+Gbn3X5LHUc/L3xMBlO0IMRYShS3W
         ugPUx4Xy55B04Wql91pIPcGFLoVWVAG2ZiLgPtTylfHuOYPE5gO0895iGUqjBS8Yq1cF
         BEysaZAseBadtp+TSGjnsS9ZdJWY+apY4yBMNBfGYZMbQL0kidqzI/0uN+HxNLFQKrUi
         OwtzO7wxaR6vCkXSfsrAR0QJIHPTm0vfZwWHkHUZt7ozIEpv4jStMrLL+/C81JgWtYhK
         QtqLqN5cRH0329BWmRHP0QvNszvM16Prwvv/wBW0O0ZaoWCPx5t+gztVY4zTOIFgrkmS
         dxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807127; x=1722411927;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OI34kF7X8iVTXee6Y5kBgaZd1jpEtspvl3Yyd3FdS9I=;
        b=LsoqUMLqZZoCzXdSa13rveUbvqnVGalaFqdo68/qPS+6UTvV8BKrWN4Ex8CI0j63hT
         mSMPBtOfYtZyywS9TsUi5ye13jKTricnDdszufPTYlsNeiHGBt5y6AffnDJsq8n12JAo
         eEBE957+X4zw89eVaspTVmiJdfSD8xvlzxLbBUXpxANkGRyRE9pY3ANkMlXksr8yzUD3
         le9PmsRX7eyHnUeIudYcKp5Wq1+fqxCGpraM7PN4Iwjqjk9sNksMv0IBLp19eudOzxU9
         wZO+JJRWWkN7kSEVKuDROZxgQupKXR+41Efb2usQG/2q29gdXM8td0j2v8zpTMXqXC9n
         /MOg==
X-Forwarded-Encrypted: i=1; AJvYcCV/+TgN9FvROvw93HXYuhx9VCrUgXeYMkF+5FqXWbk6X8yiai7WZDxSRzlJPoA6XBYpmn0kIuruJsi2sPN7Zax+ndWWKRslm+3HX+9FAgE+WENQeGuxJ2VpwQPP2uV21w2MgCLb7Uem
X-Gm-Message-State: AOJu0YxGndU7pgMswFWWI0ZxyjBJUmbYgD1j4X1gCaRRgySaah2Dqd04
	MHVD9Geq9yUl9mpBADCzx+3r2ZiNgTVQnYtEkYwwdoBmU4ZcUypu
X-Google-Smtp-Source: AGHT+IEaNcBX7cGGdyLqel+HplfZ6jvgHmTwcxh+c2jB56RAhEU74XZM6MHSztGqkV+sLPCFO8ouIw==
X-Received: by 2002:a5d:6d47:0:b0:368:5a8c:580b with SMTP id ffacd0b85a97d-369f5b2ff3bmr884587f8f.19.1721807126513;
        Wed, 24 Jul 2024 00:45:26 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868482esm13461696f8f.16.2024.07.24.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:45:26 -0700 (PDT)
Message-ID: <6fe59ff58e19bf6a8c5c5ca3ff120b4df28f1092.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7173: Fix incorrect compatible string
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, dumitru.ceclan@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 24 Jul 2024 09:45:25 +0200
In-Reply-To: <20240723111322.324947-1-dumitru.ceclan@analog.com>
References: <20240723111322.324947-1-dumitru.ceclan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 14:13 +0300, Dumitru Ceclan wrote:
> Wrong compatible strings are used for AD411x devices.
> Fix by adding the missing "adi," prefix.
>=20
> Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>




