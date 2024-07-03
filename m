Return-Path: <linux-iio+bounces-7236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB429259C1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 12:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9082959B7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AFC175545;
	Wed,  3 Jul 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbZrHBq2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD61891C6;
	Wed,  3 Jul 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003124; cv=none; b=l3S2wF55ChYhz09eAcmaFrxvxOIW0PkwSUOeYlgsB/ltaEh7fNlMJT0fqNpGeZeQoRzSFZXP+wK7rQCgrWlTeYmA8ktMbtdOsdWmx5qOKq9WWtIfqU/rITm5DZvRLYvzwMxC5ymQ0uGydmICeozqa2b1ODv/btml+1FdCsn2OX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003124; c=relaxed/simple;
	bh=nGRWwla5+HB9jizj/PkTdqARa5LM5V3yQb+q/WsaEYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzVZy+EEua5CUuuRXwGknQLiFfku3ZoaDP3szUVbp5XwOK44W69uniEk/feREyo5o8FvTAyK4bzRr0szX0F/8ZYLii1SuqcELDhrFC6RBFjGqwAWfb/zuzatHvslbA4GSLqFEqjiYGS0NEobDSzeMm/otZe6AERpW2yUNQYDsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbZrHBq2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706524adf91so4219127b3a.2;
        Wed, 03 Jul 2024 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720003123; x=1720607923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nGRWwla5+HB9jizj/PkTdqARa5LM5V3yQb+q/WsaEYo=;
        b=mbZrHBq2unfmNg8RAeMx3N1G8b8hBowePXgmw3XG/MhBcKtIdj1RyqTnH4/S2sk2J5
         g6fnHj7LSaB8QJoQDDzmXWbu9vpnYNaJStFXkTCXPV5l2hL7O+x0hPTrnLMBspDSCb40
         9OVpVNwbz3yP7BsE32UVMWpFKHZFICOuG7nYb+W1c9PO2/rE3qRXlnboobi1vkhP9TLn
         liznLPhq2eqGZbT6drILSBNEj5wPzoSELLz1W1+y1+i69EWlvXNXmwv0U7Ed6XdczPYE
         lOOtXmLmhbsLGQkEd8wWFGVPRtTMOBwwknKGGci53gPF8DRXmA+Xr8HUWNkVTFqObaxz
         i7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003123; x=1720607923;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGRWwla5+HB9jizj/PkTdqARa5LM5V3yQb+q/WsaEYo=;
        b=aeknsIxEuV+AtHKeirtX0ObzeFX3s9OQr06X97OwMIqY8dbfQnecYNvD+dpzOq1EgT
         rwpCj2Y2uX972GQzbtoJljdkRXy0QAfvIYEHKrEBuzR6TrdbPw8Xh5+Ms4eMer/hNOid
         BZ2+6g5RBht50AJZvDHYducooU6OpicPCXhZVuftSZAkS08hT38VWIZZe/tnX81c5Zwk
         VUblr1OTovIxH2S+rfQnSqDwzrdG1Rjq1RLv5FmLFg6LR9J4lFHGU1WRQ1+EQD89Np2+
         /O3D+bYXedY8dlgVP0ObKlc1znLNwjFvLpMbWW/9N/mlflL7LYllm4l6DE2eg/xj8CNS
         eYXw==
X-Forwarded-Encrypted: i=1; AJvYcCX90P1pJzrf9gYnbN/Xo335o9c2lihRzM2UdwK3HALBVJbWJN6+OgNxXxN0pvdYTglHjBdY3zQ5Zrvgr0SIKyCnIr/eyU7O3AwN8YZB
X-Gm-Message-State: AOJu0YwYc153vP/riSfh42E3UZhWNqu9eIDm14XW02gxMJvxp2rLKAbL
	JXvfzw0XOF1bTZ0hHOnl/28lU5mGS6ym1Xh6ErB1GTGGvbijh2Gs
X-Google-Smtp-Source: AGHT+IEzsS+pEUSpCMsqeqGcfqJmFjusREOUAotisS32d4FcGLQRQ72eov1ujrhxoJgNLNuCjqqdLQ==
X-Received: by 2002:a05:6a20:258a:b0:1be:c7f5:94 with SMTP id adf61e73a8af0-1bef60ef52bmr16605564637.13.1720003122508;
        Wed, 03 Jul 2024 03:38:42 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598c1asm100202335ad.267.2024.07.03.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:38:42 -0700 (PDT)
Message-ID: <fabaaa9d7be4193a2bfb5a0476fdcf1ce3117c58.camel@gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7606: remove frstdata check for serial
 mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <jic23@cam.ac.uk>, jstephan@baylibre.com, dlechner@baylibre.com
Date: Wed, 03 Jul 2024 12:42:31 +0200
In-Reply-To: <20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com>
References: <20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 12:52 +0000, Guillaume Stols wrote:
> The current implementation attempts to recover from an eventual glitch
> in the clock by checking frstdata state after reading the first
> channel's sample: If frstdata is low, it will reset the chip and
> return -EIO.
>=20
> This will only work in parallel mode, where frstdata pin is set low
> after the 2nd sample read starts.
>=20
> For the serial mode, according to the datasheet, "The FRSTDATA output
> returns to a logic low following the 16th SCLK falling edge.", thus
> after the Xth pulse, X being the number of bits in a sample, the check
> will always be true, and the driver will not work at all in serial
> mode if frstdata(optional) is defined in the devicetree as it will
> reset the chip, and return -EIO every time read_sample is called.
>=20
> Hence, this check must be removed for serial mode.
>=20
> Fixes: b9618c0cacd7 ("staging: IIO: ADC: New driver for AD7606/AD7606-
> 6/AD7606-4")
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



