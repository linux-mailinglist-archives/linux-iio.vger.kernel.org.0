Return-Path: <linux-iio+bounces-19305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28797AAFB53
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 15:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDAF9E3D48
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E122B8B0;
	Thu,  8 May 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2d4PCqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AC15A86B;
	Thu,  8 May 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711002; cv=none; b=n6BXAeo/ZcXhN8yt6/R67tYvtoaqHA/lvw2Np9vDcieaP5dNr6v1ylnW1srsX/WeUREEVEiPbe9z1xmwDPqzZKLevm7Z2nwN6UQjZM/jh6FdTodKS5jtrUvBwHyK1i9uxPR77ucYTlqyxheaMTu0GBfCrKzeieeAxzDiSsuy3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711002; c=relaxed/simple;
	bh=oO6jfY5ocMZdsPfbo434zEMB5oWyLhiGd8yaaiwDBJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bphpfc6GZ4XsyO1G4KRp2RZSRtu4SsreFlEXI7a6WpNjx81o07W89b4nVArbBawHtq9LQ6SJruzfCUFqIlgnStxXR7MGmNI+JLCJGHTpjUGDLxjO/rqyQU8+1UMF+Zryc1ml/FQHPcfuTE5umi/Hk8exLyqp9jfPcC6+8xeb2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2d4PCqg; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfca745c7so8220211fa.0;
        Thu, 08 May 2025 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746710999; x=1747315799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO6jfY5ocMZdsPfbo434zEMB5oWyLhiGd8yaaiwDBJ8=;
        b=X2d4PCqgLpUlCzvdHLOEYDRkYqMpT5ZAErMaBekTw2oD069VL6ry0K3pc7/WiGVRl2
         cKqC6XJ7RijKSBDziyvqFG58HcsMLgCqGb0nSDRKj01S/xsGi5JXYzNlpbCa+JpvGtNx
         gLePxg0kBGw+cnPllxRh+63sHfio/CYIJpi7rHZG7qfjJPRaopkNlT3HQy8qE5heK/NN
         TaO/dj78NacgjiEraTA5d4uLu2rXAa7CnbW9pbhH8OIXDQ7/rL1FBkdkQL8C31/iPo34
         TJwIFyd/XMjMztz4wMA7EcoWp2Lwm+75N9qkUUj717JeSaUM8/DvuAsD1jijVpIAuPf0
         q/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710999; x=1747315799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO6jfY5ocMZdsPfbo434zEMB5oWyLhiGd8yaaiwDBJ8=;
        b=OlpE6uNecB+qEYzN+1HxTpqfSV9psz33T1kNTB0wq0iQBdeHkIU/cDNGh3zMjrLwcX
         tf4HhdeTBPKuVbi8olzPO/JDJ146+VfxFIoNIbDyDYuSNn6IprmVUyIla/WDh0J8ElgZ
         1FuYdP1wPWzfBHWON3VhWsrLg2U7M8ElmT3o+T/gcJHUbqt40hler8IKcMDE6qwOPpcI
         3zX2+LZ2scxMpym0+sbRlxqHTf2WG6sIfNR3kHKyKv7SbY+aD+h0FRrT06ZAKwQ/avWS
         qyk0L3Ls7V+G8T3Zh0NHv55hbp/qh38LLPt4Z3Qk56yNgc3SV1LbwcFd2+fIr96+XrAp
         YYbA==
X-Forwarded-Encrypted: i=1; AJvYcCVvfizd3UiVgoQfudpr1ZeMX/gpy/jN8W4CCggs97Hw1nkf9oaJH5FOY4b96Y/jmfmMIbZbOAlztAc=@vger.kernel.org, AJvYcCWhv3d5LiTBHXQ8UUke1lPuD89Yzyd8UlZaY03SCw/dPSfET9XgWaObkC4UBbCTTa0bHt2pFbrj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CNn/5AddLnbRLLG5+1BvOthwVMV2e4+Ox7ZYdI8krnLv6o4A
	M7VazcPGD5gdBhCe2CQ6XvPtp8cI6NzL09J6Ss6a/KsO1yMQE+E/p42JY2+x/DaQGhCuZHGVGnG
	0ZAyk4um4AJnLQ6whOy/MqpeENRc=
X-Gm-Gg: ASbGnct7Apu7w47bcJxZXwJgE9qFeXGbRk+qgmFoASiCtuEZ1aJA4KxBVgEfiFfJwSS
	lqqZwtuf7jtcGUiR7LdMFPvhBAhIIbmq4PspiCqKUlK4d45E2qoXA4atsmvZoJZQP4cvSKi4ELx
	fm6uGHSNLj4gkIvdD13HjEqw+l0JyyPdVWScN5M4B/KVsWmtMrFUN3OGwDOe/qf0SZ
X-Google-Smtp-Source: AGHT+IGO4CTqNpN16Z443ZHnTEJuHwyrZf0+BdopUI36cTLUW4CVaVL8S/F795qmcXPJsXxUlpPjG+t77ZjN9e3Fyto=
X-Received: by 2002:a2e:be03:0:b0:30c:2efb:6608 with SMTP id
 38308e7fff4ca-326ad33a1aamr29247801fa.34.1746710998671; Thu, 08 May 2025
 06:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
 <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
 <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
 <20250430141112.00004bb8@huawei.com> <CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
 <20250430182537.00007eab@huawei.com> <CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
 <20250504180420.73b96437@jic23-huawei> <CAOMZO5DeMNGqpF4T7tuvBBN=i95uReSTXkj-sNW2jZTUO++5ZA@mail.gmail.com>
 <20250505161645.5bca37c5@jic23-huawei>
In-Reply-To: <20250505161645.5bca37c5@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 May 2025 10:29:47 -0300
X-Gm-Features: ATxdqUFE-FZ_i9xtKBcRyQ363OC8UXz7AnEDzIrer5loAudnJi2OY6F2z8sjmec
Message-ID: <CAOMZO5BPBV5CyTE1-TyutJctLHeKE0s24JxyiZF1T_xmeKuZfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, mazziesaccount@gmail.com, 
	linux-iio@vger.kernel.org, Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, May 5, 2025 at 12:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> That would be perfect! If you can do it by modifying the macro as that is
> going to be the simplest path to ensure there are no others even better.

I'm sorry, but I am unsure I understood your proposal correctly.

Do you plan to submit a formal patch?

Thanks

