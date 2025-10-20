Return-Path: <linux-iio+bounces-25297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830DBF419B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 02:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEADC42057F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861234369A;
	Tue, 21 Oct 2025 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zago.net header.i=@zago.net header.b="kCpm4ybj"
X-Original-To: linux-iio@vger.kernel.org
Received: from cp4.obambu.com (cp4.obambu.com [88.99.29.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EB273F9;
	Tue, 21 Oct 2025 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.29.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005115; cv=none; b=TgKQ5hYkmUK+jdnA6OFrdjYHm9LsFVCYs9sCBI1OsdCOGzAmdmkzgigTjjh/4KNJ2XY1ahiv/0sWl2SMXVVcctpu+YBkE0LxOMUUjfhzEnV/ysciJguyyPs457IEIQyQ06lSipLxWZzJiZSsh7IwPstSuVeq3I4RdAgYDmvh3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005115; c=relaxed/simple;
	bh=F1yV94Y1btTEz9XP1+4UrFoaP4Ef+rr/pPWNdyJQklI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5UW1GfZIJQrXqadMgK2LNgUN6bt/HQYnkEc90tsCIPyTpAdUt+sTpSqD2ECBMPFu5daYuQM9hfXt4tpLPYzX4wGximYjHq9QwAifMluG32eQwWh0ipCinFs1Kth+N+XJFk1l1ZwdfFvgb0tsTiL5URo0zMaUattD4udb+2dIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zago.net; spf=pass smtp.mailfrom=zago.net; dkim=pass (2048-bit key) header.d=zago.net header.i=@zago.net header.b=kCpm4ybj; arc=none smtp.client-ip=88.99.29.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zago.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zago.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zago.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0DrXsX05Grva4tWU6XxJfz/A2NsaAczVNPLro4r7jRM=; b=kCpm4ybjA9C+5MwdBHDiI3WAzU
	EghG2TGslavBB9P/wFgBzldimwl+3i4PVnxTrjlXgCyiz4gW/PdXzXLOtT7RAMgx3SB84Yz6CT/mF
	hXzhDIUs6cIO/b9bnVqAZQUfLS+XV9TPoWkOpjemQ/ntplYjEOdgxsfGkT4vF+njOj3rBPKr/JJwn
	zi+7Wq1FEW8SJSv80lpwJ9NmnWvT6g/249KNgC0LJrrIUMxp85opbqjQf53DyunsKvCFKYqXkHxFr
	J5h4Q437dzDXra+TEm+NQvnDgnZZFnJgrX/pLVLAL96FH+gP3V9cXuRZuUhLh7DfO6vAFyiwJ9bKO
	WgdWVBkA==;
Received: from [68.203.21.78] (port=46264 helo=[192.168.1.205])
	by cp4.obambu.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <frank@zago.net>)
	id 1vAzZ2-00000004D5u-0fRx;
	Tue, 21 Oct 2025 01:45:19 +0200
Message-ID: <5f2f9957-52e1-43a6-b3f0-bd3f4e434ff6@zago.net>
Date: Mon, 20 Oct 2025 18:45:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: position: Add support for ams AS5600 angle
 sensor
To: Aditya Dutt <duttaditya18@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
References: <20251020201653.86181-1-duttaditya18@gmail.com>
 <20251020201653.86181-3-duttaditya18@gmail.com>
Content-Language: en-US
From: Frank Zago <frank@zago.net>
In-Reply-To: <20251020201653.86181-3-duttaditya18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp4.obambu.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zago.net
X-Get-Message-Sender-Via: cp4.obambu.com: authenticated_id: frank@zago.net
X-Authenticated-Sender: cp4.obambu.com: frank@zago.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

Thanks for updating that driver and making the required changes. I tried to go back to it a few times but motivation was lost. 

The commit message should say "position sensor", not "angle sensor", for consistency.


> diff --git a/drivers/iio/position/as5600.c b/drivers/iio/position/as5600.c
> new file mode 100644
> index 000000000000..fe716d521548
> --- /dev/null
> +++ b/drivers/iio/position/as5600.c
...
> +	case AS5600_REG_RAW_ANGLE_L:
> +	case AS5600_REG_ANGLE_L:
> +	case AS5600_REG_AGC:
> +	case AS5600_REG_MAGN_L:
> +		mask = 0xFF;
> +		break;
> +	default:
> +		/* Not a readable register */
> +		return -EINVAL;
> +	}
> +
> +

extra empty line


I believe you could add this to the second patch:
Acked-by: Frank Zago <frank@zago.net>

Best regards,
  Frank.

