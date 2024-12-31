Return-Path: <linux-iio+bounces-13866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D709FEE00
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 09:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3915D3A28A1
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C018D625;
	Tue, 31 Dec 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJQrto0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01ED2D7BF;
	Tue, 31 Dec 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735634349; cv=none; b=Z67sOT0MlhqfeQZOI7nMjt+5TP7R2bUsgKXhVPe3uHvplM79I0RxMIDd3Q6L8uFHzAvN752jSjkm7nem1hFzAAcrhQHnFqRKgB+awgCNhB6Pwx3Aks1c4VmePlgYdapHximTOefkXiU/ECZe2jPQSfTbj+OK3lnD1IHmwNc28OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735634349; c=relaxed/simple;
	bh=HhjwaOW4H6LSRx3nXKseFXvPm+oY1sQiwXcKAdYCpXA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kTaBqU4rRmyRRtwq24poCDmHRwFoceCd/2rxKWjxkDHqgwWrfZIMUwEIWIfgg44+s7uBi3IA4SxMqhO4gSLgquru+/FSZFRrT5DGmVy5z0z7i3rY7A90TXeQaxBTQpNgVrNiYo6tBPR6MtdFFIYCX/xkDLlET16CEsHEmzY243w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJQrto0f; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso99528225e9.1;
        Tue, 31 Dec 2024 00:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735634346; x=1736239146; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZduQXI13FtBo45AD8F9a1Xz4oXXtB4vjoYK1+/48Ik=;
        b=hJQrto0fwPHjCzDNE4UJn+jxzkN4HMclg/0roYTvk1y3ROzV2ltjOlubgw3mVxTnfg
         RKMlpkXhPPqFEzr9ePBriXPpCilQTpJlGse4N3GmPuj3feCBj7fNntLGf2ENwQDz+52I
         ZkPgbrH8gTSKapeZmk+Cz0OBp5wyihd2OHTGEdcdcJm6AGURBBGaYRtMKK22G/9DkRMD
         AmhsrevBv1FpjUqjfHSrdVk9CWKpKv5iwCdT9VLFN0U3a4wQbDiGvD5I5xDYQoygixcn
         mf6h5P0iPy8J17IyHWb5fS3sotpubuPWbSRl88lQqp4ZVx/+rO3e3xmyz/+N95yFxFDJ
         V5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735634346; x=1736239146;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZduQXI13FtBo45AD8F9a1Xz4oXXtB4vjoYK1+/48Ik=;
        b=hZ+lowVrweyR11YlypB5UtRi7u4S4q+6vvvPyAwuy0NWRqDtQAfTlJkc1/dKBteVUb
         ec0MKi99vLvTq2kvtY4YNyeBAtkUWTL9nrXquibcj8um1V6vdDpA0LDP6ljjD8OJ4iw7
         qijCdnWDbr7ft3eEOaXAdKOw95riPAwiYrLbEqnp76Zl+lW/END2s/B6+JN/g7VPKyd5
         Gq285d+p5iRXJDtQnGYuRPotcwOLBHdIpTdPILi6hptZrWg10Z79z8BQrMyXauhbt06Z
         iBx8XgGq4JSJPa2OodyClDMupH19mkN43GeA76xzQ/qA2HUcKzEGS/tndH4wxAdvGr6Y
         M/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ80/oANKz3TA39QU0vzwyBVcVs8NfqB9bXE3u878XdSfSdn2gxPNjXDG7MvcXsPdYV/9f1WDOxKy95Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIKCQNRUT3L0l5sq0uT5qq7Qh4B4yQOnT1KVoUrbLSRIxMTzj
	TomJ51MelaFUVLAf8SwmWi8ziLO9NDj3IPHbe8ftO2QP2JT8LNr7kbZXdw==
X-Gm-Gg: ASbGncu1OwIEPcD10Ew3nD3rH8sIIR3XseaH9o5+1a+VwyEyz8Fvw9M2bIPN37ZFjFh
	mVAbfDyGn64j8i4NGUq5vf9HeJR9bATE+USC9IDJ2HtDFwfhnpjC69y+yuGEdtnprAvAwrdzt3b
	qZTv2iIAgSlcs77Sjq2H6jVQFhWlfbmdeovmumN/0RGnjoYEMMLtQ5eL++MRF/hN44lxeY6eGB3
	ppcz1b+Hl64qb0PnVOYjAwZaSsK49tu05TtYraIDWd26axzjwriM4xobiqKkSrAjsJUCFz7huIt
	1nZc7L9rRwAceFslqOp3fh4=
X-Google-Smtp-Source: AGHT+IHxhBqnuTzHPKyfJr7++0oZya3/MawDiw6zfSRuDwoZFjcjXIOJHL4r/xDZ9fZtI6C4AwFrfQ==
X-Received: by 2002:a05:600c:4f11:b0:435:9ed3:5698 with SMTP id 5b1f17b1804b1-43668b5e09bmr293419915e9.24.1735634345721;
        Tue, 31 Dec 2024 00:39:05 -0800 (PST)
Received: from localhost (17.pool62-36-37.static.orange.es. [62.36.37.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3d5sm384806185e9.5.2024.12.31.00.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 00:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Dec 2024 09:39:03 +0100
Message-Id: <D6PR0XZ27Z67.1IJEM2DOL18QY@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: veml3235: fix scale to conform to ABI
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Lars-Peter Clausen" <lars@metafoo.de>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
 <20241230-veml3235_scale-v3-2-48a5795e2f64@gmail.com>
In-Reply-To: <20241230-veml3235_scale-v3-2-48a5795e2f64@gmail.com>

On Mon Dec 30, 2024 at 4:13 PM CET, Javier Carrasco wrote:
> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
>
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet. When at it, use 'scale' instead of 'gain' consistently for
> the get/set functions to avoid misunderstandings.
>
> Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/Kconfig    |   1 +
>  drivers/iio/light/veml3235.c | 237 +++++++++++++++++++++++--------------=
------
>  2 files changed, 130 insertions(+), 108 deletions(-)
>

@Jonathan, if you apply this patch in its current form, could you please
fix the message from "iio: veml3235:..." to "iio: light: veml3235:..."?
I just noticed that the "light:" bit is missing.
I can send a new version if that's preferred.

The applied patches from this series did not have this issue.

Thanks and best regards,
Javier Carrasco

