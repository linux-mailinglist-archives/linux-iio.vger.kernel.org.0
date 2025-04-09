Return-Path: <linux-iio+bounces-17851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67AA81E12
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 09:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4714A4AFA
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8AE259C9A;
	Wed,  9 Apr 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJmQ4UGu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CA82899;
	Wed,  9 Apr 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183035; cv=none; b=qbekcMnQxLPNC6smoHSBKGdzUkH56yzr6HMiXPN1qtjrXJV3R8W1Km1qAREste4CTOhPWFzjC7zNklTEfkeVC5S7HRv1Y5fcfZf2F2xUoj7z2QA1lrxHLWpMD5vx6h3tO4WZc8w45tWAEazD/c0rtm6Uy3Osw5GxDq5OxIIidCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183035; c=relaxed/simple;
	bh=EOZkXQ4JXP/SATjGblkDv2e9V+LdSeaw5irq9saKdFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fdl8dO2vtR6eiXoKA0IO1FdxmNG/kmBJJhIOVQp6hoyb4e6igSJhpfCrDYsC8tgcKyeXCtTt6C5swFYKXKHj8VeTidiygB6EkjV5kbzG27giL7KVfXRvFEDd9yDEM/8DwaJcj87sn6cvbPAe3hWurLQgtqVBnm9i3NMU5+uPwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJmQ4UGu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a823036so58314615e9.0;
        Wed, 09 Apr 2025 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744183031; x=1744787831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOZkXQ4JXP/SATjGblkDv2e9V+LdSeaw5irq9saKdFQ=;
        b=IJmQ4UGuUcdBcwGT5vWzrTzCeVF+BN65lmQdussaaa/0rKRwNt0guhut5oPkKsnnA+
         njjF1Aq/VfVouTj4bN7WUwQJJEBRHgL4027rC+UZ4qnbByphXnHsN3FCEf9QFZDjdqcn
         aJ+L/1MxdFAULLZen5pTxWx1sB1i198KNmVK5ocmEaivne1VOqeBczilkdE+iOUlGCZ4
         B+v0ApU+Gv9S5W7PNls6Y6/xGkOTeKdnnp439DsOjUoTH0HXacZ4GnpBNTjXBqafsnAN
         NtH3Wlzk5YTxhQkFxIUg/V6E0UKkDCkikMfRSGZC428RAnvTHKkRzL7HF/fCOuam9YX8
         YqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183031; x=1744787831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOZkXQ4JXP/SATjGblkDv2e9V+LdSeaw5irq9saKdFQ=;
        b=hRi0ZtKRrBB1yprcsw3Fwfoi6sTxoEJ+LYAP1gE8bKNXEEGkXgKcw+v2n1f00RKHdv
         TJiPhQsywETh4IlasRkp96cjv/rDXbhzxmrEbksrVAckavNeOH7u5gN8/PJTcireVKCs
         8lDVpsZz+cbaBjveCNAM8Bzf/CGN4jVcYSGFqOJQHDUicK3dtHolSiqO9XBV78pnTtYU
         RiCV0wo2clUbu6z4wcwewU9x438kJlpp7ScujxZ1EsxbeCom0kCJOPMnNGsVncOBUvQM
         2qdkknQckpOy2qyxLMgGsxsp3f1V5yzzcGzjoj5KT+mi/4YCB4wv5sLKxr1FUUzunCBB
         /Yew==
X-Forwarded-Encrypted: i=1; AJvYcCXsoNH7wYtl6NTfIx+8AD0Q4yb4thz9wv7HxOiE4g17xd/HhOdjZyEb2OwDGQVljjraH/pbVQafXs5tt90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIbrmsFmJW8XvVTFTD1IzKdpST/Mcsy/jn9Ko4sxWII76eARP
	LSPFOBQCkSUCI/m0z084FNhRPP9tPLQiCNWDKAamtwUh4RWYyc5w
X-Gm-Gg: ASbGncscXciXqp+WFcqlSA06W9+cv7SqZKT5msZFr/EnBrmx6vrXtSzAy9HKrweCFMJ
	zZkGozG1fIRr+yqioRyeBgZskKXNKfBMARot+zftjjYOTEsJ1T3DwtbI5jT2byxbv6+OPfuzzLa
	5tVyAKBZD0FL8j/sw9ECvhQj80ffnT1b3MUsDVeAPPdtvmGGzrWeJf1g8iTIkj4cdlWafyI/An0
	h3RqAHvTnoUO1rma7wL9tH9MV11e1pOrI5Tr4fOTD8nUHhCcLhoxcV6P8zboKQpDyrE+sIhCZ+a
	d4JV2qUlpamPCVcVRUdHaLsn/kvtvHpXldOmbfXiK8AqBdOlQZshpfiPD2jElkvElxawoH7xibs
	q6fYEJc0/rW7gTJARNPSwh9d1mg==
X-Google-Smtp-Source: AGHT+IG9QQ+Mgpn76eoOf15lfQ0Vq558qk8tLYYqXhmzGW37MnsrpNpZyMcjhqw4CGbRtf3eMgGc3A==
X-Received: by 2002:a05:600c:4f90:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43f1eca8121mr13859715e9.12.1744183031214;
        Wed, 09 Apr 2025 00:17:11 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc99sm10482115e9.29.2025.04.09.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:17:10 -0700 (PDT)
Message-ID: <be16ccddf508a6252d4927af258bd10c8ecfb575.camel@gmail.com>
Subject: Re: [PATCH 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 09 Apr 2025 07:17:29 +0100
In-Reply-To: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
References: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-08 at 22:48 +0200, Angelo Dureghello wrote:
> This patchset is intended to fix a random wrong chip ID read, or a
> scratchpad test mismatch, tests done in the ad3552r-hs driver probe. The=
=20
> bus "read" operation must always check for busy flag before reading.
>=20
> First patch reorganizes a bit the busy-wait polling code, second patch
> fixes the wrong bus read occurence.=20
>=20
> NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended to =
be
> applied after the linked "ramp generator" patch.
>=20
> Link:
> https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c=
0264bd78@baylibre.com
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Hi Angelo, patches look good but typically fixes should come first. The rea=
son is
that we only want to backport fixes to stable branches and like this we dep=
end on the
first patch. So first use the plain regmap_read_poll_timeout() before acces=
sing the
bus and then add the helper...

- Nuno S=C3=A1


