Return-Path: <linux-iio+bounces-16720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A9A5AC81
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 00:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FCA3A669E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDD220699;
	Mon, 10 Mar 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vsfBF8F7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28871DE3D2
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648896; cv=none; b=B05XnMZgh4Yi+LBxufiEJ50xNEPg0U/E0Z7IAgPxrJiMZSk6fTQnjyx413EpXO7vUJm0o/0FGIivbXotrPDuzYyDuK8NCdZ/noaUI1mVFVYerfdY1GnLMbERobNt4qjEBqXTGTxQ3gNPyvNmWZhbrc37j4p+kO90BDPodZPs2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648896; c=relaxed/simple;
	bh=VBK3zZTJ0aQkKsntlwL2ZtaNAXoFRMaf+rBKaPlt+Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKtquK4GWhQ2JI4umfev2aG6R+qDEO18kw2BSD94nTw9gbs0SXnsf01AYdjbie0PdzehxnRDbeL9Koc4uZpBl7oQ6ipFS4pvi3VH76AQkcXb0TREVgnfxEXo6GUkfJkGjbDYPIYQcUgZI0Wq/vEgrv52uQuaVLDPL6XWaq7PQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vsfBF8F7; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fa28eaa52cso2459713eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741648892; x=1742253692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQSzHz3wdc8Cq+r02WWOMmxfwnytMXFYfrkpAvPImM0=;
        b=vsfBF8F7WbCHhJOOunUXBCMhkeFk/9spRumJO+je7OV540O+4cJalaF2D81R4NYhZw
         RgdSNxu1E82RIfJg1db2KyEHN3PpdoQo7SulUqDqOUcvLkxE50kE2GBtRprcr+S7FxEd
         JlaTshZHDKh8EhXUnSQDn0Px1NNkBEqo36Kay+DNqmA+0Az+dR2/Em+o5ZRrcbHifIdL
         /pD3Qnd61ZVXGnh2X8rX37S0NGTyt4i9Sbff0QA//yG0gk6ZICYYha8a91xTGOXZem0E
         ZOHs2+JlU+RuYKzIKVACifbOWNCHnJ4PjiPDAOuBkOwOSiwSZekgWSKcunTsprgTWtUr
         EgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741648892; x=1742253692;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQSzHz3wdc8Cq+r02WWOMmxfwnytMXFYfrkpAvPImM0=;
        b=DGCXPrWUuiHvRmfK83XEHq1hAcZjxVwUyfG2ox4kxtn15bde+TnYF/GCB8ysIjZP9S
         oicn9rJl1OifNTlEVGFaLVcXKFV6//VkjALFH45uv0jEW764kowI4yOIx527HlBO4raQ
         rrtwFeZjq3lwKBioH11EYGadh9/1DqMqfPEtyx0l3cj4n9dZEq82gKEVncmSZkOzB4hs
         gP/RrArZ2izQGZqL3b7mZwnl2ckKj+5tPy2V6mVUibLgHGny0EtHjLdtqDOx0BA7CDze
         pW/U5eXHFUvxCt1QNujqZ1tXjWSifRx3rz94KKpqSaaGrJ43gON7Ov6l5FECYh6ktdjr
         OiGg==
X-Forwarded-Encrypted: i=1; AJvYcCXzDJ2JzMggUGtCCMkS70Z1KWNj1evt4vPSnXZ1QmCGDQF+6skr2hGy3+Aa9qdog7ARRswQEHbZKgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDNcTxWhSkZJVYEJFNk6vD93ig2v9pFRtVzb53iCt28tfza4n
	okts8wgAXXxC7wFmi/GL7cfsawCLLdqc33+GtCZEdPihHTOsK1pkenD3G1nDlws=
X-Gm-Gg: ASbGncv25HTUBfcKEwzjmwDQVjdw5oxCVPwQ1V2tYrEPiUGQZYakIMy2XLoYW8hHIpl
	nViZYJ3Ep7Wb6EEZThm+wf3R9Fdpi6U0kBB9XqHoeIsslW54+pQxoELOAWFHYKJPlxZrmUSqKlT
	n56EzAN1TgbcyJPhhy8gqTSBCe8Hasxm9SHjFaXnxWVV/7FM95MM5EdoHG5b275j4XGDNPlHbKS
	i+oXN6Ep7hnkY8AV/y7FFXhLxEP0x0mfTgflw9rz9V3fsCnUk3umB18Im8UPNaUMDnVeA00DNBY
	DLGOyAhTpj7h9bZKD83MvcCQkeUdS3eJhufD6DdELYfay3wpZ0YWKv0hiREDelzXmmKBSlnuVJi
	IpVvuiw==
X-Google-Smtp-Source: AGHT+IHf/4iXavlTBzsdYjeJraWSD9jUkRn8CUg1rFOKIO8Ot5TgrgYqitov/Nl2Ib6huENodhhohw==
X-Received: by 2002:a05:6820:994:b0:600:228a:d800 with SMTP id 006d021491bc7-6004ab5fa66mr6971067eaf.8.1741648892575;
        Mon, 10 Mar 2025 16:21:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601b4505928sm441770eaf.11.2025.03.10.16.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:21:31 -0700 (PDT)
Message-ID: <c1ffdd06-4907-4f6a-8cfa-698be64a1e79@baylibre.com>
Date: Mon, 10 Mar 2025 18:21:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] IIO: ADCs: Sparse friendly claim of direct mode
To: Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Mike Looijmans <mike.looijmans@topic.nl>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309165819.1346684-1-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 11:58 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Resend of remaining unreviewed updates in drivers/iio/adc/*
> 
> I will eventually just apply these, but I'd much rather someone
> else took a quick look to check I haven't done anything stupid!
> 
Only managed to find one little potential oversight in patch 5/8.

Reviewed-by: David Lechner <dlechner@baylibre.com>


